import type { Lang } from "@/lib/i18n";

export type AdminSharedImageCopy = {
  orImageUrl: string;
  imageUrlPlaceholder: string;
  fileWinsHint: string;
  /** Кнопка вставки по URL (например в HTML «История») */
  insertFromUrl: string;
  galleryTitle: string;
  galleryHint: string;
  galleryAddFiles: string;
  /** Заголовок блока полей ввода URL */
  galleryUrlsByLink: string;
  galleryAddUrlField: string;
  galleryRemoveUrlField: string;
  galleryRemoveImage: string;
};

const d: Record<Lang, AdminSharedImageCopy> = {
  ru: {
    orImageUrl: "Или ссылка на изображение",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Если указаны и файл, и ссылка, сохраняется файл.",
    insertFromUrl: "Вставить в текст по ссылке",
    galleryTitle: "Дополнительные изображения",
    galleryHint:
      "Можно добавить несколько фото; каждое можно убрать отдельно до сохранения. Обложка задаётся выше.",
    galleryAddFiles: "Добавить файлы",
    galleryUrlsByLink: "По ссылке (можно несколько полей)",
    galleryAddUrlField: "Добавить ещё поле для ссылки",
    galleryRemoveUrlField: "Убрать поле",
    galleryRemoveImage: "Убрать изображение",
  },
  uk: {
    orImageUrl: "Або посилання на зображення",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Якщо вказано і файл, і посилання, зберігається файл.",
    insertFromUrl: "Вставити в текст за посиланням",
    galleryTitle: "Додаткові зображення",
    galleryHint:
      "Можна додати кілька фото; кожне можна прибрати окремо перед збереженням. Обкладинка — вище.",
    galleryAddFiles: "Додати файли",
    galleryUrlsByLink: "За посиланням (кілька полів)",
    galleryAddUrlField: "Ще одне поле для посилання",
    galleryRemoveUrlField: "Прибрати поле",
    galleryRemoveImage: "Прибрати зображення",
  },
  kk: {
    orImageUrl: "Немесе сурет сілтемесі",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "Файл мен сілтеме екеуі де болса, файл сақталады.",
    insertFromUrl: "Сілтеме бойынша мәтінге қосу",
    galleryTitle: "Қосымша суреттер",
    galleryHint:
      "Бірнеше фото қосуға болады; сақтау алдында әрқайсысын жеке алып тастауға болады. Мұқаба жоғарыда.",
    galleryAddFiles: "Файлдар қосу",
    galleryUrlsByLink: "Сілтеме бойынша (бірнеше өріс)",
    galleryAddUrlField: "Тағы бір өріс қосу",
    galleryRemoveUrlField: "Өрісті жою",
    galleryRemoveImage: "Суретті алып тастау",
  },
  en: {
    orImageUrl: "Or image URL",
    imageUrlPlaceholder: "https://…",
    fileWinsHint: "If both a file and a URL are set, the file is saved.",
    insertFromUrl: "Insert from URL into text",
    galleryTitle: "Additional images",
    galleryHint:
      "Add multiple photos; remove any before saving. The main thumbnail/cover is set above.",
    galleryAddFiles: "Add files",
    galleryUrlsByLink: "By URL (multiple fields)",
    galleryAddUrlField: "Add another URL field",
    galleryRemoveUrlField: "Remove field",
    galleryRemoveImage: "Remove image",
  },
};

export function adminSharedImageCopy(lang: Lang): AdminSharedImageCopy {
  return d[lang] ?? d.ru;
}
