"use client";

import { format, parseISO } from "date-fns";
import { useEffect, useId } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { NewsRow } from "@/lib/data";
import { RichOrPlain } from "./RichOrPlain";

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

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [onClose]);

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
            <div className="mt-4">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={news.coverImageUrl}
                alt=""
                className="mx-auto max-h-[min(400px,50vh)] max-w-full rounded-xl border border-parish-border/60 bg-parish-surface object-contain"
              />
            </div>
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
    </div>
  );
}
