import Link from "next/link";
import Image from "next/image";
import { LangSwitcher } from "./LangSwitcher";
import type { Lang } from "@/lib/i18n";
import { t, type UiKey } from "@/lib/ui-strings";
import gerb from "@/app/gerb.jpg";

const links: { href: string; key: UiKey }[] = [
  { href: "/", key: "navHome" },
  { href: "/library", key: "navLibrary" },
  { href: "/about", key: "navAboutChurch" },
];

export function SiteHeader({ lang }: { lang: Lang }) {
  return (
    <header className="sticky top-0 z-40 border-b border-parish-border/80 bg-parish-surface/95 backdrop-blur-sm">
      <div className="grid w-full grid-cols-[1fr_auto_1fr] items-center gap-3 px-4 py-3 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <Link
          href="/"
          className="min-w-0 justify-self-start font-display text-lg font-semibold tracking-tight text-parish-text sm:text-xl lg:text-2xl"
        >
          {t(lang, "parishName")}
          <span className="block text-xs font-medium text-parish-muted sm:ml-2 sm:inline sm:text-sm">
            · {t(lang, "city")}
          </span>
        </Link>

        <div className="justify-self-center">
          <Image
            src={gerb}
            alt=""
            className="h-9 w-auto max-h-11 object-contain opacity-95 sm:h-11"
            sizes="44px"
            priority
          />
        </div>

        <nav className="justify-self-end flex flex-wrap items-center justify-end gap-x-3 gap-y-2 text-sm font-medium sm:gap-x-4">
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
