"use client";

import { useEffect, useId, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView, LiturgicalExtraView } from "@/lib/data";
import { RichOrPlain } from "./RichOrPlain";

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
  const [coverLightboxUrl, setCoverLightboxUrl] = useState<string | null>(null);
  const titleId = useId();

  useEffect(() => {
    setCoverLightboxUrl(null);
  }, [event.id]);

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
          className="flex max-h-[85vh] w-full max-w-2xl flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-xl"
          onClick={(e) => e.stopPropagation()}
        >
          <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain p-6">
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
                  setCoverLightboxUrl(event.coverImageUrl);
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

      {coverLightboxUrl ? (
        <div
          className="fixed inset-0 z-[110] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-label={t(lang, "imageLightboxAria")}
          onClick={() => setCoverLightboxUrl(null)}
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={coverLightboxUrl}
            alt=""
            className="max-h-[95vh] max-w-[95vw] object-contain shadow-2xl"
            onClick={(e) => e.stopPropagation()}
          />
        </div>
      ) : null}
    </>
  );
}
