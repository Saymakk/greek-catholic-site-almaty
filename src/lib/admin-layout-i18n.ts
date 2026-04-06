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
    books: string;
    history: string;
    parishes: string;
    clergy: string;
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
    books: "Книги",
    history: "История (текст)",
    parishes: "Приходы Казахстана",
    clergy: "Священнослужители",
    settings: "Контакты",
    account: "Пароль",
    users: "Пользователи",
    toSite: "На сайт",
    signOut: "Выйти",
  },
  uk: {
    home: "Головна",
    news: "Новини",
    calendar: "Календар",
    books: "Книги",
    history: "Історія (текст)",
    parishes: "Парафії Казахстану",
    clergy: "Духовенство",
    settings: "Контакти",
    account: "Пароль",
    users: "Користувачі",
    toSite: "На сайт",
    signOut: "Вийти",
  },
  kk: {
    home: "Басты бет",
    news: "Жаңалықтар",
    calendar: "Күнтізбе",
    books: "Кітаптар",
    history: "Тарих (мәтін)",
    parishes: "Қазақстан қауымдары",
    clergy: "Дін қызметкерлері",
    settings: "Байланыс",
    account: "Құпия сөз",
    users: "Пайдаланушылар",
    toSite: "Сайтқа",
    signOut: "Шығу",
  },
  en: {
    home: "Home",
    news: "News",
    calendar: "Calendar",
    books: "Books",
    history: "History (text)",
    parishes: "Kazakhstan parishes",
    clergy: "Clergy",
    settings: "Contacts",
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

export function adminCalendarScreenCopy(lang: Lang) {
  const d: Record<
    Lang,
    {
      title: string;
      intro: string;
      add: string;
      save: string;
      edit: string;
      delete: string;
      confirmDelete: string;
      newEvent: string;
      editEvent: string;
      closeAria: string;
      templatesTitle: string;
      templatesListEmpty: string;
      deleteTemplate: string;
      confirmDeleteTemplate: string;
      editTemplate: string;
      editTemplateTitle: string;
      editTemplateSave: string;
      offerTemplateTitle: string;
      offerTemplateHint: string;
      offerTemplateSave: string;
      offerTemplateSkip: string;
      externalWidgetNewJulian: string;
      externalWidgetGregorian: string;
    }
  > = {
    ru: {
      title: "Календарь",
      intro: "Здесь вы можете создавать, редактировать и удалять события в календаре.",
      add: "Добавить",
      save: "Сохранить",
      edit: "Редактировать",
      delete: "Удалить",
      confirmDelete: "Удалить это событие?",
      newEvent: "Новое событие",
      editEvent: "Редактирование события",
      closeAria: "Закрыть",
      templatesTitle: "Шаблоны полей",
      templatesListEmpty: "Шаблонов пока нет.",
      deleteTemplate: "Удалить шаблон",
      confirmDeleteTemplate: "Удалить этот шаблон?",
      editTemplate: "Редактировать шаблон",
      editTemplateTitle: "Редактирование шаблона",
      editTemplateSave: "Сохранить шаблон",
      offerTemplateTitle: "Сохранить поля как шаблон?",
      offerTemplateHint:
        "Можно сохранить только подписи дополнительных полей этого события как шаблон для будущих записей.",
      offerTemplateSave: "Сохранить шаблон",
      offerTemplateSkip: "Не сейчас",
      externalWidgetNewJulian: "Новоюлианский",
      externalWidgetGregorian: "Григорианский",
    },
    uk: {
      title: "Календар",
      intro: "Тут ви можете створювати, редагувати й видаляти події календаря.",
      add: "Додати",
      save: "Зберегти",
      edit: "Редагувати",
      delete: "Видалити",
      confirmDelete: "Видалити цю подію?",
      newEvent: "Нова подія",
      editEvent: "Редагування події",
      closeAria: "Закрити",
      templatesTitle: "Шаблони полів",
      templatesListEmpty: "Шаблонів ще немає.",
      deleteTemplate: "Видалити шаблон",
      confirmDeleteTemplate: "Видалити цей шаблон?",
      editTemplate: "Редагувати шаблон",
      editTemplateTitle: "Редагування шаблону",
      editTemplateSave: "Зберегти шаблон",
      offerTemplateTitle: "Зберегти поля як шаблон?",
      offerTemplateHint:
        "Можна зберегти лише підписи додаткових полів цієї події як шаблон для майбутніх записів.",
      offerTemplateSave: "Зберегти шаблон",
      offerTemplateSkip: "Не зараз",
      externalWidgetNewJulian: "Новоюліанський",
      externalWidgetGregorian: "Григоріанський",
    },
    kk: {
      title: "Күнтізбе",
      intro: "Мұнда күнтізбе оқиғаларын құруға, өңдеуге және жоюға болады.",
      add: "Қосу",
      save: "Сақтау",
      edit: "Өңдеу",
      delete: "Жою",
      confirmDelete: "Бұл оқиғаны жою керек пе?",
      newEvent: "Жаңа оқиға",
      editEvent: "Оқиғаны өңдеу",
      closeAria: "Жабу",
      templatesTitle: "Өріс үлгілері",
      templatesListEmpty: "Үлгілер әлі жоқ.",
      deleteTemplate: "Үлгіні жою",
      confirmDeleteTemplate: "Бұл үлгіні жою керек пе?",
      editTemplate: "Үлгіні өңдеу",
      editTemplateTitle: "Үлгіні өңдеу",
      editTemplateSave: "Үлгіні сақтау",
      offerTemplateTitle: "Өрістерді үлгі ретінде сақтау керек пе?",
      offerTemplateHint:
        "Осы оқиғаның қосымша өрістерінің тақырыптарын ғана болашақ жазбалар үшін үлгі ретінде сақтауға болады.",
      offerTemplateSave: "Үлгіні сақтау",
      offerTemplateSkip: "Кейінірек",
      externalWidgetNewJulian: "Жаңа юлиан",
      externalWidgetGregorian: "Григориан",
    },
    en: {
      title: "Calendar",
      intro: "Create, edit, and delete liturgical calendar events here.",
      add: "Add",
      save: "Save",
      edit: "Edit",
      delete: "Delete",
      confirmDelete: "Delete this event?",
      newEvent: "New event",
      editEvent: "Edit event",
      closeAria: "Close",
      templatesTitle: "Field templates",
      templatesListEmpty: "No templates yet.",
      deleteTemplate: "Delete template",
      confirmDeleteTemplate: "Delete this template?",
      editTemplate: "Edit template",
      editTemplateTitle: "Edit template",
      editTemplateSave: "Save template",
      offerTemplateTitle: "Save fields as a template?",
      offerTemplateHint:
        "You can save only the labels of this event’s extra fields as a template for future entries.",
      offerTemplateSave: "Save template",
      offerTemplateSkip: "Not now",
      externalWidgetNewJulian: "New Julian",
      externalWidgetGregorian: "Gregorian",
    },
  };
  return d[lang] ?? d.ru;
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

export type AdminNewsScreenCopy = {
  pageTitle: string;
  create: string;
  edit: string;
  delete: string;
  confirmDelete: string;
  draft: string;
  modalNew: string;
  modalEdit: string;
  closeAria: string;
  add: string;
  save: string;
  primaryLang: string;
  publishedAt: string;
  isPublished: string;
  cover: string;
  noCover: string;
  uploadCover: string;
  removeCover: string;
  title: string;
  excerpt: string;
  body: string;
  mainEdition: string;
  removeVersion: string;
  addLocale: string;
  cancel: string;
};

export function adminNewsScreenCopy(lang: Lang): AdminNewsScreenCopy {
  const d: Record<Lang, AdminNewsScreenCopy> = {
    ru: {
      pageTitle: "Новости",
      create: "Создать",
      edit: "Редактировать",
      delete: "Удалить",
      confirmDelete: "Удалить эту новость?",
      draft: "черновик",
      modalNew: "Новая новость",
      modalEdit: "Редактирование новости",
      closeAria: "Закрыть",
      add: "Добавить",
      save: "Сохранить",
      primaryLang: "Язык основной версии (не дублируется при добавлении языка)",
      publishedAt: "Дата публикации",
      isPublished: "Опубликовано",
      cover: "Обложка",
      noCover: "Нет обложки",
      uploadCover: "Загрузить или заменить",
      removeCover: "Удалить обложку",
      title: "Заголовок",
      excerpt: "Кратко",
      body: "Текст (обычный или HTML)",
      mainEdition: "основная версия",
      removeVersion: "Убрать версию",
      addLocale: "Добавить версию на языке:",
      cancel: "Отмена",
    },
    uk: {
      pageTitle: "Новини",
      create: "Створити",
      edit: "Редагувати",
      delete: "Видалити",
      confirmDelete: "Видалити цю новину?",
      draft: "чернетка",
      modalNew: "Нова новина",
      modalEdit: "Редагування новини",
      closeAria: "Закрити",
      add: "Додати",
      save: "Зберегти",
      primaryLang: "Мова основної версії (не дублюється при додаванні мови)",
      publishedAt: "Дата публікації",
      isPublished: "Опубліковано",
      cover: "Обкладинка",
      noCover: "Немає обкладинки",
      uploadCover: "Завантажити або замінити",
      removeCover: "Видалити обкладинку",
      title: "Заголовок",
      excerpt: "Коротко",
      body: "Текст (звичайний або HTML)",
      mainEdition: "основна версія",
      removeVersion: "Прибрати версію",
      addLocale: "Додати версію мовою:",
      cancel: "Скасувати",
    },
    kk: {
      pageTitle: "Жаңалықтар",
      create: "Құру",
      edit: "Өңдеу",
      delete: "Жою",
      confirmDelete: "Бұл жаңалықты жою керек пе?",
      draft: "жоба",
      modalNew: "Жаңа жаңалық",
      modalEdit: "Жаңалықты өңдеу",
      closeAria: "Жабу",
      add: "Қосу",
      save: "Сақтау",
      primaryLang: "Негізгі нұсқа тілі (тіл қосқанда қайталанбайды)",
      publishedAt: "Жарияланған күні",
      isPublished: "Жарияланған",
      cover: "Мұқаба",
      noCover: "Мұқаба жоқ",
      uploadCover: "Жүктеу немесе ауыстыру",
      removeCover: "Мұқабаны жою",
      title: "Тақырып",
      excerpt: "Қысқаша",
      body: "Мәтін (қалыпты немесе HTML)",
      mainEdition: "негізгі нұсқа",
      removeVersion: "Нұсқаны алып тастау",
      addLocale: "Тіл нұқасын қосу:",
      cancel: "Болдырмау",
    },
    en: {
      pageTitle: "News",
      create: "Create",
      edit: "Edit",
      delete: "Delete",
      confirmDelete: "Delete this news item?",
      draft: "draft",
      modalNew: "New news item",
      modalEdit: "Edit news item",
      closeAria: "Close",
      add: "Add",
      save: "Save",
      primaryLang: "Primary language (not duplicated when adding another language)",
      publishedAt: "Publication date",
      isPublished: "Published",
      cover: "Cover image",
      noCover: "No cover",
      uploadCover: "Upload or replace",
      removeCover: "Remove cover",
      title: "Title",
      excerpt: "Excerpt",
      body: "Body (plain text or HTML)",
      mainEdition: "primary edition",
      removeVersion: "Remove version",
      addLocale: "Add language version:",
      cancel: "Cancel",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminSettingsCopy = {
  pageTitle: string;
  intro: string;
  sharedSection: string;
  phoneLabel: string;
  emailLabel: string;
  langRu: string;
  langUk: string;
  langKk: string;
  langEn: string;
  priestNameLabel: string;
  addressLabel: string;
  extraLabel: string;
  mapSection: string;
  mapHint: string;
  contactButtonsSection: string;
  addContactButton: string;
  removeContactButton: string;
  iconLabel: string;
  buttonTitleLabel: string;
  buttonUrlLabel: string;
  iconHint: string;
  save: string;
  errButtons: string;
};

export function adminSettingsCopy(lang: Lang): AdminSettingsCopy {
  const d: Record<Lang, AdminSettingsCopy> = {
    ru: {
      pageTitle: "Контакты",
      intro: "Данные отображаются на странице «Наши контакты».",
      sharedSection: "Телефон и email",
      phoneLabel: "Телефон",
      emailLabel: "Email",
      langRu: "Русский",
      langUk: "Українська",
      langKk: "Қазақша",
      langEn: "English",
      priestNameLabel: "Имя священника",
      addressLabel: "Адрес",
      extraLabel: "Дополнительный текст",
      mapSection: "Карта (страница «Наши контакты»)",
      mapHint:
        "Вставьте полный тег iframe из Google Maps («Поделиться» → «Встроить карту») или только URL. Пустое поле — карта на сайте не показывается.",
      contactButtonsSection: "Кнопки со ссылками",
      addContactButton: "Добавить кнопку",
      removeContactButton: "Удалить",
      iconLabel: "Иконка",
      buttonTitleLabel: "Название",
      buttonUrlLabel: "Ссылка",
      iconHint: "Эмодзи, слово telegram (иконка Telegram) или URL картинки",
      save: "Сохранить",
      errButtons: "Некорректные данные кнопок. Проверьте JSON или обновите страницу.",
    },
    uk: {
      pageTitle: "Контакти",
      intro: "Дані відображаються на сторінці «Наші контакти».",
      sharedSection: "Телефон і email",
      phoneLabel: "Телефон",
      emailLabel: "Email",
      langRu: "Російська",
      langUk: "Українська",
      langKk: "Қазақша",
      langEn: "English",
      priestNameLabel: "Ім’я священика",
      addressLabel: "Адреса",
      extraLabel: "Додатковий текст",
      mapSection: "Мапа (сторінка «Наші контакти»)",
      mapHint:
        "Повний тег iframe з Google Maps або лише URL. Порожнє поле — карту не показуємо.",
      contactButtonsSection: "Кнопки з посиланнями",
      addContactButton: "Додати кнопку",
      removeContactButton: "Прибрати",
      iconLabel: "Іконка",
      buttonTitleLabel: "Назва",
      buttonUrlLabel: "Посилання",
      iconHint: "Емодзі, слово telegram або URL зображення",
      save: "Зберегти",
      errButtons: "Некоректні дані кнопок.",
    },
    kk: {
      pageTitle: "Байланыс",
      intro: "Деректер «Біздің байланыстар» бетінде көрсетіледі.",
      sharedSection: "Телефон және email",
      phoneLabel: "Телефон",
      emailLabel: "Email",
      langRu: "Орысша",
      langUk: "Українська",
      langKk: "Қазақша",
      langEn: "Ағылшын",
      priestNameLabel: "Священник аты",
      addressLabel: "Мекенжай",
      extraLabel: "Қосымша мәтін",
      mapSection: "Картадағы көрініс («Біздің байланыстар»)",
      mapHint: "Google Maps iframe тегі немесе тек URL. Бос — карта көрсетілмейді.",
      contactButtonsSection: "Сілтемелі түймелер",
      addContactButton: "Түйме қосу",
      removeContactButton: "Жою",
      iconLabel: "Белгіше",
      buttonTitleLabel: "Атауы",
      buttonUrlLabel: "Сілтеме",
      iconHint: "Эмодзи, telegram сөзі немесе сурет URL",
      save: "Сақтау",
      errButtons: "Түймелер дерегі дұрыс емес.",
    },
    en: {
      pageTitle: "Contacts",
      intro: "Shown on the “Our contacts” page.",
      sharedSection: "Phone & email",
      phoneLabel: "Phone",
      emailLabel: "Email",
      langRu: "Russian",
      langUk: "Ukrainian",
      langKk: "Kazakh",
      langEn: "English",
      priestNameLabel: "Priest name",
      addressLabel: "Address",
      extraLabel: "Extra text",
      mapSection: "Map (“Our contacts” page)",
      mapHint:
        "Paste the full iframe from Google Maps or a URL only. Empty — no map on the site.",
      contactButtonsSection: "Link buttons",
      addContactButton: "Add button",
      removeContactButton: "Remove",
      iconLabel: "Icon",
      buttonTitleLabel: "Label",
      buttonUrlLabel: "URL",
      iconHint: "Emoji, the word telegram, or an image URL",
      save: "Save",
      errButtons: "Invalid button data.",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminParishesScreenCopy = {
  pageTitle: string;
  pageIntro: string;
  emptyList: string;
  addParish: string;
  save: string;
  delete: string;
  confirmDelete: string;
  cancel: string;
  mapIframeField: string;
  mapIframeHint: string;
  removeParishPhoto: string;
  removePriestPhoto: string;
  websiteUrl: string;
  parishPhoto: string;
  priestPhoto: string;
  langRu: string;
  langUk: string;
  langKk: string;
  langEn: string;
  city: string;
  name: string;
  address: string;
  priestName: string;
  priestContacts: string;
  noTitle: string;
  edit: string;
  hierarchyTitle: string;
  moveUp: string;
  moveDown: string;
  /** Подсказка перед кнопками добавления блоков RU/UK/KK/EN */
  parishAddLocaleHint: string;
};

export function adminParishesScreenCopy(lang: Lang): AdminParishesScreenCopy {
  const d: Record<Lang, AdminParishesScreenCopy> = {
    ru: {
      pageTitle: "Приходы Казахстана",
      pageIntro:
        "Карточки отображаются на сайте в разделе «О церкви» → «Приходы Казахстана». Созданная запись сразу видна посетителям.",
      emptyList: "Записей пока нет. Добавьте первый приход кнопкой выше.",
      addParish: "Добавить приход",
      save: "Сохранить",
      delete: "Удалить",
      confirmDelete: "Удалить этот приход? Действие необратимо.",
      cancel: "Отмена",
      mapIframeField: "Карта (тег iframe или URL)",
      mapIframeHint:
        "Полный код встраивания Google Maps или только ссылка. Пусто — на карточке прихода карта не показывается.",
      removeParishPhoto: "Удалить фото прихода",
      removePriestPhoto: "Удалить фото настоятеля",
      websiteUrl: "Ссылка на сайт (https://…)",
      parishPhoto: "Фото прихода / храма",
      priestPhoto: "Фото настоятеля",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      city: "Город",
      name: "Название",
      address: "Адрес",
      priestName: "Имя настоятеля",
      priestContacts: "Контакты настоятеля (телефон, e-mail и т.д.)",
      noTitle: "Без названия",
      edit: "Редактировать",
      hierarchyTitle: "Порядок в списке",
      moveUp: "Выше",
      moveDown: "Ниже",
      parishAddLocaleHint: "Другие языки — откройте поля кнопкой.",
    },
    uk: {
      pageTitle: "Парафії Казахстану",
      pageIntro:
        "Картки на сайті: «Про церкву» → «Парафії Казахстану». Створений запис одразу видно відвідувачам.",
      emptyList: "Записів ще немає. Додайте першу парафію кнопкою вище.",
      addParish: "Додати парафію",
      save: "Зберегти",
      delete: "Видалити",
      confirmDelete: "Видалити цю парафію? Це незворотно.",
      cancel: "Скасувати",
      mapIframeField: "Мапа (тег iframe або URL)",
      mapIframeHint: "Повний код з Google Maps або лише посилання.",
      removeParishPhoto: "Прибрати фото парафії",
      removePriestPhoto: "Прибрати фото настоятеля",
      websiteUrl: "Посилання на сайт (https://…)",
      parishPhoto: "Фото парафії / храму",
      priestPhoto: "Фото настоятеля",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      city: "Місто",
      name: "Назва",
      address: "Адреса",
      priestName: "Ім’я настоятеля",
      priestContacts: "Контакти настоятеля (телефон, e-mail тощо)",
      noTitle: "Без назви",
      edit: "Редагувати",
      hierarchyTitle: "Порядок у списку",
      moveUp: "Вище",
      moveDown: "Нижче",
      parishAddLocaleHint: "Інші мови — відкрийте поля кнопкою.",
    },
    kk: {
      pageTitle: "Қазақстан қауымдары",
      pageIntro:
        "Сайтта «Шіркеу туралы» → «Қазақстан қауымдары» бөлімінде көрінеді. Жасалған жазба дереу қонақтарға көрінеді.",
      emptyList: "Жазбалар әлі жоқ. Жоғарыдағы түймемен бірінші қауымды қосыңыз.",
      addParish: "Қауым қосу",
      save: "Сақтау",
      delete: "Жою",
      confirmDelete: "Бұл қауымды жоясыз ба? Қайтарылмайды.",
      cancel: "Болдырмау",
      mapIframeField: "Карта кірістіру (iframe немесе URL)",
      mapIframeHint: "Google Maps толық коды немесе сілтеме.",
      removeParishPhoto: "Қауым суретін жою",
      removePriestPhoto: "Настоятель суретін жою",
      websiteUrl: "Сайт сілтемесі (https://…)",
      parishPhoto: "Қауым / шіркеу суреті",
      priestPhoto: "Бас священник суреті",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      city: "Қала",
      name: "Атауы",
      address: "Мекенжай",
      priestName: "Бас священник аты",
      priestContacts: "Байланыс (телефон, e-mail т.б.)",
      noTitle: "Атаусыз",
      edit: "Өңдеу",
      hierarchyTitle: "Тізімдегі орын",
      moveUp: "Жоғары",
      moveDown: "Төмен",
      parishAddLocaleHint: "Қосымша тілдер — түймемен өрістерді ашыңыз.",
    },
    en: {
      pageTitle: "Kazakhstan parishes",
      pageIntro:
        "Cards appear under About the parish → Parishes in Kazakhstan. New entries are visible to visitors immediately.",
      emptyList: "No entries yet. Add the first parish using the button above.",
      addParish: "Add parish",
      save: "Save",
      delete: "Delete",
      confirmDelete: "Delete this parish? This cannot be undone.",
      cancel: "Cancel",
      mapIframeField: "Map (iframe tag or URL)",
      mapIframeHint: "Full Google Maps embed code or URL only.",
      removeParishPhoto: "Remove parish photo",
      removePriestPhoto: "Remove rector photo",
      websiteUrl: "Website URL (https://…)",
      parishPhoto: "Parish / church photo",
      priestPhoto: "Rector photo",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      city: "City",
      name: "Name",
      address: "Address",
      priestName: "Rector name",
      priestContacts: "Rector contacts (phone, email, etc.)",
      noTitle: "Untitled",
      edit: "Edit",
      hierarchyTitle: "Order in list",
      moveUp: "Move up",
      moveDown: "Move down",
      parishAddLocaleHint: "Other languages — open fields with a button below.",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminClergyScreenCopy = {
  pageTitle: string;
  pageIntro: string;
  emptyList: string;
  addClergy: string;
  save: string;
  delete: string;
  confirmDelete: string;
  cancel: string;
  fullName: string;
  nameLanguagesHint: string;
  langRu: string;
  langUk: string;
  langKk: string;
  langEn: string;
  addNameRu: string;
  addNameUk: string;
  addNameKk: string;
  addNameEn: string;
  addFieldLangRu: string;
  addFieldLangUk: string;
  addFieldLangKk: string;
  addFieldLangEn: string;
  photo: string;
  photoRequired: string;
  photoHintNew: string;
  photoHintEdit: string;
  removePhoto: string;
  extraFieldsTitle: string;
  addField: string;
  removeField: string;
  fieldLabel: string;
  fieldValue: string;
  fieldUrl: string;
  fieldUrlHint: string;
  hierarchyTitle: string;
  sortOrderLabel: string;
  sortOrderHint: string;
  moveUp: string;
  moveDown: string;
  edit: string;
  noName: string;
};

export function adminClergyScreenCopy(lang: Lang): AdminClergyScreenCopy {
  const d: Record<Lang, AdminClergyScreenCopy> = {
    ru: {
      pageTitle: "Священнослужители",
      pageIntro:
        "Карточки со священнослужителями можно вывести на сайте отдельным блоком. Обязательны фотография и ФИО; дополнительные поля и ссылки — по желанию.",
      emptyList: "Записей пока нет. Добавьте первую кнопкой выше.",
      addClergy: "Добавить",
      save: "Сохранить",
      delete: "Удалить",
      confirmDelete: "Удалить эту запись? Действие необратимо.",
      cancel: "Отмена",
      fullName: "ФИО",
      nameLanguagesHint: "Русский показан всегда. Остальные языки — отдельными кнопками.",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      addNameRu: "+ ФИО на русском",
      addNameUk: "+ ФИО українською",
      addNameKk: "+ ФИО қазақша",
      addNameEn: "+ Full name (EN)",
      addFieldLangRu: "+ RU для этого поля",
      addFieldLangUk: "+ UK для этого поля",
      addFieldLangKk: "+ KK для этого поля",
      addFieldLangEn: "+ EN для этого поля",
      photo: "Фото",
      photoRequired: "Загрузите фотографию.",
      photoHintNew: "Обязательное поле — изображение лица или портрет.",
      photoHintEdit: "Чтобы заменить фото, выберите новый файл.",
      removePhoto: "Удалить фото",
      extraFieldsTitle: "Дополнительные поля",
      addField: "Добавить поле",
      removeField: "Убрать поле",
      fieldLabel: "Подпись (необязательно)",
      fieldValue: "Текст",
      fieldUrl: "Ссылка (необязательно)",
      fieldUrlHint: "Если указана, текст можно сделать ссылкой на сайте.",
      hierarchyTitle: "Порядок в списке",
      sortOrderLabel: "Номер (меньше — выше, важнее)",
      sortOrderHint: "Чем меньше число, тем ближе к началу списка на сайте.",
      moveUp: "Выше",
      moveDown: "Ниже",
      edit: "Редактировать",
      noName: "Без имени",
    },
    uk: {
      pageTitle: "Духовенство",
      pageIntro:
        "Картки духовенства можна показати на сайті окремим блоком. Обов’язкові фото та ПІБ; додаткові поля та посилання — за потреби.",
      emptyList: "Записів ще немає. Додайте перший кнопкою вище.",
      addClergy: "Додати",
      save: "Зберегти",
      delete: "Видалити",
      confirmDelete: "Видалити цей запис? Це незворотно.",
      cancel: "Скасувати",
      fullName: "ПІБ",
      nameLanguagesHint: "Російську версію показано завжди. Інші мови — окремими кнопками.",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      addNameRu: "+ ПІБ російською",
      addNameUk: "+ ПІБ українською",
      addNameKk: "+ ПІБ қазақша",
      addNameEn: "+ ПІБ English",
      addFieldLangRu: "+ RU для цього поля",
      addFieldLangUk: "+ UK для цього поля",
      addFieldLangKk: "+ KK для цього поля",
      addFieldLangEn: "+ EN для цього поля",
      photo: "Фото",
      photoRequired: "Завантажте фотографію.",
      photoHintNew: "Обов’язкове поле — зображення обличчя або портрет.",
      photoHintEdit: "Щоб замінити фото, оберіть новий файл.",
      removePhoto: "Видалити фото",
      extraFieldsTitle: "Додаткові поля",
      addField: "Додати поле",
      removeField: "Прибрати поле",
      fieldLabel: "Підпис (необов’язково)",
      fieldValue: "Текст",
      fieldUrl: "Посилання (необов’язково)",
      fieldUrlHint: "Якщо вказано, текст можна зробити посиланням на сайті.",
      hierarchyTitle: "Порядок у списку",
      sortOrderLabel: "Номер (менше — вище, важливіше)",
      sortOrderHint: "Чим менше число, тим ближче до початку списку на сайті.",
      moveUp: "Вище",
      moveDown: "Нижче",
      edit: "Редагувати",
      noName: "Без імені",
    },
    kk: {
      pageTitle: "Дін қызметкерлері",
      pageIntro:
        "Дін қызметкерлерінің карточкаларын сайтта бөлек блок ретінде көрсетуге болады. Сурет пен ТАЖ міндетті; қосымша өрістер мен сілтемелер — қалауыңызша.",
      emptyList: "Жазбалар әлі жоқ. Жоғарыдағы түймемен біріншісін қосыңыз.",
      addClergy: "Қосу",
      save: "Сақтау",
      delete: "Жою",
      confirmDelete: "Бұл жазбаны жоясыз ба? Қайтарылмайды.",
      cancel: "Болдырмау",
      fullName: "ТАЖ",
      nameLanguagesHint: "Орыс тілі әрқашан көрінеді. Басқа тілдерді жеке түймелермен қосыңыз.",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      addNameRu: "+ ТАЖ орыс тілінде",
      addNameUk: "+ ТАЖ україн тілінде",
      addNameKk: "+ ТАЖ қазақша",
      addNameEn: "+ Full name (EN)",
      addFieldLangRu: "+ осы өріс үшін RU",
      addFieldLangUk: "+ осы өріс үшін UK",
      addFieldLangKk: "+ осы өріс үшін KK",
      addFieldLangEn: "+ осы өріс үшін EN",
      photo: "Сурет",
      photoRequired: "Фотосурет жүктеңіз.",
      photoHintNew: "Міндетті өріс — бет суреті немесе портрет.",
      photoHintEdit: "Суретті ауыстыру үшін жаңа файл таңдаңыз.",
      removePhoto: "Суретті жою",
      extraFieldsTitle: "Қосымша өрістер",
      addField: "Өріс қосу",
      removeField: "Өрісті жою",
      fieldLabel: "Тақырып (міндетті емес)",
      fieldValue: "Мәтін",
      fieldUrl: "Сілтеме (міндетті емес)",
      fieldUrlHint: "Көрсетілсе, мәтінді сайтта сілтеме етіп көрсетуге болады.",
      hierarchyTitle: "Тізімдегі орын",
      sortOrderLabel: "Нөмір (кішірек — жоғары, маңыздырақ)",
      sortOrderHint: "Сан не кіші болса, сайтта тізімнің басында соғұрлым жақын тұрады.",
      moveUp: "Жоғары",
      moveDown: "Төмен",
      edit: "Өңдеу",
      noName: "Атаусыз",
    },
    en: {
      pageTitle: "Clergy",
      pageIntro:
        "Clergy cards can be shown on the site in a dedicated section. Photo and full name are required; extra fields and links are optional.",
      emptyList: "No entries yet. Add the first one using the button above.",
      addClergy: "Add",
      save: "Save",
      delete: "Delete",
      confirmDelete: "Delete this entry? This cannot be undone.",
      cancel: "Cancel",
      fullName: "Full name",
      nameLanguagesHint: "Russian is always shown. Add other languages with the buttons below.",
      langRu: "RU",
      langUk: "UK",
      langKk: "KK",
      langEn: "EN",
      addNameRu: "+ Name in Russian",
      addNameUk: "+ Name in Ukrainian",
      addNameKk: "+ Name in Kazakh",
      addNameEn: "+ Name in English",
      addFieldLangRu: "+ RU for this field",
      addFieldLangUk: "+ UK for this field",
      addFieldLangKk: "+ KK for this field",
      addFieldLangEn: "+ EN for this field",
      photo: "Photo",
      photoRequired: "Please upload a photo.",
      photoHintNew: "Required — a portrait or headshot works best.",
      photoHintEdit: "Choose a new file to replace the current photo.",
      removePhoto: "Remove photo",
      extraFieldsTitle: "Extra fields",
      addField: "Add field",
      removeField: "Remove field",
      fieldLabel: "Label (optional)",
      fieldValue: "Text",
      fieldUrl: "Link (optional)",
      fieldUrlHint: "If set, the text can be shown as a link on the site.",
      hierarchyTitle: "Order in list",
      sortOrderLabel: "Rank (lower = higher, more prominent)",
      sortOrderHint: "Smaller numbers appear closer to the top on the site.",
      moveUp: "Move up",
      moveDown: "Move down",
      edit: "Edit",
      noName: "Untitled",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminAccountCopy = {
  pageTitle: string;
  intro: string;
  /** Opens the password change dialog */
  openChangePassword: string;
  cancel: string;
  newPassword: string;
  repeatPassword: string;
  savePassword: string;
  loading: string;
  errMinLen: string;
  errMismatch: string;
  success: string;
};

export function adminAccountCopy(lang: Lang): AdminAccountCopy {
  const d: Record<Lang, AdminAccountCopy> = {
    ru: {
      pageTitle: "Пароль",
      intro: "Смените пароль для входа в админку. Используйте надёжную комбинацию символов.",
      openChangePassword: "Сменить пароль",
      cancel: "Отмена",
      newPassword: "Новый пароль",
      repeatPassword: "Повторите пароль",
      savePassword: "Сохранить пароль",
      loading: "…",
      errMinLen: "Минимум 8 символов.",
      errMismatch: "Пароли не совпадают.",
      success: "Пароль обновлён.",
    },
    uk: {
      pageTitle: "Пароль",
      intro: "Змініть пароль для входу в адмінку. Використовуйте надійну комбінацію символів.",
      openChangePassword: "Змінити пароль",
      cancel: "Скасувати",
      newPassword: "Новий пароль",
      repeatPassword: "Повторіть пароль",
      savePassword: "Зберегти пароль",
      loading: "…",
      errMinLen: "Мінімум 8 символів.",
      errMismatch: "Паролі не збігаються.",
      success: "Пароль оновлено.",
    },
    kk: {
      pageTitle: "Құпия сөз",
      intro: "Әкімшілікке кіру құпия сөзін өзгертіңіз. Сенімді таңбалар тіркесін қолданыңыз.",
      openChangePassword: "Құпия сөзді өзгерту",
      cancel: "Болдырмау",
      newPassword: "Жаңа құпия сөз",
      repeatPassword: "Қайталаңыз",
      savePassword: "Сақтау",
      loading: "…",
      errMinLen: "Кемінде 8 таңба.",
      errMismatch: "Құпия сөздер сәйкес емес.",
      success: "Құпия сөз жаңартылды.",
    },
    en: {
      pageTitle: "Password",
      intro: "Change your password for admin sign-in. Use a strong combination of characters.",
      openChangePassword: "Change password",
      cancel: "Cancel",
      newPassword: "New password",
      repeatPassword: "Repeat password",
      savePassword: "Save password",
      loading: "…",
      errMinLen: "At least 8 characters.",
      errMismatch: "Passwords do not match.",
      success: "Password updated.",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminUsersScreenCopy = {
  pageTitle: string;
  intro: string;
  listTitle: string;
  colEmail: string;
  colName: string;
  colRole: string;
  colCreated: string;
  colActions: string;
  edit: string;
  delete: string;
  editTitle: string;
  saveEdits: string;
  cancel: string;
  fullName: string;
  roleLabel: string;
  roleAdmin: string;
  roleSuperadmin: string;
  newPasswordOptional: string;
  newPasswordHint: string;
  confirmDelete: string;
  youBadge: string;
  email: string;
  password: string;
  passwordAgain: string;
  passwordHint: string;
  createUser: string;
  loading: string;
  errMin: string;
  errMismatch: string;
  errGeneric: string;
  errNetwork: string;
  success: string;
  successUpdated: string;
  successDeleted: string;
};

export function adminUsersScreenCopy(lang: Lang): AdminUsersScreenCopy {
  const d: Record<Lang, AdminUsersScreenCopy> = {
    ru: {
      pageTitle: "Пользователи",
      intro: "Создание учётных записей администраторов и управление ими",
      listTitle: "Список пользователей",
      colEmail: "Email",
      colName: "Имя",
      colRole: "Роль",
      colCreated: "Создан",
      colActions: "Действия",
      edit: "Изменить",
      delete: "Удалить",
      editTitle: "Редактирование пользователя",
      saveEdits: "Сохранить",
      cancel: "Отмена",
      fullName: "Имя (отображение)",
      roleLabel: "Роль",
      roleAdmin: "Админ",
      roleSuperadmin: "Суперадмин",
      newPasswordOptional: "Новый пароль",
      newPasswordHint: "оставьте пустым, если не меняете",
      confirmDelete: "Удалить этого пользователя? Войти под ним станет невозможно.",
      youBadge: "вы",
      email: "Email",
      password: "Пароль",
      passwordAgain: "Пароль ещё раз",
      passwordHint: "не короче 8 символов",
      createUser: "Создать пользователя",
      loading: "…",
      errMin: "Пароль не короче 8 символов",
      errMismatch: "Пароли не совпадают",
      errGeneric: "Ошибка",
      errNetwork: "Сеть недоступна",
      success: "Пользователь создан. Передайте ему email и пароль любым способом.",
      successUpdated: "Изменения сохранены",
      successDeleted: "Пользователь удалён",
    },
    uk: {
      pageTitle: "Користувачі",
      intro: "Створення облікових записів адміністраторів та керування ними",
      listTitle: "Список користувачів",
      colEmail: "Email",
      colName: "Ім’я",
      colRole: "Роль",
      colCreated: "Створено",
      colActions: "Дії",
      edit: "Змінити",
      delete: "Видалити",
      editTitle: "Редагування користувача",
      saveEdits: "Зберегти",
      cancel: "Скасувати",
      fullName: "Ім’я (відображення)",
      roleLabel: "Роль",
      roleAdmin: "Адмін",
      roleSuperadmin: "Суперадмін",
      newPasswordOptional: "Новий пароль",
      newPasswordHint: "залиште порожнім, якщо не змінюєте",
      confirmDelete: "Видалити цього користувача? Увійти під ним буде неможливо.",
      youBadge: "ви",
      email: "Email",
      password: "Пароль",
      passwordAgain: "Повторіть пароль",
      passwordHint: "не коротше 8 символів",
      createUser: "Створити користувача",
      loading: "…",
      errMin: "Пароль не коротший за 8 символів",
      errMismatch: "Паролі не збігаються",
      errGeneric: "Помилка",
      errNetwork: "Мережа недоступна",
      success: "Користувача створено. Передайте email і пароль будь-яким способом.",
      successUpdated: "Зміни збережено",
      successDeleted: "Користувача видалено",
    },
    kk: {
      pageTitle: "Пайдаланушылар",
      intro: "Әкімші тіркелгілерін жасау және басқару",
      listTitle: "Пайдаланушылар тізімі",
      colEmail: "Email",
      colName: "Аты",
      colRole: "Рөлі",
      colCreated: "Құрылған",
      colActions: "Әрекеттер",
      edit: "Өңдеу",
      delete: "Жою",
      editTitle: "Пайдаланушыны өңдеу",
      saveEdits: "Сақтау",
      cancel: "Болдырмау",
      fullName: "Аты (көрініс)",
      roleLabel: "Рөлі",
      roleAdmin: "Әкімші",
      roleSuperadmin: "Суперәкімші",
      newPasswordOptional: "Жаңа құпия сөз",
      newPasswordHint: "өзгертпесеңіз бос қалдырыңыз",
      confirmDelete: "Бұл пайдаланушыны жоясыз ба? Кіру мүмкін болмайды.",
      youBadge: "сіз",
      email: "Email",
      password: "Құпия сөз",
      passwordAgain: "Қайталаңыз",
      passwordHint: "кемінде 8 таңба",
      createUser: "Пайдаланушыны құру",
      loading: "…",
      errMin: "Құпия сөз кемінде 8 таңба болуы керек",
      errMismatch: "Құпия сөздер сәйкес емес",
      errGeneric: "Қате",
      errNetwork: "Желі жоқ",
      success: "Пайдаланушы құрылды. Email мен құпия сөзді кез келген жолмен беріңіз.",
      successUpdated: "Сақталды",
      successDeleted: "Жойылды",
    },
    en: {
      pageTitle: "Users",
      intro: "Create administrator accounts and manage them",
      listTitle: "User list",
      colEmail: "Email",
      colName: "Name",
      colRole: "Role",
      colCreated: "Created",
      colActions: "Actions",
      edit: "Edit",
      delete: "Delete",
      editTitle: "Edit user",
      saveEdits: "Save",
      cancel: "Cancel",
      fullName: "Display name",
      roleLabel: "Role",
      roleAdmin: "Admin",
      roleSuperadmin: "Superadmin",
      newPasswordOptional: "New password",
      newPasswordHint: "leave empty to keep current",
      confirmDelete: "Delete this user? They will no longer be able to sign in.",
      youBadge: "you",
      email: "Email",
      password: "Password",
      passwordAgain: "Repeat password",
      passwordHint: "at least 8 characters",
      createUser: "Create user",
      loading: "…",
      errMin: "Password must be at least 8 characters",
      errMismatch: "Passwords do not match",
      errGeneric: "Error",
      errNetwork: "Network unavailable",
      success: "User created. Share the email and password with them securely.",
      successUpdated: "Saved",
      successDeleted: "User deleted",
    },
  };
  return d[lang] ?? d.ru;
}

export type AdminLoginCopy = {
  title: string;
  subtitle: string;
  email: string;
  password: string;
  signIn: string;
  loading: string;
  fallback: string;
};

export function adminLoginCopy(lang: Lang): AdminLoginCopy {
  const d: Record<Lang, AdminLoginCopy> = {
    ru: {
      title: "Вход",
      subtitle: "Панель прихода",
      email: "Email",
      password: "Пароль",
      signIn: "Войти",
      loading: "…",
      fallback: "…",
    },
    uk: {
      title: "Вхід",
      subtitle: "Панель парафії",
      email: "Email",
      password: "Пароль",
      signIn: "Увійти",
      loading: "…",
      fallback: "…",
    },
    kk: {
      title: "Кіру",
      subtitle: "Приход панелі",
      email: "Email",
      password: "Құпия сөз",
      signIn: "Кіру",
      loading: "…",
      fallback: "…",
    },
    en: {
      title: "Sign in",
      subtitle: "Parish admin",
      email: "Email",
      password: "Password",
      signIn: "Sign in",
      loading: "…",
      fallback: "…",
    },
  };
  return d[lang] ?? d.ru;
}
