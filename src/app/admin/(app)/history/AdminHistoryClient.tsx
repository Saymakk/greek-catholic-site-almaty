"use client";

import { useEffect, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { adminHistoryScreenCopy } from "@/lib/admin-layout-i18n";
import { HistoryEditForm } from "./HistoryEditForm";
import type { HistoryLocaleFields } from "./history-entity-locales";

function textSnippet(raw: string, max = 160): string {
  const t = raw.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
  if (!t) return "";
  return t.length > max ? `${t.slice(0, max)}…` : t;
}

function snippetForList(locales: HistoryLocaleFields[], uiLang: Lang, emptyLabel: string): string {
  const by = Object.fromEntries(locales.map((l) => [l.lang, l.body]));
  const order: string[] = [uiLang, "ru", "uk", "kk", "en"];
  for (const code of order) {
    const b = by[code]?.trim();
    if (b) {
      const s = textSnippet(b);
      return s || emptyLabel;
    }
  }
  return emptyLabel;
}

export function AdminHistoryClient({
  uiLang,
  locales,
  autoOpen,
}: {
  uiLang: Lang;
  locales: HistoryLocaleFields[];
  autoOpen: boolean;
}) {
  const copy = adminHistoryScreenCopy(uiLang);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [open, setOpen] = useState(() => autoOpen);

  function closeDialog() {
    dialogRef.current?.close();
  }

  useEffect(() => {
    const d = dialogRef.current;
    if (!d) return;
    function onClose() {
      setOpen(false);
    }
    d.addEventListener("close", onClose);
    return () => d.removeEventListener("close", onClose);
  }, []);

  useEffect(() => {
    if (!open) return;
    const id = requestAnimationFrame(() => dialogRef.current?.showModal());
    return () => cancelAnimationFrame(id);
  }, [open]);

  function openEdit() {
    setOpen(true);
  }

  const preview = snippetForList(locales, uiLang, copy.emptySnippet);

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-display text-2xl text-parish-text">{copy.pageTitle}</h1>
          <p className="mt-2 max-w-3xl text-sm text-parish-muted">{copy.listHint}</p>
        </div>
      </div>

      <ul className="mt-8 space-y-4">
        <li className="rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-stretch sm:justify-between">
            <div className="flex min-w-0 flex-1 gap-3">
              <div className="flex h-20 w-14 shrink-0 items-center justify-center rounded-md border border-parish-border bg-parish-surface text-xs text-parish-muted">
                —
              </div>
              <div className="min-w-0 flex-1">
                <span className="text-xs font-medium uppercase tracking-wide text-parish-muted">
                  {copy.versionsCount}
                </span>
                <p className="font-medium text-parish-text">{copy.cardTitle}</p>
                <p className="mt-1 line-clamp-3 text-sm text-parish-muted">{preview}</p>
              </div>
            </div>
            <div className="flex shrink-0 flex-col gap-2 sm:w-40 sm:items-stretch">
              <button
                type="button"
                onClick={openEdit}
                className="rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
              >
                {copy.edit}
              </button>
            </div>
          </div>
        </li>
      </ul>

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {open ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="min-w-0 flex-1 font-display text-lg font-semibold text-parish-text sm:text-xl">
                {copy.modalTitle}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label={copy.closeAria}
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <HistoryEditForm
              key={locales.map((l) => `${l.lang}:${l.body.length}`).join("|")}
              locales={locales}
              uiLang={uiLang}
              submitLabel={copy.save}
              onCancel={closeDialog}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
