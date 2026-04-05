import type { Lang } from "@/lib/i18n";
import type { FooterContactButton } from "@/lib/data";
import { t } from "@/lib/ui-strings";
import { ParishContactsSection } from "./ParishContactsSection";

type FooterProps = {
  lang: Lang;
  priestName: string | null;
  address: string;
  phone: string | null;
  email: string | null;
  extra: string;
  contactButtons: FooterContactButton[];
};

export function SiteFooter({
  lang,
  priestName,
  address,
  phone,
  email,
  extra,
  contactButtons,
}: FooterProps) {
  return (
    <footer className="mt-auto border-t border-parish-border bg-parish-accent-soft/40">
      <div className="w-full px-4 py-10 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <ParishContactsSection
          lang={lang}
          priestName={priestName}
          address={address}
          phone={phone}
          email={email}
          extra={extra}
          contactButtons={contactButtons}
        />
        <p className="mt-10 text-center text-xs font-medium text-parish-muted/90">
          © {new Date().getFullYear()} {t(lang, "parishName")}, {t(lang, "city")}
        </p>
      </div>
    </footer>
  );
}
