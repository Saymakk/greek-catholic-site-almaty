import type { Lang } from "@/lib/i18n";
import type { FooterContactButton } from "@/lib/data";
import { t } from "@/lib/ui-strings";
import { RichOrPlain } from "./RichOrPlain";

function TelegramGlyph({ className }: { className?: string }) {
  return (
    <svg className={className} width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
      <path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.562 8.161c-.18 1.897-.962 6.502-1.359 8.627-.168.9-.5 1.201-.82 1.23-.699.064-1.23-.461-1.909-.902-1.061-.693-1.662-1.124-2.693-1.8-1.191-.781-.419-1.212.259-1.912.177-.184 3.247-2.977 3.307-3.23.007-.032.015-.15-.056-.212s-.174-.041-.249-.024c-.106.024-1.793 1.139-5.062 3.345-.479.329-.91.489-1.297.481-.428-.009-1.252-.242-1.865-.442-.752-.244-1.349-.374-1.297-.789.027-.216.325-.437.893-.663 3.498-1.524 5.831-2.529 6.998-3.014 3.332-1.386 4.025-1.627 4.476-1.635.099-.002.321.023.465.14.121.099.155.232.171.325.019.123.044.404.025.622z" />
    </svg>
  );
}

function ContactGlyph({ icon }: { icon?: string }) {
  if (!icon?.trim()) return null;
  const s = icon.trim();
  if (/^https?:\/\//i.test(s)) {
    // eslint-disable-next-line @next/next/no-img-element
    return <img src={s} alt="" className="h-5 w-5 shrink-0 object-contain" />;
  }
  const k = s.toLowerCase().replace(/\s+/g, "");
  if (k === "telegram" || k === "tg") return <TelegramGlyph className="shrink-0 opacity-90" />;
  return <span className="text-base leading-none">{s}</span>;
}

export function ParishContactsSection({
  lang,
  priestName,
  address,
  phone,
  email,
  extra,
  contactButtons = [],
}: {
  lang: Lang;
  priestName: string | null;
  address: string;
  phone: string | null;
  email: string | null;
  extra: string;
  contactButtons?: FooterContactButton[];
}) {
  return (
    <div className="flex flex-col gap-10 lg:flex-row lg:items-start lg:justify-between">
      <div className="min-w-0 lg:max-w-xl">
        <h3 className="font-display text-lg font-semibold text-parish-text">
          {t(lang, "contacts")}
        </h3>
        {priestName ? (
          <p className="mt-2 text-sm font-medium text-parish-text">{priestName}</p>
        ) : null}
        {phone ? (
          <p className="mt-2 text-sm font-medium text-parish-muted">
            <a href={`tel:${phone.replace(/\s/g, "")}`} className="hover:text-parish-accent">
              {phone}
            </a>
          </p>
        ) : null}
        {email ? (
          <p className="mt-1 text-sm font-medium text-parish-muted">
            <a href={`mailto:${email}`} className="hover:text-parish-accent">
              {email}
            </a>
          </p>
        ) : null}
        {contactButtons.length > 0 ? (
          <ul className="mt-3 flex flex-wrap gap-2">
            {contactButtons.map((b, i) => (
              <li key={`${b.url}-${i}`}>
                <a
                  href={b.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-2 rounded-lg border border-parish-border bg-parish-surface px-3 py-2 text-sm font-semibold text-parish-accent shadow-sm transition hover:border-parish-accent/50 hover:bg-parish-accent-soft"
                >
                  <ContactGlyph icon={b.icon} />
                  {b.label}
                </a>
              </li>
            ))}
          </ul>
        ) : null}
        {extra ? (
          <RichOrPlain
            content={extra}
            className="rich-html mt-4 border-t border-parish-border/60 pt-4 text-sm leading-relaxed text-parish-muted"
          />
        ) : null}
      </div>
      <div className="shrink-0 lg:ml-8 lg:max-w-md lg:text-right">
        <h3 className="font-display text-lg font-semibold text-parish-text">
          {t(lang, "address")}
        </h3>
        <p className="mt-2 text-sm font-medium leading-relaxed text-parish-muted lg:ml-auto">
          {address || "—"}
        </p>
      </div>
    </div>
  );
}
