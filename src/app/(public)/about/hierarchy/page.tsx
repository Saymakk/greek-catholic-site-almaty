import { ClergyHierarchyList } from "@/components/ClergyHierarchyList";
import { getClergyForPublic } from "@/lib/data";
import { getLang } from "@/lib/i18n-server";
import { t } from "@/lib/ui-strings";
import type { Metadata } from "next";

export async function generateMetadata(): Promise<Metadata> {
  const lang = await getLang();
  return {
    title: `${t(lang, "hierarchyPageTitle")} · ${t(lang, "parishName")}`,
    description: t(lang, "hierarchyPageIntro"),
    alternates: { canonical: "/about/hierarchy" },
  };
}

export default async function HierarchyPage() {
  const lang = await getLang();
  const clergy = await getClergyForPublic();

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "hierarchyPageTitle")}</h1>
      <ClergyHierarchyList lang={lang} rows={clergy} />
    </article>
  );
}
