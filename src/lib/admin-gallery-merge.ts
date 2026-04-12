import { normalizeGalleryUrls } from "@/lib/gallery-urls";

const DEFAULT_MAX = 40;

/**
 * Собирает итоговый список URL галереи: hidden `gallery_urls_json` (превью + ссылки из полей) + загрузки файлов.
 */
export async function mergeGalleryFromForm(
  formData: FormData,
  options: {
    uploadFiles: (files: File[]) => Promise<string[]>;
    max?: number;
  },
): Promise<string[]> {
  const raw = (formData.get("gallery_urls_json") as string) ?? "[]";
  let kept: string[] = [];
  try {
    const j = JSON.parse(raw);
    kept = normalizeGalleryUrls(j);
  } catch {
    kept = [];
  }
  const max = options.max ?? DEFAULT_MAX;
  const files = formData
    .getAll("gallery_files")
    .filter((x): x is File => x instanceof File && x.size > 0);
  if (files.length) {
    const uploaded = await options.uploadFiles(files);
    kept = [...kept, ...uploaded];
  }
  return kept.slice(0, max);
}
