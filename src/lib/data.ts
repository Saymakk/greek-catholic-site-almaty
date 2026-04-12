import { createClient, createPublicClient } from "@/lib/supabase/server";
import type { SupabaseClient } from "@supabase/supabase-js";
import type { Lang } from "@/lib/i18n";
import { format } from "date-fns";
import { pickLocalized } from "@/lib/locale-fallback";
import {
  buildScriptureLangCodes,
  pickLiturgicalI18nRow,
  pickNewsI18nRow,
} from "@/lib/content-lang-chain";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { normalizeGalleryUrls } from "@/lib/gallery-urls";
import { t } from "@/lib/ui-strings";

export { liturgicalGridRangeForSiteNow, todayStr } from "@/lib/liturgical-site-dates";

export type NewsRow = {
  id: string;
  published_at: string;
  title: string;
  excerpt: string | null;
  body: string;
  coverImageUrl: string | null;
  galleryImageUrls: string[];
};

const HOME_PAGE_SIZE = 10;

export type PagedResult<T> = {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
  totalPages: number;
};

export async function getNewsPage(
  lang: Lang,
  page: number,
  pageSize = HOME_PAGE_SIZE,
): Promise<PagedResult<NewsRow>> {
  const supabase = createPublicClient();
  const p = Math.max(1, page);
  const size = Math.min(50, Math.max(1, pageSize));
  const from = (p - 1) * size;
  const to = from + size - 1;

  const q = (cols: string) =>
    supabase
      .from("news")
      .select(cols, { count: "exact" })
      .eq("is_published", true)
      .order("published_at", { ascending: false })
      .range(from, to);

  let res = await q("id, published_at, cover_image_url, gallery_image_urls, primary_lang");
  if (res.error && isSchemaCacheMissingColumn(res.error, "gallery_image_urls")) {
    res = await q("id, published_at, cover_image_url, primary_lang");
  }
  if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
    res = await q("id, published_at, cover_image_url, gallery_image_urls");
    if (res.error && isSchemaCacheMissingColumn(res.error, "gallery_image_urls")) {
      res = await q("id, published_at, cover_image_url");
    }
  }
  if (res.error && isSchemaCacheMissingColumn(res.error, "cover_image_url")) {
    res = await q("id, published_at, primary_lang, gallery_image_urls");
    if (res.error && isSchemaCacheMissingColumn(res.error, "gallery_image_urls")) {
      res = await q("id, published_at, primary_lang");
    }
    if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
      res = await q("id, published_at, gallery_image_urls");
      if (res.error && isSchemaCacheMissingColumn(res.error, "gallery_image_urls")) {
        res = await q("id, published_at");
      }
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (msg.includes("schema cache")) {
      res = await q("id, published_at");
    }
  }

  const total = res.count ?? 0;
  const totalPages = Math.max(1, Math.ceil(total / size));
  if (res.error) {
    return { items: [], total: 0, page: p, pageSize: size, totalPages: 0 };
  }

  type NewsListItem = {
    id: string;
    published_at: string;
    cover_image_url?: string | null;
    gallery_image_urls?: unknown;
    primary_lang?: string | null;
  };
  const news = (res.data ?? []) as unknown as NewsListItem[];
  if (!news.length) {
    return { items: [], total, page: p, pageSize: size, totalPages };
  }

  const ids = news.map((n) => n.id);
  const { data: i18nRows } = await supabase
    .from("news_i18n")
    .select("news_id, lang, title, excerpt, body")
    .in("news_id", ids);

  const byNews = new Map<
    string,
    Partial<Record<Lang, { title: string; excerpt: string | null; body: string }>>
  >();

  for (const r of i18nRows ?? []) {
    const row = r as {
      news_id: string;
      lang: string;
      title: string;
      excerpt: string | null;
      body: string;
    };
    if (!byNews.has(row.news_id)) byNews.set(row.news_id, {});
    const m = byNews.get(row.news_id)!;
    if (row.lang === "ru" || row.lang === "uk" || row.lang === "kk" || row.lang === "en") {
      m[row.lang] = {
        title: row.title,
        excerpt: row.excerpt,
        body: row.body,
      };
    }
  }

  const items = news
    .map((n) => {
      const m = byNews.get(n.id);
      const plRaw = n.primary_lang;
      const primaryLang =
        plRaw && ["ru", "uk", "kk", "en"].includes(plRaw) ? plRaw : null;
      const chosen = pickNewsI18nRow(m ?? {}, lang, primaryLang);
      if (!chosen) return null;
      return {
        id: n.id,
        published_at: n.published_at,
        title: chosen.title,
        excerpt: chosen.excerpt,
        body: chosen.body,
        coverImageUrl: n.cover_image_url ?? null,
        galleryImageUrls: normalizeGalleryUrls(n.gallery_image_urls),
      };
    })
    .filter((x): x is NewsRow => x != null);

  return { items, total, page: p, pageSize: size, totalPages };
}

