import { parseHttpImageUrl } from "./admin-image-url";

const MAX_EMBED_LEN = 16384;

/** Обложка новости: iframe / video / embed / object (код вставки с хостинга). */
export function isNewsCoverVideoEmbed(s: string | null | undefined): boolean {
  if (s == null) return false;
  const t = s.trim();
  if (!t) return false;
  return /<\s*(iframe|video|embed|object)\b/i.test(t);
}

/**
 * Пустая строка → null. HTML-вставка видео → сохраняем как есть (с ограничениями).
 * Иначе — обычный http(s) URL картинки.
 */
export function parseNewsCoverUrlOrEmbed(raw: string, fieldLabel = "Обложка"): string | null {
  const s = raw.trim();
  if (!s) return null;

  if (isNewsCoverVideoEmbed(s)) {
    if (s.length > MAX_EMBED_LEN) {
      throw new Error(`${fieldLabel}: слишком длинный фрагмент HTML`);
    }
    if (/<script\b/i.test(s)) {
      throw new Error(`${fieldLabel}: недопустимые теги`);
    }
    return s;
  }

  return parseHttpImageUrl(s, `${fieldLabel} (URL)`);
}
