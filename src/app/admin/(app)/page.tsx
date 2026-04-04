import { requireStaff } from "@/lib/admin";
import Link from "next/link";

export default async function AdminHomePage() {
  const profile = await requireStaff();

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Админка</h1>
      <p className="mt-2 text-sm text-parish-muted">
        Вы вошли как {profile.email} ({profile.role}).
      </p>
      <ul className="mt-8 list-inside list-disc space-y-2 text-sm text-parish-accent sm:hidden">
        <li>
          <Link href="/admin/news">Новости</Link>
        </li>
        <li>
          <Link href="/admin/calendar">Календарь</Link>
        </li>
        <li>
          <Link href="/admin/books">Писание</Link>
        </li>
        <li>
          <Link href="/admin/history">История</Link>
        </li>
        <li>
          <Link href="/admin/settings">Контакты</Link>
        </li>
        <li>
          <Link href="/admin/account">Пароль</Link>
        </li>
        {profile.role === "superadmin" ? (
          <li>
            <Link href="/admin/users">Пользователи</Link>
          </li>
        ) : null}
        <li>
          <Link href="/">На сайт</Link>
        </li>
      </ul>
    </div>
  );
}
