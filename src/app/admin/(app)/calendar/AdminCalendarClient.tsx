"use client";

import Link from "next/link";
import { useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { format, parseISO } from "date-fns";
import type { Lang } from "@/lib/i18n";
import { pickLiturgicalI18nRow } from "@/lib/content-lang-chain";
import { adminCalendarScreenCopy } from "@/lib/admin-layout-i18n";
import { adminCalendarFormMsg } from "@/lib/admin-calendar-form-i18n";
import {
  deleteLiturgicalEventForm,
  deleteLiturgicalTemplateForm,
  saveLiturgicalTemplateFromEventForm,
} from "../actions/calendar";
import { CalendarEventEditForm } from "./CalendarEventEditForm";
import { TemplateEditDialog } from "./TemplateEditDialog";
import { normalizeCalendarLocales } from "./calendar-entity-locales";
import type {
  AdminCalendarPayload,
  CalendarExtraRow,
  CalendarTemplatePayload,
} from "./calendar-admin-types";

export type { AdminCalendarPayload, CalendarExtraRow, CalendarTemplatePayload } from "./calendar-admin-types";

function listTitle(item: AdminCalendarPayload, uiLang: Lang): string {
  const by: Partial<
    Record<
      Lang,
      { title: string; explanation: string; prayer: string | null }
    >
  > = {};
  for (const l of item.locales) {
    if (l.lang === "ru" || l.lang === "uk" || l.lang === "kk" || l.lang === "en") {
      by[l.lang] = {
        title: l.title,
        explanation: l.explanation,
        prayer: l.prayer || null,
      };
    }
  }
  return (
    pickLiturgicalI18nRow(by, uiLang, item.primary_lang)?.title ??
    item.locales[0]?.title ??
    "—"
  );
}

function todayIso() {
  return format(new Date(), "yyyy-MM-dd");
}

function extrasHaveAnyLabel(extras: CalendarExtraRow[]): boolean {
  return extras.some((r) =>
    [r.label_ru, r.label_uk, r.label_kk, r.label_en].some((s) => (s ?? "").trim()),
  );
}

const emptyEvent = (): AdminCalendarPayload => ({
  id: "",
  event_date: todayIso(),
  kind: "feast",
  kindListLabel: "",
  kindSiteLabels: {},
  primary_lang: "ru",
  cover_image_url: null,
  locales: normalizeCalendarLocales([], "ru"),
  extras: [],
});

export function AdminCalendarClient({
  lang,
  items,
  templates,
  kindLabelsBySlug,
  initialEventId,
  offerTemplateEventId,
}: {
  lang: Lang;
  items: AdminCalendarPayload[];
  templates: CalendarTemplatePayload[];
  kindLabelsBySlug: Record<string, Partial<Record<Lang, string>>>;
  initialEventId: string | null;
  offerTemplateEventId: string | null;
}) {
  const c = adminCalendarScreenCopy(lang);
  const formMsg = adminCalendarFormMsg(lang);
  const router = useRouter();
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [active, setActive] = useState<AdminCalendarPayload | null>(null);
  const [editingTemplate, setEditingTemplate] = useState<CalendarTemplatePayload | null>(null);

  const offerEvent = useMemo(
    () => (offerTemplateEventId ? items.find((x) => x.id === offerTemplateEventId) : undefined),
    [items, offerTemplateEventId],
  );

  const showOfferTemplate = Boolean(
    offerTemplateEventId && offerEvent && extrasHaveAnyLabel(offerEvent.extras),
  );

  useEffect(() => {
    if (!offerTemplateEventId) return;
    const ev = items.find((x) => x.id === offerTemplateEventId);
    if (!ev) {
      router.replace("/admin/calendar");
      return;
    }
    if (!extrasHaveAnyLabel(ev.extras)) {
      router.replace("/admin/calendar");
    }
  }, [offerTemplateEventId, items, router]);

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

  useEffect(() => {
    if (!initialEventId) return;
    const found = items.find((x) => x.id === initialEventId);
    if (found) {
      setMode("edit");
      setActive(found);
      requestAnimationFrame(() => dialogRef.current?.showModal());
    }
  }, [initialEventId, items]);

  function openAdd() {
    setMode("add");
    setActive(emptyEvent());
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(e: AdminCalendarPayload) {
    setMode("edit");
    setActive(e);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  const kindLine = (e: AdminCalendarPayload) =>
    e.kindListLabel.trim() ? e.kindListLabel : e.kind.replace(/_/g, " ");

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-display text-2xl text-parish-text">{c.title}</h1>
          <p className="mt-2 max-w-2xl text-sm text-parish-muted">{c.intro}</p>
        </div>
        <button
          type="button"
          onClick={openAdd}
          className="shrink-0 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          {c.add}
        </button>
      </div>
      <ul className="mt-8 space-y-4">
        {items.map((e) => (
          <li
            key={e.id}
            className="rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm"
          >
            <div className="flex flex-col gap-4 sm:flex-row sm:items-stretch sm:justify-between">
              <div className="flex min-w-0 flex-1 gap-3">
                <div className="h-20 w-14 shrink-0 overflow-hidden rounded-md border border-parish-border bg-parish-surface">
                  {e.cover_image_url ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={e.cover_image_url}
                      alt=""
                      className="h-full w-full object-cover"
                    />
                  ) : (
                    <div className="flex h-full w-full items-center justify-center text-[10px] text-parish-muted">
                      —
                    </div>
                  )}
                </div>
                <div className="min-w-0 flex-1">
                  <span className="text-sm text-parish-muted">
                    {format(parseISO(e.event_date), "dd.MM.yyyy")} · {kindLine(e)}
                  </span>
                  <p className="font-medium text-parish-text">{listTitle(e, lang)}</p>
                </div>
              </div>
              <div className="flex shrink-0 flex-col gap-2 sm:w-40 sm:items-stretch">
                <button
                  type="button"
                  onClick={() => openEdit(e)}
                  className="rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
                >
                  {c.edit}
                </button>
                <form
                  action={deleteLiturgicalEventForm}
                  onSubmit={(ev) => {
                    if (!confirm(c.confirmDelete)) ev.preventDefault();
                  }}
                >
                  <input type="hidden" name="id" value={e.id} />
                  <button
                    type="submit"
                    className="w-full rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-red-600 hover:bg-red-50"
                  >
                    {c.delete}
                  </button>
                </form>
              </div>
            </div>
          </li>
        ))}
      </ul>

      {templates.length > 0 ? (
        <div className="mt-12">
          <h2 className="font-display text-lg font-semibold text-parish-text">{c.templatesTitle}</h2>
          <ul className="mt-3 space-y-2">
            {templates.map((tpl) => (
              <li
                key={tpl.id}
                className="flex flex-wrap items-center justify-between gap-2 rounded-lg border border-parish-border px-3 py-2"
              >
                <span className="text-sm text-parish-text">{tpl.name}</span>
                <div className="flex flex-wrap items-center gap-2">
                  <button
                    type="button"
                    onClick={() => setEditingTemplate(tpl)}
                    className="text-xs font-medium text-parish-accent hover:underline"
                  >
                    {c.editTemplate}
                  </button>
                  <form
                    action={deleteLiturgicalTemplateForm}
                    onSubmit={(ev) => {
                      if (!confirm(c.confirmDeleteTemplate)) ev.preventDefault();
                    }}
                  >
                    <input type="hidden" name="id" value={tpl.id} />
                    <button
                      type="submit"
                      className="rounded border border-parish-border px-2 py-1 text-xs font-medium text-red-600 hover:bg-red-50"
                    >
                      {c.deleteTemplate}
                    </button>
                  </form>
                </div>
              </li>
            ))}
          </ul>
        </div>
      ) : null}

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {active && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="min-w-0 flex-1 font-display text-lg font-semibold text-parish-text sm:text-xl">
                {mode === "add" ? c.newEvent : c.editEvent}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label={c.closeAria}
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <CalendarEventEditForm
              key={mode === "add" ? "new-cal" : active.id}
              uiLang={lang}
              eventId={active.id}
              eventDate={active.event_date}
              kind={active.kind}
              primaryLang={active.primary_lang}
              coverImageUrl={active.cover_image_url}
              locales={active.locales}
              initialExtras={active.extras}
              templates={templates}
              kindSiteLabels={active.kindSiteLabels}
              kindLabelsBySlug={kindLabelsBySlug}
              submitLabel={mode === "add" ? c.add : c.save}
              onCancel={closeDialog}
            />
          </div>
        ) : null}
      </dialog>

      {showOfferTemplate && offerTemplateEventId && offerEvent ? (
        <div
          className="fixed inset-0 z-[240] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-labelledby="offer-tpl-title"
        >
          <div className="w-full max-w-md rounded-2xl border border-parish-border bg-parish-surface p-5 shadow-2xl">
            <h2 id="offer-tpl-title" className="font-display text-lg font-semibold text-parish-text">
              {c.offerTemplateTitle}
            </h2>
            <p className="mt-2 text-sm text-parish-muted">{c.offerTemplateHint}</p>
            <form action={saveLiturgicalTemplateFromEventForm} className="mt-4 space-y-3">
              <input type="hidden" name="event_id" value={offerTemplateEventId} />
              <label className="block text-xs text-parish-muted">
                {formMsg.templateName}
                <input
                  name="template_name"
                  required
                  className="mt-1 block w-full rounded border border-parish-border px-2 py-2 text-sm"
                  placeholder="…"
                />
              </label>
              <div className="flex flex-wrap gap-2 pt-1">
                <Link
                  href="/admin/calendar"
                  className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
                >
                  {c.offerTemplateSkip}
                </Link>
                <button
                  type="submit"
                  className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
                >
                  {c.offerTemplateSave}
                </button>
              </div>
            </form>
          </div>
        </div>
      ) : null}

      {editingTemplate ? (
        <TemplateEditDialog
          lang={lang}
          template={editingTemplate}
          screen={{
            title: c.editTemplateTitle,
            save: c.editTemplateSave,
            closeAria: c.closeAria,
          }}
          onClose={() => setEditingTemplate(null)}
        />
      ) : null}
    </div>
  );
}
