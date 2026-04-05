"use client";

import { useMemo, useState } from "react";
import type { FooterContactButton } from "@/lib/data";
import type { AdminSettingsCopy } from "@/lib/admin-layout-i18n";

export function ContactButtonsEditor({
  copy,
  initial,
}: {
  copy: AdminSettingsCopy;
  initial: FooterContactButton[];
}) {
  const [rows, setRows] = useState<FooterContactButton[]>(() =>
    initial.length ? initial.map((b) => ({ ...b })) : [],
  );

  const json = useMemo(() => JSON.stringify(rows), [rows]);

  function addRow() {
    setRows((r) => [...r, { icon: "", label: "", url: "" }]);
  }

  function removeRow(i: number) {
    setRows((r) => r.filter((_, j) => j !== i));
  }

  function patch(i: number, key: keyof FooterContactButton, value: string) {
    setRows((r) => r.map((row, j) => (j === i ? { ...row, [key]: value } : row)));
  }

  return (
    <div className="space-y-3">
      <input type="hidden" name="contact_buttons_json" value={json} readOnly />
      {rows.map((row, i) => (
        <div
          key={i}
          className="grid gap-2 rounded-lg border border-parish-border/80 bg-parish-bg/30 p-3 sm:grid-cols-[minmax(0,7rem)_1fr_1fr_auto]"
        >
          <label className="block text-xs text-parish-muted sm:col-span-1">
            <span className="font-medium text-parish-text">{copy.iconLabel}</span>
            <input
              type="text"
              value={row.icon ?? ""}
              onChange={(e) => patch(i, "icon", e.target.value)}
              placeholder="telegram"
              className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
            />
          </label>
          <label className="block text-xs text-parish-muted">
            <span className="font-medium text-parish-text">{copy.buttonTitleLabel}</span>
            <input
              type="text"
              value={row.label}
              onChange={(e) => patch(i, "label", e.target.value)}
              className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
            />
          </label>
          <label className="block text-xs text-parish-muted">
            <span className="font-medium text-parish-text">{copy.buttonUrlLabel}</span>
            <input
              type="url"
              value={row.url}
              onChange={(e) => patch(i, "url", e.target.value)}
              className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm text-parish-text"
            />
          </label>
          <div className="flex items-end sm:justify-end">
            <button
              type="button"
              onClick={() => removeRow(i)}
              className="rounded border border-parish-border px-2 py-1 text-xs text-red-600 hover:bg-red-50"
            >
              {copy.removeContactButton}
            </button>
          </div>
        </div>
      ))}
      <p className="text-xs text-parish-muted">{copy.iconHint}</p>
      <button
        type="button"
        onClick={addRow}
        className="rounded-lg border border-dashed border-parish-border px-3 py-2 text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
      >
        {copy.addContactButton}
      </button>
    </div>
  );
}
