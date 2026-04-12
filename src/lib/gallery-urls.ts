/** Нормализация массива URL из jsonb или JSON из формы. */
export function normalizeGalleryUrls(raw: unknown): string[] {
  if (raw == null) return [];
  if (Array.isArray(raw)) {
    return raw.filter(
      (x): x is string => typeof x === "string" && /^https?:\/\//i.test(x.trim()),
    );
  }
  return [];
}
