import type { Lang } from "@/lib/i18n";

export type AdminSharedImageCopy = {
  orImageUrl: string;
  imageUrlPlaceholder: string;
  fileWinsHint: string;
  /** Кнопка вставки по URL (например в HTML «История») */
  insertFromUrl: string;
};

const d: Record<Lang, AdminSharedImageCopy> = {
  ru: {
    orImageUrl: "Или ссылка на изображение",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Если указаны и файл, и ссылка, сохраняется файл.",
    insertFromUrl: "Вставить в текст по ссылке",
  },
  uk: {
    orImageUrl: "Або посилання на зображення",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Якщо вказано і файл, і посилання, зберігається файл.",
    insertFromUrl: "Вставити в текст за посиланням",
  },
  kk: {
    orImageUrl: "Немесе сурет сілтемесі",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Файл мен сілтеме екеуі де болса, файл сақталады.",
    insertFromUrl: "Сілтеме бойынша мәтінге қосу",
  },
  en: {
    orImageUrl: "Or image URL",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "If both a file and a URL are set, the file is saved.",
    insertFromUrl: "Insert from URL into text",
  },
};

export function adminSharedImageCopy(lang: Lang): AdminSharedImageCopy {
  return d[lang] ?? d.ru;
}
