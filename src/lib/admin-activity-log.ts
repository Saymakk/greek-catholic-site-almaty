import { revalidatePath } from "next/cache";
import type { createClient } from "@/lib/supabase/server";
import type { StaffProfile } from "@/lib/admin";

export type AdminActivityPayload = {
  action: string;
  entityType: string;
  entityId?: string | null;
  summary?: string | null;
  meta?: Record<string, unknown> | null;
};

type SupabaseServer = Awaited<ReturnType<typeof createClient>>;

/** Запись в журнал; ошибки не прерывают основное действие. */
export async function logAdminActivity(
  supabase: SupabaseServer,
  actor: Pick<StaffProfile, "id" | "email">,
  entry: AdminActivityPayload,
): Promise<void> {
  const { error } = await supabase.from("admin_activity_log").insert({
    actor_id: actor.id,
    actor_email: actor.email ?? "",
    action: entry.action,
    entity_type: entry.entityType,
    entity_id: entry.entityId ?? null,
    summary: entry.summary ?? null,
    meta: entry.meta ?? {},
  });
  if (error) {
    console.warn("[admin_activity_log]", error.message);
    return;
  }
  revalidatePath("/admin");
}
