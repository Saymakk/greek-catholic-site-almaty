import Link from "next/link";
import { getLang } from "@/lib/i18n-server";
import { getScriptureLibraryPage } from "@/lib/data";
import { t } from "@/lib/ui-strings";
import { LibraryBooksGrid } from "@/components/LibraryBooksGrid";
import { LibraryFiltersToggle } from "@/components/LibraryFiltersToggle";

const GRID_PAGE = 21;

export default async function LibraryPage({
  searchParams,
}: {
  searchParams: Promise<{
    page?: string;
    sort?: string;
    q?: string;
    from?: string;
    to?: string;
  }>;
}) {
  const lang = await getLang();
  const sp = await searchParams;
  const page = Math.max(1, Number(sp.page) || 1);
  const sort = sp.sort === "alpha" ? "alpha" : "date";
  const q = sp.q?.trim() ?? "";
  const from = sp.from?.trim() ?? "";
  const to = sp.to?.trim() ?? "";

  const result = await getScriptureLibraryPage(lang, page, GRID_PAGE, {
    sort,
    keyword: q || undefined,
    from: from || undefined,
    to: to || undefined,
  });

  const qsForPage = (nextPage: number) => {
    const p = new URLSearchParams();
    if (q) p.set("q", q);
    if (from) p.set("from", from);
    if (to) p.set("to", to);
    if (sort !== "date") p.set("sort", sort);
    if (nextPage > 1) p.set("page", String(nextPage));
    const s = p.toString();
    return s ? `?${s}` : "";
  };

  return (
    <div className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <div className="mx-auto max-w-[110rem]">
        <div className="flex w-full flex-wrap items-center gap-3">
          <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "libraryPageTitle")}</h1>
          <LibraryFiltersToggle lang={lang} q={q} from={from} to={to} sort={sort} />
        </div>

        {result.items.length === 0 ? (
          <p className="mt-12 text-center font-medium text-parish-muted">{t(lang, "libraryEmpty")}</p>
        ) : (
          <LibraryBooksGrid lang={lang} books={result.items} />
        )}

        {result.total > 0 && result.totalPages > 1 ? (
          <nav className="mt-10 flex flex-wrap items-center justify-center gap-3 text-sm font-semibold">
            {result.page > 1 ? (
              <Link
                href={`/library${qsForPage(result.page - 1)}`}
                className="rounded-lg border border-parish-border px-3 py-1.5 text-parish-accent hover:bg-parish-accent-soft"
              >
                {t(lang, "paginationPrev")}
              </Link>
            ) : (
              <span className="rounded-lg border border-parish-border px-3 py-1.5 opacity-40">{t(lang, "paginationPrev")}</span>
            )}
            <span className="text-parish-muted">
              {t(lang, "paginationPageOf").replace("{n}", String(result.page)).replace("{m}", String(result.totalPages))}
            </span>
            {result.page < result.totalPages ? (
              <Link
                href={`/library${qsForPage(result.page + 1)}`}
                className="rounded-lg border border-parish-border px-3 py-1.5 text-parish-accent hover:bg-parish-accent-soft"
              >
                {t(lang, "paginationNext")}
              </Link>
            ) : (
              <span className="rounded-lg border border-parish-border px-3 py-1.5 opacity-40">{t(lang, "paginationNext")}</span>
            )}
          </nav>
        ) : null}
      </div>
    </div>
  );
}