export async function getNewsForLang(lang: Lang): Promise<NewsRow[]> {
  const { items } = await getNewsPage(lang, 1, 200);
  return items;
}

export type LiturgicalExtraView = {
  label: string;
  body: string;
  url: string | null;
};

export type LiturgicalEventView = {
  id: string;
  event_date: string;
  kind: string;
  kindLabel: string;
  title: string;
  explanation: string;
  prayer: string | null;
  coverImageUrl: string | null;
  galleryImageUrls: string[];
  extras: LiturgicalExtraView[];
};

type LiturgicalExtraRow = {
  event_id: string;
  sort_idx: number;
  label_ru: string | null;
  label_uk: string | null;
  label_kk: string | null;
  label_en: string | null;
  body_ru: string | null;
  body_uk: string | null;
  body_kk: string | null;
  body_en: string | null;
  url: string | null;
};

type LiturgicalEventPickRow = {
  id: string;
  event_date: string;
  kind: string;
  created_at?: string;
  primary_lang?: string | null;
  cover_image_url?: string | null;
  gallery_image_urls?: unknown;
  liturgical_event_i18n: {
    lang: string;
    title: string;
    explanation: string;
    prayer: string | null;
  }[];
};

type LiturgicalRowFilter =
  | { mode: "date"; dateStr: string }
  | { mode: "range"; start: string; end: string };

async function loadLiturgicalEventRows(
  supabase: SupabaseClient,
  filter: LiturgicalRowFilter,
  opts?: { limit?: number; offset?: number },
): Promise<LiturgicalEventPickRow[]> {
  const i18n =
    "liturgical_event_i18n ( lang, title, explanation, prayer )";
  const selFull = `id, event_date, kind, created_at, primary_lang, cover_image_url, gallery_image_urls, ${i18n}`;
  const selCoverOnly = `id, event_date, kind, created_at, cover_image_url, gallery_image_urls, ${i18n}`;
  const selPrimaryOnly = `id, event_date, kind, created_at, primary_lang, gallery_image_urls, ${i18n}`;
  const selMin = `id, event_date, kind, created_at, ${i18n}`;
  const stripGallery = (sel: string) => sel.replace("gallery_image_urls, ", "");

  const run = (sel: string) => {
    let base = supabase.from("liturgical_events").select(sel);
    if (filter.mode === "date") {
      base = base.eq("event_date", filter.dateStr).order("created_at", { ascending: false });
    } else {
      base = base
        .gte("event_date", filter.start)
        .lte("event_date", filter.end)
        .order("event_date", { ascending: true })
        .order("created_at", { ascending: false });
    }
    if (opts?.limit != null) {
      const from = opts.offset ?? 0;
      const to = from + opts.limit - 1;
      base = base.range(from, to);
    }
    return base;
  };

  let res = await run(selFull);
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) return [];
    if (msg.includes("gallery_image_urls")) {
      res = await run(stripGallery(selFull));
    } else if (msg.includes("primary_lang")) {
      res = await run(selCoverOnly);
    } else if (msg.includes("cover_image_url")) {
      res = await run(selPrimaryOnly);
    }
  }
  if (res.error) {
    const msg2 = res.error.message ?? "";
    if (msg2.includes("schema cache")) {
      if (msg2.includes("gallery_image_urls")) {
        res = await run(stripGallery(selMin));
      } else {
        res = await run(selMin);
      }
    }
  }
  if (res.error) return [];
  return (res.data ?? []) as unknown as LiturgicalEventPickRow[];
}

async function loadLiturgicalKindLabelMap(
  supabase: SupabaseClient,
  slugs: string[],
): Promise<Map<string, Partial<Record<Lang, string>>>> {
  const uniq = [...new Set(slugs)].filter(Boolean);
  const map = new Map<string, Partial<Record<Lang, string>>>();
  if (!uniq.length) return map;
  const { data, error } = await supabase
    .from("liturgical_kind_i18n")
    .select("kind_slug, lang, label")
    .in("kind_slug", uniq);
  if (error) return map;
  for (const row of data ?? []) {
    const r = row as { kind_slug: string; lang: string; label: string };
    if (!map.has(r.kind_slug)) map.set(r.kind_slug, {});
    const m = map.get(r.kind_slug)!;
    if (r.lang === "ru" || r.lang === "uk" || r.lang === "kk" || r.lang === "en") {
      m[r.lang] = r.label;
    }
  }
  return map;
}

