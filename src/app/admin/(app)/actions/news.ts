"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const LANGS = ["ru", "uk", "kk", "en"] as const;

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

export async function deleteNewsForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  await requireStaff();
  const supabase = await createClient();
  await supabase.from("news").delete().eq("id", id);
  revalidatePath("/");
  revalidatePath("/admin/news");
}

export async function saveNews(formData: FormData) {
  await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string) || "";
  const published = formData.get("is_published") === "on";
  const removeCover = formData.get("remove_cover") === "on";

  let newsId = id;
  if (!newsId) {
    const { data, error } = await supabase
      .from("news")
      .insert({ is_published: published })
      .select("id")
      .single();
    if (error) throw new Error(error.message);
    newsId = data.id;
  } else {
    await supabase
      .from("news")
      .update({
        is_published: published,
        updated_at: new Date().toISOString(),
      })
      .eq("id", newsId);
  }

  if (removeCover) {
    await supabase.from("news").update({ cover_image_url: null }).eq("id", newsId);
  }

  const cover = formData.get("cover");
  if (!removeCover && cover instanceof File && cover.size > 0) {
    const url = await uploadNewsCover(supabase, newsId, cover);
    await supabase.from("news").update({ cover_image_url: url }).eq("id", newsId);
  }

  for (const lang of LANGS) {
    const title = (formData.get(`title_${lang}`) as string)?.trim() ?? "";
    const body = (formData.get(`body_${lang}`) as string)?.trim() ?? "";
    if (!title && !body) continue;
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

  revalidatePath("/");
  redirect("/admin/news");
}
