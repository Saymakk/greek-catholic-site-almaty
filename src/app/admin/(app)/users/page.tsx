import { requireSuperadmin } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { adminUsersScreenCopy } from "@/lib/admin-layout-i18n";
import { CreateUserForm } from "./create-user-form";

export default async function AdminUsersPage() {
  await requireSuperadmin();
  const lang = await getLang();
  const c = adminUsersScreenCopy(lang);

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{c.pageTitle}</h1>
      <p className="mt-2 text-sm text-parish-muted">{c.intro}</p>
      <CreateUserForm copy={c} />
    </div>
  );
}
