"use client";

import { useMemo, useState } from "react";
import type { AdminSharedImageCopy } from "@/lib/admin-shared-image-i18n";

export function AdminGalleryEditor({
  imageCopy,
  initialUrls,
}: {
  imageCopy: AdminSharedImageCopy;
  initialUrls: string[];
}) {
  const stableInitial = useMemo(() => normalizeInitial(initialUrls), [initialUrls]);
  const [urls, setUrls] = useState<string[]>(() => stableInitial);
  /** Дополнительные поля ввода ссылок (не считаются сохранёнными превью до отправки формы). */
  const [linkRows, setLinkRows] = useState<string[]>(() => [""]);

  const galleryUrlsJson = useMemo(() => {
    const fromLinks = linkRows
      .map((s) => s.trim())
      .filter((u) => /^https?:\/\//i.test(u));
    const out = [...urls];
    for (const u of fromLinks) {
      if (!out.includes(u)) out.push(u);
    }
    return JSON.stringify(out);
  }, [urls, linkRows]);

  return (
    <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
      <p className="text-xs font-medium text-parish-muted">{imageCopy.galleryTitle}</p>
      <p className="text-[11px] leading-relaxed text-parish-muted">{imageCopy.galleryHint}</p>
      <input type="hidden" name="gallery_urls_json" value={galleryUrlsJson} />
      {urls.length > 0 ? (
        <ul className="flex flex-wrap gap-2">
          {urls.map((url, idx) => (
            <li
              key={`${url}-${idx}`}
              className="relative h-20 w-20 overflow-hidden rounded-md border border-parish-border bg-parish-surface"
            >
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img src={url} alt="" className="h-full w-full object-cover" />
              <button
                type="button"
                className="absolute right-0 top-0 flex h-7 w-7 items-center justify-center rounded-bl-md bg-parish-text/75 text-sm font-bold text-white hover:bg-red-600"
                aria-label={imageCopy.galleryRemoveImage}
                onClick={() => setUrls((prev) => prev.filter((_, i) => i !== idx))}
              >
                ×
              </button>
            </li>
          ))}
        </ul>
      ) : null}
      <label className="block text-xs text-parish-muted">
        {imageCopy.galleryAddFiles}
        <input
          type="file"
          name="gallery_files"
          multiple
          accept="image/*"
          className="mt-1 block w-full text-sm text-parish-text"
        />
      </label>
      <div className="space-y-2">
        <p className="text-xs font-medium text-parish-muted">{imageCopy.galleryUrlsByLink}</p>
        {linkRows.map((val, i) => (
          <div key={i} className="flex items-center gap-2">
            <input
              type="url"
              value={val}
              onChange={(e) =>
                setLinkRows((rows) => rows.map((r, j) => (j === i ? e.target.value : r)))
              }
              placeholder={imageCopy.imageUrlPlaceholder}
              className="min-w-0 flex-1 rounded border border-parish-border px-2 py-1.5 text-sm text-parish-text"
              autoComplete="off"
            />
            {linkRows.length > 1 ? (
              <button
                type="button"
                className="shrink-0 rounded border border-parish-border px-2 py-1.5 text-xs font-medium text-red-600 hover:bg-red-50"
                aria-label={imageCopy.galleryRemoveUrlField}
                onClick={() => setLinkRows((rows) => rows.filter((_, j) => j !== i))}
              >
                ×
              </button>
            ) : null}
          </div>
        ))}
        <button
          type="button"
          className="text-xs font-medium text-parish-accent hover:underline"
          onClick={() => setLinkRows((rows) => [...rows, ""])}
        >
          {imageCopy.galleryAddUrlField}
        </button>
      </div>
    </div>
  );
}

function normalizeInitial(urls: string[]): string[] {
  return urls.filter((u) => typeof u === "string" && /^https?:\/\//i.test(u.trim()));
}
