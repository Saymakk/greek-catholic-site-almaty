"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { isContentLang, type ContentLang } from "../books/book-locales";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { parseHttpImageUrlFromFormData } from "@/lib/admin-image-url";
import { mergeGalleryFromForm } from "@/lib/admin-gallery-merge";

const CONTENT: ContentLang[] = ["ru", "uk", "kk", "en"];

function firstTitleFromNewsForm(formData: FormData): string | null {
  for (const l of CONTENT) {
    const t = (formData.get(`title_${l}`) as string)?.trim();
    if (t) return t.length > 200 ? `${t.slice(0, 200)}…` : t;
  }
  return null;
}

function orderedLocales(primary: ContentLang, present: Set<string>): ContentLang[] {
  return [primary, ...CONTENT.filter((l) => l !== primary && present.has(l))];
}

async function uploadNewsCover(
  supabase: Awaited<ReturnType<typeof createClient>>,
  newsId: string,
  file: File,
) {
  const ext = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const path = `${newsId}/cover.${ext}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const { error } = await supabase.storage.from("news-images").upload(path, buf, {
    contentType: file.type || "image/jpeg",
    upsert: true,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("news-images").getPublicUrl(path);
  return data.publicUrl;
}

async function uploadNewsGalleryImage(
  supabase: Awaited<ReturnType<typeof createClient>>,
  newsId: string,
  file: File,
  idx: number,
) {
  const ext = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const path = `${newsId}/g/${Date.now()}_${idx}_${Math.random().toString(36).slice(2, 9)}.${ext}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const contentType =
    (file.type && file.type.startsWith("image/") ? file.type : null) || "image/jpeg";
  const { error } = await supabase.storage.from("news-images").upload(path, buf, {
    contentType,
    upsert: false,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("news-images").getPublicUrl(path);
  return data.publicUrl;
}

export async function removeNewsCover(newsId: string) {
  const profile = await requireStaff();
  if (!newsId) return;
  const supabase = await createClient();
  const { error } = await supabase
    .from("news")
    .update({ cover_image_url: null })
    .eq("id", newsId);
  if (error) throw new Error(error.message);
  await logAdminActivity(supabase, profile, {
    action: "news.cover_remove",
    entityType: "news",
    entityId: newsId,
  });
  revalidatePath("/");
  revalidatePath("/admin/news");
}

export async function deleteNewsForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("news").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "news.delete",
    entityType: "news",
    entityId: id,
  });
  revalidatePath("/");
  revalidatePath("/admin/news");
}

export async function saveNews(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string) || "";
  const published = formData.get("is_published") === "on";

  const primaryRaw = (formData.get("primary_lang") as string)?.trim() ?? "ru";
  if (!isContentLang(primaryRaw)) throw new Error("Invalid primary_lang");
  const primary_lang = primaryRaw;

  const localesRaw = ((formData.get("locales") as string) ?? primary_lang)
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);
  const present = new Set<string>();
  for (const l of localesRaw) {
    if (isContentLang(l)) present.add(l);
  }
  present.add(primary_lang);
  const locales = orderedLocales(primary_lang, present);

  let newsId = id;
  if (!newsId) {
    let ins = await supabase
      .from("news")
      .insert({ is_published: published, primary_lang })
      .select("id")
      .single();
    if (ins.error && isSchemaCacheMissingColumn(ins.error, "primary_lang")) {
      ins = await supabase
        .from("news")
        .insert({ is_published: published })
        .select("id")
        .single();
    }
    if (ins.error) throw new Error(ins.error.message);
    newsId = ins.data!.id;
  } else {
    let up = await supabase
      .from("news")
      .update({
        is_published: published,
        primary_lang,
        updated_at: new Date().toISOString(),
      })
      .eq("id", newsId);
    if (up.error && isSchemaCacheMissingColumn(up.error, "primary_lang")) {
      up = await supabase
        .from("news")
        .update({
          is_published: published,
          updated_at: new Date().toISOString(),
        })
        .eq("id", newsId);
    }
    if (up.error) throw new Error(up.error.message);
  }

  const cover = formData.get("cover");
  if (cover instanceof File && cover.size > 0) {
    const url = await uploadNewsCover(supabase, newsId, cover);
    await supabase.from("news").update({ cover_image_url: url }).eq("id", newsId);
  } else {
    const coverUrl = parseHttpImageUrlFromFormData(formData, "cover_image_url", "Обложка (URL)");
    if (coverUrl) {
      await supabase.from("news").update({ cover_image_url: coverUrl }).eq("id", newsId);
    }
  }

  const galleryUrls = await mergeGalleryFromForm(formData, {
    uploadFiles: (files) =>
      Promise.all(files.map((f, i) => uploadNewsGalleryImage(supabase, newsId, f, i))),
  });
  const galUp = await supabase
    .from("news")
    .update({ gallery_image_urls: galleryUrls })
    .eq("id", newsId);
  if (galUp.error && !isSchemaCacheMissingColumn(galUp.error, "gallery_image_urls")) {
    throw new Error(galUp.error.message);
  }

  for (const lang of locales) {
    const title = (formData.get(`title_${lang}`) as string)?.trim() ?? "";
    const body = (formData.get(`body_${lang}`) as string)?.trim() ?? "";
    if (!title && !body) {
      await supabase.from("news_i18n").delete().eq("news_id", newsId).eq("lang", lang);
      continue;
    }
    const excerpt = (formData.get(`excerpt_${lang}`) as string)?.trim() || null;
    const { error } = await supabase.from("news_i18n").upsert(
      {
        news_id: newsId,
        lang,
        title: title || "Без заголовка",
        excerpt,
        body: body || "<p></p>",
      },
      { onConflict: "news_id,lang" },
    );
    if (error) throw new Error(error.message);
  }

  const { data: existingRows } = await supabase
    .from("news_i18n")
    .select("lang")
    .eq("news_id", newsId);
  for (const r of existingRows ?? []) {
    const lg = (r as { lang: string }).lang;
    if (!(locales as readonly string[]).includes(lg)) {
      const { error } = await supabase
        .from("news_i18n")
        .delete()
        .eq("news_id", newsId)
        .eq("lang", lg);
      if (error) throw new Error(error.message);
    }
  }

  const titleHint = firstTitleFromNewsForm(formData);
  await logAdminActivity(supabase, profile, {
    action: id ? "news.update" : "news.create",
    entityType: "news",
    entityId: newsId,
    summary: titleHint,
  });

  revalidatePath("/");
  redirect("/admin/news");
}
