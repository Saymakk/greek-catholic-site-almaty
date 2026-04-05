import type { Lang } from "@/lib/i18n";
import type { CalendarLocaleFields } from "./calendar-entity-locales";

export type CalendarExtraRow = {
  sort_idx: number;
  label_ru: string | null;
  label_uk: string | null;
  label_kk: string | null;
  label_en: string | null;
  body_ru: string | null;
  body_uk: string | null;
  body_kk: string | null;
  body_en: string | null;
  url: string | null;
};

export type CalendarTemplatePayload = {
  id: string;
  name: string;
  rows: {
    sort_idx: number;
    label_ru: string | null;
    label_uk: string | null;
    label_kk: string | null;
    label_en: string | null;
  }[];
};

export type AdminCalendarPayload = {
  id: string;
  event_date: string;
  kind: string;
  /** Подпись типа для списка в админке (локаль интерфейса) */
  kindListLabel: string;
  /** Подписи типа из liturgical_kind_i18n для полей формы */
  kindSiteLabels: Partial<Record<Lang, string>>;
  primary_lang: string | null;
  cover_image_url: string | null;
  locales: CalendarLocaleFields[];
  extras: CalendarExtraRow[];
};
