"use client";

import { useEffect, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import type { KazakhstanParishRow } from "@/lib/data";
import { pickLocalized } from "@/lib/locale-fallback";
import { adminParishesScreenCopy } from "@/lib/admin-layout-i18n";
import { adminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import { deleteParishForm, reorderParishForm } from "../actions/parishes";
import { ParishEditForm } from "./ParishEditForm";

function emptyParish(rows: KazakhstanParishRow[]): KazakhstanParishRow {
  const maxSo = rows.reduce((m, r) => Math.max(m, r.sort_order), -1);
  return {
    id: "",
    sort_order: maxSo + 1,
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

/** Миниатюра в списке: сначала фото прихода, иначе настоятеля. */
function listThumb(row: KazakhstanParishRow): { url: string; variant: "parish" | "priest" } | null {
  const parish = row.parish_photo_url?.trim();
  if (parish) return { url: parish, variant: "parish" };
  const priest = row.priest_photo_url?.trim();
  if (priest) return { url: priest, variant: "priest" };
  return null;
}

function listCityPriestLine(
  row: KazakhstanParishRow,
  lang: Lang,
  c: ReturnType<typeof adminParishesScreenCopy>,
): string | null {
  const r = row as unknown as Record<string, string | null | undefined>;
  const city = pickLocalized(r, "city", lang);
  const priest = pickLocalized(r, "priest_name", lang);
  const parts: string[] = [];
  if (city) parts.push(`${c.city}: ${city}`);
  if (priest) parts.push(`${c.priestName}: ${priest}`);
  return parts.length ? parts.join(" · ") : null;
}

export function AdminParishesClient({
  lang,
  rows,
}: {
  lang: Lang;
  rows: KazakhstanParishRow[];
}) {
  const c = adminParishesScreenCopy(lang);
  const imageCopy = adminSharedImageCopy(lang);
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
    setActive(emptyParish(rows));
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(row: KazakhstanParishRow) {
    setMode("edit");
    setActive(row);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  const dialogHeaderThumb = mode === "edit" && active ? listThumb(active) : null;

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
        {rows.map((row, idx) => {
          const thumb = listThumb(row);
          const cityPriest = listCityPriestLine(row, lang, c);
          return (
          <li
            key={row.id}
            className="flex flex-col gap-3 rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm sm:flex-row sm:items-center sm:justify-between"
          >
            <div className="flex min-w-0 items-center gap-3">
              {thumb ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={thumb.url}
                  alt=""
                  className={
                    thumb.variant === "priest"
                      ? "h-12 w-12 shrink-0 rounded-full border border-parish-border object-cover"
                      : "h-12 w-12 shrink-0 rounded-lg border border-parish-border object-cover"
                  }
                />
              ) : (
                <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg border border-dashed border-parish-border bg-parish-bg text-xs text-parish-muted">
                  —
                </div>
              )}
              <div className="min-w-0">
                <p className="font-medium text-parish-text">{listTitle(row, c)}</p>
                {cityPriest ? (
                  <p className="mt-0.5 text-xs text-parish-muted">{cityPriest}</p>
                ) : null}
                <p
                  className={
                    cityPriest ? "mt-0.5 text-xs text-parish-muted" : "text-xs text-parish-muted"
                  }
                >
                  {c.hierarchyTitle}: {row.sort_order}
                </p>
              </div>
            </div>
            <div className="flex shrink-0 flex-wrap items-center gap-2">
              <form action={reorderParishForm} className="inline">
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
              <form action={reorderParishForm} className="inline">
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
          );
        })}
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
              <div className="flex min-w-0 items-center gap-2 sm:gap-3">
                {dialogHeaderThumb ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={dialogHeaderThumb.url}
                    alt=""
                    className={
                      dialogHeaderThumb.variant === "priest"
                        ? "h-9 w-9 shrink-0 rounded-full border border-parish-border object-cover"
                        : "h-9 w-9 shrink-0 rounded-lg border border-parish-border object-cover"
                    }
                  />
                ) : null}
                <h2 className="min-w-0 font-display text-lg font-semibold text-parish-text">
                  {mode === "add" ? c.addParish : listTitle(active, c)}
                </h2>
              </div>
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
              imageCopy={imageCopy}
              submitLabel={c.save}
              onCancel={closeDialog}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
