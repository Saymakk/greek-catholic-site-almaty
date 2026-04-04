import { getLang } from "@/lib/i18n-server";
import { getFooterSettings, resolveFooterDisplay } from "@/lib/data";
import { SiteHeader } from "./SiteHeader";
import { SiteFooter } from "./SiteFooter";

export async function SiteChrome({ children }: { children: React.ReactNode }) {
  const lang = await getLang();
  const footer = await getFooterSettings();
  const display = resolveFooterDisplay(footer, lang);

  return (
    <>
      <SiteHeader lang={lang} />
      <div className="min-w-0 w-full flex-1">{children}</div>
      <SiteFooter lang={lang} {...display} />
    </>
  );
}
