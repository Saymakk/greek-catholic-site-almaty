/** Пример для полей «вставить карту» в админке (полный тег iframe). */
export const DEFAULT_MAP_IFRAME_SNIPPET = `<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2905.78928166767!2d76.86756577661457!3d43.255837878039785!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x388369823d000001%3A0xe5cfe59f1bfb932a!2z0KDQuNC80YHQutC-LdCa0LDRgtC-0LvQuNGH0LXRgdC60LjQuSDQodC-0LHQvtGAINCf0YDQtdGB0LLRj9GC0L7QuSDQotGA0L7QuNGG0Ys!5e0!3m2!1sru!2skz!4v1775402248459!5m2!1sru!2skz" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>`;

/** Из поля админки: полный тег iframe, URL или пусто → нормализованный src для embed. */
export function extractMapEmbedSrc(raw: string): string | null {
  const t = raw.trim();
  if (!t) return null;
  const m = t.match(/src\s*=\s*["']([^"']+)["']/i);
  if (m?.[1]) return m[1].trim();
  if (/^https?:\/\//i.test(t)) return t;
  return null;
}

export function mapEmbedSnippetFromSrc(src: string): string {
  const esc = src.trim().replace(/&/g, "&amp;").replace(/"/g, "&quot;");
  return `<iframe src="${esc}" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>`;
}

/** Текст поля «карта» в админке футера: только сохранённый src; без значения по умолчанию. */
export function mapEmbedRawForForm(storedSrc: string | undefined | null): string {
  const s = storedSrc?.trim();
  if (!s) return "";
  return mapEmbedSnippetFromSrc(s);
}

/** Поле карты в форме прихода: по умолчанию — пример iframe; если в БД уже есть src — подставляем. */
export function mapEmbedRawForParishForm(storedSrc: string | undefined | null): string {
  const s = storedSrc?.trim();
  if (!s) return DEFAULT_MAP_IFRAME_SNIPPET;
  return mapEmbedSnippetFromSrc(s);
}
