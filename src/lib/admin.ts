import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";

export type StaffProfile = {
  id: string;
  role: "admin" | "superadmin";
  email: string | null;
  full_name: string | null;
};

export async function requireStaff(): Promise<StaffProfile> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/admin/login");
  const { data: profile } = await supabase
    .from("profiles")
    .select("id, role, email, full_name")
    .eq("id", user.id)
    .single();
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
