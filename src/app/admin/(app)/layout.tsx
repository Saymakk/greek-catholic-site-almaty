import { requireStaff } from "@/lib/admin";
import Link from "next/link";
import { signOut } from "@/app/actions/auth";
import { getLang } from "@/lib/i18n-server";
import { adminNavLabels, adminRoleLabel } from "@/lib/admin-layout-i18n";
import { AdminLangBar } from "./AdminLangBar";
import { AdminMobileNav } from "./AdminMobileNav";
import { AdminSaveNotice } from "./AdminSaveNotice";

export default async function AdminAppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const profile = await requireStaff();
  const lang = await getLang();
  const n = adminNavLabels(lang);
  const savedText =
    lang === "uk"
      ? "Збережено."
      : lang === "kk"
        ? "Сақталды."
        : lang === "en"
          ? "Saved."
          : "Сохранено.";

  return (
    <div className="flex min-h-screen bg-parish-bg">
      <aside className="hidden w-52 shrink-0 border-r border-parish-border bg-parish-surface p-4 sm:block">
        <p className="text-xs text-parish-muted">{profile.email}</p>
        <p className="text-xs font-medium text-parish-accent">
          {adminRoleLabel(lang, profile.role)}
        </p>
        <div className="mt-4">
          <AdminLangBar current={lang} />
        </div>
        <nav className="mt-6 flex flex-col gap-2 text-sm">
          <Link href="/admin" className="text-parish-text hover:text-parish-accent">
            {n.home}
          </Link>
          <Link href="/admin/news" className="text-parish-text hover:text-parish-accent">
            {n.news}
          </Link>
          <Link href="/admin/calendar" className="text-parish-text hover:text-parish-accent">
            {n.calendar}
          </Link>
          <Link href="/admin/books" className="text-parish-text hover:text-parish-accent">
            {n.books}
          </Link>
          <Link href="/admin/history" className="text-parish-text hover:text-parish-accent">
            {n.history}
          </Link>
          <Link href="/admin/parishes" className="text-parish-text hover:text-parish-accent">
            {n.parishes}
          </Link>
          <Link href="/admin/clergy" className="text-parish-text hover:text-parish-accent">
            {n.clergy}
          </Link>
          <Link href="/admin/settings" className="text-parish-text hover:text-parish-accent">
            {n.settings}
          </Link>
          <Link href="/admin/account" className="text-parish-text hover:text-parish-accent">
            {n.account}
          </Link>
          {profile.role === "superadmin" ? (
            <Link href="/admin/users" className="text-parish-text hover:text-parish-accent">
              {n.users}
            </Link>
          ) : null}
          <Link href="/" className="mt-4 text-parish-muted hover:text-parish-accent">
            {n.toSite}
          </Link>
        </nav>
        <form action={signOut} className="mt-8">
          <button
            type="submit"
            className="text-xs text-parish-muted underline hover:text-parish-accent"
          >
            {n.signOut}
          </button>
        </form>
      </aside>
      <div className="min-w-0 flex-1 p-4 pb-[max(1rem,env(safe-area-inset-bottom))] ps-[max(1rem,env(safe-area-inset-left))] pe-[max(1rem,env(safe-area-inset-right))] sm:p-8">
        <AdminMobileNav lang={lang} profile={profile} />
        <AdminSaveNotice text={savedText} />
        {children}
      </div>
    </div>
  );
}
