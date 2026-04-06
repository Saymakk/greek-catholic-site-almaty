"use client";

import { useEffect, useMemo, useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { removeLiturgicalCover, saveLiturgicalEvent } from "../actions/calendar";
import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";
import {
  sortCalendarLangsForForm,
  type CalendarLocaleFields,
} from "./calendar-entity-locales";
import type { Lang } from "@/lib/i18n";
import type { AdminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import { AdminModalSavingOverlay } from "@/components/AdminModalSavingOverlay";
import { adminCalendarFormMsg } from "@/lib/admin-calendar-form-i18n";
import type { CalendarExtraRow, CalendarTemplatePayload } from "./calendar-admin-types";

const PRESET_KINDS = new Set([
  "great_feast",
  "feast",
  "sunday",
  "fast",
  "commemoration",
  "other",
]);

const KIND_CUSTOM_SENTINEL = "__custom__";

type ExtraFormRow = {
  label_ru: string;
  label_uk: string;
  label_kk: string;
  label_en: string;
  body_ru: string;
  body_uk: string;
  body_kk: string;
  body_en: string;
  url: string;
};

function toFormRows(initial: CalendarExtraRow[]): ExtraFormRow[] {
  if (!initial.length) return [];
  return initial.map((r) => ({
    label_ru: r.label_ru ?? "",
    label_uk: r.label_uk ?? "",
    label_kk: r.label_kk ?? "",
    label_en: r.label_en ?? "",
    body_ru: r.body_ru ?? "",
    body_uk: r.body_uk ?? "",
    body_kk: r.body_kk ?? "",
    body_en: r.body_en ?? "",
    url: r.url ?? "",
  }));
}

function emptyExtraRow(): ExtraFormRow {
  return {
    label_ru: "",
    label_uk: "",
    label_kk: "",
    label_en: "",
    body_ru: "",
    body_uk: "",
    body_kk: "",
    body_en: "",
    url: "",
  };
}

function editionTitle(code: string) {
  return code.toUpperCase();
}

const LABEL_KEYS = [
  ["label_ru", "labelRu"],
  ["label_uk", "labelUk"],
  ["label_kk", "labelKk"],
  ["label_en", "labelEn"],
] as const;

const BODY_KEYS = [
  ["body_ru", "labelRu"],
  ["body_uk", "labelUk"],
  ["body_kk", "labelKk"],
  ["body_en", "labelEn"],
] as const;

export function CalendarEventEditForm({
  uiLang,
  imageCopy,
  eventId,
  eventDate,
  kind: kindInitial,
  primaryLang: primaryLangDb,
  coverImageUrl: coverImageUrlProp,
  locales,
  initialExtras,
  templates,
  kindSiteLabels,
  kindLabelsBySlug,
  submitLabel,
  onCancel,
}: {
  uiLang: Lang;
  imageCopy: AdminSharedImageCopy;
  eventId: string;
  eventDate: string;
  kind: string;
  primaryLang: string | null;
  coverImageUrl: string | null;
  locales: CalendarLocaleFields[];
  initialExtras: CalendarExtraRow[];
  templates: CalendarTemplatePayload[];
  kindSiteLabels: Partial<Record<Lang, string>>;
  /** Все подписи типов из liturgical_kind_i18n (для смены типа в форме). */
  kindLabelsBySlug: Record<string, Partial<Record<Lang, string>>>;
  submitLabel: string;
  onCancel?: () => void;
}) {
  const msg = adminCalendarFormMsg(uiLang);
  const ui = uiLang as ContentLang;
  const [primaryLang, setPrimaryLang] = useState<ContentLang>(() =>
    primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : ui,
  );
  const [activeLangs, setActiveLangs] = useState<string[]>(() =>
    sortCalendarLangsForForm(
      locales.map((l) => l.lang),
      primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : ui,
    ),
  );
  const [coverRemoved, setCoverRemoved] = useState(false);
  const [coverLightboxOpen, setCoverLightboxOpen] = useState(false);
  const [coverPending, startCoverTransition] = useTransition();
  const [kindChoice, setKindChoice] = useState<string>(() =>
    PRESET_KINDS.has(kindInitial) ? kindInitial : KIND_CUSTOM_SENTINEL,
  );
  const [customKindSlug, setCustomKindSlug] = useState(() =>
    PRESET_KINDS.has(kindInitial) ? "" : kindInitial,
  );
  const [extras, setExtras] = useState<ExtraFormRow[]>(() => toFormRows(initialExtras));
  /** Последний шаблон, применённый из списка в этой сессии (для пропуска предложения «сохранить шаблон»). */
  const [templateAppliedId, setTemplateAppliedId] = useState<string | null>(null);
  /** Добавление/удаление строк доп. полей после применения шаблона. */
  const [extrasStructureDirty, setExtrasStructureDirty] = useState(false);
  const [kindSiteInputs, setKindSiteInputs] = useState(() => ({
    ru: kindSiteLabels.ru ?? "",
    uk: kindSiteLabels.uk ?? "",
    kk: kindSiteLabels.kk ?? "",
    en: kindSiteLabels.en ?? "",
  }));
  const router = useRouter();

  const extrasJson = useMemo(() => JSON.stringify(extras), [extras]);

  useEffect(() => {
    const slug =
      kindChoice === KIND_CUSTOM_SENTINEL ? customKindSlug.trim() : kindChoice;
    if (!slug) {
      setKindSiteInputs({ ru: "", uk: "", kk: "", en: "" });
      return;
    }
    const row = kindLabelsBySlug[slug];
    setKindSiteInputs({
      ru: row?.ru ?? "",
      uk: row?.uk ?? "",
      kk: row?.kk ?? "",
      en: row?.en ?? "",
    });
  }, [kindChoice, customKindSlug, kindLabelsBySlug]);

  const presetOptions: [string, string][] = useMemo(
    () => [
      ["great_feast", msg.kindGreatFeast],
      ["feast", msg.kindFeast],
      ["sunday", msg.kindSunday],
      ["fast", msg.kindFast],
      ["commemoration", msg.kindCommemoration],
      ["other", msg.kindOther],
    ],
    [msg],
  );

  const byLang = useMemo(() => {
    const m = new Map<string, CalendarLocaleFields>();
    for (const l of locales) m.set(l.lang, l);
    return m;
  }, [locales]);

  const canAdd = CONTENT_ORDER.filter((code) => !activeLangs.includes(code));

  function addLang(code: string) {
    setActiveLangs((prev) => sortCalendarLangsForForm([...prev, code], primaryLang));
  }

  function removeLang(code: string) {
    if (code === primaryLang) return;
    setActiveLangs((prev) => prev.filter((x) => x !== code));
  }

  const orderedLangCodes = sortCalendarLangsForForm(activeLangs, primaryLang);
  const displayCover = !coverRemoved && coverImageUrlProp;

  return (
    <div className="flex min-h-0 min-w-0 flex-1 flex-col">
      <form action={saveLiturgicalEvent} className="flex min-h-0 min-w-0 flex-1 flex-col">
        <input type="hidden" name="id" value={eventId} />
        <input
          type="hidden"
          name="skip_offer_template"
          value={templateAppliedId !== null && !extrasStructureDirty ? "1" : "0"}
        />
        <input type="hidden" name="primary_lang" value={primaryLang} />
        <input type="hidden" name="locales" value={activeLangs.join(",")} />
        <input
          type="hidden"
          name="kind_mode"
          value={kindChoice === KIND_CUSTOM_SENTINEL ? "custom" : "preset"}
        />
        {kindChoice !== KIND_CUSTOM_SENTINEL ? (
          <input type="hidden" name="kind_preset" value={kindChoice} />
        ) : null}
        <input type="hidden" name="extras_json" value={extrasJson} />

        <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-4 px-4 py-4 sm:px-6">
          <label className="block text-xs text-parish-muted sm:text-sm">
            {msg.primaryLang}
            <select
              className="mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-2 py-1.5 text-sm text-parish-text"
              value={primaryLang}
              onChange={(e) => {
                const next = e.target.value;
                if (!isContentLang(next)) return;
                setPrimaryLang(next);
                setActiveLangs((prev) => sortCalendarLangsForForm(prev, next));
              }}
            >
              {CONTENT_ORDER.map((code) => (
                <option key={code} value={code}>
                  {editionTitle(code)}
                </option>
              ))}
            </select>
          </label>
          <label className="block text-xs text-parish-muted sm:text-sm">
            {msg.date}
            <input
              type="date"
              name="event_date"
              required
              defaultValue={eventDate}
              className="mt-1 block w-full max-w-md rounded border border-parish-border px-2 py-1.5 text-sm"
            />
          </label>

          <div className="space-y-2 rounded-lg border border-parish-border/70 p-3">
            <label className="block text-xs font-medium text-parish-muted sm:text-sm">
              {msg.kindSectionTitle}
              <select
                value={kindChoice}
                onChange={(e) => setKindChoice(e.target.value)}
                className="mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-2 py-1.5 text-sm text-parish-text"
              >
                {presetOptions.map(([v, label]) => (
                  <option key={v} value={v}>
                    {label}
                  </option>
                ))}
                <option value={KIND_CUSTOM_SENTINEL}>{msg.kindCustom}</option>
              </select>
            </label>
            {kindChoice === KIND_CUSTOM_SENTINEL ? (
              <div className="space-y-1">
                <label className="block text-[11px] text-parish-muted">
                  {msg.kindSlug}
                  <input
                    name="kind_slug"
                    value={customKindSlug}
                    onChange={(e) =>
                      setCustomKindSlug(e.target.value.toLowerCase().replace(/[^a-z0-9_]/g, ""))
                    }
                    className="mt-0.5 block w-full max-w-md rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                    placeholder="parish_meeting"
                    required
                  />
                </label>
                <p className="text-[11px] text-parish-muted">{msg.kindSlugHint}</p>
              </div>
            ) : null}
          </div>

          <div className="rounded-lg border border-parish-border/70 p-3">
            <p className="text-xs font-medium text-parish-muted">{msg.kindSiteLabels}</p>
            <div className="mt-2 grid gap-2 sm:grid-cols-2">
              <label className="block text-[11px] text-parish-muted">
                {msg.labelRu}
                <input
                  name="kind_label_ru"
                  value={kindSiteInputs.ru}
                  onChange={(e) =>
                    setKindSiteInputs((s) => ({ ...s, ru: e.target.value }))
                  }
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                  placeholder="—"
                />
              </label>
              <label className="block text-[11px] text-parish-muted">
                {msg.labelUk}
                <input
                  name="kind_label_uk"
                  value={kindSiteInputs.uk}
                  onChange={(e) =>
                    setKindSiteInputs((s) => ({ ...s, uk: e.target.value }))
                  }
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                  placeholder="—"
                />
              </label>
              <label className="block text-[11px] text-parish-muted">
                {msg.labelKk}
                <input
                  name="kind_label_kk"
                  value={kindSiteInputs.kk}
                  onChange={(e) =>
                    setKindSiteInputs((s) => ({ ...s, kk: e.target.value }))
                  }
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                  placeholder="—"
                />
              </label>
              <label className="block text-[11px] text-parish-muted">
                {msg.labelEn}
                <input
                  name="kind_label_en"
                  value={kindSiteInputs.en}
                  onChange={(e) =>
                    setKindSiteInputs((s) => ({ ...s, en: e.target.value }))
                  }
                  className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                  placeholder="—"
                />
              </label>
            </div>
          </div>

          <div className="rounded-lg border border-parish-border/70 p-3">
            <p className="text-xs font-medium text-parish-muted">{msg.coverTitle}</p>
            {displayCover ? (
              <button
                type="button"
                className="mt-2 block w-full max-w-full rounded-md bg-parish-surface text-left focus:outline-none focus:ring-2 focus:ring-parish-accent/40"
                onClick={() => setCoverLightboxOpen(true)}
              >
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img
                  src={displayCover}
                  alt=""
                  className="max-h-[min(512px,70vh)] max-w-full cursor-zoom-in rounded-md border border-parish-border object-contain"
                />
                <span className="mt-1 block text-[11px] text-parish-muted">{msg.coverZoom}</span>
              </button>
            ) : (
              <p className="mt-2 text-xs text-parish-muted">{msg.noCover}</p>
            )}
            <label className="mt-2 block text-xs text-parish-muted">
              {msg.uploadCover}
              <input
                type="file"
                name="cover"
                accept="image/*"
                className="mt-1 block w-full text-sm text-parish-text"
              />
            </label>
            <label className="mt-2 block text-xs text-parish-muted">
              {imageCopy.orImageUrl}
              <input
                key={`cal-cover-url-${coverImageUrlProp ?? ""}-${coverRemoved}`}
                type="url"
                name="cover_image_url"
                defaultValue={coverRemoved ? "" : (coverImageUrlProp ?? "")}
                placeholder={imageCopy.imageUrlPlaceholder}
                className="mt-1 block w-full rounded border border-parish-border px-2 py-1.5 text-sm text-parish-text"
              />
            </label>
            <p className="mt-1 text-[11px] text-parish-muted">{imageCopy.fileWinsHint}</p>
            {displayCover && eventId ? (
              <button
                type="button"
                className="mt-2 rounded-lg border border-red-200 bg-red-50/80 px-3 py-1.5 text-xs font-medium text-red-700 hover:bg-red-100 disabled:opacity-50"
                disabled={coverPending}
                onClick={() => {
                  startCoverTransition(async () => {
                    await removeLiturgicalCover(eventId);
                    setCoverRemoved(true);
                    router.refresh();
                  });
                }}
              >
                {msg.removeCover}
              </button>
            ) : null}
          </div>

          <div className="rounded-lg border border-parish-border/70 p-3">
            <p className="text-sm font-medium text-parish-accent">{msg.extrasTitle}</p>
            {templates.length > 0 ? (
              <label className="mt-2 block text-xs text-parish-muted">
                {msg.templateApply}
                <select
                  className="mt-1 block w-full max-w-md rounded border border-parish-border px-2 py-1.5 text-sm"
                  defaultValue=""
                  onChange={(e) => {
                    const id = e.target.value;
                    if (!id) return;
                    const t = templates.find((x) => x.id === id);
                    if (t) {
                      setTemplateAppliedId(t.id);
                      setExtrasStructureDirty(false);
                      setExtras(
                        t.rows.map((r) => ({
                          label_ru: r.label_ru ?? "",
                          label_uk: r.label_uk ?? "",
                          label_kk: r.label_kk ?? "",
                          label_en: r.label_en ?? "",
                          body_ru: "",
                          body_uk: "",
                          body_kk: "",
                          body_en: "",
                          url: "",
                        })),
                      );
                    }
                    e.target.selectedIndex = 0;
                  }}
                >
                  <option value="">{msg.templatePick}</option>
                  {templates.map((t) => (
                    <option key={t.id} value={t.id}>
                      {t.name}
                    </option>
                  ))}
                </select>
              </label>
            ) : null}
            <div className="mt-3 space-y-4">
              {extras.map((row, idx) => (
                <div key={idx} className="rounded-md border border-parish-border/60 p-3">
                  <div className="mb-2 flex justify-end">
                    <button
                      type="button"
                      className="rounded border border-parish-border px-2 py-1 text-xs font-medium text-red-600 hover:bg-red-50"
                      aria-label={msg.extraRemoveRow}
                      onClick={() => {
                        setExtrasStructureDirty(true);
                        setExtras((prev) => prev.filter((_, i) => i !== idx));
                      }}
                    >
                      {msg.extraFieldRemove}
                    </button>
                  </div>
                  <p className="text-[11px] font-semibold text-parish-muted">{msg.extrasLabelsSection}</p>
                  <div className="mt-1 grid gap-2 sm:grid-cols-2">
                    {LABEL_KEYS.map(([field, msgKey]) => (
                      <label key={field} className="block text-[11px] text-parish-muted">
                        {msg[msgKey]}
                        <input
                          className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 text-sm"
                          value={row[field]}
                          onChange={(e) =>
                            setExtras((prev) =>
                              prev.map((r, i) => (i === idx ? { ...r, [field]: e.target.value } : r)),
                            )
                          }
                        />
                      </label>
                    ))}
                  </div>
                  <p className="mt-3 text-[11px] font-semibold text-parish-muted">{msg.extrasBodySection}</p>
                  <div className="mt-1 grid gap-2 sm:grid-cols-2">
                    {BODY_KEYS.map(([field, msgKey]) => (
                      <label key={field} className="block text-[11px] text-parish-muted">
                        {msg[msgKey]}
                        <textarea
                          rows={2}
                          className="mt-0.5 w-full rounded border border-parish-border px-2 py-1 font-mono text-sm"
                          value={row[field]}
                          onChange={(e) =>
                            setExtras((prev) =>
                              prev.map((r, i) => (i === idx ? { ...r, [field]: e.target.value } : r)),
                            )
                          }
                        />
                      </label>
                    ))}
                  </div>
                  <label className="mt-2 block text-xs text-parish-muted">
                    {msg.extraUrl}
                    <input
                      className="mt-1 w-full rounded border border-parish-border px-2 py-1 text-sm"
                      value={row.url}
                      onChange={(e) =>
                        setExtras((prev) =>
                          prev.map((r, i) => (i === idx ? { ...r, url: e.target.value } : r)),
                        )
                      }
                      placeholder="https://"
                    />
                    <span className="mt-0.5 block text-[10px] text-parish-muted">{msg.extraUrlHint}</span>
                  </label>
                </div>
              ))}
            </div>
            <button
              type="button"
              className="mt-3 rounded-lg border border-parish-border px-3 py-1.5 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
              onClick={() => {
                setExtrasStructureDirty(true);
                setExtras((prev) => [...prev, emptyExtraRow()]);
              }}
            >
              {msg.addExtraRow}
            </button>
          </div>

          {orderedLangCodes.map((code) => {
            const row = byLang.get(code) ?? {
              lang: code,
              title: "",
              explanation: "",
              prayer: "",
            };
            return (
              <fieldset
                key={code}
                className="rounded-lg border border-parish-border/70 p-3"
              >
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <legend className="text-sm font-medium text-parish-accent">
                    {editionTitle(code)}
                    {code === primaryLang ? (
                      <span className="ml-1 font-normal text-parish-muted">— {msg.mainEdition}</span>
                    ) : null}
                  </legend>
                  {code !== primaryLang ? (
                    <button
                      type="button"
                      className="rounded border border-parish-border px-2 py-1 text-xs font-medium text-red-600 hover:bg-red-50"
                      onClick={() => removeLang(code)}
                    >
                      {msg.removeVersion}
                    </button>
                  ) : null}
                </div>
                <label className="mt-2 block text-xs text-parish-muted">
                  {msg.title}
                  <input
                    name={`title_${code}`}
                    defaultValue={row.title}
                    className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 text-sm"
                  />
                </label>
                <label className="mt-2 block text-xs text-parish-muted">
                  {msg.explanation}
                  <textarea
                    name={`explanation_${code}`}
                    rows={4}
                    defaultValue={row.explanation}
                    className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                  />
                </label>
                <label className="mt-2 block text-xs text-parish-muted">
                  {msg.prayer}
                  <textarea
                    name={`prayer_${code}`}
                    rows={3}
                    defaultValue={row.prayer}
                    className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                  />
                </label>
              </fieldset>
            );
          })}
          {canAdd.length > 0 ? (
            <div className="flex flex-wrap gap-2">
              <span className="w-full text-xs text-parish-muted">{msg.addLocale}</span>
              {canAdd.map((code) => (
                <button
                  key={code}
                  type="button"
                  className="rounded-lg border border-parish-border px-3 py-1.5 text-xs text-parish-accent hover:bg-parish-accent-soft"
                  onClick={() => addLang(code)}
                >
                  {editionTitle(code)}
                </button>
              ))}
            </div>
          ) : null}
        </div>
        <div className="flex shrink-0 flex-wrap gap-3 border-t border-parish-border bg-parish-surface/95 px-4 py-3 sm:px-6">
          {onCancel ? (
            <button
              type="button"
              onClick={onCancel}
              className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
            >
              {msg.cancel}
            </button>
          ) : null}
          <button
            type="submit"
            className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
          >
            {submitLabel}
          </button>
        </div>
        <AdminModalSavingOverlay />
      </form>

      {coverLightboxOpen && displayCover ? (
        <div
          className="fixed inset-0 z-[200] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-label={msg.coverLightboxAria}
          onClick={() => setCoverLightboxOpen(false)}
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={displayCover}
            alt=""
            className="max-h-[95vh] max-w-[95vw] object-contain shadow-2xl"
            onClick={(e) => e.stopPropagation()}
          />
        </div>
      ) : null}
    </div>
  );
}
