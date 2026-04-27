import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { normalizeBookLocales } from "./book-locales";
import { AdminBooksClient, type AdminBookPayload } from "./AdminBooksClient";
import { normalizeGalleryUrls } from "@/lib/gallery-urls";

export default async function AdminBooksPage() {
  await requireStaff();
  const lang = await getLang();
  const supabase = await createClient();
  const { data: books } = await supabase
    .from("scripture_books")
    .select(
      `
      id,
      created_at,
      primary_lang,
      gallery_image_urls,
      scripture_book_locales ( lang, title, description, read_url, file_url, cover_image_url )
    `,
    )
    .order("created_at", { ascending: false });

  const payload: AdminBookPayload[] = (books ?? []).map((b) => {
    const raw = b as {
      id: string;
      primary_lang: string | null;
      gallery_image_urls?: unknown;
      scripture_book_locales: {
        lang: string;
        title: string | null;
        description: string | null;
        read_url: string | null;
        file_url: string | null;
        cover_image_url: string | null;
      }[];
    };
    const pl =
      raw.primary_lang && ["ru", "uk", "kk", "en"].includes(raw.primary_lang)
        ? raw.primary_lang
        : null;
    return {
      id: String(raw.id),
      primaryLang: pl,
      gallery_image_urls: normalizeGalleryUrls(raw.gallery_image_urls),
      locales: normalizeBookLocales(raw.scripture_book_locales ?? [], pl),
    };
  });

  return <AdminBooksClient lang={lang} books={payload} />;
}
