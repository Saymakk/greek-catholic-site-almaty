"use client";

import { useEffect, useId, useMemo, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView, LiturgicalExtraView } from "@/lib/data";
import { RichOrPlain } from "./RichOrPlain";
import { gatherLightboxUrls, ImageLightboxOverlay } from "./ImageLightboxOverlay";

function ExtraBlock({ ex }: { ex: LiturgicalExtraView }) {
  const body = (
    <RichOrPlain
      content={ex.body}
      className="rich-html mt-2 max-w-none text-sm font-medium leading-relaxed text-parish-text"
    />
  );
  if (ex.url) {
    return (
      <button
        type="button"
        className="mt-4 w-full rounded-xl border border-parish-border/70 bg-parish-bg/40 p-4 text-left transition hover:bg-parish-accent-soft/40"
        onClick={() => window.open(ex.url!, "_blank", "noopener,noreferrer")}
      >
        {ex.label.trim() ? (
          <p className="text-xs font-bold uppercase tracking-wide text-parish-muted">{ex.label}</p>
        ) : null}
        {body}
      </button>
    );
  }
  return (
    <div className="mt-4 rounded-xl border border-parish-border/70 bg-parish-bg/40 p-4">
      {ex.label.trim() ? (
        <p className="text-xs font-bold uppercase tracking-wide text-parish-muted">{ex.label}</p>
      ) : null}
      {body}
    </div>
  );
}

export function LiturgicalEventModal({
  lang,
  event,
  onClose,
}: {
  lang: Lang;
  event: LiturgicalEventView;
  onClose: () => void;
}) {
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null);
  const titleId = useId();
  const lightboxUrls = useMemo(
    () => gatherLightboxUrls(event.coverImageUrl, event.galleryImageUrls),
    [event.coverImageUrl, event.galleryImageUrls],
  );

  useEffect(() => {
    setLightboxIndex(null);
  }, [event.id]);

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key !== "Escape") return;
      if (lightboxIndex !== null) return;
      onClose();
    }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [lightboxIndex, onClose]);

  return (
    <>
      <div
        className="fixed inset-0 z-[100] flex items-center justify-center bg-parish-text/25 p-4 backdrop-blur-sm"
        role="dialog"
        aria-modal
        aria-labelledby={titleId}
        onClick={onClose}
      >
        <div
          className="relative flex max-h-[85vh] w-full max-w-2xl flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-xl"
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
          <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain p-6 pt-14">
            <h3 id={titleId} className="font-display text-xl font-semibold text-parish-text">
              {event.title}
            </h3>
            <p className="mt-1 text-xs font-semibold uppercase tracking-wide text-parish-muted">
              {event.kindLabel}
            </p>
            {event.coverImageUrl ? (
              <button
                type="button"
                className="mt-4 block w-full rounded-xl bg-parish-surface focus:outline-none focus:ring-2 focus:ring-parish-accent/50"
                onClick={(e) => {
                  e.stopPropagation();
                  setLightboxIndex(lightboxUrls.indexOf(event.coverImageUrl!));
                }}
              >
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img
                  src={event.coverImageUrl}
                  alt=""
                  className="mx-auto max-h-[min(512px,70vh)] max-w-full w-auto cursor-zoom-in rounded-xl border border-parish-border object-contain shadow-sm"
                />
              </button>
            ) : null}
            {event.galleryImageUrls.length > 0 ? (
              <ul className="mt-3 grid grid-cols-2 gap-2 sm:grid-cols-3">
                {event.galleryImageUrls.map((src, i) => (
                  <li
                    key={`${src}-${i}`}
                    className="overflow-hidden rounded-lg border border-parish-border/70 bg-parish-bg/30"
                  >
                    <button
                      type="button"
                      className="block w-full focus:outline-none focus:ring-2 focus:ring-parish-accent/50"
                      onClick={(e) => {
                        e.stopPropagation();
                        setLightboxIndex(lightboxUrls.indexOf(src));
                      }}
                    >
                      {/* eslint-disable-next-line @next/next/no-img-element */}
                      <img
                        src={src}
                        alt=""
                        className="h-24 w-full cursor-zoom-in object-cover sm:h-28"
                      />
                    </button>
                  </li>
                ))}
              </ul>
            ) : null}
            <RichOrPlain
              content={event.explanation}
              className="rich-html mt-4 max-w-none text-sm font-medium leading-relaxed text-parish-text"
            />
            {event.extras.map((ex, i) => (
              <ExtraBlock key={i} ex={ex} />
            ))}
            {event.prayer ? (
              <div className="mt-6 rounded-xl bg-parish-accent-soft/80 p-4">
                <p className="text-xs font-bold uppercase tracking-wide text-parish-muted">
                  {t(lang, "prayer")}
                </p>
                <RichOrPlain
                  content={event.prayer}
                  className="rich-html mt-2 max-w-none text-sm font-medium leading-relaxed text-parish-text"
                />
              </div>
            ) : null}
          </div>
          <div className="shrink-0 border-t border-parish-border bg-parish-surface p-4">
            <button
              type="button"
              className="w-full rounded-lg border border-parish-border py-2 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
              onClick={onClose}
            >
              {t(lang, "closeModal")}
            </button>
          </div>
        </div>
      </div>

      <ImageLightboxOverlay
        lang={lang}
        images={lightboxUrls}
        initialIndex={lightboxIndex ?? 0}
        open={lightboxIndex !== null}
        onClose={() => setLightboxIndex(null)}
        zClass="z-[110]"
      />
    </>
  );
}
