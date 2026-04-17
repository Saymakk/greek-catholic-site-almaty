"use client";

import { format, parseISO } from "date-fns";
import { useEffect, useId, useMemo, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { NewsRow } from "@/lib/data";
import { RichOrPlain } from "./RichOrPlain";
import { NewsCoverBlock } from "./NewsCoverBlock";
import { gatherLightboxUrls, ImageLightboxOverlay } from "./ImageLightboxOverlay";

export function NewsDetailModal({
  lang,
  news,
  onClose,
}: {
  lang: Lang;
  news: NewsRow;
  onClose: () => void;
}) {
  const titleId = useId();
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null);
  const lightboxUrls = useMemo(
    () => gatherLightboxUrls(news.coverImageUrl, news.galleryImageUrls),
    [news.coverImageUrl, news.galleryImageUrls],
  );

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key !== "Escape") return;
      if (lightboxIndex !== null) return;
      onClose();
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [lightboxIndex, onClose]);

  return (
    <div
      className="fixed inset-0 z-[120] flex items-center justify-center bg-parish-text/30 p-4 backdrop-blur-sm"
      role="dialog"
      aria-modal
      aria-labelledby={titleId}
      onClick={onClose}
    >
      <div
        className="relative flex max-h-[90vh] w-full max-w-lg flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-xl sm:max-w-2xl"
        onClick={(e) => e.stopPropagation()}
      >
        <button
          type="button"
          className="absolute right-2 top-2 z-10 flex h-11 w-11 items-center justify-center rounded-lg text-parish-muted transition hover:bg-parish-accent-soft hover:text-parish-text touch-manipulation"
          aria-label={t(lang, "closeModal")}
          onClick={onClose}
        >
          <span className="text-2xl leading-none" aria-hidden>
            ×
          </span>
        </button>
        <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain p-6 pt-14 text-left sm:p-7 sm:pt-16">
          <time className="text-xs font-semibold text-parish-muted" dateTime={news.published_at}>
            {format(parseISO(news.published_at), "dd.MM.yyyy")}
          </time>
          <h2 id={titleId} className="mt-2 font-display text-2xl font-semibold text-parish-text">
            {news.title}
          </h2>
          {news.coverImageUrl ? (
            <NewsCoverBlock
              variant="modal"
              cover={news.coverImageUrl}
              onImageClick={() => setLightboxIndex(lightboxUrls.indexOf(news.coverImageUrl!))}
              imageAriaLabel={t(lang, "imageLightboxAria")}
            />
          ) : null}
          {news.galleryImageUrls.length > 0 ? (
            <ul className="mt-4 grid grid-cols-2 gap-2 sm:grid-cols-3">
              {news.galleryImageUrls.map((src, i) => (
                <li
                  key={`${src}-${i}`}
                  className="overflow-hidden rounded-lg border border-parish-border/60 bg-parish-surface"
                >
                  <button
                    type="button"
                    className="block h-full w-full focus:outline-none focus:ring-2 focus:ring-parish-accent"
                    onClick={() => setLightboxIndex(lightboxUrls.indexOf(src))}
                    aria-label={t(lang, "imageLightboxAria")}
                  >
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img src={src} alt="" className="h-28 w-full cursor-zoom-in object-cover sm:h-32" />
                  </button>
                </li>
              ))}
            </ul>
          ) : null}
          {news.excerpt ? (
            <p className="mt-4 text-sm font-medium text-parish-muted">{news.excerpt}</p>
          ) : null}
          <RichOrPlain
            content={news.body}
            className="rich-html mt-4 max-w-none text-sm font-medium leading-relaxed text-parish-text"
          />
        </div>
        <div className="shrink-0 border-t border-parish-border p-4">
          <button
            type="button"
            className="w-full rounded-lg border border-parish-border py-2.5 text-base font-semibold text-parish-accent hover:bg-parish-accent-soft"
            onClick={onClose}
          >
            {t(lang, "closeModal")}
          </button>
        </div>
      </div>
      <ImageLightboxOverlay
        lang={lang}
        images={lightboxUrls}
        initialIndex={lightboxIndex ?? 0}
        open={lightboxIndex !== null}
        onClose={() => setLightboxIndex(null)}
        zClass="z-[200]"
      />
    </div>
  );
}
