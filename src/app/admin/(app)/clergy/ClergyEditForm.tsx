"use client";

import { useState } from "react";
import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import type { ClergyExtraField, ClergyRow } from "@/lib/data";
import type { AdminClergyScreenCopy } from "@/lib/admin-layout-i18n";
import type { AdminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import { saveClergy } from "../actions/clergy";

const LANG_CODES = ["ru", "uk", "kk", "en"] as const;
type LangCode = (typeof LANG_CODES)[number];

type LocalExtra = {
  key: string;
  url: string;
  langVisible: Set<LangCode>;
  labels: Record<LangCode, string>;
  values: Record<LangCode, string>;
};

function emptyLangRecord(): Record<LangCode, string> {
  return { ru: "", uk: "", kk: "", en: "" };
}

function seedExtras(ef: ClergyExtraField[]): LocalExtra[] {
  return ef.map((f) => {
    const langVisible = new Set<LangCode>(["ru"]);
    for (const l of ["uk", "kk", "en"] as const) {
      if ((f.labels[l]?.trim() || f.values[l]?.trim())) {
        langVisible.add(l);
      }
    }
    const labels = emptyLangRecord();
    const values = emptyLangRecord();
    for (const l of LANG_CODES) {
      labels[l] = f.labels[l] ?? "";
      values[l] = f.values[l] ?? "";
    }
    return {
      key: globalThis.crypto.randomUUID(),
      url: f.url ?? "",
      langVisible,
      labels,
      values,
    };
  });
}

function emptyExtra(): LocalExtra {
  return {
    key: globalThis.crypto.randomUUID(),
    url: "",
    langVisible: new Set<LangCode>(["ru"]),
    labels: emptyLangRecord(),
    values: emptyLangRecord(),
  };
}

function initialNameVisible(c: ClergyRow): Set<LangCode> {
  const s = new Set<LangCode>(["ru"]);
  if (c.full_name_uk?.trim()) s.add("uk");
  if (c.full_name_kk?.trim()) s.add("kk");
  if (c.full_name_en?.trim()) s.add("en");
  return s;
}

function initialNames(c: ClergyRow): Record<LangCode, string> {
  return {
    ru: c.full_name_ru ?? c.full_name ?? "",
    uk: c.full_name_uk ?? "",
    kk: c.full_name_kk ?? "",
    en: c.full_name_en ?? "",
  };
}

const ADD_NAME: Record<LangCode, keyof AdminClergyScreenCopy | null> = {
  ru: null,
  uk: "addNameUk",
  kk: "addNameKk",
  en: "addNameEn",
};

const ADD_FIELD: Record<LangCode, keyof AdminClergyScreenCopy | null> = {
  ru: null,
  uk: "addFieldLangUk",
  kk: "addFieldLangKk",
  en: "addFieldLangEn",
};

const LANG_LEGEND: Record<LangCode, keyof AdminClergyScreenCopy> = {
  ru: "langRu",
  uk: "langUk",
  kk: "langKk",
  en: "langEn",
};

export function ClergyEditForm({
  clergy,
  copy,
  imageCopy,
  submitLabel,
  onCancel,
}: {
  clergy: ClergyRow;
  copy: AdminClergyScreenCopy;
  imageCopy: AdminSharedImageCopy;
  submitLabel: string;
  onCancel?: () => void;
}) {
  const [names, setNames] = useState<Record<LangCode, string>>(() => initialNames(clergy));
  const [nameLangVisible, setNameLangVisible] = useState<Set<LangCode>>(() => initialNameVisible(clergy));
  const [extras, setExtras] = useState<LocalExtra[]>(() =>
    clergy.extra_fields.length ? seedExtras(clergy.extra_fields) : [],
  );

  const extraJson = JSON.stringify(
    extras.map(({ labels, values, url }) => ({
      labels,
      values,
      url: url.trim() ? url.trim() : null,
    })),
  );

  const isNew = !clergy.id;

  function setExtraLangVisible(rowKey: string, lang: LangCode, on: boolean) {
    setExtras((prev) =>
      prev.map((row) => {
        if (row.key !== rowKey) return row;
        const next = new Set(row.langVisible);
        if (on) next.add(lang);
        else next.delete(lang);
        return { ...row, langVisible: next };
      }),
    );
  }

  function patchExtra(rowKey: string, patch: Partial<LocalExtra> | ((row: LocalExtra) => LocalExtra)) {
    setExtras((prev) =>
      prev.map((row) => {
        if (row.key !== rowKey) return row;
        return typeof patch === "function" ? patch(row) : { ...row, ...patch };
      }),
    );
  }

  return (
    <form action={saveClergy} className="flex min-h-0 min-w-0 flex-1 flex-col">
      <input type="hidden" name="id" value={clergy.id} />
      <input type="hidden" name="extra_fields" value={extraJson} />
      <input type="hidden" name="full_name_ru" value={names.ru} />
      <input type="hidden" name="full_name_uk" value={names.uk} />
      <input type="hidden" name="full_name_kk" value={names.kk} />
      <input type="hidden" name="full_name_en" value={names.en} />

      <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-5 px-4 py-4 sm:px-6">
        <div className="rounded-lg border border-parish-border/70 p-3">
          <p className="text-sm font-medium text-parish-text">{copy.fullName}</p>
          <p className="mt-1 text-xs text-parish-muted">{copy.nameLanguagesHint}</p>

          {nameLangVisible.has("ru") ? (
            <label className="mt-3 block text-xs text-parish-muted">
              <span className="font-medium text-parish-accent">{copy.langRu}</span>
              <input
                type="text"
                value={names.ru}
                onChange={(e) => setNames((n) => ({ ...n, ru: e.target.value }))}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
          ) : null}

          {nameLangVisible.has("uk") ? (
            <label className="mt-2 block text-xs text-parish-muted">
              <span className="font-medium text-parish-accent">{copy.langUk}</span>
              <input
                type="text"
                value={names.uk}
                onChange={(e) => setNames((n) => ({ ...n, uk: e.target.value }))}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
          ) : null}

          {nameLangVisible.has("kk") ? (
            <label className="mt-2 block text-xs text-parish-muted">
              <span className="font-medium text-parish-accent">{copy.langKk}</span>
              <input
                type="text"
                value={names.kk}
                onChange={(e) => setNames((n) => ({ ...n, kk: e.target.value }))}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
          ) : null}

          {nameLangVisible.has("en") ? (
            <label className="mt-2 block text-xs text-parish-muted">
              <span className="font-medium text-parish-accent">{copy.langEn}</span>
              <input
                type="text"
                value={names.en}
                onChange={(e) => setNames((n) => ({ ...n, en: e.target.value }))}
                className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
              />
            </label>
          ) : null}

          <div className="mt-3 flex flex-wrap gap-2">
            {(["uk", "kk", "en"] as const).map((l) => {
              const k = ADD_NAME[l];
              if (!k || nameLangVisible.has(l)) return null;
              return (
                <button
                  key={l}
                  type="button"
                  onClick={() => setNameLangVisible((s) => new Set(s).add(l))}
                  className="rounded-lg border border-parish-border px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
                >
                  {copy[k]}
                </button>
              );
            })}
          </div>
        </div>

        <div className="rounded-lg border border-parish-border/70 p-3">
          <p className="text-sm font-medium text-parish-text">{copy.hierarchyTitle}</p>
          <label className="mt-2 block text-xs text-parish-muted">
            {copy.sortOrderLabel}
            <input
              type="number"
              name="sort_order"
              defaultValue={clergy.sort_order}
              className="mt-1 w-full max-w-[12rem] rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
            />
          </label>
          <p className="mt-1 text-[11px] text-parish-muted">{copy.sortOrderHint}</p>
        </div>

        <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
          <p className="text-sm font-medium text-parish-text">{copy.photo}</p>
          {clergy.photo_url ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={clergy.photo_url}
              alt=""
              className="h-32 w-32 rounded-full border border-parish-border object-cover"
            />
          ) : null}
          <input type="file" name="photo" accept="image/*" className="block w-full text-xs" />
          <label className="mt-2 block text-xs text-parish-muted">
            {imageCopy.orImageUrl}
            <input
              type="url"
              name="photo_url"
              defaultValue={clergy.photo_url ?? ""}
              placeholder={imageCopy.imageUrlPlaceholder}
              className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
            />
          </label>
          <p className="mt-1 text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
          <p className="text-xs text-parish-muted">{isNew ? copy.photoHintNew : copy.photoHintEdit}</p>
        </div>

        <div className="space-y-3">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <p className="text-sm font-medium text-parish-text">{copy.extraFieldsTitle}</p>
            <button
              type="button"
              onClick={() => setExtras((prev) => [...prev, emptyExtra()])}
              className="rounded-lg border border-parish-border px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
            >
              {copy.addField}
            </button>
          </div>
          <p className="text-xs text-parish-muted">{copy.fieldUrlHint}</p>

          {extras.map((row) => (
            <div
              key={row.key}
              className="space-y-3 rounded-lg border border-parish-border/60 bg-parish-bg/30 p-3"
            >
              <div className="flex justify-end">
                <button
                  type="button"
                  onClick={() => setExtras((prev) => prev.filter((x) => x.key !== row.key))}
                  className="text-xs font-medium text-red-600 hover:underline"
                >
                  {copy.removeField}
                </button>
              </div>

              {LANG_CODES.map((l) =>
                row.langVisible.has(l) ? (
                  <div key={l} className="rounded-md border border-parish-border/50 bg-parish-surface/40 p-2">
                    <p className="mb-2 text-xs font-semibold text-parish-accent">{copy[LANG_LEGEND[l]]}</p>
                    <label className="block text-xs text-parish-muted">
                      {copy.fieldLabel}
                      <input
                        type="text"
                        value={row.labels[l]}
                        onChange={(e) =>
                          patchExtra(row.key, (r) => ({
                            ...r,
                            labels: { ...r.labels, [l]: e.target.value },
                          }))
                        }
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                      />
                    </label>
                    <label className="mt-2 block text-xs text-parish-muted">
                      {copy.fieldValue}
                      <textarea
                        value={row.values[l]}
                        onChange={(e) =>
                          patchExtra(row.key, (r) => ({
                            ...r,
                            values: { ...r.values, [l]: e.target.value },
                          }))
                        }
                        rows={2}
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                      />
                    </label>
                  </div>
                ) : null,
              )}

              <div className="flex flex-wrap gap-2">
                {(["uk", "kk", "en"] as const).map((l) => {
                  const k = ADD_FIELD[l];
                  if (!k || row.langVisible.has(l)) return null;
                  return (
                    <button
                      key={l}
                      type="button"
                      onClick={() => setExtraLangVisible(row.key, l, true)}
                      className="rounded-lg border border-parish-border px-2 py-1 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
                    >
                      {copy[k]}
                    </button>
                  );
                })}
              </div>

              <label className="block text-xs text-parish-muted">
                {copy.fieldUrl}
                <input
                  type="url"
                  value={row.url}
                  onChange={(e) => patchExtra(row.key, { url: e.target.value })}
                  placeholder="https://"
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
                />
              </label>
            </div>
          ))}
        </div>
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
