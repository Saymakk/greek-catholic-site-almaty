"use client";

import { useEffect, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import type { KazakhstanParishRow } from "@/lib/data";
import { adminParishesScreenCopy } from "@/lib/admin-layout-i18n";
import { deleteParishForm } from "../actions/parishes";
import { ParishEditForm } from "./ParishEditForm";

function emptyParish(): KazakhstanParishRow {
  return {
    id: "",
    sort_order: 0,
    is_published: true,
    parish_photo_url: null,
    priest_photo_url: null,
    website_url: null,
    city_ru: null,
    city_uk: null,
    city_kk: null,
    city_en: null,
    name_ru: null,
    name_uk: null,
    name_kk: null,
    name_en: null,
    address_ru: null,
    address_uk: null,
    address_kk: null,
    address_en: null,
    priest_name_ru: null,
    priest_name_uk: null,
    priest_name_kk: null,
    priest_name_en: null,
    priest_contacts_ru: null,
    priest_contacts_uk: null,
    priest_contacts_kk: null,
    priest_contacts_en: null,
    map_embed_src: null,
    created_at: "",
    updated_at: "",
  };
}

function listTitle(row: KazakhstanParishRow, c: ReturnType<typeof adminParishesScreenCopy>): string {
  const t =
    row.name_ru?.trim() ||
    row.name_uk?.trim() ||
    row.name_kk?.trim() ||
    row.name_en?.trim() ||
    row.city_ru?.trim() ||
    "";
  return t || c.noTitle;
}

export function AdminParishesClient({
  lang,
  rows,
}: {
  lang: Lang;
  rows: KazakhstanParishRow[];
}) {
  const c = adminParishesScreenCopy(lang);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [active, setActive] = useState<KazakhstanParishRow | null>(null);

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
    setActive(emptyParish());
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(row: KazakhstanParishRow) {
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
          {c.addParish}
        </button>
      </div>

      <ul className="mt-8 space-y-4">
        {rows.map((row) => (
          <li
            key={row.id}
            className="flex flex-col gap-3 rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm sm:flex-row sm:items-center sm:justify-between"
          >
            <div className="min-w-0">
              <p className="font-medium text-parish-text">{listTitle(row, c)}</p>
              <p className="text-xs text-parish-muted">{row.is_published ? "✓" : "○"}</p>
            </div>
            <div className="flex shrink-0 flex-wrap gap-2">
              <button
                type="button"
                onClick={() => openEdit(row)}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
              >
                {c.edit}
              </button>
              <form
                action={deleteParishForm}
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

      {rows.length === 0 ? (
        <p className="mt-8 text-sm text-parish-muted">{c.emptyList}</p>
      ) : null}

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {active && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="font-display text-lg font-semibold text-parish-text">
                {mode === "add" ? c.addParish : listTitle(active, c)}
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
            <ParishEditForm
              key={mode === "add" ? "new" : active.id}
              parish={active}
              copy={c}
              submitLabel={c.save}
              onCancel={closeDialog}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
