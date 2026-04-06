import Link from "next/link";
import { getLang } from "@/lib/i18n-server";
import { t, type UiKey } from "@/lib/ui-strings";
import type { Metadata } from "next";

const SECTIONS: { href: string; key: UiKey }[] = [
  { href: "/about/hierarchy", key: "aboutNavHierarchy" },
  { href: "/about/history", key: "aboutNavHistory" },
  { href: "/about/parishes-kz", key: "aboutNavKazakhstanParishes" },
  { href: "/about/contacts", key: "aboutNavContacts" },
];

export async function generateMetadata(): Promise<Metadata> {
  const lang = await getLang();
  return {
    title: `${t(lang, "aboutChurchPageTitle")} · ${t(lang, "parishName")}`,
    description: t(lang, "aboutChurchIntro"),
    alternates: { canonical: "/about" },
  };
}

export default async function AboutPage() {
  const lang = await getLang();

  return (
    <article className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <h1 className="font-display text-3xl font-semibold text-parish-text">{t(lang, "aboutChurchPageTitle")}</h1>
      <p className="mt-3 max-w-2xl text-sm font-medium leading-relaxed text-parish-muted">{t(lang, "aboutChurchIntro")}</p>
      <nav className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-2 xl:grid-cols-4 lg:gap-6">
        {SECTIONS.map(({ href, key }) => (
          <Link
            key={href}
            href={href}
            className="group rounded-2xl border border-parish-border bg-parish-surface p-6 shadow-sm transition hover:border-parish-accent/50 hover:shadow-md"
          >
            <span className="font-display text-lg font-semibold text-parish-accent group-hover:underline">{t(lang, key)}</span>
          </Link>
        ))}
      </nav>
    </article>
  );
}
