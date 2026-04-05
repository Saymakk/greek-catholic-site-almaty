import type { Lang } from "@/lib/i18n";

/** Если в БД нет строки в liturgical_kind_i18n — запасные подписи по языку интерфейса */
export const PRESET_FALLBACK: Record<string, Record<Lang, string>> = {
  great_feast: {
    ru: "Великий праздник",
    uk: "Велике свято",
    kk: "Үлкен мереке",
    en: "Great feast",
  },
  feast: {
    ru: "Праздник",
    uk: "Свято",
    kk: "Мереке",
    en: "Feast",
  },
  sunday: {
    ru: "Воскресенье",
    uk: "Неділя",
    kk: "Жексенбі",
    en: "Sunday",
  },
  fast: {
    ru: "Пост",
    uk: "Піст",
    kk: "Ораза",
    en: "Fast",
  },
  commemoration: {
    ru: "Память",
    uk: "Пам\u0027ять",
    kk: "Еске алу",
    en: "Commemoration",
  },
  other: {
    ru: "Другое",
    uk: "Інше",
    kk: "Басқа",
    en: "Other",
  },
};

export function buildKindSlugLabelMap(
  rows: { kind_slug: string; lang: string; label: string }[],
): Map<string, Partial<Record<Lang, string>>> {
  const m = new Map<string, Partial<Record<Lang, string>>>();
  for (const r of rows) {
    if (!m.has(r.kind_slug)) m.set(r.kind_slug, {});
    const lg = r.lang as Lang;
    if (lg === "ru" || lg === "uk" || lg === "kk" || lg === "en") {
      (m.get(r.kind_slug) as Partial<Record<Lang, string>>)[lg] = r.label;
    }
  }
  return m;
}

export function pickKindListLabel(
  slug: string,
  bySlug: Map<string, Partial<Record<Lang, string>>>,
  uiLang: Lang,
): string {
  const entry = bySlug.get(slug);
  const order: Lang[] = [uiLang, "ru", "uk", "kk", "en"];
  if (entry) {
    for (const L of order) {
      const v = entry[L]?.trim();
      if (v) return v;
    }
  }
  const preset = PRESET_FALLBACK[slug];
  if (preset) {
    for (const L of order) {
      const v = preset[L]?.trim();
      if (v) return v;
    }
  }
  return slug.replace(/_/g, " ");
}

/** Для клиента: карта slug → подписи из liturgical_kind_i18n. */
export function kindLabelMapToRecord(
  map: Map<string, Partial<Record<Lang, string>>>,
): Record<string, Partial<Record<Lang, string>>> {
  return Object.fromEntries(map.entries());
}
