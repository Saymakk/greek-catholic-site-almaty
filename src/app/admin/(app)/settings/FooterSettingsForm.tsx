"use client";

import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import { saveFooter } from "../actions/content";
import type { AdminSettingsCopy } from "@/lib/admin-layout-i18n";
import type { FooterContactButton, FooterSettings } from "@/lib/data";
import { ContactButtonsEditor } from "./ContactButtonsEditor";

const LANGS = ["ru", "uk", "kk", "en"] as const;

const LANG_KEY: Record<(typeof LANGS)[number], keyof AdminSettingsCopy> = {
  ru: "langRu",
  uk: "langUk",
  kk: "langKk",
  en: "langEn",
};

export function FooterSettingsForm({
  copy,
  footer,
  mapEmbedRaw,
  initialButtons,
}: {
  copy: AdminSettingsCopy;
  footer: FooterSettings;
  mapEmbedRaw: string;
  initialButtons: FooterContactButton[];
}) {
  return (
    <form action={saveFooter} className="mt-8 max-w-3xl space-y-8">
      <fieldset className="rounded-xl border border-parish-border bg-parish-surface/60 p-4 shadow-sm">
        <legend className="px-1 font-display text-sm font-semibold text-parish-text">{copy.sharedSection}</legend>
        <div className="mt-3 space-y-4">
          <div className="flex max-w-md flex-col gap-1">
            <label htmlFor="footer_phone" className="text-sm font-medium text-parish-text">
              {copy.phoneLabel}
            </label>
            <input
              id="footer_phone"
              type="text"
              name="phone"
              defaultValue={footer.phone ?? ""}
              className="w-full rounded-lg border border-parish-border px-3 py-2 text-sm"
            />
          </div>
          <div className="flex max-w-md flex-col gap-1">
            <label htmlFor="footer_email" className="text-sm font-medium text-parish-text">
              {copy.emailLabel}
            </label>
            <input
              id="footer_email"
              type="email"
              name="email"
              defaultValue={footer.email ?? ""}
              className="w-full rounded-lg border border-parish-border px-3 py-2 text-sm"
            />
          </div>
        </div>
      </fieldset>

      {LANGS.map((l) => (
        <fieldset key={l} className="rounded-xl border border-parish-border bg-parish-surface/60 p-4 shadow-sm">
          <legend className="px-1 font-display text-sm font-semibold text-parish-text">{copy[LANG_KEY[l]]}</legend>
          <div className="mt-3 space-y-3">
            <label className="block text-sm text-parish-text">
              <span className="font-medium">{copy.priestNameLabel}</span>
              <input
                type="text"
                name={`priest_name_${l}`}
                defaultValue={footer[`priest_name_${l}`] ?? ""}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 text-sm"
              />
            </label>
            <label className="block text-sm text-parish-text">
              <span className="font-medium">{copy.addressLabel}</span>
              <textarea
                name={`address_${l}`}
                rows={2}
                defaultValue={footer[`address_${l}`] ?? ""}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 text-sm"
              />
            </label>
            <label className="block text-sm text-parish-text">
              <span className="font-medium">{copy.extraLabel}</span>
              <textarea
                name={`extra_${l}`}
                rows={3}
                defaultValue={footer[`extra_${l}`] ?? ""}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 text-sm"
              />
            </label>
          </div>
        </fieldset>
      ))}

      <fieldset className="rounded-xl border border-parish-border bg-parish-surface/60 p-4 shadow-sm">
        <legend className="px-1 font-display text-sm font-semibold text-parish-text">{copy.mapSection}</legend>
        <label className="mt-2 block text-sm text-parish-text">
          <textarea
            name="map_embed_raw"
            rows={5}
            defaultValue={mapEmbedRaw}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-xs"
          />
        </label>
        <p className="mt-2 text-xs text-parish-muted">{copy.mapHint}</p>
      </fieldset>

      <fieldset className="rounded-xl border border-parish-border bg-parish-surface/60 p-4 shadow-sm">
        <legend className="px-1 font-display text-sm font-semibold text-parish-text">{copy.contactButtonsSection}</legend>
        <div className="mt-3">
          <ContactButtonsEditor copy={copy} initial={initialButtons} />
        </div>
      </fieldset>

      <button type="submit" className="rounded-lg bg-parish-accent px-6 py-2 text-white hover:opacity-90">
        {copy.save}
      </button>
      <AdminModalSavingOverlay />
    </form>
  );
}
