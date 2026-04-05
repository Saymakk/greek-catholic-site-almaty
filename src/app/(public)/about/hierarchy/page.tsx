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

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "hierarchyPageTitle")}</h1>
      <p className="mt-6 max-w-2xl rounded-xl border border-parish-border bg-parish-surface p-6 text-sm font-medium leading-relaxed text-parish-muted shadow-sm">
        {t(lang, "hierarchyPageIntro")}
      </p>
    </article>
  );
}
