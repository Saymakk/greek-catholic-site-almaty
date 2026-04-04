import type { Lang } from "@/lib/i18n";

/** Человекочитаемые подписи для action (код хранится в БД). */
const labels: Record<string, Record<Lang, string>> = {
  "news.create": {
    ru: "Создана новость",
    uk: "Створено новину",
    kk: "Жаңалық жасалды",
    en: "News item created",
  },
  "news.update": {
    ru: "Обновлена новость",
    uk: "Оновлено новину",
    kk: "Жаңалық жаңартылды",
    en: "News item updated",
  },
  "news.delete": {
    ru: "Удалена новость",
    uk: "Видалено новину",
    kk: "Жаңалық жойылды",
    en: "News item deleted",
  },
  "news.cover_remove": {
    ru: "Убрана обложка новости",
    uk: "Прибрано обкладинку новини",
    kk: "Жаңалық мұқабасы алынды",
    en: "News cover removed",
  },
  "liturgical.create": {
    ru: "Создано событие календаря",
    uk: "Створено подію календаря",
    kk: "Күнтізбе оқиғасы жасалды",
    en: "Calendar event created",
  },
  "liturgical.update": {
    ru: "Обновлено событие календаря",
    uk: "Оновлено подію календаря",
    kk: "Күнтізбе оқиғасы жаңартылды",
    en: "Calendar event updated",
  },
  "liturgical.delete": {
    ru: "Удалено событие календаря",
    uk: "Видалено подію календаря",
    kk: "Күнтізбе оқиғасы жойылды",
    en: "Calendar event deleted",
  },
  "liturgical.cover_remove": {
    ru: "Убрана обложка события",
    uk: "Прибрано обкладинку події",
    kk: "Оқиға мұқабасы алынды",
    en: "Event cover removed",
  },
  "scripture.create": {
    ru: "Создана книга Писания",
    uk: "Створено книгу Писання",
    kk: "Жазба кітабы жасалды",
    en: "Scripture book created",
  },
  "scripture.update": {
    ru: "Обновлена книга Писания",
    uk: "Оновлено книгу Писання",
    kk: "Жазба кітабы жаңартылды",
    en: "Scripture book updated",
  },
  "scripture.delete": {
    ru: "Удалена книга Писания",
    uk: "Видалено книгу Писання",
    kk: "Жазба кітабы жойылды",
    en: "Scripture book deleted",
  },
  "scripture.cover_remove": {
    ru: "Убрана обложка книги",
    uk: "Прибрано обкладинку книги",
    kk: "Кітап мұқабасы алынды",
    en: "Book cover removed",
  },
  "history.save": {
    ru: "Сохранена страница «История»",
    uk: "Збережено сторінку «Історія»",
    kk: "«Тарих» беті сақталды",
    en: "History page saved",
  },
  "settings.footer.save": {
    ru: "Сохранены контакты / футер",
    uk: "Збережено контакти / підвал",
    kk: "Байланыс / футер сақталды",
    en: "Footer / contacts saved",
  },
  "user.invite": {
    ru: "Приглашён пользователь",
    uk: "Запрошено користувача",
    kk: "Пайдаланушы шақырылды",
    en: "User invited",
  },
};

export function adminActivityActionLabel(lang: Lang, action: string): string {
  const row = labels[action];
  if (row) return row[lang] ?? row.ru;
  return action;
}

export function adminActivityEntityLabel(lang: Lang, entityType: string): string {
  const map: Record<string, Record<Lang, string>> = {
    news: { ru: "Новости", uk: "Новини", kk: "Жаңалықтар", en: "News" },
    liturgical_event: { ru: "Календарь", uk: "Календар", kk: "Күнтізбе", en: "Calendar" },
    scripture_book: { ru: "Писание", uk: "Писання", kk: "Жазба", en: "Scripture" },
    page_content: { ru: "Страница", uk: "Сторінка", kk: "Бет", en: "Page" },
    site_settings: { ru: "Настройки", uk: "Налаштування", kk: "Баптаулар", en: "Settings" },
    auth: { ru: "Пользователи", uk: "Користувачі", kk: "Пайдаланушылар", en: "Users" },
  };
  const row = map[entityType];
  if (row) return row[lang] ?? row.ru;
  return entityType;
}

export function adminDashboardCopy(lang: Lang) {
  const d: Record<
    Lang,
    {
      pageTitle: string;
      welcomeLine: string;
      activityTitle: string;
      activityEmpty: string;
      activityUnavailable: string;
      colTime: string;
      colUser: string;
      colAction: string;
      colDetails: string;
    }
  > = {
    ru: {
      pageTitle: "Панель",
      welcomeLine: "Вы вошли как",
      activityTitle: "Последние действия",
      activityEmpty: "Пока нет записей в журнале.",
      activityUnavailable: "Журнал действий недоступен (примените миграцию БД).",
      colTime: "Время",
      colUser: "Кто",
      colAction: "Действие",
      colDetails: "Детали",
    },
    uk: {
      pageTitle: "Панель",
      welcomeLine: "Ви увійшли як",
      activityTitle: "Останні дії",
      activityEmpty: "Записів у журналі ще немає.",
      activityUnavailable: "Журнал дій недоступний (застосуйте міграцію БД).",
      colTime: "Час",
      colUser: "Хто",
      colAction: "Дія",
      colDetails: "Деталі",
    },
    kk: {
      pageTitle: "Панель",
      welcomeLine: "Сіз кірдіңіз",
      activityTitle: "Соңғы әрекеттер",
      activityEmpty: "Журналда әлі жазбалар жоқ.",
      activityUnavailable: "Әрекеттер журналы қолжетімсіз (МҚ миграциясын қолданыңыз).",
      colTime: "Уақыт",
      colUser: "Кім",
      colAction: "Әрекет",
      colDetails: "Толығырақ",
    },
    en: {
      pageTitle: "Dashboard",
      welcomeLine: "Signed in as",
      activityTitle: "Recent activity",
      activityEmpty: "No log entries yet.",
      activityUnavailable: "Activity log unavailable (apply the database migration).",
      colTime: "Time",
      colUser: "Who",
      colAction: "Action",
      colDetails: "Details",
    },
  };
  return d[lang] ?? d.ru;
}
