"use client";

import Link from "next/link";
import { useEffect, useId, useRef, useState } from "react";
import { createPortal } from "react-dom";
import { LangSwitcher } from "./LangSwitcher";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

export type SiteMobileNavItem = { href: string; label: string };

function MenuIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" aria-hidden className="shrink-0">
      <path fill="currentColor" d="M4 6h16v2H4V6zm0 5h16v2H4v-2zm0 5h16v2H4v-2z" />
    </svg>
  );
}

function CloseIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" aria-hidden className="shrink-0">
      <path
        fill="currentColor"
        d="M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"
      />
    </svg>
  );
}

export function SiteMobileNav({ lang, navItems }: { lang: Lang; navItems: SiteMobileNavItem[] }) {
  const [open, setOpen] = useState(false);
  const btnRef = useRef<HTMLButtonElement>(null);
  const panelId = useId();
  const prevOpen = useRef(false);

  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("keydown", onKey);
    document.body.style.overflow = "hidden";
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = "";
    };
  }, [open]);

  useEffect(() => {
    if (prevOpen.current && !open) {
      btnRef.current?.focus();
    }
    prevOpen.current = open;
  }, [open]);

  const close = () => setOpen(false);

  const drawer =
    open && typeof document !== "undefined" ? (
      <>
        <button
          type="button"
          className="fixed inset-0 z-[200] cursor-default bg-black/50 sm:hidden"
          aria-label={t(lang, "closeModal")}
          onClick={close}
        />
        <div
          id={panelId}
          role="dialog"
          aria-modal="true"
          aria-label={t(lang, "navMainMenuAria")}
          className="fixed inset-y-0 right-0 z-[210] flex w-[min(100vw,20rem)] flex-col border-l border-parish-border bg-parish-surface shadow-2xl sm:hidden"
        >
          <div className="flex shrink-0 items-center justify-between border-b border-parish-border bg-parish-surface px-4 py-3 pt-[max(0.75rem,env(safe-area-inset-top))]">
            <span className="font-display text-sm font-semibold text-parish-text">
              {t(lang, "navMainMenuAria")}
            </span>
            <button
              type="button"
              className="flex h-11 w-11 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft hover:text-parish-text"
              aria-label={t(lang, "closeModal")}
              onClick={close}
            >
              <CloseIcon />
            </button>
          </div>

          <nav className="min-h-0 flex-1 overflow-y-auto bg-parish-surface px-3 py-4">
            <ul className="flex flex-col gap-1">
              {navItems.map((item) => (
                <li key={item.href}>
                  <Link
                    href={item.href}
                    className="block rounded-xl px-4 py-3.5 text-base font-semibold text-parish-text transition hover:bg-parish-accent-soft"
                    onClick={close}
                  >
                    {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>

          <div className="shrink-0 border-t border-parish-border bg-parish-surface p-4 pb-[max(1rem,env(safe-area-inset-bottom))]">
            <p className="mb-2 text-xs font-medium uppercase tracking-wide text-parish-muted">
              {t(lang, "siteLangSelectAria")}
            </p>
            <LangSwitcher
              current={lang}
              srOnlyLabel={t(lang, "siteLangSelectAria")}
              className="w-full flex-col items-stretch gap-2 [&_select]:w-full [&_select]:min-h-11"
            />
          </div>
        </div>
      </>
    ) : null;

  return (
    <>
      <button
        ref={btnRef}
        type="button"
        className="inline-flex min-h-11 min-w-11 shrink-0 items-center justify-center rounded-lg border border-parish-border bg-parish-surface text-parish-text touch-manipulation"
        aria-expanded={open}
        aria-controls={open ? panelId : undefined}
        aria-label={open ? t(lang, "closeModal") : t(lang, "navMainMenuAria")}
        onClick={() => setOpen((o) => !o)}
      >
        {open ? <CloseIcon /> : <MenuIcon />}
      </button>

      {drawer && typeof document !== "undefined"
        ? createPortal(drawer, document.body)
        : null}
    </>
  );
}
