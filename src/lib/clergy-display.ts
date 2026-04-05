import type { Lang } from "@/lib/i18n";

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
