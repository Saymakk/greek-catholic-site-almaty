import type { Lang } from "./i18n";

/** Первый `src` у `<img>` в HTML (порядок появления в разметке). */
function firstImgSrcInHtml(html: string): string | null {
  const m = html.match(/<img\b[^>]*\bsrc\s*=\s*["']([^"']+)["']/i);
  return m?.[1]?.trim() || null;
}

/**
 * Первое изображение для превью: язык интерфейса, затем ru, uk, kk, en —
 * как при выборе текста для списка.
 */
export function firstHistoryImageForAdmin(
  locales: { lang: string; body: string }[],
  uiLang: Lang,
): string | null {
  const by: Record<string, string> = {};
  for (const l of locales) by[l.lang] = l.body ?? "";
  const order: string[] = [uiLang, "ru", "uk", "kk", "en"];
  for (const code of order) {
    const b = by[code]?.trim();
    if (!b) continue;
    const src = firstImgSrcInHtml(b);
    if (src) return src;
  }
  return null;
}
