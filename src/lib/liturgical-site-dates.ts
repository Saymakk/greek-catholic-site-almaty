import { endOfMonth, endOfWeek, format, startOfMonth, startOfWeek } from "date-fns";
import { toZonedTime } from "date-fns-tz";
import { getSiteTimeZone } from "@/lib/site-timezone";

/** Сегодняшняя дата календаря (YYYY-MM-DD) в часовом поясе прихода, не UTC сервера. */
export function todayStr() {
  return format(toZonedTime(new Date(), getSiteTimeZone()), "yyyy-MM-dd");
}

/** Диапазон сетки месяца для загрузки событий (как в виджете календаря). */
export function liturgicalGridRangeForSiteNow(now: Date = new Date()) {
  const tz = getSiteTimeZone();
  const zNow = toZonedTime(now, tz);
  const gridStart = startOfWeek(startOfMonth(zNow), { weekStartsOn: 1 });
  const gridEnd = endOfWeek(endOfMonth(zNow), { weekStartsOn: 1 });
  return { gridStart, gridEnd, zNow };
}
