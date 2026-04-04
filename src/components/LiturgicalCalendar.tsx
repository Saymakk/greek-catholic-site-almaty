"use client";

import {
  addMonths,
  eachDayOfInterval,
  endOfMonth,
  endOfWeek,
  format,
  isSameMonth,
  isToday,
  startOfMonth,
  startOfWeek,
  subMonths,
} from "date-fns";
import { ru } from "date-fns/locale";
import { useEffect, useMemo, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView } from "@/lib/data";
import { RichOrPlain } from "./RichOrPlain";

type Props = {
  lang: Lang;
  initialEvents: LiturgicalEventView[];
  /** ISO string — Date не сериализуется в RSC → клиент */
  initialMonthIso: string;
  /** Внутри модального окна — без обёртки section и заголовка страницы */
  embedded?: boolean;
};

export function LiturgicalCalendar({
  lang,
  initialEvents,
  initialMonthIso,
  embedded = false,
}: Props) {
  const [month, setMonth] = useState(() => new Date(initialMonthIso));
  const [events, setEvents] = useState<LiturgicalEventView[]>(initialEvents);
  const [modal, setModal] = useState<LiturgicalEventView | null>(null);
  const skipInitialFetch = useRef(!!embedded);

  const gridStart = startOfWeek(startOfMonth(month), { weekStartsOn: 1 });
  const gridEnd = endOfWeek(endOfMonth(month), { weekStartsOn: 1 });
  const days = eachDayOfInterval({ start: gridStart, end: gridEnd });

  const byDate = useMemo(() => {
    const m = new Map<string, LiturgicalEventView[]>();
    for (const e of events) {
      const k = e.event_date;
      if (!m.has(k)) m.set(k, []);
      m.get(k)!.push(e);
    }
    return m;
  }, [events]);

  const gridStartKey = format(gridStart, "yyyy-MM-dd");
  const gridEndKey = format(gridEnd, "yyyy-MM-dd");

  useEffect(() => {
    if (skipInitialFetch.current) {
      skipInitialFetch.current = false;
      return;
    }
    let cancelled = false;
    async function run() {
      const res = await fetch(
        `/api/liturgical?start=${gridStartKey}&end=${gridEndKey}&lang=${lang}`,
      );
      const data = (await res.json()) as LiturgicalEventView[];
      if (cancelled) return;
      const next = Array.isArray(data) ? data : [];
      setEvents((prev) =>
        JSON.stringify(prev) === JSON.stringify(next) ? prev : next,
      );
    }
    void run();
    return () => {
      cancelled = true;
    };
  }, [gridStartKey, gridEndKey, lang]);

  const locale = lang === "ru" ? ru : undefined;

  const inner = (
    <>
      {!embedded ? (
        <>
          <h2 className="font-display text-2xl font-semibold text-parish-text">
            {t(lang, "calendarTitle")}
          </h2>
          <p className="mt-2 text-sm font-medium text-parish-muted">
            {t(lang, "calendarHint")}
          </p>
        </>
      ) : null}
      <div className={`${embedded ? "mt-0" : "mt-6"} flex items-center justify-between gap-4`}>
        <button
          type="button"
          onClick={() => setMonth(subMonths(month, 1))}
          className="rounded-lg border border-parish-border px-3 py-1 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
          aria-label="Previous month"
        >
          ←
        </button>
        <span className="font-display text-lg font-semibold capitalize text-parish-text">
          {format(month, "LLLL yyyy", { locale })}
        </span>
        <button
          type="button"
          onClick={() => setMonth(addMonths(month, 1))}
          className="rounded-lg border border-parish-border px-3 py-1 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
          aria-label="Next month"
        >
          →
        </button>
      </div>
      <div className="mt-4 min-h-[22rem]">
        <div className="grid grid-cols-7 gap-1 text-center text-xs font-semibold text-parish-muted sm:gap-2 sm:text-sm">
          {["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"].map((d) => (
            <div key={d} className="py-2">
              {d}
            </div>
          ))}
          {days.map((day) => {
            const key = format(day, "yyyy-MM-dd");
            const list = byDate.get(key) ?? [];
            const muted = !isSameMonth(day, month);
            return (
              <button
                key={key}
                type="button"
                onClick={() => {
                  if (list[0]) setModal(list[0]);
                }}
                className={[
                  "min-h-[4.5rem] rounded-xl border p-1 text-left align-top transition sm:min-h-[5.5rem] sm:p-2",
                  muted ? "border-transparent bg-transparent opacity-40" : "border-parish-border/60 bg-parish-surface",
                  isToday(day) ? "ring-2 ring-parish-accent/30" : "",
                  list.length ? "cursor-pointer hover:border-parish-accent" : "cursor-default",
                ].join(" ")}
              >
                <span className="block text-xs font-semibold text-parish-muted">{format(day, "d")}</span>
                <ul className="mt-1 space-y-0.5">
                  {list.slice(0, 3).map((ev) => (
                    <li
                      key={ev.id}
                      className="truncate rounded bg-parish-accent-soft px-1 py-0.5 text-[10px] font-semibold text-parish-accent sm:text-xs"
                      onClick={(e) => {
                        e.stopPropagation();
                        setModal(ev);
                      }}
                    >
                      {ev.title}
                    </li>
                  ))}
                </ul>
              </button>
            );
          })}
        </div>
      </div>
    </>
  );

  return (
    <>
      {embedded ? (
        <div>{inner}</div>
      ) : (
        <section id="calendar" className="scroll-mt-24">
          {inner}
        </section>
      )}

      {modal ? (
        <div
          className="fixed inset-0 z-[100] flex items-center justify-center bg-parish-text/25 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          onClick={() => setModal(null)}
        >
          <div
            className="max-h-[85vh] w-full max-w-2xl overflow-y-auto rounded-2xl border border-parish-border bg-parish-surface p-6 shadow-xl"
            onClick={(e) => e.stopPropagation()}
          >
            <h3 className="font-display text-xl font-semibold text-parish-text">{modal.title}</h3>
            <p className="mt-1 text-xs font-semibold uppercase tracking-wide text-parish-muted">
              {modal.kind.replace(/_/g, " ")}
            </p>
            <RichOrPlain
              content={modal.explanation}
              className="rich-html mt-4 max-w-none text-sm font-medium leading-relaxed text-parish-text"
            />
            {modal.prayer ? (
              <div className="mt-6 rounded-xl bg-parish-accent-soft/80 p-4">
                <p className="text-xs font-bold uppercase tracking-wide text-parish-muted">
                  {t(lang, "prayer")}
                </p>
                <RichOrPlain
                  content={modal.prayer}
                  className="rich-html mt-2 max-w-none text-sm font-medium leading-relaxed text-parish-text"
                />
              </div>
            ) : null}
            <button
              type="button"
              className="mt-6 w-full rounded-lg border border-parish-border py-2 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
              onClick={() => setModal(null)}
            >
              OK
            </button>
          </div>
        </div>
      ) : null}
    </>
  );
}
