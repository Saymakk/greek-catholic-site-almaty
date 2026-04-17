export const MAX_HTTP_IMAGE_URL_LEN = 4096;

/** Пустая строка → null; иначе проверка http(s) URL. */
export function parseHttpImageUrl(
  raw: string,
  fieldLabel = "URL",
  maxLen: number = MAX_HTTP_IMAGE_URL_LEN,
): string | null {
  const s = raw.trim();
  if (!s) return null;
  if (s.length > maxLen) {
    throw new Error(`${fieldLabel}: слишком длинная ссылка`);
  }
  let u: URL;
  try {
    u = new URL(s);
  } catch {
    throw new Error(`${fieldLabel}: некорректный адрес`);
  }
  if (u.protocol !== "http:" && u.protocol !== "https:") {
    throw new Error(`${fieldLabel}: разрешены только http и https`);
  }
  return s;
}

export function parseHttpImageUrlFromFormData(
  formData: FormData,
  key: string,
  fieldLabel?: string,
): string | null {
  const v = formData.get(key);
  if (v == null) return null;
  return parseHttpImageUrl(String(v), fieldLabel ?? key);
}
