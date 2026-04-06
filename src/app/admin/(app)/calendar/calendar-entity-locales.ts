import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";

export type CalendarLocaleFields = {
  lang: string;
  title: string;
  explanation: string;
  prayer: string;
};

export function normalizeCalendarLocales(
  rows: {
    lang: string;
    title: string;
    explanation: string;
    prayer: string | null;
  }[],
  primaryLang: string | null,
  uiFallback: ContentLang = "ru",
): CalendarLocaleFields[] {
  const primary: ContentLang =
    primaryLang && isContentLang(primaryLang) ? primaryLang : uiFallback;
  const map = new Map(
    rows
      .filter((r) => ["ru", "uk", "kk", "en"].includes(r.lang))
      .map((r) => [r.lang, r]),
  );
  const out: CalendarLocaleFields[] = [];
  const push = (code: ContentLang) => {
    const r = map.get(code);
    out.push(
      r
        ? {
            lang: r.lang,
            title: r.title,
            explanation: r.explanation,
            prayer: r.prayer ?? "",
          }
        : emptyCal(code),
    );
  };
  push(primary);
  for (const code of CONTENT_ORDER) {
    if (code === primary) continue;
    if (map.has(code)) push(code);
  }
  return out;
}

function emptyCal(lang: ContentLang): CalendarLocaleFields {
  return { lang, title: "", explanation: "", prayer: "" };
}

export function sortCalendarLangsForForm(codes: string[], primary: ContentLang): string[] {
  const set = new Set(codes.filter((c) => c !== "main"));
  set.add(primary);
  return [primary, ...CONTENT_ORDER.filter((l) => l !== primary && set.has(l))];
}
