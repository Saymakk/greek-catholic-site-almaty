"use client";

import { useEffect, useRef, useState } from "react";
import { format, parseISO } from "date-fns";
import type { Lang } from "@/lib/i18n";
import { pickLiturgicalI18nRow } from "@/lib/content-lang-chain";
import { deleteLiturgicalEventForm } from "../actions/calendar";
import { CalendarEventEditForm } from "./CalendarEventEditForm";
import type { CalendarLocaleFields } from "./calendar-entity-locales";
import { normalizeCalendarLocales } from "./calendar-entity-locales";

const KIND_LABEL: Record<string, string> = {
  great_feast: "Великий праздник",
  feast: "Праздник",
  sunday: "Воскресенье",
  fast: "Пост",
  commemoration: "Память",
  other: "Другое",
};

export type AdminCalendarPayload = {
  id: string;
  event_date: string;
  kind: string;
  sort_order: number;
  primary_lang: string | null;
  cover_image_url: string | null;
  locales: CalendarLocaleFields[];
};

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

const emptyEvent = (): AdminCalendarPayload => ({
  id: "",
  event_date: todayIso(),
  kind: "feast",
  sort_order: 0,
  primary_lang: "ru",
  cover_image_url: null,
  locales: normalizeCalendarLocales([], "ru"),
});

export function AdminCalendarClient({
  lang,
  items,
  initialEventId,
}: {
  lang: Lang;
  items: AdminCalendarPayload[];
  initialEventId: string | null;
}) {
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [active, setActive] = useState<AdminCalendarPayload | null>(null);

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

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <h1 className="font-display text-2xl text-parish-text">Календарь</h1>
        <button
          type="button"
          onClick={openAdd}
          className="shrink-0 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          Добавить
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
                <div className="h-20 w-14 shrink-0 overflow-hidden rounded-md border border-parish-border bg-parish-muted/20">
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
                    {format(parseISO(e.event_date), "dd.MM.yyyy")} ·{" "}
                    {KIND_LABEL[e.kind] ?? e.kind}
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
                  Редактировать
                </button>
                <form
                  action={deleteLiturgicalEventForm}
                  onSubmit={(ev) => {
                    if (!confirm("Удалить это событие?")) ev.preventDefault();
                  }}
                >
                  <input type="hidden" name="id" value={e.id} />
                  <button
                    type="submit"
                    className="w-full rounded-lg px-3 py-2 text-center text-sm text-red-600 hover:bg-red-50"
                  >
                    Удалить
                  </button>
                </form>
              </div>
            </div>
          </li>
        ))}
      </ul>

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {active && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="min-w-0 flex-1 font-display text-lg font-semibold text-parish-text sm:text-xl">
                {mode === "add" ? "Новое событие" : "Редактирование события"}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label="Закрыть"
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <CalendarEventEditForm
              key={mode === "add" ? "new-cal" : active.id}
              eventId={active.id}
              eventDate={active.event_date}
              kind={active.kind}
              sortOrder={active.sort_order}
              primaryLang={active.primary_lang}
              coverImageUrl={active.cover_image_url}
              locales={active.locales}
              submitLabel={mode === "add" ? "Добавить" : "Сохранить"}
              onCancel={closeDialog}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
