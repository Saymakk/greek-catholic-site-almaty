import { getHistoryHtml } from "@/lib/data";
import { getLang } from "@/lib/i18n-server";
import { HistoryBody } from "@/components/HistoryBody";
import { t } from "@/lib/ui-strings";
import type { Metadata } from "next";

export async function generateMetadata(): Promise<Metadata> {
  const lang = await getLang();
  return { title: `${t(lang, "historyPageTitle")} · ${t(lang, "parishName")}` };
}

export default async function AboutHistoryPage() {
  const lang = await getLang();
  const body = await getHistoryHtml(lang);

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl text-parish-text">{t(lang, "historyPageTitle")}</h1>
      <HistoryBody body={body} lang={lang} />
    </article>
  );
}
