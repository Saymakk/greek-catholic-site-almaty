import type { Lang } from "./i18n";

export type AdminCalendarFormMsg = {
  primaryLang: string;
  date: string;
  kindSectionTitle: string;
  kindPreset: string;
  kindCustom: string;
  kindSlug: string;
  kindSlugHint: string;
  kindSiteLabels: string;
  labelRu: string;
  labelUk: string;
  labelKk: string;
  labelEn: string;
  coverTitle: string;
  coverZoom: string;
  noCover: string;
  uploadCover: string;
  removeCover: string;
  extrasTitle: string;
  extrasLabelsSection: string;
  extrasBodySection: string;
  addExtraRow: string;
  /** Текст кнопки удаления строки доп. поля */
  extraFieldRemove: string;
  extraRemoveRow: string;
  extraUrl: string;
  extraUrlHint: string;
  coverLightboxAria: string;
  templateApply: string;
  templatePick: string;
  templateName: string;
  kindGreatFeast: string;
  kindFeast: string;
  kindSunday: string;
  kindFast: string;
  kindCommemoration: string;
  kindOther: string;
  title: string;
  explanation: string;
  prayer: string;
  mainEdition: string;
  removeVersion: string;
  addLocale: string;
  cancel: string;
  recurrenceSection: string;
  recurrenceEnable: string;
  recurrenceFreq: string;
  recurrenceDaily: string;
  recurrenceWeekly: string;
  recurrenceMonthly: string;
  recurrenceTotal: string;
  recurrenceHint: string;
};

