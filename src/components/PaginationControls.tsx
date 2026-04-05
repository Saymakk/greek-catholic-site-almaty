"use client";

import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

export function PaginationControls({
  lang,
  page,
  totalPages,
  totalItems,
  pageSize,
  onPageChange,
}: {
  lang: Lang;
  page: number;
  totalPages: number;
  totalItems: number;
  pageSize: number;
  onPageChange: (next: number) => void;
}) {
  if (totalPages <= 1 || totalItems === 0) return null;
  const label = t(lang, "paginationPageOf")
    .replace("{n}", String(page))
    .replace("{m}", String(totalPages));
  return (
    <nav
      className="mt-6 flex flex-wrap items-center justify-center gap-3 text-sm font-semibold"
      aria-label="Pagination"
    >
      <button
        type="button"
        disabled={page <= 1}
        onClick={() => onPageChange(page - 1)}
        className="rounded-lg border border-parish-border px-3 py-1.5 text-parish-accent transition hover:bg-parish-accent-soft disabled:cursor-not-allowed disabled:opacity-40"
      >
        {t(lang, "paginationPrev")}
      </button>
      <span className="text-parish-muted">{label}</span>
      <button
        type="button"
        disabled={page >= totalPages}
        onClick={() => onPageChange(page + 1)}
        className="rounded-lg border border-parish-border px-3 py-1.5 text-parish-accent transition hover:bg-parish-accent-soft disabled:cursor-not-allowed disabled:opacity-40"
      >
        {t(lang, "paginationNext")}
      </button>
      <span className="w-full text-center text-xs font-medium text-parish-muted/90 sm:w-auto">
        {(page - 1) * pageSize + 1}–{Math.min(page * pageSize, totalItems)} / {totalItems}
      </span>
    </nav>
  );
}
