import type { Lang } from "@/lib/i18n";
import { isNewsCoverVideoEmbed } from "@/lib/news-cover";

const ORDER: Lang[] = ["ru", "uk", "kk", "en"];

/** Как в saveNews: пустой заголовок в форме сохраняется таким текстом */
const NEWS_PLACEHOLDER_TITLE = "Без заголовка";

/**
 * Порядок для публичного контента: язык интерфейса → основной → остальные (ru, uk, kk, en).
 */
export function buildContentLangChain(siteLang: Lang, primaryLang: string | null): Lang[] {
  const out: Lang[] = [];
  const add = (c: Lang) => {
    if (!out.includes(c)) out.push(c);
  };
  add(siteLang);
  if (primaryLang && ORDER.includes(primaryLang as Lang)) {
    add(primaryLang as Lang);
  }
  for (const l of ORDER) add(l);
  return out;
}

/**
 * Цепочка для Писания: интерфейс → primary или main → ru…en.
 */
export function buildScriptureLangCodes(siteLang: Lang, primaryLang: string | null): string[] {
  const out: string[] = [];
  const add = (c: string) => {
    if (!out.includes(c)) out.push(c);
  };
  add(siteLang);
  if (primaryLang && ORDER.includes(primaryLang as Lang)) add(primaryLang);
  else add("main");
  for (const l of ORDER) add(l);
  return out;
}

function newsBodyHasTextOrEmbed(body: string): boolean {
  const b = body.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
  if (b.length > 0) return true;
  return isNewsCoverVideoEmbed(body);
}

function rowHasNewsContent(row: { title: string; body: string } | undefined): boolean {
  if (!row) return false;
  const t = row.title?.trim() ?? "";
  if (!t.length) return false;
  if (newsBodyHasTextOrEmbed(row.body ?? "")) return true;
  /**
   * Заголовок задан явно, а «Текст» пустой в админке → в БД `<p></p>`: без видимого текста,
   * но локаль должна участвовать в выборе языка.
   */
  if (t !== NEWS_PLACEHOLDER_TITLE) return true;
  return false;
}

export function pickNewsI18nRow<T extends { title: string; excerpt: string | null; body: string }>(
  byLang: Partial<Record<Lang, T>>,
  siteLang: Lang,
  primaryLang: string | null,
): T | null {
  const chain = buildContentLangChain(siteLang, primaryLang);
  for (const code of chain) {
    const row = byLang[code];
    if (row && rowHasNewsContent(row)) return row;
  }
  for (const l of ORDER) {
    const row = byLang[l];
    if (row?.title?.trim()) return row ?? null;
  }
  return null;
}

export function pickLiturgicalI18nRow<
  T extends { title: string; explanation: string; prayer: string | null },
>(byLang: Partial<Record<Lang, T>>, siteLang: Lang, primaryLang: string | null): T | null {
  const chain = buildContentLangChain(siteLang, primaryLang);
  for (const code of chain) {
    const row = byLang[code];
    const t = row?.title?.trim() ?? "";
    const x = row?.explanation?.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim() ?? "";
    if (row && t && x) return row;
  }
  for (const l of ORDER) {
    const row = byLang[l];
    if (row?.title?.trim()) return row ?? null;
  }
  return null;
}
