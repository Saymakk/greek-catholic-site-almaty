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
    books: "Книги",
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
    books: "Кітаптар",
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
    books: "Books",
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
      deleteTemplate: string;
      confirmDeleteTemplate: string;
      editTemplate: string;
      editTemplateTitle: string;
      editTemplateSave: string;
      offerTemplateTitle: string;
      offerTemplateHint: string;
      offerTemplateSave: string;
      offerTemplateSkip: string;
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
  introBeforeJson: string;
  introPriestCode: string;
  introPriestDesc: string;
  introEmailCode: string;
  introAnd: string;
  introPhoneCode: string;
  introPerLang: string;
  introAddressCode: string;
  introExtraPart: string;
  introExtraCode: string;
  introFallback: string;
  save: string;
  errParse: string;
  errShape: string;
};

export function adminSettingsCopy(lang: Lang): AdminSettingsCopy {
  const d: Record<Lang, AdminSettingsCopy> = {
    ru: {
      pageTitle: "Контакты и футер",
      introBeforeJson: "Один JSON:",
      introPriestCode: "priest_name_*",
      introPriestDesc: "(ФИО настоятеля), общие",
      introEmailCode: "email",
      introAnd: "и",
      introPhoneCode: "phone",
      introPerLang: ", по языкам —",
      introAddressCode: "address_*",
      introExtraPart: "и при необходимости",
      introExtraCode: "extra_*",
      introFallback: ". Пустое значение для языка на сайте подменяется русским.",
      save: "Сохранить",
      errParse:
        "Некорректный JSON. Проверьте двойные кавычки у ключей и строк, запятые между полями, без запятой после последнего поля.",
      errShape: "Корнем должен быть объект в фигурных скобках { … }, не массив и не одна строка.",
    },
    uk: {
      pageTitle: "Контакти та підвал сайту",
      introBeforeJson: "Один JSON:",
      introPriestCode: "priest_name_*",
      introPriestDesc: "(ПІБ настоятеля), спільні",
      introEmailCode: "email",
      introAnd: "та",
      introPhoneCode: "phone",
      introPerLang: ", за мовами —",
      introAddressCode: "address_*",
      introExtraPart: "за потреби",
      introExtraCode: "extra_*",
      introFallback: ". Порожнє значення для мови на сайті замінюється російською.",
      save: "Зберегти",
      errParse:
        "Некоректний JSON. Перевірте лапки навколо ключів і рядків, коми між полями, без коми після останнього поля.",
      errShape: "Коренем має бути об’єкт у фігурних дужках { … }, не масив і не один рядок.",
    },
    kk: {
      pageTitle: "Байланыс және футер",
      introBeforeJson: "Бір JSON:",
      introPriestCode: "priest_name_*",
      introPriestDesc: "(настоятельдің аты-жөні), ортақ",
      introEmailCode: "email",
      introAnd: "және",
      introPhoneCode: "phone",
      introPerLang: ", тілдер бойынша —",
      introAddressCode: "address_*",
      introExtraPart: "қажет болса",
      introExtraCode: "extra_*",
      introFallback: ". Тіл үшін бос мән сайтта орыс тілімен ауыстырылады.",
      save: "Сақтау",
      errParse:
        "JSON дұрыс емес. Кілттер мен жолдардың тырнақшаларын, өрістер арасындағы үтірлерді тексеріңіз; соңғы өрістен кейін үтір болмауы керек.",
      errShape: "Түбірі { … } жақшасындағы объект болуы керек, массив немесе бір жол емес.",
    },
    en: {
      pageTitle: "Contacts & footer",
      introBeforeJson: "A single JSON object:",
      introPriestCode: "priest_name_*",
      introPriestDesc: "(rector’s name), shared",
      introEmailCode: "email",
      introAnd: "and",
      introPhoneCode: "phone",
      introPerLang: "; per language —",
      introAddressCode: "address_*",
      introExtraPart: "and if needed",
      introExtraCode: "extra_*",
      introFallback: ". Empty values for a language fall back to Russian on the site.",
      save: "Save",
      errParse:
        "Invalid JSON. Check quotes around keys and strings, commas between fields, and no trailing comma after the last field.",
      errShape: "The root must be an object in braces { … }, not an array or a single string.",
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
};

export function adminUsersScreenCopy(lang: Lang): AdminUsersScreenCopy {
  const d: Record<Lang, AdminUsersScreenCopy> = {
    ru: {
      pageTitle: "Пользователи",
      intro: "Здесь создаются администраторы",
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
    },
    uk: {
      pageTitle: "Користувачі",
      intro: "Тут створюються адміністратори",
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
    },
    kk: {
      pageTitle: "Пайдаланушылар",
      intro: "Мұнда әкімшілер құрылады",
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
    },
    en: {
      pageTitle: "Users",
      intro: "Create administrator accounts here",
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