async function loadLiturgicalExtrasByEventIds(
  supabase: SupabaseClient,
  eventIds: string[],
): Promise<Map<string, LiturgicalExtraRow[]>> {
  const out = new Map<string, LiturgicalExtraRow[]>();
  if (!eventIds.length) return out;
  const { data, error } = await supabase
    .from("liturgical_event_extra_fields")
    .select(
      "event_id, sort_idx, label_ru, label_uk, label_kk, label_en, body_ru, body_uk, body_kk, body_en, url",
    )
    .in("event_id", eventIds)
    .order("sort_idx", { ascending: true });
  if (error) return out;
  for (const row of data ?? []) {
    const r = row as LiturgicalExtraRow;
    if (!out.has(r.event_id)) out.set(r.event_id, []);
    out.get(r.event_id)!.push(r);
  }
  return out;
}

function pickI18nString(
  values: Partial<Record<Lang, string>>,
  lang: Lang,
  primaryLang: string | null,
): string {
  const order: Lang[] = [lang];
  if (primaryLang && ["ru", "uk", "kk", "en"].includes(primaryLang) && primaryLang !== lang) {
    order.push(primaryLang as Lang);
  }
  for (const l of ["ru", "uk", "kk", "en"] as Lang[]) {
    if (!order.includes(l)) order.push(l);
  }
  for (const l of order) {
    const v = (values[l] ?? "").trim();
    if (v) return v;
  }
  return "";
}

function pickLiturgicalExtraForLang(
  row: LiturgicalExtraRow,
  lang: Lang,
  primaryLang: string | null,
): { label: string; body: string; url: string | null } {
  const labels: Partial<Record<Lang, string>> = {
    ru: row.label_ru ?? "",
    uk: row.label_uk ?? "",
    kk: row.label_kk ?? "",
    en: row.label_en ?? "",
  };
  const bodies: Partial<Record<Lang, string>> = {
    ru: row.body_ru ?? "",
    uk: row.body_uk ?? "",
    kk: row.body_kk ?? "",
    en: row.body_en ?? "",
  };
  const body = pickI18nString(bodies, lang, primaryLang);
  const label = pickI18nString(labels, lang, primaryLang);
  const urlRaw = (row.url ?? "").trim();
  const url = urlRaw.length && body.length ? urlRaw : null;
  return { label, body, url };
}

function liturgicalExtrasToViews(
  rows: LiturgicalExtraRow[] | undefined,
  lang: Lang,
  primaryLang: string | null,
): LiturgicalExtraView[] {
  if (!rows?.length) return [];
  const list: LiturgicalExtraView[] = [];
  for (const row of rows) {
    const { label, body, url } = pickLiturgicalExtraForLang(row, lang, primaryLang);
    if (!body.trim()) continue;
    list.push({ label, body, url });
  }
  return list;
}

async function mapLiturgicalRowsToViews(
  supabase: SupabaseClient,
  events: LiturgicalEventPickRow[],
  lang: Lang,
): Promise<LiturgicalEventView[]> {
  if (!events.length) return [];
  const ids = events.map((e) => e.id);
  const kindMap = await loadLiturgicalKindLabelMap(
    supabase,
    events.map((e) => e.kind),
  );
  const extrasMap = await loadLiturgicalExtrasByEventIds(supabase, ids);
  return events.map((e) => {
    const v = pickI18n(e, lang);
    const km = kindMap.get(e.kind);
    const kindLabel =
      (km && (km[lang] ?? km.ru ?? km.uk ?? km.kk ?? km.en))?.trim() ||
      e.kind.replace(/_/g, " ");
    const pl =
      e.primary_lang && ["ru", "uk", "kk", "en"].includes(e.primary_lang)
        ? e.primary_lang
        : null;
    const extras = liturgicalExtrasToViews(extrasMap.get(e.id), lang, pl);
    return { ...v, kindLabel, extras };
  });
}

export type LiturgicalDatePage = {
  events: LiturgicalEventView[];
  hasMore: boolean;
};

export async function getLiturgicalForDatePage(
  dateStr: string,
  lang: Lang,
  page: number,
  pageSize = 10,
): Promise<LiturgicalDatePage> {
  const supabase = createPublicClient();
  const offset = Math.max(0, page - 1) * pageSize;
  const events = await loadLiturgicalEventRows(
    supabase,
    { mode: "date", dateStr },
    { limit: pageSize + 1, offset },
  );
  const hasMore = events.length > pageSize;
  const slice = hasMore ? events.slice(0, pageSize) : events;
  const views = await mapLiturgicalRowsToViews(supabase, slice, lang);
  return { events: views, hasMore };
}

export async function getLiturgicalForDate(
  dateStr: string,
  lang: Lang,
): Promise<LiturgicalEventView[]> {
  const { events } = await getLiturgicalForDatePage(dateStr, lang, 1, 10);
  return events;
}

export async function getLiturgicalForDateCount(dateStr: string): Promise<number> {
  const supabase = createPublicClient();
  const { count, error } = await supabase
    .from("liturgical_events")
    .select("id", { count: "exact", head: true })
    .eq("event_date", dateStr);
  if (error) return 0;
  return count ?? 0;
}

