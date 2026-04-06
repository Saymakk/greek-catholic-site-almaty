"use client";

import { useMemo, useRef, useState, useTransition } from "react";
import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import { saveHistory, uploadHistoryImage } from "../actions/content";
import { parseHttpImageUrl } from "@/lib/admin-image-url";
import { adminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";
import { sortHistoryLangsForForm, type HistoryLocaleFields } from "./history-entity-locales";
import type { Lang } from "@/lib/i18n";
import { adminHistoryScreenCopy } from "@/lib/admin-layout-i18n";

function editionTitle(code: string) {
  return code.toUpperCase();
}

function ImageInsertForLang({
  langCode,
  getTextarea,
  copy,
  imageCopy,
}: {
  langCode: string;
  getTextarea: () => HTMLTextAreaElement | null | undefined;
  copy: ReturnType<typeof adminHistoryScreenCopy>;
  imageCopy: ReturnType<typeof adminSharedImageCopy>;
}) {
  const inputRef = useRef<HTMLInputElement>(null);
  const [err, setErr] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();
  const [urlDraft, setUrlDraft] = useState("");

  function insertImgTag(url: string) {
    const ta = getTextarea();
    if (!ta) return;
    const insert = `\n<p><img src="${url}" alt="" class="max-w-full rounded-lg" loading="lazy" /></p>\n`;
    const start = ta.selectionStart ?? ta.value.length;
    const end = ta.selectionEnd ?? ta.value.length;
    const v = ta.value;
    ta.value = v.slice(0, start) + insert + v.slice(end);
    const pos = start + insert.length;
    ta.selectionStart = ta.selectionEnd = pos;
    ta.focus();
  }

  function pick() {
    setErr(null);
    inputRef.current?.click();
  }

  function onFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const f = e.target.files?.[0];
    e.target.value = "";
    if (!f) return;
    setErr(null);
    startTransition(async () => {
      try {
        const fd = new FormData();
        fd.append("file", f);
        fd.append("lang", langCode);
        const url = await uploadHistoryImage(fd);
        insertImgTag(url);
      } catch (e: unknown) {
        setErr(e instanceof Error ? e.message : "Ошибка загрузки");
      }
    });
  }

  function insertFromUrlField() {
    setErr(null);
    try {
      const u = parseHttpImageUrl(urlDraft, imageCopy.orImageUrl);
      if (!u) {
        setErr("Укажите ссылку");
        return;
      }
      insertImgTag(u);
      setUrlDraft("");
    } catch (e: unknown) {
      setErr(e instanceof Error ? e.message : "Ошибка");
    }
  }

  return (
    <div className="mt-2 rounded-md border border-dashed border-parish-border/80 bg-parish-bg/40 p-3">
      <p className="text-xs font-medium text-parish-muted">{copy.imageSection}</p>
      <p className="mt-1 text-[11px] leading-snug text-parish-muted">{copy.imageHint}</p>
      <div className="mt-2 flex flex-wrap items-center gap-2">
        <input
          ref={inputRef}
          type="file"
          accept="image/*"
          className="hidden"
          onChange={onFileChange}
        />
        <button
          type="button"
          disabled={pending}
          onClick={pick}
          className="rounded-lg border border-parish-border bg-parish-surface px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft disabled:opacity-50"
        >
          {pending ? copy.uploading : copy.insertImage}
        </button>
        {err ? <span className="text-xs text-red-600">{err}</span> : null}
      </div>
      <div className="mt-3 flex flex-col gap-2 sm:flex-row sm:flex-wrap sm:items-end">
        <label className="min-w-0 flex-1 text-xs text-parish-muted">
          {imageCopy.orImageUrl}
          <input
            type="url"
            value={urlDraft}
            onChange={(e) => setUrlDraft(e.target.value)}
            placeholder={imageCopy.imageUrlPlaceholder}
            className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
          />
        </label>
        <button
          type="button"
          onClick={insertFromUrlField}
          className="shrink-0 rounded-lg border border-parish-border bg-parish-surface px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
        >
          {imageCopy.insertFromUrl}
        </button>
      </div>
    </div>
  );
}

export function HistoryEditForm({
  locales,
  uiLang,
  submitLabel,
  onCancel,
}: {
  locales: HistoryLocaleFields[];
  uiLang: Lang;
  submitLabel: string;
  onCancel?: () => void;
}) {
  const copy = adminHistoryScreenCopy(uiLang);
  const imageCopy = adminSharedImageCopy(uiLang);
  const [primaryLang, setPrimaryLang] = useState<ContentLang>(() =>
    isContentLang(uiLang) ? uiLang : "ru",
  );
  const textareaRefs = useRef<Record<string, HTMLTextAreaElement | null>>({});

  const byLang = useMemo(() => {
    const m = new Map<string, HistoryLocaleFields>();
    for (const l of locales) m.set(l.lang, l);
    return m;
  }, [locales]);

  const orderedLangCodes = sortHistoryLangsForForm(
    locales.map((l) => l.lang),
    primaryLang,
  );

  return (
    <form action={saveHistory} className="flex min-h-0 min-w-0 flex-1 flex-col">
      <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-4 px-4 py-4 sm:px-6">
        <label className="block text-xs text-parish-muted sm:text-sm">
          {copy.primaryLangLabel}
          <select
            className="mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-2 py-1.5 text-sm text-parish-text"
            value={primaryLang}
            onChange={(e) => {
              const next = e.target.value;
              if (!isContentLang(next)) return;
              setPrimaryLang(next);
            }}
          >
            {CONTENT_ORDER.map((code) => (
              <option key={code} value={code}>
                {editionTitle(code)}
              </option>
            ))}
          </select>
        </label>

        {orderedLangCodes.map((code) => {
          const row = byLang.get(code) ?? { lang: code, body: "" };
          return (
            <fieldset
              key={code}
              className="rounded-lg border border-parish-border/70 p-3"
            >
              <legend className="text-sm font-medium text-parish-accent">
                {editionTitle(code)}
              </legend>
              <label className="mt-2 block text-xs text-parish-muted sm:text-sm">
                {copy.bodyLabel}
                <textarea
                  ref={(el) => {
                    textareaRefs.current[code] = el;
                  }}
                  name={`history_${code}`}
                  rows={10}
                  defaultValue={row.body}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                />
              </label>
              <ImageInsertForLang
                langCode={code}
                getTextarea={() => textareaRefs.current[code]}
                copy={copy}
                imageCopy={imageCopy}
              />
            </fieldset>
          );
        })}
      </div>
      <div className="flex shrink-0 flex-wrap gap-3 border-t border-parish-border bg-parish-surface/95 px-4 py-3 sm:px-6">
        {onCancel ? (
          <button
            type="button"
            onClick={onCancel}
            className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
          >
            {copy.cancel}
          </button>
        ) : null}
        <button
          type="submit"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
        >
          {submitLabel}
        </button>
      </div>
      <AdminModalSavingOverlay />
    </form>
  );
}
