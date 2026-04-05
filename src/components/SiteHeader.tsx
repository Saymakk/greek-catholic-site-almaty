import Link from "next/link";
import { LangSwitcher } from "./LangSwitcher";
import type { Lang } from "@/lib/i18n";
import { t, type UiKey } from "@/lib/ui-strings";

const links: { href: string; key: UiKey }[] = [
  { href: "/", key: "navHome" },
  { href: "/#news", key: "navNews" },
  { href: "/library", key: "navLibrary" },
  { href: "/#telegram", key: "navTelegram" },
  { href: "/history", key: "navHistory" },
];

export function SiteHeader({ lang }: { lang: Lang }) {
  return (
    <header className="sticky top-0 z-40 border-b border-parish-border/80 bg-parish-surface/95 backdrop-blur-sm">
      <div className="flex w-full flex-wrap items-center justify-between gap-4 px-4 py-4 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <Link href="/" className="font-display text-xl font-semibold tracking-tight text-parish-text sm:text-2xl">
          {t(lang, "parishName")}
          <span className="block text-sm font-medium text-parish-muted sm:ml-2 sm:inline">
            · {t(lang, "city")}
          </span>
        </Link>
        <nav className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm font-medium">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className="text-parish-muted transition hover:text-parish-accent"
            >
              {t(lang, l.key)}
            </a>
          ))}
          <LangSwitcher current={lang} srOnlyLabel={t(lang, "siteLangSelectAria")} />
        </nav>
      </div>
    </header>
  );
}