export async function getLiturgicalRange(
  start: string,
  end: string,
  lang: Lang,
): Promise<LiturgicalEventView[]> {
  const supabase = createPublicClient();
  const events = await loadLiturgicalEventRows(supabase, {
    mode: "range",
    start,
    end,
  });
  if (!events.length) return [];
  return mapLiturgicalRowsToViews(supabase, events, lang);
}

function pickI18n(
  e: {
    id: string;
    event_date: string;
    kind: string;
    primary_lang?: string | null;
    cover_image_url?: string | null;
    gallery_image_urls?: unknown;
    liturgical_event_i18n: {
      lang: string;
      title: string;
      explanation: string;
      prayer: string | null;
    }[];
  },
  lang: Lang,
): Omit<LiturgicalEventView, "kindLabel" | "extras"> {
  const rows = e.liturgical_event_i18n ?? [];
  const pl = e.primary_lang;
  const primaryLang = pl && ["ru", "uk", "kk", "en"].includes(pl) ? pl : null;
  const byLang: Partial<
    Record<Lang, { title: string; explanation: string; prayer: string | null }>
  > = {};
  for (const r of rows) {
    if (r.lang === "ru" || r.lang === "uk" || r.lang === "kk" || r.lang === "en") {
      byLang[r.lang] = {
        title: r.title,
        explanation: r.explanation,
        prayer: r.prayer,
      };
    }
  }
  const row = pickLiturgicalI18nRow(byLang, lang, primaryLang);
  const fallback = rows[0];
  const chosen = row ?? fallback;
  return {
    id: e.id,
    event_date: e.event_date,
    kind: e.kind,
    title: chosen?.title ?? "—",
    explanation: chosen?.explanation ?? "",
    prayer: chosen?.prayer ?? null,
    coverImageUrl: e.cover_image_url ?? null,
    galleryImageUrls: normalizeGalleryUrls(e.gallery_image_urls),
  };
}

type ScriptureLocaleRow = {
  lang: string;
  title: string | null;
  description: string | null;
  read_url: string | null;
  file_url: string | null;
  cover_image_url: string | null;
};

/** Пункт меню чтения/скачивания: при нескольких редакциях книги показываем все языки, даже без URL */
export type ScriptureEditionMenuItem = {
  langCode: string;
  label: string;
  url: string | null;
  /** Обложка редакции или обложка основной редакции, если у этой нет */
  coverUrl: string | null;
};

export type ScriptureBook = {
  id: string;
  created_at: string;
  title: string | null;
  description: string | null;
  coverImageUrl: string | null;
  galleryImageUrls: string[];
  /** Язык основной редакции (ru/uk/kk/en) или null для старых данных с lang=main */
  primaryLang: string | null;
  /** Есть отдельная запись main без primary_lang в БД */
  legacyMain: boolean;
  readMenu: ScriptureEditionMenuItem[];
  fileMenu: ScriptureEditionMenuItem[];
};

function scriptureLangLabel(siteLang: Lang, code: string): string {
  const key =
    code === "main"
      ? "scriptureEditionMain"
      : code === "ru"
        ? "langNativeRu"
        : code === "uk"
          ? "langNativeUk"
          : code === "kk"
            ? "langNativeKk"
            : code === "en"
              ? "langNativeEn"
              : null;
  return key ? t(siteLang, key) : code;
}

/** Порядок: интерфейс → основная редакция (или main) → ru…en → прочие */
function editionPriorityChain(
  editions: ScriptureLocaleRow[],
  siteLang: Lang,
  primaryLang: string | null,
): ScriptureLocaleRow[] {
  const by = (code: string) => editions.find((e) => e.lang === code);
  const seen = new Set<string>();
  const out: ScriptureLocaleRow[] = [];
  function take(row: ScriptureLocaleRow | undefined) {
    if (!row || seen.has(row.lang)) return;
    seen.add(row.lang);
    out.push(row);
  }
  for (const code of buildScriptureLangCodes(siteLang, primaryLang)) {
    take(by(code));
  }
  for (const e of editions) take(e);
  return out;
}

function scriptureEditionMenuLabel(siteLang: Lang, langCode: string, primaryLang: string | null): string {
  const base = scriptureLangLabel(siteLang, langCode);
  const isPrimary =
    (primaryLang && langCode === primaryLang) || (!primaryLang && langCode === "main");
  if (isPrimary) return `${base} (${t(siteLang, "scripturePrimaryBadge")})`;
  return base;
}

function sortEditionsForPublic(
  editions: ScriptureLocaleRow[],
  primaryLang: string | null,
): ScriptureLocaleRow[] {
  const rank = (l: string) => {
    if (primaryLang && l === primaryLang) return 0;
    if (!primaryLang && l === "main") return 0;
    const ord = ["ru", "uk", "kk", "en"];
    const i = ord.indexOf(l);
    return i === -1 ? 50 : i + 1;
  };
  return [...editions].sort((a, b) => rank(a.lang) - rank(b.lang));
}

