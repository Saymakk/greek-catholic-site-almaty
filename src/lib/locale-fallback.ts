import type { Lang } from "./i18n";

/** Строка на выбранном языке или запасной вариант на русском. */
export function pickLocalized(
  row: Record<string, string | null | undefined>,
  baseKey: string,
  lang: Lang,
): string | null {
  const langVal = row[`${baseKey}_${lang}`];
  if (typeof langVal === "string" && langVal.trim()) return langVal.trim();
  const ru = row[`${baseKey}_ru`];
  if (typeof ru === "string" && ru.trim()) return ru.trim();
  return null;
}
