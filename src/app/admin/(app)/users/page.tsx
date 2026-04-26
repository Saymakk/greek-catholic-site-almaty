import { createClient } from "@/lib/supabase/server";
import { requireSuperadmin } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { adminUsersScreenCopy } from "@/lib/admin-layout-i18n";
import { AdminUsersClient, type AdminUserRow } from "./AdminUsersClient";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";

export default async function AdminUsersPage() {
  const me = await requireSuperadmin();
  const lang = await getLang();
  const c = adminUsersScreenCopy(lang);

  const supabase = await createClient();
  const q = await supabase
    .from("profiles")
    .select("id, email, full_name, role, can_view_all_objects, can_edit_all_objects, created_at")
    .order("created_at", { ascending: true });
  let rows = q.data as
    | {
        id: string;
        email: string | null;
        full_name: string | null;
        role: string;
        can_view_all_objects?: boolean;
        can_edit_all_objects?: boolean;
        created_at: string;
      }[]
    | null;
  let error = q.error;
  if (error && isSchemaCacheMissingColumn(error, "can_view_all_objects")) {
    const fallback = await supabase
      .from("profiles")
      .select("id, email, full_name, role, created_at")
      .order("created_at", { ascending: true });
    rows = fallback.data as typeof rows;
    error = fallback.error;
  }

  const users: AdminUserRow[] = error
    ? []
    : (rows ?? []).map((r) => ({
        id: r.id,
        email: r.email,
        full_name: r.full_name,
        role: r.role,
        can_view_all_objects: (r.can_view_all_objects as boolean | undefined) ?? true,
        can_edit_all_objects: (r.can_edit_all_objects as boolean | undefined) ?? true,
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
