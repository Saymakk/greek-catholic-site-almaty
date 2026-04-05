"use client";

import { useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

function FilterIcon({ className }: { className?: string }) {
  return (
    <svg
      className={className}
      width="18"
      height="18"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden
    >
      <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" />
    </svg>
  );
}

export function LibraryFiltersToggle({
  lang,
  q,
  from,
  to,
  sort,
}: {
  lang: Lang;
  q: string;
  from: string;
  to: string;
  sort: string;
}) {
  const [open, setOpen] = useState(false);

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className={`inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-xl border shadow-sm transition ${
          open
            ? "border-parish-accent bg-parish-accent-soft text-parish-accent"
            : "border-parish-border bg-parish-surface text-parish-muted hover:border-parish-accent/50 hover:text-parish-accent"
        }`}
        aria-expanded={open}
        aria-label={t(lang, "libraryFiltersToggleAria")}
        title={t(lang, "libraryFiltersToggleAria")}
      >
        <FilterIcon />
      </button>
      {open ? (
        <div className="mt-4 w-full basis-full rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm">
          <form
            method="get"
            aria-label={t(lang, "libraryFiltersSection")}
            className="flex flex-col gap-4 sm:flex-row sm:flex-wrap sm:items-end"
          >
            <label className="flex min-w-[12rem] flex-1 flex-col gap-1 text-xs font-semibold text-parish-muted">
              {t(lang, "libraryFilterKeyword")}
              <input
                name="q"
                defaultValue={q}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-text"
                placeholder="…"
              />
            </label>
            <label className="flex flex-col gap-1 text-xs font-semibold text-parish-muted">
              {t(lang, "libraryFilterFrom")}
              <input
                type="date"
                name="from"
                defaultValue={from}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-text"
              />
            </label>
            <label className="flex flex-col gap-1 text-xs font-semibold text-parish-muted">
              {t(lang, "libraryFilterTo")}
              <input
                type="date"
                name="to"
                defaultValue={to}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-text"
              />
            </label>
            <label className="flex flex-col gap-1 text-xs font-semibold text-parish-muted">
              {t(lang, "librarySortLabel")}
              <select
                name="sort"
                defaultValue={sort}
                className="rounded-lg border border-parish-border px-3 py-2 text-sm font-medium text-parish-text"
              >
                <option value="date">{t(lang, "librarySortDate")}</option>
                <option value="alpha">{t(lang, "librarySortAlpha")}</option>
              </select>
            </label>
            <button
              type="submit"
              className="rounded-lg bg-parish-accent px-4 py-2 text-sm font-semibold text-white hover:opacity-90"
            >
              {t(lang, "librarySubmit")}
            </button>
          </form>
        </div>
      ) : null}
    </>
  );
}
