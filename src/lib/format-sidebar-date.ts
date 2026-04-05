import { format, parseISO } from "date-fns";
import { enUS, kk, ru, uk } from "date-fns/locale";
import type { Lang } from "@/lib/i18n";

const locales = { ru, uk, kk, en: enUS } as const;

/** Заголовок блока «сегодня» на главной: локализованная дата. */
export function formatSidebarTodayDate(lang: Lang, isoDate: string): string {
  const d = parseISO(isoDate);
  const locale = locales[lang] ?? ru;
  return format(d, "d MMMM yyyy", { locale });
}