function pickFieldFromChain(
  chain: ScriptureLocaleRow[],
  field: "title" | "description" | "cover_image_url",
): string | null {
  for (const row of chain) {
    const v = row[field];
    if (typeof v === "string" && v.trim()) return v.trim();
  }
  return null;
}

function mapScriptureBookRow(
  row: {
    id: string;
    created_at: string;
    primary_lang: string | null;
    gallery_image_urls?: unknown;
    scripture_book_locales: ScriptureLocaleRow[] | null;
  },
  siteLang: Lang,
): ScriptureBook {
  const editions = [...(row.scripture_book_locales ?? [])];
  const primaryLang =
    row.primary_lang && ["ru", "uk", "kk", "en"].includes(row.primary_lang)
      ? row.primary_lang
      : null;
  const legacyMain = !primaryLang && editions.some((e) => e.lang === "main");

  const chain = editionPriorityChain(editions, siteLang, primaryLang);
  const title = pickFieldFromChain(chain, "title");
  const description = pickFieldFromChain(chain, "description");
  const coverImageUrl = pickFieldFromChain(chain, "cover_image_url");

  const primaryRow = primaryLang
    ? editions.find((e) => e.lang === primaryLang)
    : editions.find((e) => e.lang === "main");
  const primaryCoverRaw = (primaryRow?.cover_image_url ?? "").trim();
  const primaryCover =
    primaryCoverRaw ||
    pickFieldFromChain(chain, "cover_image_url") ||
    editions.map((e) => (e.cover_image_url ?? "").trim()).find((s) => s.length) ||
    null;

  const sortedEditions = sortEditionsForPublic(editions, primaryLang);
  const readMenu: ScriptureEditionMenuItem[] = sortedEditions.map((e) => {
    const u = (e.read_url ?? "").trim();
    const cov = (e.cover_image_url ?? "").trim();
    return {
      langCode: e.lang,
      label: scriptureEditionMenuLabel(siteLang, e.lang, primaryLang),
      url: u.length ? u : null,
      coverUrl: cov || primaryCover || null,
    };
  });
  const fileMenu: ScriptureEditionMenuItem[] = sortedEditions.map((e) => {
    const u = (e.file_url ?? "").trim();
    const cov = (e.cover_image_url ?? "").trim();
    return {
      langCode: e.lang,
      label: scriptureEditionMenuLabel(siteLang, e.lang, primaryLang),
      url: u.length ? u : null,
      coverUrl: cov || primaryCover || null,
    };
  });

  return {
    id: row.id,
    created_at: row.created_at,
    title,
    description,
    coverImageUrl,
    galleryImageUrls: normalizeGalleryUrls(row.gallery_image_urls),
    primaryLang,
    legacyMain,
    readMenu,
    fileMenu,
  };
}

const SCRIPTURE_SELECT = `
      id,
      created_at,
      primary_lang,
      gallery_image_urls,
      scripture_book_locales ( lang, title, description, read_url, file_url, cover_image_url )
    `;

export async function getScriptureBooksPage(
  siteLang: Lang,
  page: number,
  pageSize = HOME_PAGE_SIZE,
): Promise<PagedResult<ScriptureBook>> {
  const supabase = createPublicClient();
  const p = Math.max(1, page);
  const size = Math.min(50, Math.max(1, pageSize));
  const from = (p - 1) * size;
  const to = from + size - 1;

  const { data, error, count } = await supabase
    .from("scripture_books")
    .select(SCRIPTURE_SELECT, { count: "exact" })
    .order("created_at", { ascending: false })
    .range(from, to);

  const total = count ?? 0;
  const totalPages = Math.max(1, Math.ceil(total / size));
  if (error || !data) {
    return { items: [], total: 0, page: p, pageSize: size, totalPages: 0 };
  }

  const items = (
    data as {
      id: string;
      created_at: string;
      primary_lang: string | null;
      scripture_book_locales: ScriptureLocaleRow[] | null;
    }[]
  ).map((row) => mapScriptureBookRow(row, siteLang));

  return { items, total, page: p, pageSize: size, totalPages };
}

export async function getScriptureBooks(siteLang: Lang): Promise<ScriptureBook[]> {
  const supabase = createPublicClient();
  const { data } = await supabase
    .from("scripture_books")
    .select(SCRIPTURE_SELECT)
    .order("created_at", { ascending: false })
    .limit(500);

  if (!data) return [];

  return (
    data as {
      id: string;
      created_at: string;
      primary_lang: string | null;
      scripture_book_locales: ScriptureLocaleRow[] | null;
    }[]
  ).map((row) => mapScriptureBookRow(row, siteLang));
}

