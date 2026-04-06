export const LANGS = ["uk", "ru", "kk", "en"] as const;
export type Lang = (typeof LANGS)[number];

export const LANG_NAMES: Record<Lang, string> = {
  ru: "Русский",
  uk: "Українська",
  kk: "Қазақша",
  en: "English",
};

export const LANG_COOKIE = "parish_lang";
