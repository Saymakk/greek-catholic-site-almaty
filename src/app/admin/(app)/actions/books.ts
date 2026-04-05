"use server";

import { parseHttpImageUrlFromFormData } from "@/lib/admin-image-url";
import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { format } from "date-fns";
import { isContentLang, type ContentLang } from "../books/book-locales";

const CONTENT_ORDER: ContentLang[] = ["ru", "uk", "kk", "en"];
const LOCALE_FOR_COVER = new Set<string>([...CONTENT_ORDER, "main"]);

const EXT_TO_MIME: Record<string, string> = {
  pdf: "application/pdf",
  epub: "application/epub+zip",
  mobi: "application/x-mobipocket-ebook",
  doc: "application/msword",
  docx: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  txt: "text/plain",
  rtf: "application/rtf",
  zip: "application/zip",
};

function mimeFromFilename(name: string): string | null {
  const ext = name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "");
  if (!ext) return null;
  return EXT_TO_MIME[ext] ?? null;
}

/** Только ASCII в ключе Storage (Supabase отклоняет кириллицу и спецсимволы в пути). */
function scriptureObjectFileName(originalName: string, uploadedAt: Date) {
  const leaf = originalName.split(/[/\\]/).pop()?.trim() || "file";
  const lastDot = leaf.lastIndexOf(".");
  const rawExt =
    lastDot > 0 ? leaf.slice(lastDot).replace(/[^a-zA-Z0-9.]/g, "").slice(0, 14) : "";
  const ext = rawExt.startsWith(".") ? rawExt : rawExt ? `.${rawExt}` : ".bin";
  const stamp = format(uploadedAt, "yyyy-MM-dd_HH-mm-ss_SSS");
  return `upload_${stamp}${ext}`;
}

async function uploadScriptureFile(
  supabase: Awaited<ReturnType<typeof createClient>>,
  bookId: string,
  locale: string,
  file: File,
) {
  const fileName = scriptureObjectFileName(file.name, new Date());
  const path = `${bookId}/${locale}/${fileName}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const contentType =
    (file.type && file.type !== "application/octet-stream" ? file.type : null) ||
    mimeFromFilename(file.name) ||
    "application/octet-stream";
  const { error } = await supabase.storage.from("scripture-books").upload(path, buf, {
    contentType,
    upsert: false,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("scripture-books").getPublicUrl(path);
  return data.publicUrl;
}

async function uploadBookCover(
  supabase: Awaited<ReturnType<typeof createClient>>,
  bookId: string,
  locale: string,
  file: File,
) {
  const ext = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const path = `${bookId}/covers/${locale}.${ext}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const contentType =
    (file.type && file.type.startsWith("image/") ? file.type : null) ||
    (ext === "png"
      ? "image/png"
      : ext === "webp"
        ? "image/webp"
        : ext === "gif"
          ? "image/gif"
          : "image/jpeg");
  const { error } = await supabase.storage.from("scripture-books").upload(path, buf, {
    contentType,
    upsert: true,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("scripture-books").getPublicUrl(path);
  return data.publicUrl;
}

function strOrNull(v: FormDataEntryValue | null) {
  const s = typeof v === "string" ? v.trim() : "";
  return s.length ? s : null;
}

function pickMerged(
  formData: FormData,
  field: string,
  loc: string,
  mergeMain: boolean,
): string | null {
  const direct = strOrNull(formData.get(`${field}_${loc}`));
  if (direct) return direct;
  if (mergeMain) return strOrNull(formData.get(`${field}_main`));
  return null;
}

function orderedLocales(primary: ContentLang, present: Set<string>): ContentLang[] {
  return [primary, ...CONTENT_ORDER.filter((l) => l !== primary && present.has(l))];
}

function firstTitleFromBookForm(formData: FormData): string | null {
  for (const loc of [...CONTENT_ORDER, "main"] as const) {
    const t = (formData.get(`title_${loc}`) as string)?.trim();
    if (t) return t.length > 200 ? `${t.slice(0, 200)}…` : t;
  }
  return null;
}

export async function removeBookCover(bookId: string, locale: string) {
  const profile = await requireStaff();
  if (!bookId || !LOCALE_FOR_COVER.has(locale)) return;
  const supabase = await createClient();
  const { error } = await supabase
    .from("scripture_book_locales")
    .update({ cover_image_url: null })
    .eq("book_id", bookId)
    .eq("lang", locale);
  if (error) throw new Error(error.message);
  await logAdminActivity(supabase, profile, {
    action: "scripture.cover_remove",
    entityType: "scripture_book",
    entityId: bookId,
    meta: { locale },
  });
  revalidatePath("/");
  revalidatePath("/admin/books");
}

export async function deleteBookForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("scripture_books").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "scripture.delete",
    entityType: "scripture_book",
    entityId: id,
  });
  revalidatePath("/");
  revalidatePath("/admin/books");
  redirect("/admin/books");
}