const LIBRARY_FETCH_CAP = 500;

export type ScriptureLibraryFilters = {
  sort: "date" | "alpha";
  keyword?: string;
  from?: string;
  to?: string;
};

export async function getScriptureLibraryPage(
  siteLang: Lang,
  page: number,
  pageSize: number,
  filters: ScriptureLibraryFilters,
): Promise<PagedResult<ScriptureBook>> {
  const supabase = createPublicClient();
  const p = Math.max(1, page);
  const size = Math.min(50, Math.max(1, pageSize));

  const { data, error } = await supabase
    .from("scripture_books")
    .select(SCRIPTURE_SELECT)
    .order("created_at", { ascending: false })
    .limit(LIBRARY_FETCH_CAP);

  if (error || !data) {
    return { items: [], total: 0, page: p, pageSize: size, totalPages: 0 };
  }

  const rows = data as {
    id: string;
    created_at: string;
    primary_lang: string | null;
    scripture_book_locales: ScriptureLocaleRow[] | null;
  }[];

  let items = rows.map((row) => mapScriptureBookRow(row, siteLang));

  const kw = (filters.keyword ?? "").trim().toLowerCase();
  if (kw) {
    items = items.filter((b) => {
      const hay = `${b.title ?? ""} ${b.description ?? ""}`.toLowerCase();
      return hay.includes(kw);
    });
  }

  if (filters.from) {
    const fromMs = new Date(filters.from).setHours(0, 0, 0, 0);
    items = items.filter((b) => new Date(b.created_at).getTime() >= fromMs);
  }
  if (filters.to) {
    const toMs = new Date(filters.to).setHours(23, 59, 59, 999);
    items = items.filter((b) => new Date(b.created_at).getTime() <= toMs);
  }

  if (filters.sort === "alpha") {
    const collator = new Intl.Collator(siteLang === "kk" ? "kk" : siteLang === "uk" ? "uk" : siteLang === "en" ? "en" : "ru");
    items = [...items].sort((a, b) =>
      collator.compare((a.title ?? "").trim(), (b.title ?? "").trim()),
    );
  } else {
    items = [...items].sort(
      (a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime(),
    );
  }

  const total = items.length;
  const totalPages = total === 0 ? 0 : Math.max(1, Math.ceil(total / size));
  const fromIdx = (p - 1) * size;
  const slice = items.slice(fromIdx, fromIdx + size);

  return { items: slice, total, page: p, pageSize: size, totalPages };
}

export async function getTelegramMessages(limit = 30) {
  const supabase = createPublicClient();
  const { data } = await supabase
    .from("telegram_messages")
    .select("id, text, sent_at")
    .order("sent_at", { ascending: false })
    .limit(limit);
  return data ?? [];
}

export type FooterContactButton = {
  icon?: string;
  label: string;
  url: string;
};

/** Один объект JSON в site_settings.footer */
export type FooterSettings = {
  priest_name_ru?: string;
  priest_name_uk?: string;
  priest_name_kk?: string;
  priest_name_en?: string;
  phone?: string;
  email?: string;
  address_ru?: string;
  address_uk?: string;
  address_kk?: string;
  address_en?: string;
  extra_ru?: string;
  extra_uk?: string;
  extra_kk?: string;
  extra_en?: string;
  /** Старые данные: «название» в контактах — подставляется, если нет priest_name_* */
  name_ru?: string;
  name_uk?: string;
  name_kk?: string;
  name_en?: string;
  /** iframe src для карты на странице «Наши контакты»; только если задано в админке */
  map_embed_src?: string;
  /** Кнопки (иконка, название, ссылка) */
  contact_buttons?: FooterContactButton[];
};

export async function getFooterSettings(): Promise<FooterSettings> {
  const supabase = createPublicClient();
  const { data } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "footer")
    .maybeSingle();
  return (data?.value as FooterSettings) ?? {};
}

/** Виджеты prayer-service.pp.ua на главной (между нашим календарём и Telegram). */
export type ExternalLiturgicalWidgetSettings = {
  new_julian: boolean;
  gregorian: boolean;
};

const EXTERNAL_LITURGICAL_WIDGET_SRC = {
  new_julian: "https://prayer-service.pp.ua/u-widget.html",
  gregorian: "https://prayer-service.pp.ua/g-widget.html",
} as const;

/** Разбор JSON из БД; поддерживает старый формат `{ enabled, variant }`. */
export function parseExternalLiturgicalWidgetValue(
  raw: unknown,
): ExternalLiturgicalWidgetSettings {
  const v = raw && typeof raw === "object" ? (raw as Record<string, unknown>) : null;
  if (!v) return { new_julian: false, gregorian: false };
  if ("new_julian" in v || "gregorian" in v) {
    return {
      new_julian: Boolean(v.new_julian),
      gregorian: Boolean(v.gregorian),
    };
  }
  const enabled = Boolean(v.enabled);
  const variant = v.variant === "gregorian" ? "gregorian" : "new_julian";
  if (!enabled) return { new_julian: false, gregorian: false };
  if (variant === "gregorian") return { new_julian: false, gregorian: true };
  return { new_julian: true, gregorian: false };
}

