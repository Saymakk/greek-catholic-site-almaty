"use client";

import {
  addDays,
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
import { enUS, ru, uk } from "date-fns/locale";
import { useEffect, useMemo, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView } from "@/lib/data";
import { LiturgicalEventModal } from "./LiturgicalEventModal";
import { SiteLoadingSpinner } from "./SiteLoadingSpinner";

type Props = {
  lang: Lang;
  initialEvents: LiturgicalEventView[];
  /** ISO string — Date не сериализуется в RSC → клиент */
  initialMonthIso: string;
  /** Внутри модального окна — без обёртки section и заголовка страницы */
  embedded?: boolean;
};

function dateFnsLocale(siteLang: Lang) {
  if (siteLang === "uk") return uk;
  if (siteLang === "en") return enUS;
  return ru;
}

export function LiturgicalCalendar({
  lang,
  initialEvents,
  initialMonthIso,
  embedded = false,
}: Props) {
  const [month, setMonth] = useState(() => new Date(initialMonthIso));
  const [events, setEvents] = useState<LiturgicalEventView[]>(initialEvents);
  const [modal, setModal] = useState<LiturgicalEventView | null>(null);
  const [rangeLoading, setRangeLoading] = useState(false);
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

      {modal ? <LiturgicalEventModal lang={lang} event={modal} onClose={() => setModal(null)} /> : null}
    </>
  );
}
