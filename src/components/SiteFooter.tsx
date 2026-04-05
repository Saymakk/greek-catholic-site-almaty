import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

export function SiteFooter({ lang }: { lang: Lang }) {
  return (
    <footer className="mt-auto border-t border-parish-border bg-parish-accent-soft/40">
      <div className="w-full px-4 py-8 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <p className="text-center text-xs font-medium text-parish-muted/90">
          © {new Date().getFullYear()} {t(lang, "parishName")}, {t(lang, "city")}
        </p>
      </div>
    </footer>
  );
}