export async function saveBook(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string) || "";

  const primaryRaw = (formData.get("primary_lang") as string)?.trim() ?? "ru";
  if (!isContentLang(primaryRaw)) throw new Error("Invalid primary_lang");
  const primary_lang = primaryRaw;

  const localesRaw = ((formData.get("locales") as string) ?? primary_lang)
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);

  const hasMain = localesRaw.includes("main");
  const present = new Set<string>();
  for (const l of localesRaw) {
    if (l === "main") present.add("main");
    else if (isContentLang(l)) present.add(l);
  }
  present.add(primary_lang);

  const locales = orderedLocales(primary_lang, present);

  let bookId = id;
  if (!bookId) {
    const { data, error } = await supabase
      .from("scripture_books")
      .insert({ primary_lang })
      .select("id")
      .single();
    if (error) throw new Error(error.message);
    bookId = data.id;
  } else {
    const { error: upBook } = await supabase
      .from("scripture_books")
      .update({ primary_lang })
      .eq("id", bookId);
    if (upBook) throw new Error(upBook.message);
  }

  for (const loc of locales) {
    const mergeMain = hasMain && loc === primary_lang;

    let title = pickMerged(formData, "title", loc, mergeMain);
    const description = pickMerged(formData, "description", loc, mergeMain);
    let read_url = pickMerged(formData, "read_url", loc, mergeMain);
    let file_url = pickMerged(formData, "file_url", loc, mergeMain);

    const upLoc = formData.get(`upload_${loc}`);
    const upMain = mergeMain ? formData.get("upload_main") : null;
    const upFile =
      upLoc instanceof File && upLoc.size > 0
        ? upLoc
        : upMain instanceof File && upMain.size > 0
          ? upMain
          : null;
    if (upFile) {
      file_url = await uploadScriptureFile(supabase, bookId, loc, upFile);
    }

    let cover_image_url: string | null = strOrNull(formData.get(`cover_stored_${loc}`));
    if (!cover_image_url && mergeMain) {
      cover_image_url = strOrNull(formData.get("cover_stored_main"));
    }

    const coverLoc = formData.get(`cover_${loc}`);
    const coverMain = mergeMain ? formData.get("cover_main") : null;
    const coverFile =
      coverLoc instanceof File && coverLoc.size > 0
        ? coverLoc
        : coverMain instanceof File && coverMain.size > 0
          ? coverMain
          : null;
    if (coverFile) {
      cover_image_url = await uploadBookCover(supabase, bookId, loc, coverFile);
    } else {
      const coverUrlField = parseHttpImageUrlFromFormData(
        formData,
        `cover_url_${loc}`,
        "Обложка (URL)",
      );
      if (coverUrlField) {
        cover_image_url = coverUrlField;
      }
    }

    const { error } = await supabase.from("scripture_book_locales").upsert(
      {
        book_id: bookId,
        lang: loc,
        title,
        description,
        read_url,
        file_url,
        cover_image_url,
      },
      { onConflict: "book_id,lang" },
    );
    if (error) throw new Error(error.message);
  }

  const { data: existingRows } = await supabase
    .from("scripture_book_locales")
    .select("lang")
    .eq("book_id", bookId);
  for (const r of existingRows ?? []) {
    const lg = (r as { lang: string }).lang;
    if (lg === "main" || !(locales as readonly string[]).includes(lg)) {
      const { error } = await supabase
        .from("scripture_book_locales")
        .delete()
        .eq("book_id", bookId)
        .eq("lang", lg);
      if (error) throw new Error(error.message);
    }
  }

  const titleHint = firstTitleFromBookForm(formData);
  await logAdminActivity(supabase, profile, {
    action: id ? "scripture.update" : "scripture.create",
    entityType: "scripture_book",
    entityId: bookId,
    summary: titleHint,
  });

  revalidatePath("/");
  redirect("/admin/books");
}
