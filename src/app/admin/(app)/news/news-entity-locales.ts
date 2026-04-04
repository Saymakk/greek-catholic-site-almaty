import type { NewsLocaleFields } from "./NewsEditForm";
import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";

export function normalizeNewsLocales(
  rows: {
    lang: string;
    title: string;
    excerpt: string | null;
    body: string;
  }[],
  primaryLang: string | null,
): NewsLocaleFields[] {
  const primary: ContentLang =
    primaryLang && isContentLang(primaryLang) ? primaryLang : "ru";
  const map = new Map(
    rows
      .filter((r) => ["ru", "uk", "kk", "en"].includes(r.lang))
      .map((r) => [r.lang, r]),
  );
  const out: NewsLocaleFields[] = [];
  const push = (code: ContentLang) => {
    const r = map.get(code);
    out.push(
      r
        ? {
            lang: r.lang,
            title: r.title,
            excerpt: r.excerpt ?? "",
            body: r.body,
          }
        : emptyNews(code),
    );
  };
  push(primary);
  for (const code of CONTENT_ORDER) {
    if (code === primary) continue;
    if (map.has(code)) push(code);
  }
  return out;
}

function emptyNews(lang: ContentLang): NewsLocaleFields {
  return { lang, title: "", excerpt: "", body: "" };
}

export function sortNewsLangsForForm(codes: string[], primary: ContentLang): string[] {
  const set = new Set(codes.filter((c) => c !== "main"));
  set.add(primary);
  return [primary, ...CONTENT_ORDER.filter((l) => l !== primary && set.has(l))];
}
