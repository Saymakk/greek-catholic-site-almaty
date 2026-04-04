import type { Lang } from "@/lib/i18n";

const labels: Record<Lang, string> = {
  ru: "Язык интерфейса",
  uk: "Мова інтерфейсу",
  kk: "Интерфейс тілі",
  en: "Interface language",
};

export function adminInterfaceLanguageLabel(lang: Lang): string {
  return labels[lang] ?? labels.ru;
}
