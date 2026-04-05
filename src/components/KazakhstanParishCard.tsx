import type { Lang } from "@/lib/i18n";
import type { PublicKazakhstanParish } from "@/lib/data";
import { t } from "@/lib/ui-strings";
import { ParishMapEmbed } from "@/components/ParishMapEmbed";

export function KazakhstanParishCard({ lang, parish: p }: { lang: Lang; parish: PublicKazakhstanParish }) {
  const hasPriestBlock = Boolean(p.priestPhotoUrl || p.priestName || p.priestContacts);
  const mapTitle = t(lang, "mapEmbedTitle");

  return (
    <article className="flex h-full flex-col overflow-hidden rounded-2xl border border-parish-border bg-parish-surface shadow-sm">
      <div className="flex flex-1 flex-col gap-6 p-5">
        <div className="grid gap-6 min-[520px]:grid-cols-2 min-[520px]:items-start">
          <div className="min-w-0 space-y-3">
            {p.name ? (
              <h2 className="font-display text-lg font-semibold leading-tight text-parish-text">{p.name}</h2>
            ) : null}
            {p.city ? <p className="text-sm font-medium text-parish-accent">{p.city}</p> : null}
            {p.address ? (
              <p className="whitespace-pre-line text-sm leading-relaxed text-parish-muted">{p.address}</p>
            ) : null}
            {p.websiteUrl ? (
              <p>
                <a
                  href={p.websiteUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-sm font-semibold text-parish-accent underline-offset-2 hover:underline"
                >
                  {t(lang, "parishCardWebsite")}
                </a>
              </p>
            ) : null}
            {p.parishPhotoUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={p.parishPhotoUrl}
                alt=""
                className="max-h-44 w-full max-w-[220px] rounded-xl border border-parish-border object-cover"
              />
            ) : null}
          </div>

          <aside className="min-w-0 border-t border-parish-border pt-4 min-[520px]:border-l min-[520px]:border-t-0 min-[520px]:pl-6 min-[520px]:pt-0">
            {hasPriestBlock ? (
              <div className="flex flex-col items-center gap-3 min-[520px]:items-start min-[520px]:flex-row">
                {p.priestPhotoUrl ? (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    src={p.priestPhotoUrl}
                    alt=""
                    className="h-24 w-24 shrink-0 rounded-full border border-parish-border object-cover"
                  />
                ) : null}
                <div className="min-w-0 text-center min-[520px]:text-left">
                  {p.priestName ? (
                    <p className="font-display text-sm font-semibold text-parish-text">
                      {t(lang, "parishCardPriest")}: {p.priestName}
                    </p>
                  ) : p.priestContacts || p.priestPhotoUrl ? (
                    <p className="font-display text-sm font-semibold text-parish-text">{t(lang, "parishCardPriest")}</p>
                  ) : null}
                  {p.priestContacts ? (
                    <p className="mt-1 whitespace-pre-line text-sm leading-relaxed text-parish-muted">{p.priestContacts}</p>
                  ) : null}
                </div>
              </div>
            ) : null}
          </aside>
        </div>

        {p.mapEmbedSrc ? (
          <ParishMapEmbed src={p.mapEmbedSrc} title={mapTitle} className="mt-0" />
        ) : null}
      </div>
    </article>
  );
}
