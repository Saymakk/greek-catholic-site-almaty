"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import type { Lang } from "@/lib/i18n";
import type { KazakhstanParishRow } from "@/lib/data";
import type { AdminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import type { AdminParishesScreenCopy } from "@/lib/admin-layout-i18n";
import { mapEmbedRawForParishForm } from "@/lib/map-embed";
import { removeParishImage, saveParish } from "../actions/parishes";

const LANGS = ["ru", "uk", "kk", "en"] as const;

const BTN_REMOVE_IMAGE =
  "mt-2 rounded-lg border border-red-200 bg-red-50/80 px-3 py-1.5 text-xs font-medium text-red-700 hover:bg-red-100 disabled:opacity-50";

const LANG_LABEL: Record<(typeof LANGS)[number], keyof AdminParishesScreenCopy> = {
  ru: "langRu",
  uk: "langUk",
  kk: "langKk",
  en: "langEn",
};

function langHasContent(row: KazakhstanParishRow, l: (typeof LANGS)[number]): boolean {
  const keys = [`city_${l}`, `name_${l}`, `address_${l}`, `priest_name_${l}`, `priest_contacts_${l}`] as const;
  for (const k of keys) {
    const v = row[k as keyof KazakhstanParishRow];
    if (typeof v === "string" && v.trim()) return true;
  }
  return false;
}

export function ParishEditForm({
  parish,
  copy,
  imageCopy,
  submitLabel,
  onCancel,
  uiLang,
  isNew,
}: {
  parish: KazakhstanParishRow;
  copy: AdminParishesScreenCopy;
  imageCopy: AdminSharedImageCopy;
  submitLabel: string;
  onCancel?: () => void;
  uiLang: Lang;
  isNew: boolean;
}) {
  const r = parish;
  const mapDefault = mapEmbedRawForParishForm(r.map_embed_src);

  const [expandedLangs, setExpandedLangs] = useState(() => {
    const s = new Set<(typeof LANGS)[number]>([uiLang]);
    if (!isNew) {
      for (const l of LANGS) {
        if (l !== uiLang && langHasContent(r, l)) s.add(l);
      }
    }
    return s;
  });

  const availableToAdd = LANGS.filter((l) => !expandedLangs.has(l));
  const extraExpanded = LANGS.filter((l) => l !== uiLang && expandedLangs.has(l));

  const router = useRouter();
  const [parishRemoved, setParishRemoved] = useState(false);
  const [priestRemoved, setPriestRemoved] = useState(false);
  const [parishPending, startParishRemove] = useTransition();
  const [priestPending, startPriestRemove] = useTransition();

  const parishUrl =
    !parishRemoved && r.parish_photo_url?.trim() ? r.parish_photo_url.trim() : null;
  const priestUrl =
    !priestRemoved && r.priest_photo_url?.trim() ? r.priest_photo_url.trim() : null;
  const parishRowId = r.id?.trim() ?? "";

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
            {parishUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={parishUrl}
                alt=""
                className="h-28 w-full max-w-[12rem] rounded-lg border border-parish-border object-cover"
              />
            ) : (
              <p className="mt-2 text-xs text-parish-muted">—</p>
            )}
            <input type="file" name="parish_photo" accept="image/*" className="block w-full text-xs" />
            <label className="block text-xs text-parish-muted">
              {imageCopy.orImageUrl}
              <input
                key={`parish-photo-url-${parishUrl ?? "empty"}`}
                type="url"
                name="parish_photo_url"
                defaultValue={parishUrl ?? ""}
                placeholder={imageCopy.imageUrlPlaceholder}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
            <p className="text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
            {parishRowId && parishUrl ? (
              <button
                type="button"
                className={BTN_REMOVE_IMAGE}
                disabled={parishPending}
                onClick={() => {
                  startParishRemove(async () => {
                    await removeParishImage(parishRowId, "parish");
                    setParishRemoved(true);
                    router.refresh();
                  });
                }}
              >
                {copy.removeParishPhoto}
              </button>
            ) : null}
          </div>
          <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
            <p className="text-sm font-medium text-parish-text">{copy.priestPhoto}</p>
            {priestUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={priestUrl}
                alt=""
                className="h-28 w-28 rounded-full border border-parish-border object-cover"
              />
            ) : (
              <p className="mt-2 text-xs text-parish-muted">—</p>
            )}
            <input type="file" name="priest_photo" accept="image/*" className="block w-full text-xs" />
            <label className="block text-xs text-parish-muted">
              {imageCopy.orImageUrl}
              <input
                key={`priest-photo-url-${priestUrl ?? "empty"}`}
                type="url"
                name="priest_photo_url"
                defaultValue={priestUrl ?? ""}
                placeholder={imageCopy.imageUrlPlaceholder}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
            <p className="text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
            {parishRowId && priestUrl ? (
              <button
                type="button"
                className={BTN_REMOVE_IMAGE}
                disabled={priestPending}
                onClick={() => {
                  startPriestRemove(async () => {
                    await removeParishImage(parishRowId, "priest");
                    setPriestRemoved(true);
                    router.refresh();
                  });
                }}
              >
                {copy.removePriestPhoto}
              </button>
            ) : null}
          </div>
        </div>

        <ParishLangFieldset copy={copy} r={r} lang={uiLang} />

        {availableToAdd.length > 0 ? (
          <div className="space-y-2">
            <p className="text-xs text-parish-muted">{copy.parishAddLocaleHint}</p>
            <div className="flex flex-wrap gap-2">
              {availableToAdd.map((l) => (
                <button
                  key={l}
                  type="button"
                  className="rounded-lg border border-parish-border px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
                  onClick={() => setExpandedLangs((prev) => new Set([...prev, l]))}
                >
                  {copy[LANG_LABEL[l]]}
                </button>
              ))}
            </div>
          </div>
        ) : null}

        {extraExpanded.map((l) => (
          <ParishLangFieldset key={l} copy={copy} r={r} lang={l} />
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

function ParishLangFieldset({
  copy,
  r,
  lang: l,
}: {
  copy: AdminParishesScreenCopy;
  r: KazakhstanParishRow;
  lang: (typeof LANGS)[number];
}) {
  return (
    <fieldset className="rounded-lg border border-parish-border/80 p-3">
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
  );
}
