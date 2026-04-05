import { getFooterSettings, resolveFooterDisplay } from "@/lib/data";
import { getLang } from "@/lib/i18n-server";
import { ParishContactsSection } from "@/components/ParishContactsSection";
import { ParishMapEmbed } from "@/components/ParishMapEmbed";
import { t } from "@/lib/ui-strings";
import type { Metadata } from "next";

export async function generateMetadata(): Promise<Metadata> {
  const lang = await getLang();
  return { title: `${t(lang, "aboutNavContacts")} · ${t(lang, "parishName")}` };
}

export default async function AboutContactsPage() {
  const lang = await getLang();
  const footer = await getFooterSettings();
  const display = resolveFooterDisplay(footer, lang);

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "aboutNavContacts")}</h1>
      <div className="mt-8 rounded-xl border border-parish-border bg-parish-surface p-6 shadow-sm sm:p-8">
        <ParishContactsSection
          lang={lang}
          priestName={display.priestName}
          address={display.address}
          phone={display.phone}
          email={display.email}
          extra={display.extra}
          contactButtons={display.contactButtons}
        />
      </div>
      {display.mapEmbedSrc ? (
        <>
          <h2 className="mt-10 font-display text-xl font-semibold text-parish-text">{t(lang, "mapSectionTitle")}</h2>
          <ParishMapEmbed src={display.mapEmbedSrc} title={t(lang, "mapEmbedTitle")} />
        </>
      ) : null}
    </article>
  );
}
