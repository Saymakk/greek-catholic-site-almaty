"use client";

import { useMemo, useState } from "react";
import { updateLiturgicalTemplateForm } from "../actions/calendar";
import { adminCalendarFormMsg } from "@/lib/admin-calendar-form-i18n";
import type { Lang } from "@/lib/i18n";
import type { CalendarTemplatePayload } from "./calendar-admin-types";

type LabelRow = {
  label_ru: string;
  label_uk: string;
  label_kk: string;
  label_en: string;
};

function toRows(tpl: CalendarTemplatePayload): LabelRow[] {
  if (!tpl.rows.length) return [{ label_ru: "", label_uk: "", label_kk: "", label_en: "" }];
  return tpl.rows.map((r) => ({
    label_ru: r.label_ru ?? "",
    label_uk: r.label_uk ?? "",
    label_kk: r.label_kk ?? "",
    label_en: r.label_en ?? "",
  }));
}

export function TemplateEditDialog({
  lang,
  template,
  screen,
  onClose,
}: {
  lang: Lang;
  template: CalendarTemplatePayload;
  screen: { title: string; save: string; closeAria: string };
  onClose: () => void;
}) {
  const msg = adminCalendarFormMsg(lang);
  const [name, setName] = useState(template.name);
  const [rows, setRows] = useState<LabelRow[]>(() => toRows(template));
  const rowsJson = useMemo(() => JSON.stringify(rows), [rows]);

  return (
    <div
      className="fixed inset-0 z-[250] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
      role="dialog"
      aria-modal
      aria-labelledby="tpl-edit-title"
      onClick={onClose}
    >
      <div
        className="flex max-h-[min(90dvh,calc(100dvh-2rem))] w-full max-w-lg flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-2xl"
        onClick={(e) => e.stopPropagation()}
      >
        <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-5">
          <h2 id="tpl-edit-title" className="font-display text-lg font-semibold text-parish-text">
            {screen.title}
          </h2>
          <button
            type="button"
            onClick={onClose}
            className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
            aria-label={screen.closeAria}
          >
            <span className="text-2xl leading-none" aria-hidden>
              ×
            </span>
          </button>
        </div>
        <form
          action={updateLiturgicalTemplateForm}
          className="flex min-h-0 flex-1 flex-col"
        >
          <input type="hidden" name="id" value={template.id} />
          <input type="hidden" name="template_rows_json" value={rowsJson} readOnly />
          <div className="min-h-0 flex-1 space-y-4 overflow-y-auto px-4 py-4 sm:px-5">
            <label className="block text-xs text-parish-muted sm:text-sm">
              {msg.templateName}
              <input
                name="template_name"
                required
                value={name}
                onChange={(e) => setName(e.target.value)}
                className="mt-1 block w-full rounded border border-parish-border bg-parish-surface px-2 py-1.5 text-sm text-parish-text"
              />
            </label>
            <p className="text-xs font-medium text-parish-muted">{msg.extrasLabelsSection}</p>
            <div className="space-y-3">
              {rows.map((row, idx) => (
                <div
                  key={idx}
                  className="rounded-lg border border-parish-border/70 p-3"
                >
                  <div className="mb-2 flex justify-end">
                    <button
                      type="button"
                      className="rounded border border-parish-border px-2 py-1 text-xs font-medium text-red-600 hover:bg-red-50"
                      aria-label={msg.extraRemoveRow}
                      onClick={() => setRows((prev) => prev.filter((_, i) => i !== idx))}
                    >
                      {msg.extraFieldRemove}
                    </button>
                  </div>
                  <div className="grid gap-2 sm:grid-cols-2">
                    <label className="block text-[11px] text-parish-muted">
                      {msg.labelRu}
                      <input
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                        value={row.label_ru}
                        onChange={(e) =>
                          setRows((prev) =>
                            prev.map((r, i) => (i === idx ? { ...r, label_ru: e.target.value } : r)),
                          )
                        }
                      />
                    </label>
                    <label className="block text-[11px] text-parish-muted">
                      {msg.labelUk}
                      <input
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                        value={row.label_uk}
                        onChange={(e) =>
                          setRows((prev) =>
                            prev.map((r, i) => (i === idx ? { ...r, label_uk: e.target.value } : r)),
                          )
                        }
                      />
                    </label>
                    <label className="block text-[11px] text-parish-muted">
                      {msg.labelKk}
                      <input
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                        value={row.label_kk}
                        onChange={(e) =>
                          setRows((prev) =>
                            prev.map((r, i) => (i === idx ? { ...r, label_kk: e.target.value } : r)),
                          )
                        }
                      />
                    </label>
                    <label className="block text-[11px] text-parish-muted">
                      {msg.labelEn}
                      <input
                        className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                        value={row.label_en}
                        onChange={(e) =>
                          setRows((prev) =>
                            prev.map((r, i) => (i === idx ? { ...r, label_en: e.target.value } : r)),
                          )
                        }
                      />
                    </label>
                  </div>
                </div>
              ))}
            </div>
            <button
              type="button"
              className="rounded-lg border border-parish-border px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
              onClick={() =>
                setRows((prev) => [
                  ...prev,
                  { label_ru: "", label_uk: "", label_kk: "", label_en: "" },
                ])
              }
            >
              {msg.addExtraRow}
            </button>
          </div>
          <div className="flex shrink-0 flex-wrap gap-2 border-t border-parish-border bg-parish-surface/95 px-4 py-3 sm:px-5">
            <button
              type="button"
              onClick={onClose}
              className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
            >
              {msg.cancel}
            </button>
            <button
              type="submit"
              className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
            >
              {screen.save}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
