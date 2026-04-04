"use server";

import { createClient } from "@/lib/supabase/server";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

const ACTIVITY_COOKIE = "parish_activity_at";

export async function signOut() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  (await cookies()).delete(ACTIVITY_COOKIE);
  redirect("/admin/login");
}
