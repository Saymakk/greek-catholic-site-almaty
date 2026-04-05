import { createClient } from "@/lib/supabase/server";
import { requireSuperadmin } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { adminUsersScreenCopy } from "@/lib/admin-layout-i18n";
import { AdminUsersClient, type AdminUserRow } from "./AdminUsersClient";

export default async function AdminUsersPage() {
  const me = await requireSuperadmin();
  const lang = await getLang();
  const c = adminUsersScreenCopy(lang);

  const supabase = await createClient();
  const { data: rows, error } = await supabase
    .from("profiles")
    .select("id, email, full_name, role, created_at")
    .order("created_at", { ascending: true });

  const users: AdminUserRow[] = error
    ? []
    : ((rows ?? []) as AdminUserRow[]).map((r) => ({
        id: r.id,
        email: r.email,
        full_name: r.full_name,
        role: r.role,
        created_at: r.created_at,
      }));

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{c.pageTitle}</h1>
      <p className="mt-2 text-sm text-parish-muted">{c.intro}</p>
      {error ? (
        <p className="mt-4 text-sm text-red-600">
          {c.errGeneric}: {error.message}
        </p>
      ) : null}
      <AdminUsersClient lang={lang} copy={c} currentUserId={me.id} initialUsers={users} />
    </div>
  );
}
