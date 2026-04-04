import type { Lang } from "@/lib/i18n";
import { t, type UiKey } from "@/lib/ui-strings";
import type { ScriptureBook } from "@/lib/data";
import { ScriptureReadPicker, ScriptureFilePicker } from "@/components/ScriptureEditionPicker";

function bookPrimaryNativeName(siteLang: Lang, code: string): string {
  const keys: Record<string, UiKey> = {
    ru: "langNativeRu",
    uk: "langNativeUk",
    kk: "langNativeKk",
    en: "langNativeEn",
  };
  const k = keys[code];
  return k ? t(siteLang, k) : code;
}

export function ScriptureSection({
  lang,
  books,
  variant = "default",
}: {
  lang: Lang;
  books: ScriptureBook[];
  variant?: "default" | "sidebar";
}) {
  const isSidebar = variant === "sidebar";

  return (
    <section className="scroll-mt-24 overflow-visible">
      <h2
        className={
          isSidebar
            ? "font-display text-lg font-semibold leading-tight text-parish-text lg:text-xl"
            : "font-display text-2xl font-semibold text-parish-text"
        }
      >
        {t(lang, "scriptureTitle")}
      </h2>
      <p
        className={
          isSidebar
            ? "mt-2 text-xs font-medium leading-snug text-parish-muted"
            : "mt-2 text-sm font-medium text-parish-muted"
        }
      >
        {t(lang, "scriptureHint")}
      </p>
      <ul className={isSidebar ? "mt-4 space-y-3 overflow-visible" : "mt-6 space-y-4 overflow-visible"}>
        {books.length === 0 ? (
          <li className="font-medium text-parish-muted">{t(lang, "notAvailableLang")}</li>
        ) : (
          books.map((b) => (
            <li
              key={b.id}
              className={
                isSidebar
                  ? "relative z-10 flex flex-col gap-2 overflow-visible rounded-xl border border-parish-border bg-parish-surface px-3 py-3"
                  : "relative z-10 flex flex-col gap-3 overflow-visible rounded-xl border border-parish-border bg-parish-surface px-4 py-4 sm:flex-row sm:items-center sm:justify-between"
              }
            >
              <div
                className={
                  isSidebar
                    ? "flex gap-3"
                    : "flex flex-col gap-3 sm:flex-row sm:items-center sm:gap-4"
                }
              >
                {b.coverImageUrl ? (
                  <img
                    src={b.coverImageUrl}
                    alt=""
                    className={
                      isSidebar
                        ? "h-20 w-14 shrink-0 rounded-md object-cover shadow-sm"
                        : "mx-auto h-28 w-20 shrink-0 rounded-md object-cover shadow-sm sm:mx-0 sm:h-32 sm:w-[5.5rem]"
                    }
                  />
                ) : null}
                <div
                  className={
                    isSidebar
                      ? "min-w-0 flex-1"
                      : "text-center sm:text-left"
                  }
                >
                  <span
                    className={
                      isSidebar
                        ? "text-sm font-semibold leading-snug text-parish-text"
                        : "font-semibold text-parish-text"
                    }
                  >
                    {b.title ?? "—"}
                  </span>
                  {b.primaryLang ? (
                    <p
                      className={
                        isSidebar
                          ? "mt-0.5 text-[11px] leading-snug text-parish-muted"
                          : "mt-1 text-xs text-parish-muted"
                      }
                    >
                      {t(lang, "scripturePrimaryOnSite")}:{" "}
                      <span className="font-medium text-parish-text">
                        {bookPrimaryNativeName(lang, b.primaryLang)}
                      </span>
                    </p>
                  ) : b.legacyMain ? (
                    <p
                      className={
                        isSidebar
                          ? "mt-0.5 text-[11px] leading-snug text-parish-muted"
                          : "mt-1 text-xs text-parish-muted"
                      }
                    >
                      {t(lang, "scripturePrimaryLegacyNote")}
                    </p>
                  ) : null}
                  {b.description ? (
                    <p
                      className={
                        isSidebar
                          ? "mt-1 text-xs leading-snug text-parish-muted"
                          : "mt-2 max-w-xl text-sm leading-relaxed text-parish-muted"
                      }
                    >
                      {b.description}
                    </p>
                  ) : null}
                </div>
              </div>
              <div
                className={
                  isSidebar
                    ? "relative z-20 flex flex-col gap-2 overflow-visible"
                    : "relative z-20 flex flex-wrap justify-center gap-2 overflow-visible sm:justify-end"
                }
              >
                {b.readMenu.some((m) => m.url) ? (
                  <ScriptureReadPicker
                    lang={lang}
                    options={b.readMenu}
                    className={
                      isSidebar
                        ? "rounded-lg bg-parish-accent px-3 py-2 text-center text-xs font-semibold text-white hover:opacity-90"
                        : "rounded-lg bg-parish-accent px-4 py-2 text-sm font-semibold text-white hover:opacity-90"
                    }
                  >
                    {t(lang, "readOnline")}
                  </ScriptureReadPicker>
                ) : null}
                {b.fileMenu.some((m) => m.url) ? (
                  <ScriptureFilePicker
                    lang={lang}
                    options={b.fileMenu}
                    className={
                      isSidebar
                        ? "rounded-lg border border-parish-border px-3 py-2 text-center text-xs font-semibold text-parish-accent hover:bg-parish-accent-soft"
                        : "rounded-lg border border-parish-border px-4 py-2 text-sm font-semibold text-parish-accent hover:bg-parish-accent-soft"
                    }
                  >
                    {t(lang, "download")}
                  </ScriptureFilePicker>
                ) : null}
                {!b.readMenu.some((m) => m.url) && !b.fileMenu.some((m) => m.url) ? (
                  <span
                    className={
                      isSidebar
                        ? "text-xs font-medium text-parish-muted"
                        : "text-sm font-medium text-parish-muted"
                    }
                  >
                    {t(lang, "notAvailableLang")}
                  </span>
                ) : null}
              </div>
            </li>
          ))
        )}
      </ul>
    </section>
  );
}
