"use client";

import { useEffect, useMemo, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t, type UiKey } from "@/lib/ui-strings";
import type { ScriptureBook } from "@/lib/data";
import { ScriptureReadPicker, ScriptureFilePicker } from "@/components/ScriptureEditionPicker";
import { BookDetailModal } from "@/components/BookDetailModal";
import { PaginationControls } from "@/components/PaginationControls";

const PAGE_SIZE = 10;

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

const footerRead =
  "block w-full rounded-lg bg-parish-accent py-2 text-center text-xs font-semibold text-white hover:opacity-90";
const footerDownload =
  "flex min-h-[2.25rem] w-full items-center justify-center rounded-lg border border-parish-border px-1 py-2 text-center text-xs font-semibold text-parish-accent hover:bg-parish-accent-soft";
const footerDetails =
  "flex min-h-[2.25rem] w-full items-center justify-center rounded-lg border border-parish-border px-2 py-2 text-center text-xs font-semibold text-parish-text hover:bg-parish-accent-soft";

export function ScriptureSection({
  lang,
  books,
  variant = "default",
}: {
  lang: Lang;
  books: ScriptureBook[];
  variant?: "default" | "sidebar";
}) {
  const isSidebar = variant === "sidebar";
  const [page, setPage] = useState(1);
  const [detailBook, setDetailBook] = useState<ScriptureBook | null>(null);
  const [coverLightboxUrl, setCoverLightboxUrl] = useState<string | null>(null);

  const total = books.length;
  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));
  const currentPage = Math.min(Math.max(1, page), totalPages);
  const pageBooks = useMemo(() => {
    const from = (currentPage - 1) * PAGE_SIZE;
    return books.slice(from, from + PAGE_SIZE);
  }, [books, currentPage]);

  useEffect(() => {
    setPage((p) => Math.min(p, totalPages));
  }, [totalPages]);

  return (
    <section id="useful-books" className="scroll-mt-24 overflow-visible">
      <h2
        className={
          isSidebar
            ? "font-display text-lg font-semibold leading-tight text-parish-text lg:text-xl"
            : "font-display text-2xl font-semibold text-parish-text"
        }
      >
        {t(lang, "scriptureTitle")}
      </h2>
      <p
        className={
          isSidebar
            ? "mt-2 text-xs font-medium leading-snug text-parish-muted"
            : "mt-2 text-sm font-medium text-parish-muted"
        }
      >
        {t(lang, "scriptureHint")}
      </p>
      <ul className={isSidebar ? "mt-4 space-y-3 overflow-visible" : "mt-6 space-y-4 overflow-visible"}>
        {books.length === 0 ? (
          <li className="font-medium text-parish-muted">{t(lang, "notAvailableLang")}</li>
        ) : (
          pageBooks.map((b) => (
            <li
              key={b.id}
              className="flex gap-3 overflow-hidden rounded-xl border border-parish-border bg-parish-surface p-2 shadow-sm sm:gap-3 sm:p-3"
            >
              <div className="relative mt-0 aspect-[2/3] w-14 shrink-0 overflow-hidden rounded-md bg-parish-surface sm:w-16">
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
                  <span className="flex h-full w-full items-center justify-center px-1 text-center text-[10px] font-medium leading-tight text-parish-muted">
                    {b.title ?? "—"}
                  </span>
                )}
              </div>

              <div className="flex min-h-0 min-w-0 flex-1 flex-col justify-between gap-2">
                <div>
                  <p
                    className={
                      isSidebar
                        ? "line-clamp-3 text-xs font-semibold leading-snug text-parish-text sm:text-sm"
                        : "line-clamp-3 text-sm font-semibold leading-snug text-parish-text"
                    }
                  >
                    {b.title ?? "—"}
                  </p>
                  {b.primaryLang ? (
                    <p className="mt-1 text-[10px] leading-snug text-parish-muted sm:text-[11px]">
                      {t(lang, "scripturePrimaryOnSite")}:{" "}
                      <span className="font-medium text-parish-text">
                        {bookPrimaryNativeName(lang, b.primaryLang)}
                      </span>
                    </p>
                  ) : b.legacyMain ? (
                    <p className="mt-1 text-[10px] leading-snug text-parish-muted sm:text-[11px]">
                      {t(lang, "scripturePrimaryLegacyNote")}
                    </p>
                  ) : null}
                </div>

                <div className="mt-[5px] space-y-2 border-t border-parish-border pt-2">
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
                    <button type="button" onClick={() => setDetailBook(b)} className={footerDetails}>
                      {t(lang, "moreDetails")}
                    </button>
                  </div>
                  {!b.readMenu.some((m) => m.url) && !b.fileMenu.some((m) => m.url) ? (
                    <p className="text-center text-xs font-medium text-parish-muted">
                      {t(lang, "notAvailableLang")}
                    </p>
                  ) : null}
                </div>
              </div>
            </li>
          ))
        )}
      </ul>
      {books.length > 0 ? (
        <PaginationControls
          lang={lang}
          page={currentPage}
          totalPages={totalPages}
          totalItems={total}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      ) : null}
      {detailBook ? (
        <BookDetailModal lang={lang} book={detailBook} onClose={() => setDetailBook(null)} />
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
    </section>
  );
}
