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

const navLinkClass =
  "inline-flex shrink-0 items-center rounded-lg px-2.5 py-2 text-sm font-semibold text-parish-muted transition hover:bg-parish-accent-soft hover:text-parish-accent min-h-10 sm:min-h-0 sm:px-3 sm:py-2";

export function SiteHeader({ lang }: { lang: Lang }) {
  return (
    <header className="sticky top-0 z-40 border-b border-parish-border/80 bg-parish-surface/95 pt-[max(0.75rem,env(safe-area-inset-top))] backdrop-blur-sm">
      <div className="grid w-full grid-cols-[minmax(0,1fr)_auto_minmax(0,1fr)] items-center gap-x-2 gap-y-2 pb-3 ps-[max(1rem,env(safe-area-inset-left))] pe-[max(1rem,env(safe-area-inset-right))] sm:gap-x-4 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <Link
          href="/"
          className="min-w-0 justify-self-start font-display text-sm font-semibold leading-tight tracking-tight text-parish-text sm:text-xl lg:text-2xl"
        >
          <span className="block truncate whitespace-nowrap">
            {t(lang, "parishName")}
            <span className="font-medium text-parish-muted"> · </span>
            <span className="align-baseline text-[0.6875rem] font-medium text-parish-muted sm:text-base lg:text-lg">
              {t(lang, "city")}
            </span>
          </span>
        </Link>

        <div className="justify-self-center">
          <Image
            src={gerb}
            alt=""
            className="h-9 w-auto object-contain opacity-95 sm:h-11"
            sizes="(max-width: 640px) 36px, 44px"
            priority
          />
        </div>

        <nav className="nav-scroll-x flex min-w-0 max-w-full flex-nowrap items-center justify-end gap-0.5 justify-self-end overflow-x-auto sm:flex-wrap sm:overflow-visible sm:gap-x-1">
          {links.map((l) => (
            <a key={l.href} href={l.href} className={navLinkClass}>
              {t(lang, l.key)}
            </a>
          ))}
          <div className="shrink-0 ps-0.5 sm:ps-1">
            <LangSwitcher current={lang} srOnlyLabel={t(lang, "siteLangSelectAria")} />
          </div>
        </nav>
      </div>
    </header>
  );
}
