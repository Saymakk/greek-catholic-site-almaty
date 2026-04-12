import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { AdminNewsClient, type AdminNewsPayload } from "./AdminNewsClient";
import { normalizeNewsLocales } from "./news-entity-locales";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { normalizeGalleryUrls } from "@/lib/gallery-urls";

export default async function AdminNewsListPage({
  searchParams,
}: {
  searchParams: Promise<{ id?: string }>;
}) {
  await requireStaff();
  const lang = await getLang();
  const { id: openNewsId } = await searchParams;
  const supabase = await createClient();
  const i18n = "news_i18n ( lang, title, excerpt, body )";
  const selFull = `id, published_at, is_published, primary_lang, cover_image_url, gallery_image_urls, ${i18n}`;
  const selNoPrimary = `id, published_at, is_published, cover_image_url, gallery_image_urls, ${i18n}`;
  const selNoCover = `id, published_at, is_published, primary_lang, gallery_image_urls, ${i18n}`;
  const selMin = `id, published_at, is_published, ${i18n}`;
  const stripGallery = (sel: string) => sel.replace("gallery_image_urls, ", "");
  const q = (sel: string) =>
    supabase.from("news").select(sel).order("published_at", { ascending: false });

  let res = await q(selFull);
  if (res.error) {
    const m0 = res.error.message ?? "";
    if (m0.includes("gallery_image_urls") && m0.includes("schema cache")) {
      res = await q(stripGallery(selFull));
    }
  }
  if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
    res = await q(selNoPrimary);
    if (res.error) {
      const m1 = res.error.message ?? "";
      if (m1.includes("gallery_image_urls") && m1.includes("schema cache")) {
        res = await q(stripGallery(selNoPrimary));
      }
    }
  }
  if (res.error && isSchemaCacheMissingColumn(res.error, "cover_image_url")) {
    res = await q(selNoCover);
    if (res.error) {
      const m2 = res.error.message ?? "";
      if (m2.includes("gallery_image_urls") && m2.includes("schema cache")) {
        res = await q(stripGallery(selNoCover));
      }
    }
    if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
      res = await q(selMin);
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (msg.includes("schema cache")) {
      res = await q(selMin);
    }
  }
  if (res.error) throw new Error(res.error.message);
  type NewsListRow = {
    id: string;
    published_at: string;
    is_published: boolean;
    primary_lang?: string | null;
    cover_image_url?: string | null;
    gallery_image_urls?: unknown;
    news_i18n: {
      lang: string;
      title: string;
      excerpt: string | null;
      body: string;
    }[];
  };
  const rows = (res.data ?? []) as unknown as NewsListRow[];

  const items: AdminNewsPayload[] = rows.map((r) => {
    const pl =
      r.primary_lang && ["ru", "uk", "kk", "en"].includes(r.primary_lang)
        ? r.primary_lang
        : null;
    return {
      id: r.id,
      published_at: r.published_at,
      is_published: r.is_published,
      primary_lang: pl,
      cover_image_url: r.cover_image_url ?? null,
      gallery_image_urls: normalizeGalleryUrls(r.gallery_image_urls),
      locales: normalizeNewsLocales(r.news_i18n ?? [], pl, lang),
    };
  });

  return (
    <AdminNewsClient
      lang={lang}
      items={items}
      initialNewsId={openNewsId ?? null}
    />
  );
}
