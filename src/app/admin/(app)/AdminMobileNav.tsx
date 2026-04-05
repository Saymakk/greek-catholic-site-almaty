"use client";

import { useState } from "react";
import Link from "next/link";
import { signOut } from "@/app/actions/auth";
import { AdminLangBar } from "./AdminLangBar";
import type { Lang } from "@/lib/i18n";
import type { StaffProfile } from "@/lib/admin";
import { adminNavLabels, adminRoleLabel } from "@/lib/admin-layout-i18n";

export function AdminMobileNav({
  lang,
  profile,
}: {
  lang: Lang;
  profile: StaffProfile;
}) {
  const [open, setOpen] = useState(false);
  const n = adminNavLabels(lang);

  return (
    <>
      <div className="mb-4 flex items-center justify-between gap-3 sm:hidden">
        <button
          type="button"
          aria-expanded={open}
          aria-controls="admin-mobile-drawer"
          onClick={() => setOpen((v) => !v)}
          className="inline-flex h-12 w-12 touch-manipulation items-center justify-center rounded-lg border border-parish-border bg-parish-surface text-parish-text shadow-sm"
        >
          <span className="sr-only">Menu</span>
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden>
            <path d="M4 6h16M4 12h16M4 18h16" strokeLinecap="round" />
          </svg>
        </button>
        <AdminLangBar current={lang} />
      </div>

      {open ? (
        <button
          type="button"
          aria-label="Close menu"
          className="fixed inset-0 z-[80] bg-parish-text/40 backdrop-blur-[1px] sm:hidden"
          onClick={() => setOpen(false)}
        />
      ) : null}

      <aside
        id="admin-mobile-drawer"
        className={[
          "fixed left-0 top-0 z-[90] flex h-full w-[min(18rem,88vw)] max-w-[calc(100vw-env(safe-area-inset-left))] flex-col border-r border-parish-border bg-parish-surface p-4 pt-[max(1rem,env(safe-area-inset-top))] pb-[max(1rem,env(safe-area-inset-bottom))] pl-[max(1rem,env(safe-area-inset-left))] shadow-xl transition-transform duration-200 ease-out sm:hidden",
          open ? "translate-x-0" : "-translate-x-full pointer-events-none",
        ].join(" ")}
      >
        <div className="flex items-center justify-between gap-2">
          <p className="text-xs text-parish-muted">{profile.email}</p>
          <button
            type="button"
            onClick={() => setOpen(false)}
            className="flex h-9 w-9 items-center justify-center rounded-lg text-parish-muted hover:bg-parish-accent-soft"
            aria-label="Close"
          >
            <span className="text-xl leading-none">×</span>
          </button>
        </div>
        <p className="mt-1 text-xs font-medium text-parish-accent">{adminRoleLabel(lang, profile.role)}</p>
        <nav className="mt-6 flex min-h-0 flex-1 flex-col gap-0.5 overflow-y-auto overscroll-contain text-sm">
          <Link
            href="/admin"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.home}
          </Link>
          <Link
            href="/admin/news"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.news}
          </Link>
          <Link
            href="/admin/calendar"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.calendar}
          </Link>
          <Link
            href="/admin/books"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.books}
          </Link>
          <Link
            href="/admin/history"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.history}
          </Link>
          <Link
            href="/admin/parishes"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.parishes}
          </Link>
          <Link
            href="/admin/clergy"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.clergy}
          </Link>
          <Link
            href="/admin/settings"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.settings}
          </Link>
          <Link
            href="/admin/account"
            className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.account}
          </Link>
          {profile.role === "superadmin" ? (
            <Link
              href="/admin/users"
              className="touch-manipulation rounded-lg px-2 py-3 text-parish-text hover:bg-parish-accent-soft hover:text-parish-accent"
              onClick={() => setOpen(false)}
            >
              {n.users}
            </Link>
          ) : null}
          <Link
            href="/"
            className="mt-3 touch-manipulation rounded-lg px-2 py-3 text-parish-muted hover:bg-parish-accent-soft hover:text-parish-accent"
            onClick={() => setOpen(false)}
          >
            {n.toSite}
          </Link>
        </nav>
        <form action={signOut} className="mt-6 shrink-0 border-t border-parish-border pt-4">
          <button
            type="submit"
            className="touch-manipulation min-h-11 w-full rounded-lg py-2.5 text-left text-sm text-parish-muted underline hover:bg-parish-accent-soft hover:text-parish-accent"
          >
            {n.signOut}
          </button>
        </form>
      </aside>
    </>
  );
}
