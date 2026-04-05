/** Календарь и «сегодня» — в этом поясе (по умолчанию Алматы). Задайте SITE_TIMEZONE или NEXT_PUBLIC_SITE_TIMEZONE. */
const DEFAULT_SITE_TIMEZONE = "Asia/Almaty";

export function getSiteTimeZone(): string {
  return (
    process.env.SITE_TIMEZONE ??
    process.env.NEXT_PUBLIC_SITE_TIMEZONE ??
    DEFAULT_SITE_TIMEZONE
  );
}
