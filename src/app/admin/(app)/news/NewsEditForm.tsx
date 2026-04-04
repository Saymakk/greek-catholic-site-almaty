"use client";

import { useMemo, useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { removeNewsCover, saveNews } from "../actions/news";
import {
  CONTENT_ORDER,
  isContentLang,
  type ContentLang,
} from "../books/book-locales";
import { sortNewsLangsForForm } from "./news-entity-locales";

export type NewsLocaleFields = {
  lang: string;
  title: string;
  excerpt: string;
  body: string;
};

function editionTitle(code: string) {
  return code.toUpperCase();
}

export function NewsEditForm({
  newsId,
  publishedAt,
  isPublished: isPublishedInitial,
  primaryLang: primaryLangDb,
  coverImageUrl: coverImageUrlProp,
  locales,
  submitLabel,
  onCancel,
}: {
  newsId: string;
  publishedAt: string;
  isPublished: boolean;
  primaryLang: string | null;
  coverImageUrl: string | null;
  locales: NewsLocaleFields[];
  submitLabel: string;
  onCancel?: () => void;
}) {
  const [primaryLang, setPrimaryLang] = useState<ContentLang>(() =>
    primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : "ru",
  );
  const [activeLangs, setActiveLangs] = useState<string[]>(() =>
    sortNewsLangsForForm(
      locales.map((l) => l.lang),
      primaryLangDb && isContentLang(primaryLangDb) ? primaryLangDb : "ru",
    ),
  );
  const [coverRemoved, setCoverRemoved] = useState(false);
  const [coverPending, startCoverTransition] = useTransition();
  const router = useRouter();

  const byLang = useMemo(() => {
    const m = new Map<string, NewsLocaleFields>();
    for (const l of locales) m.set(l.lang, l);
    return m;
  }, [locales]);

  const canAdd = CONTENT_ORDER.filter((code) => !activeLangs.includes(code));

  function addLang(code: string) {
    setActiveLangs((prev) => sortNewsLangsForForm([...prev, code], primaryLang));
  }

  function removeLang(code: string) {
    if (code === primaryLang) return;
    setActiveLangs((prev) => prev.filter((x) => x !== code));
  }

  const orderedLangCodes = sortNewsLangsForForm(activeLangs, primaryLang);
  const displayCover = !coverRemoved && coverImageUrlProp;

  return (
    <form action={saveNews} className="flex min-h-0 min-w-0 flex-1 flex-col">
      <input type="hidden" name="id" value={newsId} />
      <input type="hidden" name="primary_lang" value={primaryLang} />
      <input type="hidden" name="locales" value={activeLangs.join(",")} />
      <div className="admin-book-dialog__scroll min-h-0 flex-1 space-y-4 px-4 py-4 sm:px-6">
        <label className="block text-xs text-parish-muted sm:text-sm">
          Язык основной версии (не дублируется при добавлении языка)
          <select
            className="mt-1 block w-full max-w-md rounded border border-parish-border bg-parish-surface px-2 py-1.5 text-sm text-parish-text"
            value={primaryLang}
            onChange={(e) => {
              const next = e.target.value;
              if (!isContentLang(next)) return;
              setPrimaryLang(next);
              setActiveLangs((prev) => sortNewsLangsForForm(prev, next));
            }}
          >
            {CONTENT_ORDER.map((code) => (
              <option key={code} value={code}>
                {editionTitle(code)}
              </option>
            ))}
          </select>
        </label>
        <p className="text-xs text-parish-muted">Дата публикации: {publishedAt}</p>
        <label className="flex items-center gap-2 text-sm text-parish-text">
          <input
            type="checkbox"
            name="is_published"
            defaultChecked={isPublishedInitial}
            className="rounded"
          />
          Опубликовано
        </label>
        <div className="rounded-lg border border-parish-border/70 p-3">
          <p className="text-xs font-medium text-parish-muted">Обложка</p>
          {displayCover ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={displayCover}
              alt=""
              className="mt-2 h-28 max-w-xs rounded-md border border-parish-border object-cover"
            />
          ) : (
            <p className="mt-2 text-xs text-parish-muted">Нет обложки</p>
          )}
          <label className="mt-2 block text-xs text-parish-muted">
            Загрузить или заменить
            <input
              type="file"
              name="cover"
              accept="image/*"
              className="mt-1 block w-full text-sm text-parish-text"
            />
          </label>
          {displayCover && newsId ? (
            <button
              type="button"
              className="mt-2 rounded-lg border border-red-200 bg-red-50/80 px-3 py-1.5 text-xs font-medium text-red-700 hover:bg-red-100 disabled:opacity-50"
              disabled={coverPending}
              onClick={() => {
                startCoverTransition(async () => {
                  await removeNewsCover(newsId);
                  setCoverRemoved(true);
                  router.refresh();
                });
              }}
            >
              Удалить обложку
            </button>
          ) : null}
        </div>
        {orderedLangCodes.map((code) => {
          const row = byLang.get(code) ?? {
            lang: code,
            title: "",
            excerpt: "",
            body: "",
          };
          return (
            <fieldset
              key={code}
              className="rounded-lg border border-parish-border/70 p-3"
            >
              <div className="flex flex-wrap items-center justify-between gap-2">
                <legend className="text-sm font-medium text-parish-accent">
                  {editionTitle(code)}
                  {code === primaryLang ? (
                    <span className="ml-1 font-normal text-parish-muted">
                      — основная версия
                    </span>
                  ) : null}
                </legend>
                {code !== primaryLang ? (
                  <button
                    type="button"
                    className="text-xs text-red-600 hover:underline"
                    onClick={() => removeLang(code)}
                  >
                    Убрать версию
                  </button>
                ) : null}
              </div>
              <label className="mt-2 block text-xs text-parish-muted">
                Заголовок
                <input
                  name={`title_${code}`}
                  defaultValue={row.title}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 text-sm"
                />
              </label>
              <label className="mt-2 block text-xs text-parish-muted">
                Кратко
                <input
                  name={`excerpt_${code}`}
                  defaultValue={row.excerpt}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 text-sm"
                />
              </label>
              <label className="mt-2 block text-xs text-parish-muted">
                Текст (обычный или HTML)
                <textarea
                  name={`body_${code}`}
                  rows={5}
                  defaultValue={row.body}
                  className="mt-1 w-full rounded border border-parish-border px-2 py-1.5 font-mono text-sm"
                />
              </label>
            </fieldset>
          );
        })}
        {canAdd.length > 0 ? (
          <div className="flex flex-wrap gap-2">
            <span className="w-full text-xs text-parish-muted">
              Добавить версию на языке:
            </span>
            {canAdd.map((code) => (
              <button
                key={code}
                type="button"
                className="rounded-lg border border-parish-border px-3 py-1.5 text-xs text-parish-accent hover:bg-parish-accent-soft"
                onClick={() => addLang(code)}
              >
                {editionTitle(code)}
              </button>
            ))}
          </div>
        ) : null}
      </div>
      <div className="flex shrink-0 flex-wrap gap-3 border-t border-parish-border bg-parish-surface/95 px-4 py-3 sm:px-6">
        {onCancel ? (
          <button
            type="button"
            onClick={onCancel}
            className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
          >
            Отмена
          </button>
        ) : null}
        <button
          type="submit"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
        >
          {submitLabel}
        </button>
      </div>
    </form>
  );
}
