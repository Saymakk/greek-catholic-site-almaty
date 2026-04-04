"use client";

import { useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { LiturgicalEventView } from "@/lib/data";
import { LiturgicalCalendar } from "./LiturgicalCalendar";
import { RichOrPlain } from "./RichOrPlain";

export function TodayWithCalendar({
  lang,
  events,
  initialEvents,
  initialMonthIso,
  variant = "default",
}: {
  lang: Lang;
  events: LiturgicalEventView[];
  initialEvents: LiturgicalEventView[];
  initialMonthIso: string;
  variant?: "default" | "sidebar";
}) {
  const [calendarOpen, setCalendarOpen] = useState(false);
  const isSidebar = variant === "sidebar";

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
            className={
              isSidebar
                ? "w-full shrink-0 rounded-xl border border-parish-border bg-parish-surface px-3 py-2 text-xs font-semibold text-parish-accent shadow-sm transition hover:bg-parish-accent-soft sm:text-sm"
                : "shrink-0 rounded-xl border border-parish-border bg-parish-surface px-4 py-2.5 text-sm font-semibold text-parish-accent shadow-sm transition hover:bg-parish-accent-soft"
            }
          >
            {t(lang, "openCalendar")}
          </button>
        </div>

        {!events.length ? (
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
            {events.map((e) => (
              <li key={e.id}>
                <div
                  className={
                    isSidebar
                      ? "flex gap-3"
                      : "flex flex-col gap-3 sm:flex-row sm:items-start sm:gap-4"
                  }
                >
                  {e.coverImageUrl ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={e.coverImageUrl}
                      alt=""
                      className={
                        isSidebar
                          ? "h-20 w-14 shrink-0 rounded-md object-cover shadow-sm"
                          : "mx-auto h-28 w-20 shrink-0 rounded-md object-cover shadow-sm sm:mx-0 sm:h-32 sm:w-[5.5rem]"
                      }
                    />
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
                    {e.prayer ? (
                      <div
                        className={
                          isSidebar
                            ? "mt-2 rounded-lg bg-parish-surface/80 p-3 text-xs font-medium leading-relaxed text-parish-text"
                            : "mt-3 rounded-xl bg-parish-surface/80 p-4 text-sm font-medium leading-relaxed text-parish-text"
                        }
                      >
                        <p
                          className={
                            isSidebar
                              ? "text-[10px] font-bold uppercase tracking-wide text-parish-muted"
                              : "text-xs font-bold uppercase tracking-wide text-parish-muted"
                          }
                        >
                          {t(lang, "prayer")}
                        </p>
                        <RichOrPlain
                          content={e.prayer}
                          className={
                            isSidebar
                              ? "rich-html mt-1 max-w-none leading-relaxed"
                              : "rich-html mt-2 max-w-none text-sm leading-relaxed text-parish-text"
                          }
                        />
                      </div>
                    ) : null}
                  </div>
                </div>
              </li>
            ))}
          </ul>
        )}
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
            className="max-h-[92vh] w-full max-w-[min(96rem,calc(100vw-2rem))] overflow-y-auto rounded-2xl border border-parish-border bg-parish-surface p-5 shadow-xl sm:p-8"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="mb-4 flex items-start justify-between gap-4 border-b border-parish-border pb-4">
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
            <p className="mb-4 text-sm font-medium text-parish-muted">{t(lang, "calendarHint")}</p>
            <LiturgicalCalendar
              lang={lang}
              embedded
              initialEvents={initialEvents}
              initialMonthIso={initialMonthIso}
            />
          </div>
        </div>
      ) : null}
    </div>
  );
}
