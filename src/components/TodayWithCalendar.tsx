"use client";

import { useEffect, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { formatSidebarTodayDate } from "@/lib/format-sidebar-date";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView } from "@/lib/data";
import { LiturgicalCalendar } from "./LiturgicalCalendar";
import { LiturgicalEventModal } from "./LiturgicalEventModal";
import { PaginationControls } from "./PaginationControls";
import { SiteLoadingSpinner } from "./SiteLoadingSpinner";
import { stripTagsForPreview } from "./RichOrPlain";

const PAGE_SIZE = 10;
const PREVIEW_LEN = 200;

function previewBlock(e: LiturgicalEventView): string {
  const a = stripTagsForPreview(e.explanation).trim();
  const b = stripTagsForPreview(e.prayer ?? "").trim();
  const body = [a, b].filter(Boolean).join("\n\n");
  const base = body.length ? body : e.title;
  const truncated = base.length > PREVIEW_LEN;
  return truncated ? `${base.slice(0, PREVIEW_LEN)}…` : base;
}

export function TodayWithCalendar({
  lang,
  events: initialTodayEvents,
  todayDateStr,
  todayTotal,
  initialEvents,
  initialMonthIso,
  variant = "default",
}: {
  lang: Lang;
  events: LiturgicalEventView[];
  todayDateStr: string;
  todayTotal: number;
  initialEvents: LiturgicalEventView[];
  initialMonthIso: string;
  variant?: "default" | "sidebar";
}) {
  const [calendarOpen, setCalendarOpen] = useState(false);
  const [page, setPage] = useState(1);
  const [events, setEvents] = useState<LiturgicalEventView[]>(initialTodayEvents);
  const [listLoading, setListLoading] = useState(false);
  const [detailEvent, setDetailEvent] = useState<LiturgicalEventView | null>(null);
  const isSidebar = variant === "sidebar";

  const totalPages = Math.max(1, Math.ceil(todayTotal / PAGE_SIZE));

  useEffect(() => {
    if (page !== 1) return;
    setEvents(initialTodayEvents);
  }, [page, initialTodayEvents]);

  useEffect(() => {
    if (page === 1) return;
    let cancelled = false;
    async function run() {
      setListLoading(true);
      try {
        const res = await fetch(
          `/api/liturgical/today?date=${encodeURIComponent(todayDateStr)}&page=${page}&lang=${lang}`,
        );
        const data = (await res.json()) as { events?: LiturgicalEventView[] };
        if (cancelled) return;
        setEvents(Array.isArray(data.events) ? data.events : []);
      } finally {
        if (!cancelled) setListLoading(false);
      }
    }
    void run();
    return () => {
      cancelled = true;
    };
  }, [page, todayDateStr, lang]);

  useEffect(() => {
    setPage(1);
  }, [todayDateStr, lang]);

  return (
    <div id="today" className="scroll-mt-24">
      <div
        className={
          isSidebar
            ? "rounded-2xl border border-parish-border bg-gradient-to-br from-parish-surface to-parish-accent-soft/60 px-4 py-5 shadow-sm lg:px-4 lg:py-5"
            : "rounded-2xl border border-parish-border bg-gradient-to-br from-parish-surface to-parish-accent-soft/60 px-6 py-8 shadow-sm"
        }
      >
        <div
          className={
            isSidebar
              ? "flex flex-col gap-3"
              : "flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between"
          }
        >
          <h2
            className={
              isSidebar
                ? "font-display text-lg font-semibold leading-tight text-parish-text lg:text-xl"
                : "font-display text-2xl font-semibold text-parish-text"
            }
          >
            {t(lang, "todayFeast")}
          </h2>
          <button
            type="button"
            onClick={() => setCalendarOpen(true)}
            aria-label={t(lang, "openCalendar")}
            className={
              isSidebar
                ? "w-full shrink-0 rounded-xl border border-parish-border bg-parish-surface px-3 py-2 text-xs font-semibold text-parish-accent shadow-sm transition hover:bg-parish-accent-soft sm:text-sm"
                : "shrink-0 rounded-xl border border-parish-border bg-parish-surface px-4 py-2.5 text-sm font-semibold text-parish-accent shadow-sm transition hover:bg-parish-accent-soft"
            }
          >
            {formatSidebarTodayDate(lang, todayDateStr)}
          </button>
        </div>

        {listLoading ? (
          <div className="mt-4 flex justify-center py-6" aria-busy>
            <SiteLoadingSpinner />
          </div>
        ) : !events.length ? (
          <p
            className={
              isSidebar
                ? "mt-3 text-xs font-medium leading-snug text-parish-muted"
                : "mt-4 text-sm font-medium text-parish-muted"
            }
          >
            {t(lang, "noFeast")}
          </p>
        ) : (
          <ul className={isSidebar ? "mt-3 space-y-4" : "mt-4 space-y-6"}>
            {events.map((e) => {
              const previewText = previewBlock(e);
              return (
                <li key={e.id}>
                  <div
                    className={
                      isSidebar
                        ? "flex gap-3"
                        : "flex flex-col gap-3 sm:flex-row sm:items-start sm:gap-4"
                    }
                  >
                    {e.coverImageUrl ? (
                      <div
                        className={
                          isSidebar
                            ? "h-20 w-14 shrink-0 overflow-hidden rounded-md bg-parish-surface shadow-sm"
                            : "mx-auto h-28 w-20 shrink-0 overflow-hidden rounded-md bg-parish-surface shadow-sm sm:mx-0 sm:h-32 sm:w-[5.5rem]"
                        }
                      >
                        {/* eslint-disable-next-line @next/next/no-img-element */}
                        <img
                          src={e.coverImageUrl}
                          alt=""
                          className="h-full w-full object-cover"
                        />
                      </div>
                    ) : null}
                    <div className="min-w-0 flex-1">
                      <p
                        className={
                          isSidebar
                            ? "text-sm font-semibold leading-snug text-parish-text"
                            : "font-semibold text-parish-text"
                        }
                      >
                        {e.title}
                      </p>
                      <p
                        className={
                          isSidebar
                            ? "mt-2 whitespace-pre-wrap text-xs font-medium leading-relaxed text-parish-muted"
                            : "mt-2 whitespace-pre-wrap text-sm font-medium leading-relaxed text-parish-muted"
                        }
                      >
                        {previewText}
                      </p>
                      <button
                        type="button"
                        onClick={() => setDetailEvent(e)}
                        className={
                          isSidebar
                            ? "mt-2 text-xs font-semibold text-parish-accent hover:underline"
                            : "mt-3 text-sm font-semibold text-parish-accent hover:underline"
                        }
                      >
                        {t(lang, "moreDetails")}
                      </button>
                    </div>
                  </div>
                </li>
              );
            })}
          </ul>
        )}

        {!listLoading && todayTotal > 0 ? (
          <PaginationControls
            lang={lang}
            page={Math.min(page, totalPages)}
            totalPages={totalPages}
            totalItems={todayTotal}
            pageSize={PAGE_SIZE}
            onPageChange={setPage}
          />
        ) : null}
      </div>

      {calendarOpen ? (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-parish-text/30 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-labelledby="calendar-modal-title"
          onClick={() => setCalendarOpen(false)}
        >
          <div
            className="flex max-h-[92vh] w-full max-w-[min(96rem,calc(100vw-2rem))] flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-xl"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex shrink-0 items-start justify-between gap-4 border-b border-parish-border px-5 py-4 sm:px-8 sm:py-5">
              <h2
                id="calendar-modal-title"
                className="font-display text-xl font-semibold text-parish-text sm:text-2xl"
              >
                {t(lang, "calendarTitle")}
              </h2>
              <button
                type="button"
                onClick={() => setCalendarOpen(false)}
                className="rounded-lg border border-parish-border px-3 py-1 text-sm font-semibold text-parish-muted hover:bg-parish-accent-soft hover:text-parish-accent"
              >
                {t(lang, "closeModal")}
              </button>
            </div>
            <div className="min-h-0 flex-1 overflow-y-auto overscroll-contain px-5 pb-5 pt-3 sm:px-8 sm:pb-8 sm:pt-4">
              <p className="mb-4 text-sm font-medium text-parish-muted">{t(lang, "calendarHint")}</p>
              <LiturgicalCalendar
                lang={lang}
                embedded
                initialEvents={initialEvents}
                initialMonthIso={initialMonthIso}
              />
            </div>
          </div>
        </div>
      ) : null}

      {detailEvent ? (
        <LiturgicalEventModal lang={lang} event={detailEvent} onClose={() => setDetailEvent(null)} />
      ) : null}
    </div>
  );
}
