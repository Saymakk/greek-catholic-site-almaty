"use client";

import { useId, useMemo, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t, type UiKey } from "@/lib/ui-strings";
import type { ScriptureBook } from "@/lib/data";
import { ScriptureReadPicker, ScriptureFilePicker } from "@/components/ScriptureEditionPicker";
import { gatherLightboxUrls, ImageLightboxOverlay } from "@/components/ImageLightboxOverlay";
import { RichOrPlain } from "@/components/RichOrPlain";

const COVER_COL = "w-32 shrink-0 sm:w-36";

const footerRead =
  "block w-full rounded-lg bg-parish-accent py-2.5 text-center text-sm font-semibold text-white hover:opacity-90";
const footerDownload =
  "flex min-h-[2.75rem] w-full items-center justify-center rounded-lg border border-parish-border px-3 py-2.5 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft";

function bookPrimaryNativeName(siteLang: Lang, code: string): string {
  const keys: Record<string, UiKey> = {
    ru: "langNativeRu",
    uk: "langNativeUk",
    kk: "langNativeKk",
    en: "langNativeEn",
  };
  const k = keys[code];
  return k ? t(siteLang, k) : code;
}

/** Чем длиннее описание, тем шире модалка (шаги ~512 → ~672 → ~768 → ~896px) */
function bookModalMaxWidthClass(description: string | null | undefined): string {
  const n = (description ?? "").length;
  if (n >= 2000) return "max-w-4xl";
  if (n >= 1000) return "max-w-3xl";
  if (n >= 450) return "max-w-2xl";
  if (n >= 180) return "max-w-lg";
  return "max-w-lg";
}

export function BookDetailModal({
  lang,
  book,
  onClose,
}: {
  lang: Lang;
  book: ScriptureBook;
  onClose: () => void;
}) {
  const titleId = useId();
  const [lightboxIndex, setLightboxIndex] = useState<number | null>(null);
  const coverUrl = book.coverImageUrl;
  const lightboxUrls = useMemo(
    () => gatherLightboxUrls(book.coverImageUrl, book.galleryImageUrls),
    [book.coverImageUrl, book.galleryImageUrls],
  );
  const modalWidthClass = bookModalMaxWidthClass(book.description);

  return (
    <>
      <div
        className="fixed inset-0 z-[120] flex items-center justify-center bg-parish-text/30 p-4 backdrop-blur-sm"
        role="dialog"
        aria-modal
        aria-labelledby={titleId}
        onClick={onClose}
      >
        <div
          className={`flex max-h-[90vh] w-full ${modalWidthClass} flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-xl`}
          onClick={(e) => e.stopPropagation()}
        >
          <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain p-6 sm:p-7">
            <div className="flex flex-col gap-5 sm:flex-row sm:items-start">
              <div className={`mx-auto flex flex-col gap-3 sm:mx-0 ${COVER_COL}`}>
                {coverUrl ? (
                  <button
                    type="button"
                    className="block overflow-hidden rounded-md bg-parish-surface focus:outline-none focus:ring-2 focus:ring-parish-accent/40"
                    onClick={() => setLightboxIndex(lightboxUrls.indexOf(coverUrl))}
                    aria-label={t(lang, "imageLightboxAria")}
                  >
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={coverUrl}
                      alt=""
                      className="h-48 w-full rounded-md object-cover shadow-sm sm:h-52"
                    />
                  </button>
                ) : (
                  <div className="flex h-48 w-full items-center justify-center rounded-md border border-dashed border-parish-border bg-parish-surface text-sm text-parish-muted sm:h-52">
                    —
                  </div>
                )}
                {book.galleryImageUrls.length > 0 ? (
                  <ul className="grid grid-cols-2 gap-2">
                    {book.galleryImageUrls.map((src, i) => (
                      <li
                        key={`${src}-${i}`}
                        className="overflow-hidden rounded-md border border-parish-border/60"
                      >
                        <button
                          type="button"
                          className="block w-full"
                          onClick={() => setLightboxIndex(lightboxUrls.indexOf(src))}
                          aria-label={t(lang, "imageLightboxAria")}
                        >
                          {/* eslint-disable-next-line @next/next/no-img-element */}
                          <img src={src} alt="" className="h-16 w-full object-cover" />
                        </button>
                      </li>
                    ))}
                  </ul>
                ) : null}
              </div>
              <div className="min-w-0 flex-1 text-center sm:text-left">
                <h3
                  id={titleId}
                  className="font-display text-2xl font-semibold leading-snug text-parish-text sm:text-[1.65rem]"
                >
                  {book.title ?? "—"}
                </h3>
                {book.primaryLang ? (
                  <p className="mt-3 text-sm text-parish-muted">
                    {t(lang, "scripturePrimaryOnSite")}:{" "}
                    <span className="font-medium text-parish-text">
                      {bookPrimaryNativeName(lang, book.primaryLang)}
                    </span>
                  </p>
                ) : book.legacyMain ? (
                  <p className="mt-3 text-sm text-parish-muted">{t(lang, "scripturePrimaryLegacyNote")}</p>
                ) : null}
                {book.description ? (
                  <RichOrPlain
                    content={book.description}
                    className="rich-html mt-4 max-w-none text-base font-medium leading-relaxed text-parish-text [&_p]:break-words"
                  />
                ) : null}
              </div>
            </div>
          </div>
          <div className="shrink-0 space-y-2 border-t border-parish-border bg-parish-bg/25 p-4">
            {book.readMenu.some((m) => m.url) ? (
              <ScriptureReadPicker
                lang={lang}
                options={book.readMenu}
                anchorClassName="block w-full"
                className={footerRead}
              >
                {t(lang, "readOnline")}
              </ScriptureReadPicker>
            ) : null}
            {book.fileMenu.some((m) => m.url) ? (
              <ScriptureFilePicker
                lang={lang}
                options={book.fileMenu}
                anchorClassName="block w-full"
                className={footerDownload}
              >
                {t(lang, "download")}
              </ScriptureFilePicker>
            ) : null}
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

      <ImageLightboxOverlay
        lang={lang}
        images={lightboxUrls}
        initialIndex={lightboxIndex ?? 0}
        open={lightboxIndex !== null}
        onClose={() => setLightboxIndex(null)}
        zClass="z-[140]"
      />
    </>
  );
}
