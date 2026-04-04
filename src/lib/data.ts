import { createClient } from "@/lib/supabase/server";
import type { Lang } from "@/lib/i18n";
import { format } from "date-fns";
import { pickLocalized } from "@/lib/locale-fallback";
import {
  buildScriptureLangCodes,
  pickLiturgicalI18nRow,
  pickNewsI18nRow,
} from "@/lib/content-lang-chain";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { t } from "@/lib/ui-strings";

export type NewsRow = {
  id: string;
  published_at: string;
  title: string;
  excerpt: string | null;
  body: string;
  coverImageUrl: string | null;
};

export async function getNewsForLang(lang: Lang): Promise<NewsRow[]> {
  const supabase = await createClient();
  const q = (cols: string) =>
    supabase
      .from("news")
      .select(cols)
      .eq("is_published", true)
      .order("published_at", { ascending: false })
      .limit(200);

  let res = await q("id, published_at, cover_image_url, primary_lang");
  if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
    res = await q("id, published_at, cover_image_url");
  }
  if (res.error && isSchemaCacheMissingColumn(res.error, "cover_image_url")) {
    res = await q("id, published_at, primary_lang");
    if (res.error && isSchemaCacheMissingColumn(res.error, "primary_lang")) {
      res = await q("id, published_at");
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (msg.includes("schema cache")) {
      res = await q("id, published_at");
    }
  }
  if (res.error) return [];
  type NewsListItem = {
    id: string;
    published_at: string;
    cover_image_url?: string | null;
    primary_lang?: string | null;
  };
  const news = (res.data ?? []) as unknown as NewsListItem[];
  if (!news.length) return [];

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

  return news
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
      };
    })
    .filter((x): x is NewsRow => x != null);
}

export type LiturgicalEventView = {
  id: string;
  event_date: string;
  kind: string;
  title: string;
  explanation: string;
  prayer: string | null;
  coverImageUrl: string | null;
};

type LiturgicalEventPickRow = {
  id: string;
  event_date: string;
  kind: string;
  sort_order?: number;
  primary_lang?: string | null;
  cover_image_url?: string | null;
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
  supabase: Awaited<ReturnType<typeof createClient>>,
  filter: LiturgicalRowFilter,
): Promise<LiturgicalEventPickRow[]> {
  const i18n =
    "liturgical_event_i18n ( lang, title, explanation, prayer )";
  const selFull = `id, event_date, kind, sort_order, primary_lang, cover_image_url, ${i18n}`;
  const selCoverOnly = `id, event_date, kind, sort_order, cover_image_url, ${i18n}`;
  const selPrimaryOnly = `id, event_date, kind, sort_order, primary_lang, ${i18n}`;
  const selMin = `id, event_date, kind, sort_order, ${i18n}`;

  const run = (sel: string) => {
    const base = supabase.from("liturgical_events").select(sel);
    if (filter.mode === "date") {
      return base.eq("event_date", filter.dateStr).order("sort_order");
    }
    return base
      .gte("event_date", filter.start)
      .lte("event_date", filter.end)
      .order("event_date")
      .order("sort_order");
  };

  let res = await run(selFull);
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) return [];
    if (msg.includes("primary_lang")) {
      res = await run(selCoverOnly);
    } else if (msg.includes("cover_image_url")) {
      res = await run(selPrimaryOnly);
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (msg.includes("schema cache")) {
      res = await run(selMin);
    }
  }
  if (res.error) return [];
  return (res.data ?? []) as unknown as LiturgicalEventPickRow[];
}

export async function getLiturgicalForDate(
  dateStr: string,
  lang: Lang,
): Promise<LiturgicalEventView[]> {
  const supabase = await createClient();
  const events = await loadLiturgicalEventRows(supabase, {
    mode: "date",
    dateStr,
  });
  if (!events.length) return [];
  return events.map((e) => pickI18n(e, lang));
}

export async function getLiturgicalRange(
  start: string,
  end: string,
  lang: Lang,
): Promise<LiturgicalEventView[]> {
  const supabase = await createClient();
  const events = await loadLiturgicalEventRows(supabase, {
    mode: "range",
    start,
    end,
  });
  if (!events.length) return [];
  return events.map((e) => pickI18n(e, lang));
}

function pickI18n(
  e: {
    id: string;
    event_date: string;
    kind: string;
    primary_lang?: string | null;
    cover_image_url?: string | null;
    liturgical_event_i18n: {
      lang: string;
      title: string;
      explanation: string;
      prayer: string | null;
    }[];
  },
  lang: Lang,
): LiturgicalEventView {
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
  };
}

export function todayStr() {
  return format(new Date(), "yyyy-MM-dd");
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
};

export type ScriptureBook = {
  id: string;
  sort_order: number;
  title: string | null;
  description: string | null;
  coverImageUrl: string | null;
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

export async function getScriptureBooks(siteLang: Lang): Promise<ScriptureBook[]> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("scripture_books")
    .select(
      `
      id,
      sort_order,
      primary_lang,
      scripture_book_locales ( lang, title, description, read_url, file_url, cover_image_url )
    `,
    )
    .order("sort_order", { ascending: true });

  if (!data) return [];

  return data.map(
    (row: {
      id: string;
      sort_order: number;
      primary_lang: string | null;
      scripture_book_locales: ScriptureLocaleRow[] | null;
    }) => {
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

      const sortedEditions = sortEditionsForPublic(editions, primaryLang);
      const readMenu: ScriptureEditionMenuItem[] = sortedEditions.map((e) => {
        const u = (e.read_url ?? "").trim();
        return {
          langCode: e.lang,
          label: scriptureEditionMenuLabel(siteLang, e.lang, primaryLang),
          url: u.length ? u : null,
        };
      });
      const fileMenu: ScriptureEditionMenuItem[] = sortedEditions.map((e) => {
        const u = (e.file_url ?? "").trim();
        return {
          langCode: e.lang,
          label: scriptureEditionMenuLabel(siteLang, e.lang, primaryLang),
          url: u.length ? u : null,
        };
      });

      return {
        id: row.id,
        sort_order: Number(row.sort_order ?? 0),
        title,
        description,
        coverImageUrl,
        primaryLang,
        legacyMain,
        readMenu,
        fileMenu,
      };
    },
  );
}

export async function getTelegramMessages(limit = 30) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("telegram_messages")
    .select("id, text, sent_at")
    .order("sent_at", { ascending: false })
    .limit(limit);
  return data ?? [];
}

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
};

export async function getFooterSettings(): Promise<FooterSettings> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "footer")
    .maybeSingle();
  return (data?.value as FooterSettings) ?? {};
}

export function resolveFooterDisplay(footer: FooterSettings, lang: Lang) {
  const f = footer as Record<string, string | undefined>;
  const priestName =
    pickLocalized(f, "priest_name", lang) ?? pickLocalized(f, "name", lang);
  const address = pickLocalized(f, "address", lang);
  const extra = pickLocalized(f, "extra", lang);
  return {
    priestName,
    address: address ?? "",
    phone: footer.phone?.trim() || null,
    email: footer.email?.trim() || null,
    extra: extra ?? "",
  };
}

export async function getHistoryHtml(lang: Lang) {
  const supabase = await createClient();
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
