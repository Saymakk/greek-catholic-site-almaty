import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";

export type HistoryLocaleFields = {
  lang: string;
  body: string;
};

export function normalizeHistoryLocales(
  rows: { lang: string; body: string | null }[],
): HistoryLocaleFields[] {
  const map = new Map(
    rows.filter((r) => ["ru", "uk", "kk", "en"].includes(r.lang)).map((r) => [r.lang, r]),
  );
  const out: HistoryLocaleFields[] = [];
  for (const code of CONTENT_ORDER) {
    const r = map.get(code);
    out.push({
      lang: code,
      body: r?.body ?? "",
    });
  }
  return out;
}

export function sortHistoryLangsForForm(codes: string[], primary: ContentLang): string[] {
  const set = new Set(codes.filter((c) => ["ru", "uk", "kk", "en"].includes(c)));
  for (const c of CONTENT_ORDER) set.add(c);
  const p = isContentLang(primary) ? primary : "ru";
  return [p, ...CONTENT_ORDER.filter((l) => l !== p && set.has(l))];
}
