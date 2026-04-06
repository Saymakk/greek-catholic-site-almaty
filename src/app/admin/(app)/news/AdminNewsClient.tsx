"use client";

import { useEffect, useRef, useState } from "react";
import { format, parseISO } from "date-fns";
import type { Lang } from "@/lib/i18n";
import { pickNewsI18nRow } from "@/lib/content-lang-chain";
import { adminNewsScreenCopy } from "@/lib/admin-layout-i18n";
import { adminSharedImageCopy } from "@/lib/admin-shared-image-i18n";
import { deleteNewsForm } from "../actions/news";
import { NewsEditForm, type NewsLocaleFields } from "./NewsEditForm";
import type { ContentLang } from "../books/book-locales";
import { normalizeNewsLocales } from "./news-entity-locales";

export type AdminNewsPayload = {
  id: string;
  published_at: string;
  is_published: boolean;
  primary_lang: string | null;
  cover_image_url: string | null;
  locales: NewsLocaleFields[];
};

function listTitle(item: AdminNewsPayload, uiLang: Lang): string {
  const by: Partial<
    Record<Lang, { title: string; excerpt: string | null; body: string }>
  > = {};
  for (const l of item.locales) {
    if (l.lang === "ru" || l.lang === "uk" || l.lang === "kk" || l.lang === "en") {
      by[l.lang] = {
        title: l.title,
        excerpt: l.excerpt || null,
        body: l.body,
      };
    }
  }
  return (
    pickNewsI18nRow(by, uiLang, item.primary_lang)?.title ??
    item.locales[0]?.title ??
    "—"
  );
}

const emptyNewsItem = (uiLang: Lang): AdminNewsPayload => ({
  id: "",
  published_at: new Date().toISOString(),
  is_published: true,
  primary_lang: uiLang,
  cover_image_url: null,
  locales: normalizeNewsLocales([], null, uiLang as ContentLang),
});

export function AdminNewsClient({
  lang,
  items,
  initialNewsId,
}: {
  lang: Lang;
  items: AdminNewsPayload[];
  initialNewsId: string | null;
}) {
  const c = adminNewsScreenCopy(lang);
  const imageCopy = adminSharedImageCopy(lang);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [active, setActive] = useState<AdminNewsPayload | null>(null);

  function closeDialog() {
    dialogRef.current?.close();
    setMode(null);
    setActive(null);
  }

  useEffect(() => {
    const d = dialogRef.current;
    if (!d) return;
    function onClose() {
      setMode(null);
      setActive(null);
    }
    d.addEventListener("close", onClose);
    return () => d.removeEventListener("close", onClose);
  }, []);

  useEffect(() => {
    if (!initialNewsId) return;
    const found = items.find((x) => x.id === initialNewsId);
    if (found) {
      setMode("edit");
      setActive(found);
      requestAnimationFrame(() => dialogRef.current?.showModal());
    }
  }, [initialNewsId, items]);

  function openAdd() {
    setMode("add");
    setActive(emptyNewsItem(lang));
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(n: AdminNewsPayload) {
    setMode("edit");
    setActive(n);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <h1 className="font-display text-2xl text-parish-text">{c.pageTitle}</h1>
        <button
          type="button"
          onClick={openAdd}
          className="shrink-0 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          {c.create}
        </button>
      </div>
      <ul className="mt-8 space-y-4">
        {items.map((n) => (
          <li
            key={n.id}
            className="rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm"
          >
            <div className="flex flex-col gap-4 sm:flex-row sm:items-stretch sm:justify-between">
              <div className="flex min-w-0 flex-1 gap-3">
                <div className="h-20 w-14 shrink-0 overflow-hidden rounded-md border border-parish-border bg-parish-surface">
                  {n.cover_image_url ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      src={n.cover_image_url}
                      alt=""
                      className="h-full w-full object-cover"
                    />
                  ) : (
                    <div className="flex h-full w-full items-center justify-center text-[10px] text-parish-muted">
                      —
                    </div>
                  )}
                </div>
                <div className="min-w-0 flex-1">
                  <span className="text-sm text-parish-muted">
                    {format(parseISO(n.published_at), "dd.MM.yyyy")}
                    {!n.is_published ? ` · ${c.draft}` : ""}
                  </span>
                  <p className="font-medium text-parish-text">{listTitle(n, lang)}</p>
                </div>
              </div>
              <div className="flex shrink-0 flex-col gap-2 sm:w-40 sm:items-stretch">
                <button
                  type="button"
                  onClick={() => openEdit(n)}
                  className="rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
                >
                  {c.edit}
                </button>
                <form
                  action={deleteNewsForm}
                  onSubmit={(e) => {
                    if (!confirm(c.confirmDelete)) e.preventDefault();
                  }}
                >
                  <input type="hidden" name="id" value={n.id} />
                  <button
                    type="submit"
                    className="w-full rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-red-600 hover:bg-red-50"
                  >
                    {c.delete}
                  </button>
                </form>
              </div>
            </div>
          </li>
        ))}
      </ul>

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {active && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 sm:px-6">
              <h2 className="min-w-0 flex-1 font-display text-lg font-semibold text-parish-text sm:text-xl">
                {mode === "add" ? c.modalNew : c.modalEdit}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label={c.closeAria}
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <NewsEditForm
              key={mode === "add" ? "new" : active.id}
              formMsg={c}
              imageCopy={imageCopy}
              newsId={active.id}
              publishedAt={format(parseISO(active.published_at), "dd.MM.yyyy HH:mm")}
              isPublished={active.is_published}
              primaryLang={active.primary_lang}
              coverImageUrl={active.cover_image_url}
              locales={active.locales}
              submitLabel={mode === "add" ? c.add : c.save}
              onCancel={closeDialog}
              uiLang={lang}
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
