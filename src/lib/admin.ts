import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";

export type StaffProfile = {
  id: string;
  role: "admin" | "superadmin";
  email: string | null;
  full_name: string | null;
  can_view_all_objects: boolean;
  can_edit_all_objects: boolean;
};

export async function requireStaff(): Promise<StaffProfile> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/admin/login");
  let prof = await supabase
    .from("profiles")
    .select("id, role, email, full_name, can_view_all_objects, can_edit_all_objects")
    .eq("id", user.id)
    .single();
  if (prof.error && isSchemaCacheMissingColumn(prof.error, "can_view_all_objects")) {
    prof = await supabase
      .from("profiles")
      .select("id, role, email, full_name")
      .eq("id", user.id)
      .single();
  }
  const profile = prof.data
    ? {
        ...prof.data,
        can_view_all_objects: (prof.data as { can_view_all_objects?: boolean }).can_view_all_objects ?? true,
        can_edit_all_objects: (prof.data as { can_edit_all_objects?: boolean }).can_edit_all_objects ?? true,
      }
    : null;
  if (!profile || (profile.role !== "admin" && profile.role !== "superadmin")) {
    redirect("/admin/login");
  }
  return profile as StaffProfile;
}

export async function requireSuperadmin(): Promise<StaffProfile> {
  const p = await requireStaff();
  if (p.role !== "superadmin") redirect("/admin");
  return p;
}

export async function requireStaffCanViewObjects(): Promise<StaffProfile> {
  const p = await requireStaff();
  if (p.role !== "superadmin" && !p.can_view_all_objects) redirect("/admin/account");
  return p;
}

export async function requireStaffCanEditObjects(): Promise<StaffProfile> {
  const p = await requireStaff();
  if (p.role !== "superadmin" && !p.can_edit_all_objects) redirect("/admin/account");
  return p;
}
