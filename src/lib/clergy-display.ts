import type { Lang } from "@/lib/i18n";
import type { ClergyExtraField } from "@/lib/data";

/** Поля имён без зависимости от server-only `data.ts`. */
export type ClergyNameRow = {
  full_name: string;
  full_name_ru: string | null;
  full_name_uk: string | null;
  full_name_kk: string | null;
  full_name_en: string | null;
};

export function displayClergyName(row: ClergyNameRow, lang: Lang): string {
  const byLang: Record<Lang, string | null> = {
    ru: row.full_name_ru,
    uk: row.full_name_uk,
    kk: row.full_name_kk,
    en: row.full_name_en,
  };
  const p = byLang[lang]?.trim();
  if (p) return p;
  return (
    row.full_name_ru?.trim() ||
    row.full_name_uk?.trim() ||
    row.full_name_kk?.trim() ||
    row.full_name_en?.trim() ||
    row.full_name.trim() ||
    ""
  );
}

const EXTRA_LANG_FALLBACK: Lang[] = ["ru", "uk", "kk", "en"];

function pickExtraLangString(
  map: Partial<Record<Lang, string>>,
  lang: Lang,
): string {
  const order: Lang[] = [lang, ...EXTRA_LANG_FALLBACK.filter((l) => l !== lang)];
  for (const l of order) {
    const v = map[l]?.trim();
    if (v) return v;
  }
  return "";
}

export function displayClergyExtraLabel(field: ClergyExtraField, lang: Lang): string {
  return pickExtraLangString(field.labels, lang);
}

export function displayClergyExtraValue(field: ClergyExtraField, lang: Lang): string {
  return pickExtraLangString(field.values, lang);
}