const M: Record<Lang, AdminCalendarFormMsg> = {
  ru: {
    primaryLang: "Язык основной версии",
    date: "Дата",
    kindSectionTitle: "Тип события",
    kindPreset: "Стандартный тип",
    kindCustom: "Свой тип (латиница, через _)",
    kindSlug: "Код типа",
    kindSlugHint: "например parish_event — только a–z, цифры и _",
    kindSiteLabels: "Подписи типа на сайте (по желанию)",
    labelRu: "RU",
    labelUk: "UK",
    labelKk: "KK",
    labelEn: "EN",
    coverTitle: "Миниатюра события",
    coverZoom: "Нажмите для просмотра в полном размере",
    noCover: "Нет изображения",
    uploadCover: "Загрузить или заменить",
    removeCover: "Удалить изображение",
    extrasTitle: "Дополнительные поля",
    extrasLabelsSection: "Подписи поля",
    extrasBodySection: "Текст поля",
    addExtraRow: "Добавить поле",
    extraFieldRemove: "Удалить",
    extraRemoveRow: "Удалить поле",
    extraUrl: "Ссылка (только если есть текст)",
    extraUrlHint: "Без текста ссылка не сохранится",
    templateApply: "Шаблон полей",
    templatePick: "Подставить шаблон (только подписи)",
    templateName: "Название шаблона",
    coverLightboxAria: "Просмотр обложки",
    kindGreatFeast: "Великий праздник",
    kindFeast: "Праздник",
    kindSunday: "Воскресенье",
    kindFast: "Пост",
    kindCommemoration: "Память",
    kindOther: "Другое",
    title: "Название",
    explanation: "Пояснение (текст или HTML)",
    prayer: "Молитва (опционально)",
    mainEdition: "основная версия",
    removeVersion: "Убрать версию",
    addLocale: "Добавить версию на языке:",
    cancel: "Отмена",
    recurrenceSection: "Повторение",
    recurrenceEnable: "Создать несколько событий по расписанию",
    recurrenceFreq: "Как повторять",
    recurrenceDaily: "каждый день",
    recurrenceWeekly: "каждую неделю",
    recurrenceMonthly: "каждый месяц",
    recurrenceTotal: "Всего дат (включая первую)",
    recurrenceHint:
      "Будет создано несколько отдельных событий с одинаковым содержимым; каждое можно править или удалить по отдельности.",
  },
  uk: {
    primaryLang: "Мова основної версії",
    date: "Дата",
    kindSectionTitle: "Тип події",
    kindPreset: "Стандартний тип",
    kindCustom: "Власний тип (латиниця, через _)",
    kindSlug: "Код типу",
    kindSlugHint: "наприклад parish_event — лише a–z, цифри та _",
    kindSiteLabels: "Підписи типу на сайті (за бажанням)",
    labelRu: "RU",
    labelUk: "UK",
    labelKk: "KK",
    labelEn: "EN",
    coverTitle: "Мініатюра події",
    coverZoom: "Натисніть для перегляду",
    noCover: "Немає зображення",
    uploadCover: "Завантажити або замінити",
    removeCover: "Видалити зображення",
    extrasTitle: "Додаткові поля",
    extrasLabelsSection: "Підписи поля",
    extrasBodySection: "Текст поля",
    addExtraRow: "Додати поле",
    extraFieldRemove: "Видалити",
    extraRemoveRow: "Видалити поле",
    extraUrl: "Посилання (лише якщо є текст)",
    extraUrlHint: "Без тексту посилання не збережеться",
    templateApply: "Шаблон полів",
    templatePick: "Підставити шаблон (лише підписи)",
    templateName: "Назва шаблону",
    coverLightboxAria: "Перегляд обкладинки",
    kindGreatFeast: "Велике свято",
    kindFeast: "Свято",
    kindSunday: "Неділя",
    kindFast: "Піст",
    kindCommemoration: "Пам\u0027ять",
    kindOther: "Інше",
    title: "Назва",
    explanation: "Пояснення (текст або HTML)",
    prayer: "Молитва (необов’язково)",
    mainEdition: "основна версія",
    removeVersion: "Прибрати версію",
    addLocale: "Додати версію мовою:",
    cancel: "Скасувати",
    recurrenceSection: "Повторення",
    recurrenceEnable: "Створити кілька подій за розкладом",
    recurrenceFreq: "Як повторювати",
    recurrenceDaily: "щодня",
    recurrenceWeekly: "щотижня",
    recurrenceMonthly: "щомісяця",
    recurrenceTotal: "Усього дат (включно з першою)",
    recurrenceHint:
      "Буде створено кілька окремих подій з однаковим вмістом; кожну можна редагувати чи видаляти окремо.",
  },
  kk: {
    primaryLang: "Негізгі нұсқа тілі",
    date: "Күні",
    kindSectionTitle: "Оқиға түрі",
    kindPreset: "Стандартты түр",
    kindCustom: "Өз түрі (латын, _ арқылы)",
    kindSlug: "Түр коды",
    kindSlugHint: "мысалы parish_event — тек a–z, сандар және _",
    kindSiteLabels: "Сайттағы түр атаулары (міндетті емес)",
    labelRu: "RU",
    labelUk: "UK",
    labelKk: "KK",
    labelEn: "EN",
    coverTitle: "Оқиға миниатюрасы",
    coverZoom: "Толық көру үшін басыңыз",
    noCover: "Сурет жоқ",
    uploadCover: "Жүктеу немесе ауыстыру",
    removeCover: "Суретті жою",
    extrasTitle: "Қосымша өрістер",
    extrasLabelsSection: "Өріс тақырыптары",
    extrasBodySection: "Өріс мәтіні",
    addExtraRow: "Өріс қосу",
    extraFieldRemove: "Жою",
    extraRemoveRow: "Өрісті жою",
    extraUrl: "Сілтеме (тек мәтін болса)",
    extraUrlHint: "Мәтінсіз сілтеме сақталмайды",
    templateApply: "Өріс үлгісі",
    templatePick: "Үлгіні қою (тек тақырыптар)",
    templateName: "Үлгі атауы",
    coverLightboxAria: "Мұқабаны көру",
    kindGreatFeast: "Үлкен мереке",
    kindFeast: "Мереке",
    kindSunday: "Жексенбі",
    kindFast: "Ораза",
    kindCommemoration: "Еске алу",
    kindOther: "Басқа",
    title: "Атауы",
    explanation: "Түсіндірме (мәтін немесе HTML)",
    prayer: "Дұға (міндетті емес)",
    mainEdition: "негізгі нұсқа",
    removeVersion: "Нұсқаны алып тастау",
    addLocale: "Тіл нұқасын қосу:",
    cancel: "Болдырмау",
    recurrenceSection: "Қайталану",
    recurrenceEnable: "Кесте бойынша бірнеше оқиға жасау",
    recurrenceFreq: "Қайталау жиілігі",
    recurrenceDaily: "күн сайын",
    recurrenceWeekly: "апта сайын",
    recurrenceMonthly: "ай сайын",
    recurrenceTotal: "Барлық күндер (біріншісі қоса)",
    recurrenceHint:
      "Бірдей мазмұнды жеке оқиғалар жасалады; әрқайсысын жеке өзгерту немесе жоюға болады.",
  },
  en: {
    primaryLang: "Primary language",
    date: "Date",
    kindSectionTitle: "Event type",
    kindPreset: "Preset type",
    kindCustom: "Custom type (Latin, underscores)",
    kindSlug: "Type code",
    kindSlugHint: "e.g. parish_event — letters, digits, underscore only",
    kindSiteLabels: "Type labels on the site (optional)",
    labelRu: "RU",
    labelUk: "UK",
    labelKk: "KK",
    labelEn: "EN",
    coverTitle: "Event thumbnail",
    coverZoom: "Click to view full size",
    noCover: "No image",
    uploadCover: "Upload or replace",
    removeCover: "Remove image",
    extrasTitle: "Extra fields",
    extrasLabelsSection: "Field labels",
    extrasBodySection: "Field body",
    addExtraRow: "Add field",
    extraFieldRemove: "Delete",
    extraRemoveRow: "Remove field",
    extraUrl: "URL (only if there is body text)",
    extraUrlHint: "URL is ignored without body text",
    templateApply: "Field template",
    templatePick: "Apply template (labels only)",
    templateName: "Template name",
    coverLightboxAria: "Cover preview",
    kindGreatFeast: "Great feast",
    kindFeast: "Feast",
    kindSunday: "Sunday",
    kindFast: "Fast",
    kindCommemoration: "Commemoration",
    kindOther: "Other",
    title: "Title",
    explanation: "Explanation (text or HTML)",
    prayer: "Prayer (optional)",
    mainEdition: "primary edition",
    removeVersion: "Remove version",
    addLocale: "Add language version:",
    cancel: "Cancel",
    recurrenceSection: "Recurrence",
    recurrenceEnable: "Create multiple scheduled events",
    recurrenceFreq: "Repeat",
    recurrenceDaily: "every day",
    recurrenceWeekly: "every week",
    recurrenceMonthly: "every month",
    recurrenceTotal: "Total dates (including the first)",
    recurrenceHint:
      "Several separate events with the same content will be created; each can be edited or deleted on its own.",
  },
};

export function adminCalendarFormMsg(lang: Lang): AdminCalendarFormMsg {
  return M[lang] ?? M.ru;
}
