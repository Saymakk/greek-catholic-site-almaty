"use client";

import { useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { ScriptureBook } from "@/lib/data";
import { ScriptureReadPicker, ScriptureFilePicker } from "@/components/ScriptureEditionPicker";
import { BookDetailModal } from "@/components/BookDetailModal";

const footerRead =
  "block w-full rounded-lg bg-parish-accent py-2 text-center text-xs font-semibold text-white hover:opacity-90";
const footerDownload =
  "flex min-h-[2.25rem] w-full items-center justify-center rounded-lg border border-parish-border px-1 py-2 text-center text-xs font-semibold text-parish-accent hover:bg-parish-accent-soft";
const footerDetails =
  "flex min-h-[2.25rem] w-full items-center justify-center rounded-lg border border-parish-border px-2 py-2 text-center text-xs font-semibold text-parish-text hover:bg-parish-accent-soft";

export function LibraryBooksGrid({ lang, books }: { lang: Lang; books: ScriptureBook[] }) {
  const [detail, setDetail] = useState<ScriptureBook | null>(null);
  const [coverLightboxUrl, setCoverLightboxUrl] = useState<string | null>(null);

  return (
    <>
      <ul className="mt-10 grid grid-cols-2 gap-4 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-7">
        {books.map((b) => (
          <li
            key={b.id}
            className="flex flex-col overflow-hidden rounded-xl border border-parish-border bg-parish-surface shadow-sm"
          >
            <div className="relative flex aspect-[2/3] items-center justify-center bg-parish-surface p-2">
              {b.coverImageUrl ? (
                <button
                  type="button"
                  className="flex h-full w-full items-center justify-center focus:outline-none focus:ring-2 focus:ring-parish-accent/40"
                  onClick={() => setCoverLightboxUrl(b.coverImageUrl!)}
                  aria-label={t(lang, "imageLightboxAria")}
                >
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img
                    src={b.coverImageUrl}
                    alt=""
                    className="max-h-full max-w-full cursor-zoom-in object-contain"
                  />
                </button>
              ) : (
                <span className="px-2 text-center text-xs font-medium text-parish-muted">
                  {b.title ?? "—"}
                </span>
              )}
            </div>

            <div className="flex min-h-0 flex-1 flex-col px-3 pt-2">
              <p className="line-clamp-3 text-center text-xs font-semibold leading-snug text-parish-text">
                {b.title ?? "—"}
              </p>
            </div>

            <div className="mt-auto shrink-0 space-y-2 border-t border-parish-border bg-parish-bg/25 px-3 py-3">
              {b.readMenu.some((m) => m.url) ? (
                <ScriptureReadPicker
                  lang={lang}
                  options={b.readMenu}
                  anchorClassName="block w-full"
                  className={footerRead}
                >
                  {t(lang, "readOnline")}
                </ScriptureReadPicker>
              ) : null}
              <div className="flex flex-col gap-2">
                {b.fileMenu.some((m) => m.url) ? (
                  <div className="w-full">
                    <ScriptureFilePicker
                      lang={lang}
                      options={b.fileMenu}
                      anchorClassName="block w-full"
                      className={footerDownload}
                    >
                      {t(lang, "download")}
                    </ScriptureFilePicker>
                  </div>
                ) : null}
                <button type="button" onClick={() => setDetail(b)} className={footerDetails}>
                  {t(lang, "moreDetails")}
                </button>
              </div>
            </div>
          </li>
        ))}
      </ul>
      {detail ? (
        <BookDetailModal lang={lang} book={detail} onClose={() => setDetail(null)} />
      ) : null}
      {coverLightboxUrl ? (
        <div
          className="fixed inset-0 z-[130] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
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
