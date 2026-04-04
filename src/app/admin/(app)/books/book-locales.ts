import type { BookLocaleFields } from "./BookEditForm";

export const CONTENT_ORDER = ["ru", "uk", "kk", "en"] as const;
const LEGACY_ORDER = ["main", ...CONTENT_ORDER] as const;

export type ContentLang = (typeof CONTENT_ORDER)[number];

export function isContentLang(code: string): code is ContentLang {
  return (CONTENT_ORDER as readonly string[]).includes(code);
}

function toFields(
  r: {
    lang: string;
    title: string | null;
    description: string | null;
    read_url: string | null;
    file_url: string | null;
    cover_image_url: string | null;
  },
): BookLocaleFields {
  return {
    lang: r.lang,
    title: r.title ?? "",
    description: r.description ?? "",
    read_url: r.read_url ?? "",
    file_url: r.file_url ?? "",
    cover_image_url: r.cover_image_url,
  };
}

function emptyFields(lang: string): BookLocaleFields {
  return {
    lang,
    title: "",
    description: "",
    read_url: "",
    file_url: "",
    cover_image_url: null,
  };
}

/**
 * @param primaryLang — с колонки scripture_books; если задан, строка lang=main игнорируется.
 */
export function normalizeBookLocales(
  rows: {
    lang: string;
    title: string | null;
    description: string | null;
    read_url: string | null;
    file_url: string | null;
    cover_image_url: string | null;
  }[],
  primaryLang: string | null,
): BookLocaleFields[] {
  if (primaryLang && isContentLang(primaryLang)) {
    const filtered = rows.filter((r) => r.lang !== "main");
    const map = new Map(filtered.map((r) => [r.lang, r]));
    const out: BookLocaleFields[] = [];
    const push = (code: string) => {
      const r = map.get(code);
      out.push(r ? toFields(r) : emptyFields(code));
    };
    push(primaryLang);
    for (const code of CONTENT_ORDER) {
      if (code === primaryLang) continue;
      if (map.has(code)) push(code);
    }
    return out;
  }

  const rank = (l: string) => {
    const i = (LEGACY_ORDER as readonly string[]).indexOf(l);
    return i === -1 ? 99 : i;
  };
  const sorted = [...rows].sort((a, b) => rank(a.lang) - rank(b.lang));
  if (!sorted.some((r) => r.lang === "main")) {
    return [emptyFields("main"), ...sorted.map(toFields)];
  }
  return sorted.map(toFields);
}

/** Порядок вкладок языков в форме (primary всегда первый, кроме legacy с main). */
export function sortLangsForForm(codes: string[], primary: ContentLang, legacy: boolean): string[] {
  if (legacy) {
    const lo = ["main", "ru", "uk", "kk", "en"];
    const rank = (l: string) => {
      const i = lo.indexOf(l);
      return i === -1 ? 99 : i;
    };
    return [...new Set(codes)].sort((a, b) => rank(a) - rank(b));
  }
  const set = new Set(codes.filter((c) => c !== "main"));
  set.add(primary);
  return [primary, ...CONTENT_ORDER.filter((l) => l !== primary && set.has(l))];
}
