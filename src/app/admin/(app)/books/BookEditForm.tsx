"use client";

import { useMemo, useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import { removeBookCover, saveBook } from "../actions/books";
import { editionLegendKey, type AdminBooksMsg } from "@/lib/admin-books-i18n";
import {
  sortLangsForForm,
  isContentLang,
  CONTENT_ORDER,
  type ContentLang,
} from "./book-locales";

export type BookLocaleFields = {
  lang: string;
  title: string;
  description: string;
  read_url: string;
  file_url: string;
  cover_image_url: string | null;
};

function editionTitle(code: string, msg: AdminBooksMsg) {
  const k = editionLegendKey(code);
  return k ? msg[k] : code;
}

export function BookEditForm({
  bookId,
  primaryLang: primaryLangDb,
  locales,
  submitLabel,
  msg,
  onCancel,
  fluidScale = false,
  modalLayout = false,
}: {
  bookId: string;
  /** null — старая запись с lang main; после сохранения станет выбранный язык */
  primaryLang: string | null;
  locales: BookLocaleFields[];
  submitLabel: string;
  msg: AdminBooksMsg;
  onCancel?: () => void;
  /** Типографика от размера модалки (em + cqmin на предках) */
  fluidScale?: boolean;
  /** Поля в прокрутке, кнопки закреплены внизу модалки */
  modalLayout?: boolean;
}) {
  const isLegacy = useMemo(
    () => primaryLangDb === null && locales.some((l) => l.lang === "main"),
    [primaryLangDb, locales],
  );

  const [primaryLang, setPrimaryLang] = useState<ContentLang>(() => {
    if (primaryLangDb && isContentLang(primaryLangDb)) return primaryLangDb;
    return "ru";
  });

  const [activeLangs, setActiveLangs] = useState<string[]>(() =>
    sortLangsForForm(
      locales.map((l) => l.lang),
      primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : "ru",
      primaryLangDb === null && locales.some((l) => l.lang === "main"),
    ),
  );
  const [coverRemoved, setCoverRemoved] = useState<Record<string, boolean>>({});
  const [coverPending, startCoverTransition] = useTransition();
  const router = useRouter();

  const byLang = useMemo(() => {
    const m = new Map<string, BookLocaleFields>();
    for (const l of locales) m.set(l.lang, l);
    return m;
  }, [locales]);

  const canAdd = CONTENT_ORDER.filter((code) => !activeLangs.includes(code));

  const f = fluidScale;
  const label = f ? "text-[0.88em] leading-snug" : "text-xs";
  const legend = f ? "text-[0.92em]" : "text-xs";
  const field =
    f
      ? "mt-2 w-full rounded border border-parish-border px-[0.45em] py-[0.35em] text-[1em]"
      : "mt-2 w-full rounded border border-parish-border px-2 py-1 text-sm";
  const fileInput = f ? "mt-1 block w-full text-[0.88em] text-parish-text" : "mt-1 block w-full text-xs text-parish-text";
  const btnGhost =
    f
      ? "rounded-lg border border-parish-border px-[0.85em] py-[0.45em] text-[1em] text-parish-text hover:bg-parish-accent-soft"
      : "rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft";
  const btnPrimary =
    f
      ? "rounded-lg bg-parish-accent px-[1em] py-[0.45em] text-[1em] text-white hover:opacity-90"
      : "rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90";
  const btnRemoveCover =
    f
      ? "mt-2 rounded-lg border border-red-200 bg-red-50/80 px-[0.75em] py-[0.4em] text-[0.88em] font-medium text-red-700 hover:bg-red-100 disabled:opacity-50"
      : "mt-2 rounded-lg border border-red-200 bg-red-50/80 px-3 py-1.5 text-xs font-medium text-red-700 hover:bg-red-100 disabled:opacity-50";
  const addLangBtn =
    f
      ? "rounded-lg border border-parish-border px-[0.65em] py-[0.4em] text-[0.88em] text-parish-accent hover:bg-parish-accent-soft"
      : "rounded-lg border border-parish-border px-3 py-1.5 text-xs text-parish-accent hover:bg-parish-accent-soft";
  const coverImg = f
    ? "mt-2 h-[clamp(3.25rem,11cqmin,6.5rem)] w-auto max-w-[min(8rem,28cqmin)] rounded border border-parish-border object-cover"
    : "mt-2 h-24 w-auto max-w-[8rem] rounded border border-parish-border object-cover";
  const fsGap = f ? "space-y-[1em]" : "space-y-4";
  const fsPad = f ? "p-[0.75em]" : "p-3";
  const modalPad = f ? "px-[1em] py-[1em] sm:px-[1.25em]" : "px-4 py-4 sm:px-6";
  const footerPad = f ? "px-[1em] py-[0.75em] sm:px-[1.25em]" : "px-4 py-3 sm:px-6";

  function addLang(code: string) {
    setActiveLangs((prev) =>
      sortLangsForForm([...prev, code], primaryLang, isLegacy),
    );
  }

  function removeLang(code: string) {
    if (isLegacy && code === "main") return;
    if (!isLegacy && code === primaryLang) return;
    setActiveLangs((prev) => prev.filter((x) => x !== code));
  }

  const orderedLangCodes = sortLangsForForm(activeLangs, primaryLang, isLegacy);

  const formClass = modalLayout
    ? "flex min-h-0 min-w-0 flex-1 flex-col"
    : fsGap;

  const mainFields = (
    <>
      <label className={`block text-parish-muted ${label}`}>
        {msg.primaryLanguageLabel}
        <select
          className={
            f
              ? "mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-[0.45em] py-[0.35em] text-[1em] text-parish-text"
              : "mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-2 py-1 text-sm text-parish-text"
          }
          value={primaryLang}
          onChange={(e) => {
            const next = e.target.value;
            if (!isContentLang(next)) return;
            setPrimaryLang(next);
            if (!isLegacy) {
              setActiveLangs((prev) => sortLangsForForm(prev, next, false));
            }
          }}
        >
          {CONTENT_ORDER.map((code) => (
            <option key={code} value={code}>
              {editionTitle(code, msg)}
            </option>
          ))}
        </select>
      </label>
      <input type="hidden" name="primary_lang" value={primaryLang} />

      {orderedLangCodes.map((code) => {
        const row = byLang.get(code) ?? {
          lang: code,
          title: "",
          description: "",
          read_url: "",
          file_url: "",
          cover_image_url: null,
        };
        const storedCoverUrl =
          coverRemoved[code] ? null : row.cover_image_url;
        return (
          <fieldset
            key={code}
            className={`rounded-lg border border-parish-border/70 ${fsPad}`}
          >
            <div className="flex flex-wrap items-center justify-between gap-2">
              <legend className={`font-medium text-parish-accent ${legend}`}>
                {editionTitle(code, msg)}
                {(isLegacy && code === "main") || (!isLegacy && code === primaryLang) ? (
                  <span className="ml-1 font-normal text-parish-muted">
                    — {msg.primaryEditionMark}
                  </span>
                ) : null}
              </legend>
              {(isLegacy ? code !== "main" : code !== primaryLang) ? (
                <button
                  type="button"
                  className={`rounded border border-parish-border px-2 py-1 font-medium text-red-600 hover:bg-red-50 ${f ? "text-[0.85em]" : "text-xs"}`}
                  onClick={() => removeLang(code)}
                >
                  {msg.removeEdition}
                </button>
              ) : null}
            </div>
            <input
              name={`title_${code}`}
              placeholder={msg.titlePh}
              defaultValue={row.title}
              className={field}
            />
            <textarea
              name={`description_${code}`}
              placeholder={msg.descriptionPh}
              rows={f ? 4 : 3}
              defaultValue={row.description}
              className={field}
            />
            <input
              name={`read_url_${code}`}
              placeholder={msg.readUrlPh}
              defaultValue={row.read_url}
              className={field}
            />
            <input
              name={`file_url_${code}`}
              placeholder={msg.fileUrlPh}
              defaultValue={row.file_url}
              className={field}
            />
            <label className={`mt-2 block text-parish-muted ${label}`}>
              {msg.uploadFile}
              <input type="file" name={`upload_${code}`} className={fileInput} />
            </label>
            <input
              type="hidden"
              name={`cover_stored_${code}`}
              value={storedCoverUrl ?? ""}
            />
            <div className="mt-3 border-t border-parish-border/50 pt-3">
              <p className={`text-parish-muted ${label}`}>{msg.coverSection}</p>
              {storedCoverUrl ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={storedCoverUrl} alt="" className={coverImg} />
              ) : (
                <p className={`mt-1 text-parish-muted ${label}`}>{msg.noCover}</p>
              )}
              <label className={`mt-2 block text-parish-muted ${label}`}>
                {msg.uploadCover}
                <input
                  type="file"
                  name={`cover_${code}`}
                  accept="image/jpeg,image/png,image/webp,image/gif"
                  className={fileInput}
                />
              </label>
              {storedCoverUrl && bookId ? (
                <button
                  type="button"
                  className={btnRemoveCover}
                  disabled={coverPending}
                  onClick={() => {
                    startCoverTransition(async () => {
                      await removeBookCover(bookId, code);
                      setCoverRemoved((r) => ({ ...r, [code]: true }));
                      router.refresh();
                    });
                  }}
                >
                  {msg.removeCover}
                </button>
              ) : null}
            </div>
          </fieldset>
        );
      })}

      {canAdd.length > 0 ? (
        <div className="flex flex-wrap gap-2">
          <span className={`w-full text-parish-muted ${label}`}>{msg.addEditionHint}</span>
          {canAdd.map((code) => (
            <button
              key={code}
              type="button"
              className={addLangBtn}
              onClick={() => addLang(code)}
            >
              {editionTitle(code, msg)}
            </button>
          ))}
        </div>
      ) : null}
    </>
  );

  return (
    <form action={saveBook} className={formClass}>
      <input type="hidden" name="id" value={bookId} />
      <input type="hidden" name="locales" value={activeLangs.join(",")} />
      {modalLayout ? (
        <div
          className={`admin-book-dialog__scroll min-h-0 flex-1 ${modalPad} ${fsGap}`}
        >
          {mainFields}
        </div>
      ) : (
        mainFields
      )}
      {modalLayout ? (
        <div
          className={`flex shrink-0 flex-wrap gap-3 border-t border-parish-border bg-parish-surface/95 ${footerPad} ${f ? "gap-[0.75em]" : ""}`}
        >
          {onCancel ? (
            <button type="button" className={btnGhost} onClick={onCancel}>
              {msg.cancel}
            </button>
          ) : null}
          <button type="submit" className={btnPrimary}>
            {submitLabel}
          </button>
        </div>
      ) : (
        <div className={`flex flex-wrap gap-3 pt-2 ${f ? "gap-[0.75em]" : ""}`}>
          {onCancel ? (
            <button type="button" className={btnGhost} onClick={onCancel}>
              {msg.cancel}
            </button>
          ) : null}
          <button type="submit" className={btnPrimary}>
            {submitLabel}
          </button>
        </div>
      )}
      <AdminModalSavingOverlay />
    </form>
  );
}
