"use client";

import { useMemo, useState, useTransition } from "react";
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

const KINDS = [
  ["great_feast", "Великий праздник"],
  ["feast", "Праздник"],
  ["sunday", "Воскресенье"],
  ["fast", "Пост"],
  ["commemoration", "Память"],
  ["other", "Другое"],
] as const;

function editionTitle(code: string) {
  return code.toUpperCase();
}

export function CalendarEventEditForm({
  eventId,
  eventDate,
  kind: kindInitial,
  sortOrder,
  primaryLang: primaryLangDb,
  coverImageUrl: coverImageUrlProp,
  locales,
  submitLabel,
  onCancel,
}: {
  eventId: string;
  eventDate: string;
  kind: string;
  sortOrder: number;
  primaryLang: string | null;
  coverImageUrl: string | null;
  locales: CalendarLocaleFields[];
  submitLabel: string;
  onCancel?: () => void;
}) {
  const [primaryLang, setPrimaryLang] = useState<ContentLang>(() =>
    primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : "ru",
  );
  const [activeLangs, setActiveLangs] = useState<string[]>(() =>
    sortCalendarLangsForForm(
      locales.map((l) => l.lang),
      primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : "ru",
    ),
  );
  const [coverRemoved, setCoverRemoved] = useState(false);
  const [coverLightboxOpen, setCoverLightboxOpen] = useState(false);
  const [coverPending, startCoverTransition] = useTransition();
  const router = useRouter();

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
    <form action={saveLiturgicalEvent} className="flex min-h-0 min-w-0 flex-1 flex-col">
      <input type="hidden" name="id" value={eventId} />
      <input type="hidden" name="primary_lang" value={primaryLang} />
      <input type="hidden" name="locales" value={activeLangs.join(",")} />
      <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-4 px-4 py-4 sm:px-6">
        <label className="block text-xs text-parish-muted sm:text-sm">
          Язык основной версии
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
          Дата
          <input
            type="date"
            name="event_date"
            required
            defaultValue={eventDate}
            className="mt-1 block w-full max-w-md rounded border border-parish-border px-2 py-1.5 text-sm"
          />
        </label>
        <label className="block text-xs text-parish-muted sm:text-sm">
          Тип
          <select
            name="kind"
            required
            defaultValue={kindInitial}
            className="mt-1 block w-full max-w-md rounded border border-parish-border px-2 py-1.5 text-sm"
          >
            {KINDS.map(([v, label]) => (
              <option key={v} value={v}>
                {label}
              </option>
            ))}
          </select>
        </label>
        <label className="block text-xs text-parish-muted sm:text-sm">
          Порядок в один день (меньше — выше)
          <input
            type="number"
            name="sort_order"
            defaultValue={sortOrder}
            className="mt-1 block w-full max-w-[8rem] rounded border border-parish-border px-2 py-1.5 text-sm"
          />
        </label>
        <div className="rounded-lg border border-parish-border/70 p-3">
          <p className="text-xs font-medium text-parish-muted">Миниатюра события</p>
          {displayCover ? (
            <button
              type="button"
              className="mt-2 block w-full max-w-full rounded-md text-left focus:outline-none focus:ring-2 focus:ring-parish-accent/40"
              onClick={() => setCoverLightboxOpen(true)}
            >
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={displayCover}
                alt=""
                className="max-h-[min(512px,70vh)] max-w-full rounded-md border border-parish-border object-contain cursor-zoom-in"
              />
              <span className="mt-1 block text-[11px] text-parish-muted">
                Нажмите для просмотра в полном размере
              </span>
            </button>
          ) : (
            <p className="mt-2 text-xs text-parish-muted">Нет изображения</p>
          )}
          <label className="mt-2 block text-xs text-parish-muted">
            Загрузить или заменить
            <input
              type="file"
              name="cover"
              accept="image/*"
              className="mt-1 block w-full text-sm text-parish-text"
            />
          </label>
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
              Удалить изображение
            </button>
          ) : null}
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
                    <span className="ml-1 font-normal text-parish-muted">
                      — основная версия
                    </span>
                  ) : null}
                </legend>
                {code !== primaryLang ? (
                  <button
                    type="button"
                    className="text-xs text-red-600 hover:underline"
                    onClick={() => removeLang(code)}
                  >
                    Убрать версию
                  </button>
                ) : null}
              </div>
              <label className="mt-2 block text-xs text-parish-muted">
                Название
                <input
                  name={`title_${code}`}
                  defaultValue={row.title}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 text-sm"
                />
              </label>
              <label className="mt-2 block text-xs text-parish-muted">
                Пояснение (текст или HTML)
                <textarea
                  name={`explanation_${code}`}
                  rows={4}
                  defaultValue={row.explanation}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                />
              </label>
              <label className="mt-2 block text-xs text-parish-muted">
                Молитва (опционально)
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
            <span className="w-full text-xs text-parish-muted">
              Добавить версию на языке:
            </span>
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
            Отмена
          </button>
        ) : null}
        <button
          type="submit"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
        >
          {submitLabel}
        </button>
      </div>

      {coverLightboxOpen && displayCover ? (
        <div
          className="fixed inset-0 z-[200] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-label="Обложка"
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
    </form>
  );
}
