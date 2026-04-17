"use client";

import { useEffect, useMemo, useState } from "react";
import { format, parseISO, startOfDay } from "date-fns";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import type { NewsRow } from "@/lib/data";
import { RichOrPlain, stripTagsForPreview } from "./RichOrPlain";
import { PaginationControls } from "./PaginationControls";
import { NewsDetailModal } from "./NewsDetailModal";
import { NewsCoverBlock } from "./NewsCoverBlock";
import { gatherLightboxUrls, ImageLightboxOverlay } from "./ImageLightboxOverlay";

const PREVIEW_LEN = 100;
const PAGE_SIZE = 10;

function FilterIcon({ className }: { className?: string }) {
  return (
    <svg
      className={className}
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2.2"
      strokeLinecap="round"
      aria-hidden
    >
      <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" />
    </svg>
  );
}

export function NewsSection({ lang, news }: { lang: Lang; news: NewsRow[] }) {
  const [filtersOpen, setFiltersOpen] = useState(false);
  const [detailNews, setDetailNews] = useState<NewsRow | null>(null);
  const [lightbox, setLightbox] = useState<{ images: string[]; index: number } | null>(null);
  const [keyword, setKeyword] = useState("");
  const [from, setFrom] = useState("");
  const [to, setTo] = useState("");
  const [page, setPage] = useState(1);

  const filtered = useMemo(() => {
    const kw = keyword.trim().toLowerCase();
    const fromD = from ? startOfDay(parseISO(from)) : null;
    const toD = to ? startOfDay(parseISO(to)) : null;
    return news.filter((n) => {
      if (kw) {
        const hay = `${n.title} ${n.excerpt ?? ""} ${stripTagsForPreview(n.body)}`.toLowerCase();
        if (!hay.includes(kw)) return false;
      }
      const pub = startOfDay(parseISO(n.published_at));
      if (fromD && pub < fromD) return false;
      if (toD && pub > toD) return false;
      return true;
    });
  }, [news, keyword, from, to]);

  const totalFiltered = filtered.length;
  const totalPages = Math.max(1, Math.ceil(totalFiltered / PAGE_SIZE));
  const currentPage = Math.min(Math.max(1, page), totalPages);
  const pageItems = useMemo(() => {
    const fromIdx = (currentPage - 1) * PAGE_SIZE;
    return filtered.slice(fromIdx, fromIdx + PAGE_SIZE);
  }, [filtered, currentPage]);

  useEffect(() => {
    setPage(1);
  }, [keyword, from, to]);

  useEffect(() => {
    setPage((p) => Math.min(p, totalPages));
  }, [totalPages]);

  return (
    <section className="scroll-mt-24 flex w-full min-w-0 flex-col items-center">
      <div className="flex w-full max-w-3xl flex-wrap items-center justify-center gap-3">
        <h2 className="font-display text-2xl font-semibold text-parish-text">
          {t(lang, "newsTitle")}
        </h2>
        <button
          type="button"
          onClick={() => setFiltersOpen((v) => !v)}
          className={`inline-flex h-11 w-11 shrink-0 touch-manipulation items-center justify-center rounded-xl border text-parish-muted shadow-sm transition ${
            filtersOpen
              ? "border-parish-accent bg-parish-accent-soft text-parish-accent"
              : "border-parish-border bg-parish-surface hover:border-parish-accent/50 hover:text-parish-accent"
          }`}
          aria-expanded={filtersOpen}
          aria-label={t(lang, "newsFilters")}
          title={t(lang, "newsFilters")}
        >
          <FilterIcon />
        </button>
      </div>

      {filtersOpen ? (
        <div className="mt-6 flex w-full max-w-3xl flex-col gap-3 rounded-xl border border-parish-border bg-parish-surface p-4 sm:flex-row sm:flex-wrap sm:items-end">
          <label className="flex min-w-[12rem] flex-1 flex-col gap-1 text-xs font-semibold text-parish-muted">
            {t(lang, "filterKeyword")}
            <input
              value={keyword}
              onChange={(e) => setKeyword(e.target.value)}
              className="min-h-11 rounded-lg border border-parish-border px-3 py-2 text-base font-medium text-parish-text sm:min-h-0 sm:text-sm"
              placeholder="…"
            />
          </label>
          <label className="flex flex-col gap-1 text-xs font-semibold text-parish-muted">
            {t(lang, "filterFrom")}
            <input
              type="date"
              value={from}
              onChange={(e) => setFrom(e.target.value)}
              className="min-h-11 rounded-lg border border-parish-border px-3 py-2 text-base font-medium text-parish-text sm:min-h-0 sm:text-sm"
            />
          </label>
          <label className="flex flex-col gap-1 text-xs font-semibold text-parish-muted">
            {t(lang, "filterTo")}
            <input
              type="date"
              value={to}
              onChange={(e) => setTo(e.target.value)}
              className="min-h-11 rounded-lg border border-parish-border px-3 py-2 text-base font-medium text-parish-text sm:min-h-0 sm:text-sm"
            />
          </label>
          <button
            type="button"
            onClick={() => {
              setKeyword("");
              setFrom("");
              setTo("");
            }}
            className="min-h-11 touch-manipulation rounded-lg border border-parish-border bg-parish-accent-soft px-4 py-2.5 text-sm font-semibold text-parish-accent hover:bg-parish-border/40"
          >
            {t(lang, "resetFilters")}
          </button>
        </div>
      ) : null}

      <ul className="mt-8 w-full max-w-3xl space-y-8">
        {filtered.length === 0 ? (
          <li className="text-center font-medium text-parish-muted">{t(lang, "noNews")}</li>
        ) : (
          pageItems.map((n) => {
            const plain = stripTagsForPreview(n.body);
            const needsExpand = plain.length > PREVIEW_LEN;
            return (
              <li
                key={n.id}
                className="rounded-2xl border border-parish-border/80 bg-parish-surface px-6 py-6 text-center shadow-sm sm:text-left"
              >
                <time
                  className="text-xs font-semibold text-parish-muted"
                  dateTime={n.published_at}
                >
                  {format(parseISO(n.published_at), "dd.MM.yyyy")}
                </time>
                <h3 className="mt-2 font-display text-xl font-semibold text-parish-text">
                  {n.title}
                </h3>
                {n.coverImageUrl ? (
                  <NewsCoverBlock
                    variant="section"
                    cover={n.coverImageUrl}
                    onImageClick={() =>
                      setLightbox({
                        images: gatherLightboxUrls(n.coverImageUrl, n.galleryImageUrls),
                        index: 0,
                      })
                    }
                    imageAriaLabel={t(lang, "imageLightboxAria")}
                  />
                ) : null}
                {n.excerpt ? (
                  <p className="mt-2 text-sm font-medium text-parish-muted">{n.excerpt}</p>
                ) : null}
                <div className="rich-html mt-4 max-w-none text-sm font-medium leading-relaxed text-parish-text">
                  {needsExpand ? (
                    <p className="text-left">
                      {plain.slice(0, PREVIEW_LEN)}
                      …
                    </p>
                  ) : (
                    <RichOrPlain content={n.body} className="text-left" />
                  )}
                </div>
                {needsExpand ? (
                  <button
                    type="button"
                    className="mt-3 text-sm font-semibold text-parish-accent hover:underline"
                    onClick={() => setDetailNews(n)}
                  >
                    {t(lang, "openNews")}
                  </button>
                ) : null}
              </li>
            );
          })
        )}
      </ul>

      {filtered.length > 0 ? (
        <PaginationControls
          lang={lang}
          page={currentPage}
          totalPages={totalPages}
          totalItems={totalFiltered}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      ) : null}

      {detailNews ? (
        <NewsDetailModal lang={lang} news={detailNews} onClose={() => setDetailNews(null)} />
      ) : null}

      <ImageLightboxOverlay
        lang={lang}
        images={lightbox?.images ?? []}
        initialIndex={lightbox?.index ?? 0}
        open={lightbox !== null}
        onClose={() => setLightbox(null)}
        zClass="z-[200]"
      />
    </section>
  );
}