export async function getExternalLiturgicalWidgetSettings(): Promise<ExternalLiturgicalWidgetSettings> {
  const supabase = createPublicClient();
  const { data } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "external_liturgical_widget")
    .maybeSingle();
  return parseExternalLiturgicalWidgetValue(data?.value);
}

/** URL iframe в порядке: новоюлианский, затем григорианский. */
export function resolveExternalLiturgicalWidgetSrcs(
  s: ExternalLiturgicalWidgetSettings | null | undefined,
): string[] {
  const out: string[] = [];
  if (s?.new_julian) out.push(EXTERNAL_LITURGICAL_WIDGET_SRC.new_julian);
  if (s?.gregorian) out.push(EXTERNAL_LITURGICAL_WIDGET_SRC.gregorian);
  return out;
}

function normalizeContactButtons(raw: unknown): FooterContactButton[] {
  if (!Array.isArray(raw)) return [];
  const out: FooterContactButton[] = [];
  for (const item of raw) {
    if (!item || typeof item !== "object") continue;
    const o = item as Record<string, unknown>;
    const url = typeof o.url === "string" ? o.url.trim() : "";
    const label = typeof o.label === "string" ? o.label.trim() : "";
    if (!url || !label) continue;
    const icon = typeof o.icon === "string" ? o.icon.trim() : "";
    out.push({ url, label, icon: icon || undefined });
  }
  return out;
}

export function resolveFooterDisplay(footer: FooterSettings, lang: Lang) {
  const f = footer as Record<string, string | undefined>;
  const priestName =
    pickLocalized(f, "priest_name", lang) ?? pickLocalized(f, "name", lang);
  const address = pickLocalized(f, "address", lang);
  const extra = pickLocalized(f, "extra", lang);
  const mapSrc = footer.map_embed_src?.trim();
  return {
    priestName,
    address: address ?? "",
    phone: footer.phone?.trim() || null,
    email: footer.email?.trim() || null,
    extra: extra ?? "",
    mapEmbedSrc: mapSrc || null,
    contactButtons: normalizeContactButtons(footer.contact_buttons),
  };
}

export async function getHistoryHtml(lang: Lang) {
  const supabase = createPublicClient();
  const { data: rows } = await supabase
    .from("page_content")
    .select("lang, body")
    .eq("page_key", "history")
    .in("lang", lang === "ru" ? ["ru"] : [lang, "ru"]);

  const byLang = Object.fromEntries(
    (rows ?? []).map((r: { lang: string; body: string }) => [r.lang, r.body]),
  );
  const primary = byLang[lang]?.trim();
  if (primary) return primary;
  return (byLang.ru ?? "").trim();
}

/** Строка БД kazakhstan_parishes */
export type KazakhstanParishRow = {
  id: string;
  sort_order: number;
  parish_photo_url: string | null;
  priest_photo_url: string | null;
  website_url: string | null;
  city_ru: string | null;
  city_uk: string | null;
  city_kk: string | null;
  city_en: string | null;
  name_ru: string | null;
  name_uk: string | null;
  name_kk: string | null;
  name_en: string | null;
  address_ru: string | null;
  address_uk: string | null;
  address_kk: string | null;
  address_en: string | null;
  priest_name_ru: string | null;
  priest_name_uk: string | null;
  priest_name_kk: string | null;
  priest_name_en: string | null;
  priest_contacts_ru: string | null;
  priest_contacts_uk: string | null;
  priest_contacts_kk: string | null;
  priest_contacts_en: string | null;
  map_embed_src?: string | null;
  created_at: string;
  updated_at: string;
};

export type PublicKazakhstanParish = {
  id: string;
  city: string;
  name: string;
  address: string;
  websiteUrl: string | null;
  parishPhotoUrl: string | null;
  priestPhotoUrl: string | null;
  priestName: string;
  priestContacts: string;
  mapEmbedSrc: string | null;
};

function mapParishRowToPublic(row: KazakhstanParishRow, lang: Lang): PublicKazakhstanParish {
  const r = row as unknown as Record<string, string | null | undefined>;
  return {
    id: row.id,
    city: pickLocalized(r, "city", lang) ?? "",
    name: pickLocalized(r, "name", lang) ?? "",
    address: pickLocalized(r, "address", lang) ?? "",
    websiteUrl: row.website_url?.trim() || null,
    parishPhotoUrl: row.parish_photo_url?.trim() || null,
    priestPhotoUrl: row.priest_photo_url?.trim() || null,
    priestName: pickLocalized(r, "priest_name", lang) ?? "",
    priestContacts: pickLocalized(r, "priest_contacts", lang) ?? "",
    mapEmbedSrc: row.map_embed_src?.trim() || null,
  };
}

