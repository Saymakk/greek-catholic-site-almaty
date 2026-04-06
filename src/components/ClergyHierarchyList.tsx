import type { ClergyRow } from "@/lib/data";
import type { Lang } from "@/lib/i18n";
import {
  displayClergyExtraLabel,
  displayClergyExtraValue,
  displayClergyName,
} from "@/lib/clergy-display";
import { t } from "@/lib/ui-strings";

function isSafeHttpUrl(href: string): boolean {
  try {
    const u = new URL(href);
    return u.protocol === "https:" || u.protocol === "http:";
  } catch {
    return false;
  }
}

export function ClergyHierarchyList({ lang, rows }: { lang: Lang; rows: ClergyRow[] }) {
  if (!rows.length) {
    return (
      <p className="mt-6 max-w-2xl rounded-xl border border-parish-border bg-parish-surface p-6 text-sm font-medium leading-relaxed text-parish-muted shadow-sm">
        {t(lang, "hierarchyPageEmpty")}
      </p>
    );
  }

  return (
    <>
      <p className="mt-6 max-w-2xl text-sm font-medium leading-relaxed text-parish-muted">
        {t(lang, "hierarchyPageIntro")}
      </p>
      <ul className="mt-10 space-y-12">
        {rows.map((row) => {
          const name = displayClergyName(row, lang);
          return (
            <li
              key={row.id}
              className="rounded-xl border border-parish-border bg-parish-surface p-5 shadow-sm sm:p-6"
            >
              <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:gap-8">
                {row.photo_url ? (
                  <div className="shrink-0 sm:max-w-[min(100%,320px)]">
                    {/* eslint-disable-next-line @next/next/no-img-element -- natural aspect ratio from upload */}
                    <img
                      src={row.photo_url}
                      alt={name}
                      className="max-h-[min(70vh,480px)] w-full object-contain object-left"
                    />
                  </div>
                ) : null}
                <div className="min-w-0 flex-1">
                  <h2 className="font-display text-xl font-semibold text-parish-text sm:text-2xl">
                    {name}
                  </h2>
                  {row.extra_fields.length ? (
                    <dl className="mt-4 space-y-4">
                      {row.extra_fields.map((ef, i) => {
                        const label = displayClergyExtraLabel(ef, lang);
                        const value = displayClergyExtraValue(ef, lang);
                        const url = ef.url?.trim();
                        const safeUrl = url && isSafeHttpUrl(url) ? url : null;
                        if (!label && !value && !safeUrl) return null;
                        return (
                          <div key={i}>
                            {label ? (
                              <dt className="text-xs font-semibold uppercase tracking-wide text-parish-muted">
                                {label}
                              </dt>
                            ) : null}
                            {value ? (
                              <dd className="mt-1 whitespace-pre-wrap text-sm leading-relaxed text-parish-text">
                                {value}
                              </dd>
                            ) : null}
                            {safeUrl ? (
                              <dd className={value || label ? "mt-2" : "mt-0"}>
                                <a
                                  href={safeUrl}
                                  target="_blank"
                                  rel="noopener noreferrer"
                                  className="text-sm font-medium text-parish-accent underline-offset-2 hover:underline"
                                >
                                  {t(lang, "moreDetails")}
                                </a>
                              </dd>
                            ) : null}
                          </div>
                        );
                      })}
                    </dl>
                  ) : null}
                </div>
              </div>
            </li>
          );
        })}
      </ul>
    </>
  );
}
