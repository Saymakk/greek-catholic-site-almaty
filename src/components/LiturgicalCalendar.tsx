"use client";

import {
  addDays,
  addMonths,
  eachDayOfInterval,
  endOfMonth,
  endOfWeek,
  format,
  startOfMonth,
  startOfWeek,
  subMonths,
} from "date-fns";
import { formatInTimeZone, toZonedTime } from "date-fns-tz";
import { enUS, ru, uk } from "date-fns/locale";
import { useEffect, useMemo, useRef, useState, useSyncExternalStore } from "react";
import type { Lang } from "@/lib/i18n";
import { getSiteTimeZone } from "@/lib/site-timezone";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView } from "@/lib/data";
import { LiturgicalEventModal } from "./LiturgicalEventModal";
import { SiteLoadingSpinner } from "./SiteLoadingSpinner";

type Props = {
  lang: Lang;
  initialEvents: LiturgicalEventView[];
  /** Внутри модального окна — без обёртки section и заголовка страницы */
  embedded?: boolean;
};

function dateFnsLocale(siteLang: Lang) {
  if (siteLang === "uk") return uk;
  if (siteLang === "en") return enUS;
  return ru;
}

function subscribeMaxSm(cb: () => void) {
  if (typeof window === "undefined") return () => {};
  const mq = window.matchMedia("(max-width: 639px)");
  mq.addEventListener("change", cb);
  return () => mq.removeEventListener("change", cb);
}

function getMaxSmSnapshot() {
  if (typeof window === "undefined") return false;
  return window.matchMedia("(max-width: 639px)").matches;
}

function useMaxSmScreen() {
  return useSyncExternalStore(subscribeMaxSm, getMaxSmSnapshot, () => false);
}

