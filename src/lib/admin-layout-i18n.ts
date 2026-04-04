import type { Lang } from "@/lib/i18n";

const interfaceLangLabel: Record<Lang, string> = {
  ru: "Язык интерфейса",
  uk: "Мова інтерфейсу",
  kk: "Интерфейс тілі",
  en: "Interface language",
};

const nav: Record<
  Lang,
  {
    home: string;
    news: string;
    calendar: string;
    scripture: string;
    history: string;
    settings: string;
    account: string;
    users: string;
    toSite: string;
    signOut: string;
  }
> = {
  ru: {
    home: "Главная",
    news: "Новости",
    calendar: "Календарь",
    scripture: "Писание",
    history: "История (текст)",
    settings: "Контакты / футер",
    account: "Пароль",
    users: "Пользователи",
    toSite: "На сайт",
    signOut: "Выйти",
  },
  uk: {
    home: "Головна",
    news: "Новини",
    calendar: "Календар",
    scripture: "Писання",
    history: "Історія (текст)",
    settings: "Контакти / підвал",
    account: "Пароль",
    users: "Користувачі",
    toSite: "На сайт",
    signOut: "Вийти",
  },
  kk: {
    home: "Басты бет",
    news: "Жаңалықтар",
    calendar: "Күнтізбе",
    scripture: "Жазба",
    history: "Тарих (мәтін)",
    settings: "Байланыс / футер",
    account: "Құпия сөз",
    users: "Пайдаланушылар",
    toSite: "Сайтқа",
    signOut: "Шығу",
  },
  en: {
    home: "Home",
    news: "News",
    calendar: "Calendar",
    scripture: "Scripture",
    history: "History (text)",
    settings: "Contacts / footer",
    account: "Password",
    users: "Users",
    toSite: "To website",
    signOut: "Sign out",
  },
};

const roleLabels: Record<Lang, Record<"admin" | "superadmin", string>> = {
  ru: { admin: "Админ", superadmin: "Суперадмин" },
  uk: { admin: "Адмін", superadmin: "Суперадмін" },
  kk: { admin: "Әкімші", superadmin: "Суперәкімші" },
  en: { admin: "Admin", superadmin: "Superadmin" },
};

export function adminInterfaceLanguageLabel(lang: Lang): string {
  return interfaceLangLabel[lang] ?? interfaceLangLabel.ru;
}

export function adminNavLabels(lang: Lang) {
  return nav[lang] ?? nav.ru;
}

export function adminRoleLabel(lang: Lang, role: "admin" | "superadmin"): string {
  const m = roleLabels[lang] ?? roleLabels.ru;
  return m[role] ?? role;
}

/** Экран админки «История» (текст страницы /history). */
export function adminHistoryScreenCopy(lang: Lang) {
  const d: Record<
    Lang,
    {
      pageTitle: string;
      listHint: string;
      cardTitle: string;
      versionsCount: string;
      emptySnippet: string;
      edit: string;
      cancel: string;
      save: string;
      modalTitle: string;
      primaryLangLabel: string;
      bodyLabel: string;
      closeAria: string;
      imageSection: string;
      insertImage: string;
      imageHint: string;
      uploading: string;
    }
  > = {
    ru: {
      pageTitle: "Страница «История»",
      listHint:
        "Текст публичной страницы /history. Абзацы или HTML; картинки — кнопкой загрузки (вставляется готовый тег img).",
      cardTitle: "История прихода",
      versionsCount: "языковых версий: 4",
      emptySnippet: "Текст ещё не задан",
      edit: "Редактировать",
      cancel: "Отмена",
      save: "Сохранить",
      modalTitle: "Редактирование страницы «История»",
      primaryLangLabel: "Сначала показывать поле языка (удобство редактирования)",
      bodyLabel: "Текст (HTML или абзацы)",
      closeAria: "Закрыть",
      imageSection: "Изображение в текст",
      insertImage: "Загрузить и вставить в текст",
      imageHint:
        "Файл сохраняется в хранилище; в поле добавится HTML с тегом img в позиции курсора.",
      uploading: "Загрузка…",
    },
    uk: {
      pageTitle: "Сторінка «Історія»",
      listHint:
        "Текст публічної сторінки /history. Абзаци або HTML; зображення — кнопкою завантаження (вставляється тег img).",
      cardTitle: "Історія парафії",
      versionsCount: "мовних версій: 4",
      emptySnippet: "Текст ще не задано",
      edit: "Редагувати",
      cancel: "Скасувати",
      save: "Зберегти",
      modalTitle: "Редагування сторінки «Історія»",
      primaryLangLabel: "Спочатку показувати поле мови (зручність редагування)",
      bodyLabel: "Текст (HTML або абзаци)",
      closeAria: "Закрити",
      imageSection: "Зображення в тексті",
      insertImage: "Завантажити й вставити в текст",
      imageHint:
        "Файл зберігається в сховищі; в поле додасться HTML з тегом img у позиції курсора.",
      uploading: "Завантаження…",
    },
    kk: {
      pageTitle: "«Тарих» беті",
      listHint:
        "Қоғамдық /history бетінің мәтіні. Абзацтар немесе HTML; суреттерді жүктеу түймесімен (img тегі қосылады).",
      cardTitle: "Приход тарихы",
      versionsCount: "тіл нұсқалары: 4",
      emptySnippet: "Мәтін әлі жоқ",
      edit: "Өңдеу",
      cancel: "Болдырмау",
      save: "Сақтау",
      modalTitle: "«Тарих» бетін өңдеу",
      primaryLangLabel: "Алдымен тіл өрісін көрсету (өңдеу ыңғайы)",
      bodyLabel: "Мәтін (HTML немесе абзацтар)",
      closeAria: "Жабу",
      imageSection: "Мәтіндегі сурет",
      insertImage: "Жүктеп, мәтінге қосу",
      imageHint:
        "Файл қоймада сақталады; өріс курсор орнына img тегімен HTML қосады.",
      uploading: "Жүктелуде…",
    },
    en: {
      pageTitle: "“History” page",
      listHint:
        "Public /history page copy. Paragraphs or HTML; use upload to insert an image (adds an img tag).",
      cardTitle: "Parish history",
      versionsCount: "language versions: 4",
      emptySnippet: "No content yet",
      edit: "Edit",
      cancel: "Cancel",
      save: "Save",
      modalTitle: "Edit “History” page",
      primaryLangLabel: "Show this language’s field first (editing order)",
      bodyLabel: "Body (HTML or paragraphs)",
      closeAria: "Close",
      imageSection: "Image in body",
      insertImage: "Upload and insert into text",
      imageHint:
        "File is stored in the bucket; HTML with an img tag is inserted at the cursor.",
      uploading: "Uploading…",
    },
  };
  return d[lang] ?? d.ru;
}
