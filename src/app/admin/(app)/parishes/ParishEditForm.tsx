"use client";

import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import type { KazakhstanParishRow } from "@/lib/data";
import type { AdminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import type { AdminParishesScreenCopy } from "@/lib/admin-layout-i18n";
import { mapEmbedRawForParishForm } from "@/lib/map-embed";
import { saveParish } from "../actions/parishes";

const LANGS = ["ru", "uk", "kk", "en"] as const;

const LANG_LABEL: Record<(typeof LANGS)[number], keyof AdminParishesScreenCopy> = {
  ru: "langRu",
  uk: "langUk",
  kk: "langKk",
  en: "langEn",
};

export function ParishEditForm({
  parish,
  copy,
  imageCopy,
  submitLabel,
  onCancel,
}: {
  parish: KazakhstanParishRow;
  copy: AdminParishesScreenCopy;
  imageCopy: AdminSharedImageCopy;
  submitLabel: string;
  onCancel?: () => void;
}) {
  const r = parish;
  const mapDefault = mapEmbedRawForParishForm(r.map_embed_src);

  return (
    <form action={saveParish} className="flex min-h-0 min-w-0 flex-1 flex-col">
      <input type="hidden" name="id" value={r.id} />
      <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-5 px-4 py-4 sm:px-6">
        <label className="block text-sm text-parish-text">
          <span className="font-medium">{copy.websiteUrl}</span>
          <input
            type="url"
            name="website_url"
            defaultValue={r.website_url ?? ""}
            className="mt-1 w-full rounded-lg border border-parish-border px-2 py-1.5 text-sm"
          />
        </label>

        <label className="block text-sm text-parish-text">
          <span className="font-medium">{copy.mapIframeField}</span>
          <textarea
            name="map_embed_raw"
            rows={5}
            defaultValue={mapDefault}
            className="mt-1 w-full rounded-lg border border-parish-border px-2 py-1.5 font-mono text-xs leading-relaxed text-parish-text"
          />
        </label>
        <p className="text-xs text-parish-muted">{copy.mapIframeHint}</p>

        <div className="grid gap-6 sm:grid-cols-2">
          <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
            <p className="text-sm font-medium text-parish-text">{copy.parishPhoto}</p>
            {r.parish_photo_url ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={r.parish_photo_url}
                alt=""
                className="h-28 w-full max-w-[12rem] rounded-lg border border-parish-border object-cover"
              />
            ) : null}
            <label className="flex items-center gap-2 text-xs text-parish-muted">
              <input type="checkbox" name="remove_parish_photo" className="rounded" />
              {copy.removeParishPhoto}
            </label>
            <input type="file" name="parish_photo" accept="image/*" className="block w-full text-xs" />
            <label className="block text-xs text-parish-muted">
              {imageCopy.orImageUrl}
              <input
                type="url"
                name="parish_photo_url"
                defaultValue={r.parish_photo_url ?? ""}
                placeholder={imageCopy.imageUrlPlaceholder}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
            <p className="text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
          </div>
          <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
            <p className="text-sm font-medium text-parish-text">{copy.priestPhoto}</p>
            {r.priest_photo_url ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={r.priest_photo_url}
                alt=""
                className="h-28 w-28 rounded-full border border-parish-border object-cover"
              />
            ) : null}
            <label className="flex items-center gap-2 text-xs text-parish-muted">
              <input type="checkbox" name="remove_priest_photo" className="rounded" />
              {copy.removePriestPhoto}
            </label>
            <input type="file" name="priest_photo" accept="image/*" className="block w-full text-xs" />
            <label className="block text-xs text-parish-muted">
              {imageCopy.orImageUrl}
              <input
                type="url"
                name="priest_photo_url"
                defaultValue={r.priest_photo_url ?? ""}
                placeholder={imageCopy.imageUrlPlaceholder}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
            <p className="text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
          </div>
        </div>

        {LANGS.map((l) => (
          <fieldset key={l} className="rounded-lg border border-parish-border/80 p-3">
            <legend className="px-1 text-xs font-semibold text-parish-accent">{copy[LANG_LABEL[l]]}</legend>
            <div className="mt-2 space-y-2">
              <label className="block text-xs text-parish-muted">
                {copy.city}
                <input
                  type="text"
                  name={`city_${l}`}
                  defaultValue={r[`city_${l}`] ?? ""}
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
              <label className="block text-xs text-parish-muted">
                {copy.name}
                <input
                  type="text"
                  name={`name_${l}`}
                  defaultValue={r[`name_${l}`] ?? ""}
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
              <label className="block text-xs text-parish-muted">
                {copy.address}
                <textarea
                  name={`address_${l}`}
                  rows={2}
                  defaultValue={r[`address_${l}`] ?? ""}
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
              <label className="block text-xs text-parish-muted">
                {copy.priestName}
                <input
                  type="text"
                  name={`priest_name_${l}`}
                  defaultValue={r[`priest_name_${l}`] ?? ""}
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
              <label className="block text-xs text-parish-muted">
                {copy.priestContacts}
                <textarea
                  name={`priest_contacts_${l}`}
                  rows={3}
                  defaultValue={r[`priest_contacts_${l}`] ?? ""}
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
            </div>
          </fieldset>
        ))}
      </div>
      <div className="flex shrink-0 flex-wrap gap-2 border-t border-parish-border bg-parish-surface px-4 py-3 sm:px-6">
        {onCancel ? (
          <button
            type="button"
            onClick={onCancel}
            className="rounded-lg border border-parish-border px-4 py-2 text-sm font-medium text-parish-muted hover:bg-parish-accent-soft"
          >
            {copy.cancel}
          </button>
        ) : null}
        <button
          type="submit"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          {submitLabel}
        </button>
      </div>
      <AdminModalSavingOverlay />
    </form>
  );
}
