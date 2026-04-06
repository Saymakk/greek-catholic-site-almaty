"use client";

import { useEffect, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import type { ClergyRow } from "@/lib/data";
import { displayClergyName } from "@/lib/clergy-display";
import { adminClergyScreenCopy } from "@/lib/admin-layout-i18n";
import { adminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import { deleteClergyForm, reorderClergyForm } from "../actions/clergy";
import { ClergyEditForm } from "./ClergyEditForm";

function emptyClergy(rows: ClergyRow[]): ClergyRow {
  const maxSo = rows.reduce((m, r) => Math.max(m, r.sort_order), -1);
  return {
    id: "",
    sort_order: maxSo + 1,
    photo_url: null,
    full_name: "",
    full_name_ru: null,
    full_name_uk: null,
    full_name_kk: null,
    full_name_en: null,
    extra_fields: [],
    created_at: "",
    updated_at: "",
  };
}

function listTitle(
  row: ClergyRow,
  uiLang: Lang,
  c: ReturnType<typeof adminClergyScreenCopy>,
): string {
  const t = displayClergyName(row, uiLang);
  return t || c.noName;
}

export function AdminClergyClient({ lang, rows }: { lang: Lang; rows: ClergyRow[] }) {
  const c = adminClergyScreenCopy(lang);
  const imageCopy = adminSharedImageCopy(lang);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [active, setActive] = useState<ClergyRow | null>(null);

  function closeDialog() {
    dialogRef.current?.close();
    setMode(null);
    setActive(null);
  }

  useEffect(() => {
    const d = dialogRef.current;
    if (!d) return;
    function onClose() {
      setMode(null);
      setActive(null);
    }
    d.addEventListener("close", onClose);
    return () => d.removeEventListener("close", onClose);
  }, []);

  function openAdd() {
    setMode("add");
    setActive(emptyClergy(rows));
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(row: ClergyRow) {
    setMode("edit");
    setActive(row);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-display text-2xl text-parish-text">{c.pageTitle}</h1>
          <p className="mt-2 max-w-2xl text-sm text-parish-muted">{c.pageIntro}</p>
        </div>
        <button
          type="button"
          onClick={openAdd}
          className="shrink-0 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          {c.addClergy}
        </button>
      </div>

      <ul className="mt-8 space-y-4">
        {rows.map((row, idx) => (
          <li
            key={row.id}
            className="flex flex-col gap-3 rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm sm:flex-row sm:items-center sm:justify-between"
          >
            <div className="flex min-w-0 items-center gap-3">
              {row.photo_url ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={row.photo_url}
                  alt=""
                  className="max-h-14 max-w-[5.5rem] shrink-0 rounded-md border border-parish-border object-contain object-left"
                />
              ) : (
                <div className="flex h-14 min-w-[3.5rem] shrink-0 items-center justify-center rounded-md border border-dashed border-parish-border bg-parish-bg text-xs text-parish-muted">
                  —
                </div>
              )}
              <div className="min-w-0">
                <p className="font-medium text-parish-text">{listTitle(row, lang, c)}</p>
                <p className="text-xs text-parish-muted">
                  {c.hierarchyTitle}: {row.sort_order}
                </p>
              </div>
            </div>
            <div className="flex shrink-0 flex-wrap items-center gap-2">
              <form action={reorderClergyForm} className="inline">
                <input type="hidden" name="id" value={row.id} />
                <input type="hidden" name="dir" value="up" />
                <button
                  type="submit"
                  disabled={idx === 0}
                  className="rounded-lg border border-parish-border px-2 py-2 text-xs font-medium text-parish-muted hover:bg-parish-accent-soft disabled:cursor-not-allowed disabled:opacity-40"
                >
                  {c.moveUp}
                </button>
              </form>
              <form action={reorderClergyForm} className="inline">
                <input type="hidden" name="id" value={row.id} />
                <input type="hidden" name="dir" value="down" />
                <button
                  type="submit"
                  disabled={idx >= rows.length - 1}
                  className="rounded-lg border border-parish-border px-2 py-2 text-xs font-medium text-parish-muted hover:bg-parish-accent-soft disabled:cursor-not-allowed disabled:opacity-40"
                >
                  {c.moveDown}
                </button>
              </form>
              <button
                type="button"
                onClick={() => openEdit(row)}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
              >
                {c.edit}
              </button>
              <form
                action={deleteClergyForm}
                onSubmit={(e) => {
                  if (!confirm(c.confirmDelete)) e.preventDefault();
                }}
              >
                <input type="hidden" name="id" value={row.id} />
                <button
                  type="submit"
                  className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50"
                >
                  {c.delete}
                </button>
              </form>
            </div>
          </li>
        ))}
      </ul>

      {rows.length === 0 ? <p className="mt-8 text-sm text-parish-muted">{c.emptyList}</p> : null}

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {active && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="font-display text-lg font-semibold text-parish-text">
                {mode === "add" ? c.addClergy : listTitle(active, lang, c)}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft"
                aria-label={c.cancel}
              >
                <span className="text-2xl leading-none">×</span>
              </button>
            </div>
            <ClergyEditForm
              key={mode === "add" ? "new" : active.id}
              clergy={active}
              copy={c}
              imageCopy={imageCopy}
              submitLabel={c.save}
              onCancel={closeDialog}
              uiLang={lang}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
