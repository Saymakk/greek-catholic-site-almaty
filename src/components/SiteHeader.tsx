import Link from "next/link";
import Image from "next/image";
import { LangSwitcher } from "./LangSwitcher";
import { SiteMobileNav } from "./SiteMobileNav";
import type { Lang } from "@/lib/i18n";
import { ABOUT_SUBNAV_SECTIONS } from "@/lib/about-nav";
import { t } from "@/lib/ui-strings";
import gerb from "@/app/gerb.jpg";

const navLinkClass =
  "inline-flex shrink-0 items-center rounded-lg px-2.5 py-2 text-sm font-semibold text-parish-muted transition hover:bg-parish-accent-soft hover:text-parish-accent min-h-10 sm:min-h-0 sm:px-3 sm:py-2";

function ChevronDownNav({ className }: { className?: string }) {
  return (
    <svg
      width="14"
      height="14"
      viewBox="0 0 24 24"
      aria-hidden
      className={className}
    >
      <path
        fill="currentColor"
        d="M7 10l5 5 5-5H7z"
      />
    </svg>
  );
}

export function SiteHeader({ lang }: { lang: Lang }) {
  const mobileNavItems = [
    { href: "/", label: t(lang, "navHome") },
    { href: "/library", label: t(lang, "navLibrary") },
    ...ABOUT_SUBNAV_SECTIONS.map(({ href, key }) => ({ href, label: t(lang, key) })),
  ];

  return (
    <header className="sticky top-0 z-40 border-b border-parish-border/80 bg-parish-surface/95 pt-[max(0.75rem,env(safe-area-inset-top))] backdrop-blur-sm">
      <div className="grid w-full grid-cols-[minmax(0,1fr)_auto_minmax(0,1fr)] items-center gap-x-2 gap-y-2 pb-3 ps-[max(1rem,env(safe-area-inset-left))] pe-[max(1rem,env(safe-area-inset-right))] sm:gap-x-4 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
        <Link
          href="/"
          className="min-w-0 justify-self-start font-display text-sm font-semibold leading-tight tracking-tight text-parish-text sm:text-xl lg:text-2xl"
        >
          <span className="block truncate whitespace-nowrap sm:hidden">
            {t(lang, "parishNameAbbrev")}
            <span className="font-medium text-parish-muted"> · </span>
            <span className="align-baseline text-[0.6875rem] font-medium text-parish-muted">
              {t(lang, "city")}
            </span>
          </span>
          <span className="hidden truncate whitespace-nowrap sm:block">
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

        <div className="flex justify-end justify-self-end sm:contents">
          <nav className="hidden min-w-0 max-w-full flex-nowrap items-center justify-end gap-0.5 sm:flex sm:flex-wrap sm:gap-x-1">
            <Link href="/" className={navLinkClass}>
              {t(lang, "navHome")}
            </Link>
            <Link href="/library" className={navLinkClass}>
              {t(lang, "navLibrary")}
            </Link>
            <div className="relative group">
              <button
                type="button"
                className={`${navLinkClass} gap-0.5`}
                aria-haspopup="menu"
                aria-expanded="false"
              >
                {t(lang, "navAboutChurch")}
                <ChevronDownNav className="opacity-70" />
              </button>
              <div
                className="pointer-events-none absolute left-0 top-full z-50 pt-1 opacity-0 transition-opacity duration-150 group-hover:pointer-events-auto group-hover:opacity-100 group-focus-within:pointer-events-auto group-focus-within:opacity-100"
                role="menu"
                aria-label={t(lang, "navAboutChurch")}
              >
                <div className="min-w-[min(16rem,calc(100vw-2rem))] rounded-xl border border-parish-border bg-parish-surface/98 p-1.5 shadow-lg shadow-parish-text/[0.07] backdrop-blur-sm">
                  <ul className="flex flex-col gap-0.5">
                    {ABOUT_SUBNAV_SECTIONS.map(({ href, key }) => (
                      <li key={href} role="none">
                        <Link
                          href={href}
                          role="menuitem"
                          className="block rounded-lg px-3 py-2 text-sm font-semibold text-parish-text transition hover:bg-parish-accent-soft hover:text-parish-accent"
                        >
                          {t(lang, key)}
                        </Link>
                      </li>
                    ))}
                  </ul>
                </div>
              </div>
            </div>
            <div className="shrink-0 ps-0.5 sm:ps-1">
              <LangSwitcher current={lang} srOnlyLabel={t(lang, "siteLangSelectAria")} />
            </div>
          </nav>
          <div className="sm:hidden">
            <SiteMobileNav lang={lang} navItems={mobileNavItems} />
          </div>
        </div>
      </div>
    </header>
  );
}