export function LiturgicalCalendar({
  lang,
  initialEvents,
  embedded = false,
}: Props) {
  const tz = getSiteTimeZone();
  const [month, setMonth] = useState(() => startOfMonth(toZonedTime(new Date(), tz)));
  const [events, setEvents] = useState<LiturgicalEventView[]>(initialEvents);
  const [modal, setModal] = useState<LiturgicalEventView | null>(null);
  const [daySheet, setDaySheet] = useState<{ day: Date; events: LiturgicalEventView[] } | null>(null);
  const [rangeLoading, setRangeLoading] = useState(false);
  const skipInitialFetch = useRef(!!embedded);
  const isMaxSm = useMaxSmScreen();

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

  const gridStartKey = formatInTimeZone(gridStart, tz, "yyyy-MM-dd");
  const gridEndKey = formatInTimeZone(gridEnd, tz, "yyyy-MM-dd");
  const todayKey = formatInTimeZone(new Date(), tz, "yyyy-MM-dd");

  const dfLocale = dateFnsLocale(lang);
  const mondayRef = startOfWeek(new Date(2024, 0, 1), { weekStartsOn: 1 });
  const weekdayLabels = useMemo(
    () =>
      Array.from({ length: 7 }, (_, i) => format(addDays(mondayRef, i), "EEE", { locale: dfLocale })),
    [dfLocale],
  );

  useEffect(() => {
    if (skipInitialFetch.current) {
      skipInitialFetch.current = false;
      return;
    }
    let cancelled = false;
    async function run() {
      setRangeLoading(true);
      try {
        const res = await fetch(
          `/api/liturgical?start=${gridStartKey}&end=${gridEndKey}&lang=${lang}`,
        );
        const data = (await res.json()) as LiturgicalEventView[];
        if (cancelled) return;
        const next = Array.isArray(data) ? data : [];
        setEvents((prev) =>
          JSON.stringify(prev) === JSON.stringify(next) ? prev : next,
        );
      } finally {
        if (!cancelled) setRangeLoading(false);
      }
    }
    void run();
    return () => {
      cancelled = true;
    };
  }, [gridStartKey, gridEndKey, lang]);

  useEffect(() => {
    if (!daySheet) return;
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") {
        e.preventDefault();
        setDaySheet(null);
      }
    }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [daySheet]);

  const inner = (
    <>
      {!embedded ? (
        <>
          <h2 className="font-display text-2xl font-semibold text-parish-text">
            {t(lang, "calendarTitle")}
          </h2>
          <p className="mt-2 text-sm font-medium text-parish-muted">{t(lang, "calendarHint")}</p>
        </>
      ) : null}
      <div className={`${embedded ? "mt-0" : "mt-6"} flex items-center justify-between gap-4`}>
        <button
          type="button"
          onClick={() => setMonth(subMonths(month, 1))}
          className="rounded-lg border border-parish-border px-3 py-1 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
          aria-label={t(lang, "calendarPrevMonth")}
        >
          ←
        </button>
        <span className="font-display text-lg font-semibold capitalize text-parish-text">
          {format(month, "LLLL yyyy", { locale: dfLocale })}
        </span>
        <button
          type="button"
          onClick={() => setMonth(addMonths(month, 1))}
          className="rounded-lg border border-parish-border px-3 py-1 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
          aria-label={t(lang, "calendarNextMonth")}
        >
          →
        </button>
      </div>
      <div className="relative mt-4 min-h-[22rem]">
        {rangeLoading ? (
          <div
            className="absolute inset-0 z-10 flex items-center justify-center rounded-xl bg-parish-surface/80 backdrop-blur-[2px]"
            aria-busy
          >
            <SiteLoadingSpinner />
          </div>
        ) : null}
        <div className="grid grid-cols-7 gap-1 text-center text-xs font-semibold text-parish-muted sm:gap-2 sm:text-sm">
          {weekdayLabels.map((d, i) => (
            <div key={i} className="py-2">
              {d}
            </div>
          ))}
          {days.map((day) => {
            const key = formatInTimeZone(day, tz, "yyyy-MM-dd");
            const list = byDate.get(key) ?? [];
            const muted =
              formatInTimeZone(day, tz, "yyyy-MM") !== formatInTimeZone(month, tz, "yyyy-MM");
            return (
              <div
                key={key}
                role={list.length ? "button" : undefined}
                tabIndex={list.length ? 0 : undefined}
                className={[
                  "min-h-[4.5rem] rounded-xl border p-1 text-left align-top transition sm:min-h-[5.5rem] sm:p-2",
                  muted ? "border-transparent bg-transparent opacity-40" : "border-parish-border/60 bg-parish-surface",
                  key === todayKey ? "ring-2 ring-parish-accent/30" : "",
                  list.length ? "cursor-pointer hover:border-parish-accent/80" : "cursor-default",
                ].join(" ")}
                onClick={() => {
                  if (!list[0]) return;
                  if (isMaxSm && list.length > 1) {
                    setDaySheet({ day, events: list });
                    return;
                  }
                  setModal(list[0]);
                }}
                onKeyDown={(e) => {
                  if (!list.length) return;
                  if (e.key === "Enter" || e.key === " ") {
                    e.preventDefault();
                    if (!list[0]) return;
                    if (isMaxSm && list.length > 1) {
                      setDaySheet({ day, events: list });
                      return;
                    }
                    setModal(list[0]);
                  }
                }}
              >
                <span className="block text-xs font-semibold text-parish-muted">{format(day, "d")}</span>
                <ul className="mt-1 list-none space-y-0.5">
                  {list.slice(0, 3).map((ev) => (
                    <li key={ev.id}>
                      <button
                        type="button"
                        className="w-full truncate rounded border border-transparent bg-parish-accent-soft px-1 py-0.5 text-left text-[10px] font-semibold text-parish-accent transition hover:border-parish-accent/50 hover:bg-parish-accent/25 hover:text-parish-text hover:shadow-sm focus:outline-none focus-visible:ring-2 focus-visible:ring-parish-accent/50 sm:text-xs"
                        onClick={(e) => {
                          e.stopPropagation();
                          if (isMaxSm && list.length > 1) {
                            setDaySheet({ day, events: list });
                            return;
                          }
                          setModal(ev);
                        }}
                      >
                        {ev.title}
                      </button>
                    </li>
                  ))}
                </ul>
              </div>
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

      {daySheet ? (
        <div
          className="fixed inset-0 z-[90] flex items-end justify-center bg-parish-text/40 p-0 backdrop-blur-sm sm:items-center sm:p-4"
          role="dialog"
          aria-modal
          aria-labelledby="cal-day-events-title"
          onClick={() => setDaySheet(null)}
        >
          <div
            className="flex max-h-[min(88dvh,100%)] w-full max-w-lg flex-col overflow-hidden rounded-t-2xl border border-parish-border border-b-0 bg-parish-surface shadow-xl sm:max-h-[min(85dvh,100%)] sm:rounded-2xl sm:border-b"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 pt-[max(0.75rem,env(safe-area-inset-top))] sm:pt-3">
              <div className="min-w-0">
                <h2
                  id="cal-day-events-title"
                  className="font-display text-lg font-semibold capitalize text-parish-text sm:text-xl"
                >
                  {format(daySheet.day, "EEEE, d MMMM yyyy", { locale: dfLocale })}
                </h2>
                <p className="mt-1 text-sm font-medium text-parish-muted">{t(lang, "calendarDayChooseEvent")}</p>
              </div>
              <button
                type="button"
                className="flex h-11 w-11 shrink-0 touch-manipulation items-center justify-center rounded-lg text-parish-muted transition hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label={t(lang, "closeModal")}
                onClick={() => setDaySheet(null)}
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <ul className="min-h-0 flex-1 list-none space-y-2 overflow-y-auto overscroll-contain px-4 pb-[max(1rem,env(safe-area-inset-bottom))] pt-3 sm:px-5 sm:pb-5">
              {daySheet.events.map((ev) => (
                <li key={ev.id}>
                  <button
                    type="button"
                    className="w-full rounded-xl border border-parish-border/70 bg-parish-bg/30 px-4 py-3 text-left transition hover:border-parish-accent/50 hover:bg-parish-accent-soft focus:outline-none focus-visible:ring-2 focus-visible:ring-parish-accent/50"
                    onClick={() => {
                      setDaySheet(null);
                      setModal(ev);
                    }}
                  >
                    <span className="block text-sm font-semibold text-parish-text">{ev.title}</span>
                    <span className="mt-1 block text-xs font-medium uppercase tracking-wide text-parish-muted">
                      {ev.kindLabel}
                    </span>
                  </button>
                </li>
              ))}
            </ul>
          </div>
        </div>
      ) : null}

      {modal ? <LiturgicalEventModal lang={lang} event={modal} onClose={() => setModal(null)} /> : null}
    </>
  );
}
