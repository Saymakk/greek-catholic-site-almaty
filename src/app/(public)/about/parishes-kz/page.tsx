import { getPublishedKazakhstanParishes } from "@/lib/data";
import { getLang } from "@/lib/i18n-server";
import { t } from "@/lib/ui-strings";
import { KazakhstanParishCard } from "@/components/KazakhstanParishCard";
import type { Metadata } from "next";

export async function generateMetadata(): Promise<Metadata> {
  const lang = await getLang();
  return {
    title: `${t(lang, "kazakhstanParishesPageTitle")} · ${t(lang, "parishName")}`,
    description: t(lang, "kazakhstanParishesEmpty"),
    alternates: { canonical: "/about/parishes-kz" },
  };
}

export default async function KazakhstanParishesPage() {
  const lang = await getLang();
  const parishes = await getPublishedKazakhstanParishes(lang);

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "kazakhstanParishesPageTitle")}</h1>
      {parishes.length === 0 ? (
        <p className="mt-8 max-w-2xl rounded-xl border border-parish-border bg-parish-surface p-6 text-sm font-medium leading-relaxed text-parish-muted shadow-sm">
          {t(lang, "kazakhstanParishesEmpty")}
        </p>
      ) : (
        <ul className="mt-10 grid gap-6 sm:grid-cols-2 lg:gap-8">
          {parishes.map((p) => (
            <li key={p.id} className="flex h-full min-w-0 flex-col">
              <KazakhstanParishCard lang={lang} parish={p} />
            </li>
          ))}
        </ul>
      )}
    </article>
  );
}
