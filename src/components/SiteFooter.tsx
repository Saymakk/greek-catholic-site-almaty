import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

type FooterProps = {
  lang: Lang;
  priestName: string | null;
  address: string;
  phone: string | null;
  email: string | null;
  extra: string;
};

export function SiteFooter({
  lang,
  priestName,
  address,
  phone,
  email,
  extra,
}: FooterProps) {
  return (
    <footer className="mt-auto border-t border-parish-border bg-parish-accent-soft/40">
      <div className="w-full px-4 py-10 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
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
            {extra ? (
              <p className="mt-4 whitespace-pre-line border-t border-parish-border/60 pt-4 text-sm leading-relaxed text-parish-muted">
                {extra}
              </p>
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
        <p className="mt-10 text-center text-xs font-medium text-parish-muted/90">
          © {new Date().getFullYear()} {t(lang, "parishName")}, {t(lang, "city")}
        </p>
      </div>
    </footer>
  );
}