export async function getPublishedKazakhstanParishes(lang: Lang): Promise<PublicKazakhstanParish[]> {
  const supabase = createPublicClient();
  const { data, error } = await supabase
    .from("kazakhstan_parishes")
    .select("*")
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error) return [];
  if (!data?.length) return [];
  return (data as KazakhstanParishRow[]).map((row) => mapParishRowToPublic(row, lang));
}

export async function getKazakhstanParishesForAdmin(): Promise<KazakhstanParishRow[]> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("kazakhstan_parishes")
    .select("*")
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error) return [];
  return (data ?? []) as KazakhstanParishRow[];
}

const CLERGY_LANGS = ["ru", "uk", "kk", "en"] as const;

/** Дополнительное поле: подпись и текст по языкам, общая ссылка. */
export type ClergyExtraField = {
  labels: Partial<Record<(typeof CLERGY_LANGS)[number], string>>;
  values: Partial<Record<(typeof CLERGY_LANGS)[number], string>>;
  url: string | null;
};

/** Строка БД clergy */
export type ClergyRow = {
  id: string;
  sort_order: number;
  photo_url: string | null;
  /** Сводное ФИО (дублирует приоритетный язык для совместимости и поиска). */
  full_name: string;
  full_name_ru: string | null;
  full_name_uk: string | null;
  full_name_kk: string | null;
  full_name_en: string | null;
  extra_fields: ClergyExtraField[];
  created_at: string;
  updated_at: string;
};

function mapClergyExtraFromDb(item: Record<string, unknown>): ClergyExtraField {
  const urlRaw = typeof item.url === "string" ? item.url.trim() : "";
  const labels: ClergyExtraField["labels"] = {};
  const values: ClergyExtraField["values"] = {};
  const labelsObj = item.labels as Record<string, unknown> | undefined;
  const valuesObj = item.values as Record<string, unknown> | undefined;
  if (labelsObj && typeof labelsObj === "object") {
    for (const l of CLERGY_LANGS) {
      const v = labelsObj[l];
      if (typeof v === "string" && v.trim()) labels[l] = v;
    }
  }
  if (valuesObj && typeof valuesObj === "object") {
    for (const l of CLERGY_LANGS) {
      const v = valuesObj[l];
      if (typeof v === "string" && v.trim()) values[l] = v;
    }
  }
  if (Object.keys(labels).length === 0 && typeof item.label === "string" && item.label.trim()) {
    labels.ru = item.label;
  }
  if (Object.keys(values).length === 0 && typeof item.value === "string" && item.value.trim()) {
    values.ru = item.value;
  }
  return {
    labels,
    values,
    url: urlRaw ? urlRaw : null,
  };
}

function mapClergyDbRow(row: Record<string, unknown>): ClergyRow {
  const rawEf = row.extra_fields;
  let extra_fields: ClergyExtraField[] = [];
  if (Array.isArray(rawEf)) {
    extra_fields = rawEf.map((item) => mapClergyExtraFromDb(item as Record<string, unknown>));
  }
  const fn = (k: string) => {
    const v = row[k];
    return typeof v === "string" && v.trim() ? v.trim() : null;
  };
  const full_name_ru = fn("full_name_ru");
  const full_name_uk = fn("full_name_uk");
  const full_name_kk = fn("full_name_kk");
  const full_name_en = fn("full_name_en");
  const legacy = typeof row.full_name === "string" ? row.full_name.trim() : "";
  const full_name =
    full_name_ru ||
    full_name_uk ||
    full_name_kk ||
    full_name_en ||
    legacy ||
    "";
  return {
    id: String(row.id),
    sort_order: Number(row.sort_order) || 0,
    photo_url: typeof row.photo_url === "string" ? row.photo_url : null,
    full_name,
    full_name_ru,
    full_name_uk,
    full_name_kk,
    full_name_en,
    extra_fields,
    created_at: typeof row.created_at === "string" ? row.created_at : "",
    updated_at: typeof row.updated_at === "string" ? row.updated_at : "",
  };
}

async function queryClergyRows(supabase: SupabaseClient): Promise<ClergyRow[]> {
  const { data, error } = await supabase
    .from("clergy")
    .select("*")
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error) return [];
  return (data ?? []).map((r) => mapClergyDbRow(r as Record<string, unknown>));
}

export async function getClergyForAdmin(): Promise<ClergyRow[]> {
  const supabase = await createClient();
  return queryClergyRows(supabase);
}

/** Публичный список (RLS: select для всех). */
export async function getClergyForPublic(): Promise<ClergyRow[]> {
  return queryClergyRows(createPublicClient());
}

