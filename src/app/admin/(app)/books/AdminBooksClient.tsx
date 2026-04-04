"use client";

import { useEffect, useRef, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { adminBooksMsg, editionLegendKey, type AdminBooksMsg } from "@/lib/admin-books-i18n";
import { deleteBookForm } from "../actions/books";
import { BookEditForm, type BookLocaleFields } from "./BookEditForm";
import { sortLangsForForm, isContentLang, type ContentLang } from "./book-locales";

export type AdminBookPayload = {
  id: string;
  sortOrder: number;
  /** null = старая схема с lang main */
  primaryLang: string | null;
  locales: BookLocaleFields[];
};

function sortEditionRowsForBook(
  locales: BookLocaleFields[],
  primaryLang: string | null,
): BookLocaleFields[] {
  const legacy = primaryLang === null && locales.some((l) => l.lang === "main");
  const primary: ContentLang =
    primaryLang && isContentLang(primaryLang) ? primaryLang : "ru";
  const codes = sortLangsForForm(
    locales.map((l) => l.lang),
    primary,
    legacy,
  );
  const m = new Map(locales.map((l) => [l.lang, l]));
  return codes.map((c) => m.get(c)!).filter(Boolean);
}

function editionLabel(code: string, msg: AdminBooksMsg) {
  const k = editionLegendKey(code);
  return k ? msg[k] : code;
}

export function AdminBooksClient({
  lang,
  books,
}: {
  lang: Lang;
  books: AdminBookPayload[];
}) {
  const msg = adminBooksMsg(lang);
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [mode, setMode] = useState<"add" | "edit" | null>(null);
  const [activeBook, setActiveBook] = useState<AdminBookPayload | null>(null);

  function closeDialog() {
    dialogRef.current?.close();
    setMode(null);
    setActiveBook(null);
  }

  useEffect(() => {
    const d = dialogRef.current;
    if (!d) return;
    function onClose() {
      setMode(null);
      setActiveBook(null);
    }
    d.addEventListener("close", onClose);
    return () => d.removeEventListener("close", onClose);
  }, []);

  function openAdd() {
    setMode("add");
    setActiveBook({
      id: "",
      sortOrder: 0,
      primaryLang: "ru",
      locales: [
        {
          lang: "ru",
          title: "",
          description: "",
          read_url: "",
          file_url: "",
          cover_image_url: null,
        },
      ],
    });
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function openEdit(book: AdminBookPayload) {
    setMode("edit");
    setActiveBook(book);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  return (
    <div>
      <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-display text-2xl text-parish-text">{msg.pageTitle}</h1>
          <p className="mt-2 max-w-2xl text-sm text-parish-muted">{msg.pageIntro}</p>
        </div>
        <button
          type="button"
          onClick={openAdd}
          className="shrink-0 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
        >
          {msg.addBook}
        </button>
      </div>

      <ul className="mt-8 space-y-4">
        {books.map((book) => (
          <li
            key={book.id}
            className="rounded-xl border border-parish-border bg-parish-surface p-4 shadow-sm"
          >
            <div className="flex flex-col gap-4 sm:flex-row sm:items-stretch sm:justify-between">
              <div className="min-w-0 flex-1 space-y-3">
                {sortEditionRowsForBook(book.locales, book.primaryLang).map((loc) => (
                  <div
                    key={loc.lang}
                    className="flex gap-3 rounded-lg border border-parish-border/50 bg-parish-bg/40 p-2"
                  >
                    <div className="h-20 w-14 shrink-0 overflow-hidden rounded-md border border-parish-border bg-parish-muted/20">
                      {loc.cover_image_url ? (
                        // eslint-disable-next-line @next/next/no-img-element
                        <img
                          src={loc.cover_image_url}
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
                      <p className="text-xs font-medium text-parish-accent">
                        {editionLabel(loc.lang, msg)}
                        {(book.primaryLang === loc.lang ||
                          (!book.primaryLang && loc.lang === "main")) && (
                          <span className="ml-1 font-normal text-parish-muted">
                            ({msg.primaryEditionMark})
                          </span>
                        )}
                      </p>
                      <p className="mt-0.5 text-sm font-semibold text-parish-text">
                        {loc.title.trim() || msg.noTitle}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
              <div className="flex shrink-0 flex-col gap-2 sm:w-40 sm:items-stretch">
                <button
                  type="button"
                  onClick={() => openEdit(book)}
                  className="rounded-lg border border-parish-border px-3 py-2 text-center text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
                >
                  {msg.edit}
                </button>
                <form
                  action={deleteBookForm}
                  onSubmit={(e) => {
                    if (!confirm(msg.deleteConfirm)) e.preventDefault();
                  }}
                >
                  <input type="hidden" name="id" value={book.id} />
                  <button
                    type="submit"
                    className="w-full rounded-lg px-3 py-2 text-center text-sm text-red-600 hover:bg-red-50"
                  >
                    {msg.delete}
                  </button>
                </form>
              </div>
            </div>
          </li>
        ))}
      </ul>

      {books.length === 0 ? (
        <p className="mt-8 text-sm text-parish-muted">{msg.emptyList}</p>
      ) : null}

      <dialog
        ref={dialogRef}
        className="admin-book-dialog rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl open:flex open:flex-col"
      >
        {activeBook && mode ? (
          <div className="admin-book-dialog__inner">
            <div className="flex shrink-0 items-start justify-between gap-3 border-b border-parish-border px-4 py-3 pl-4 pr-2 sm:px-6 sm:pr-4">
              <h2 className="min-w-0 flex-1 font-display font-semibold leading-tight text-[clamp(1.05rem,4cqmin+0.35rem,1.6rem)] text-parish-text">
                {mode === "add" ? msg.modalAddTitle : msg.modalEditTitle}
              </h2>
              <button
                type="button"
                onClick={closeDialog}
                className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
                aria-label={msg.modalClose}
              >
                <span className="text-2xl leading-none" aria-hidden>
                  ×
                </span>
              </button>
            </div>
            <BookEditForm
              key={mode === "add" ? "new-book" : activeBook.id}
              bookId={activeBook.id}
              sortOrder={activeBook.sortOrder}
              primaryLang={activeBook.primaryLang}
              locales={activeBook.locales}
              submitLabel={mode === "add" ? msg.addSubmit : msg.save}
              msg={msg}
              onCancel={closeDialog}
              fluidScale
              modalLayout
            />
          </div>
        ) : null}
      </dialog>
    </div>
  );
}
