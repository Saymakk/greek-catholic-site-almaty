import Link from "next/link";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

function buildAdminActivityQuery(page: number, perPage: number): string {
  const q = new URLSearchParams();
  if (page > 1) q.set("page", String(page));
  if (perPage !== 20) q.set("per", String(perPage));
  const s = q.toString();
  return s ? `?${s}` : "";
}

const btn =
  "inline-flex min-h-11 items-center justify-center rounded-lg border border-parish-border px-3 py-2 text-parish-accent transition hover:bg-parish-accent-soft sm:min-h-0 sm:py-1.5";
const btnDisabled = "inline-flex min-h-11 cursor-not-allowed items-center justify-center rounded-lg border border-parish-border px-3 py-2 opacity-40 sm:min-h-0 sm:py-1.5";

export function AdminActivityPagination({
  lang,
  page,
  perPage,
  total,
}: {
  lang: Lang;
  page: number;
  perPage: number;
  total: number;
}) {
  const totalPages = Math.max(1, Math.ceil(total / perPage));
  if (total === 0 || totalPages <= 1) return null;

  const label = t(lang, "paginationPageOf")
    .replace("{n}", String(page))
    .replace("{m}", String(totalPages));
  const from = (page - 1) * perPage + 1;
  const to = Math.min(page * perPage, total);

  return (
    <nav
      className="flex flex-wrap items-center gap-3 text-sm font-semibold"
      aria-label="Pagination"
    >
      {page > 1 ? (
        <Link href={`/admin${buildAdminActivityQuery(page - 1, perPage)}`} className={btn}>
          {t(lang, "paginationPrev")}
        </Link>
      ) : (
        <span className={btnDisabled}>{t(lang, "paginationPrev")}</span>
      )}
      <span className="text-parish-muted">{label}</span>
      {page < totalPages ? (
        <Link href={`/admin${buildAdminActivityQuery(page + 1, perPage)}`} className={btn}>
          {t(lang, "paginationNext")}
        </Link>
      ) : (
        <span className={btnDisabled}>{t(lang, "paginationNext")}</span>
      )}
      <span className="w-full text-center text-xs font-medium text-parish-muted/90 sm:w-auto">
        {from}–{to} / {total}
      </span>
    </nav>
  );
}
