"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const LANGS = ["ru", "uk", "kk", "en"] as const;
const KINDS = [
  "great_feast",
  "feast",
  "sunday",
  "fast",
  "commemoration",
  "other",
] as const;

export async function deleteLiturgicalEventForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  await requireStaff();
  const supabase = await createClient();
  await supabase.from("liturgical_events").delete().eq("id", id);
  revalidatePath("/");
  revalidatePath("/admin/calendar");
}

export async function saveLiturgicalEvent(formData: FormData) {
  await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string) || "";
  const event_date = formData.get("event_date") as string;
  const kind = formData.get("kind") as string;
  if (!event_date || !KINDS.includes(kind as (typeof KINDS)[number])) {
    throw new Error("Неверные дата или тип");
  }

  let eventId = id;
  if (!eventId) {
    const { data, error } = await supabase
      .from("liturgical_events")
      .insert({
        event_date,
        kind,
        sort_order: Number(formData.get("sort_order") || 0),
      })
      .select("id")
      .single();
    if (error) throw new Error(error.message);
    eventId = data.id;
  } else {
    await supabase
      .from("liturgical_events")
      .update({
        event_date,
        kind,
        sort_order: Number(formData.get("sort_order") || 0),
      })
      .eq("id", eventId);
  }

  for (const lang of LANGS) {
    const title = (formData.get(`title_${lang}`) as string)?.trim() ?? "";
    const explanation = (formData.get(`explanation_${lang}`) as string)?.trim() ?? "";
    if (!title && !explanation) continue;
    const prayer = (formData.get(`prayer_${lang}`) as string)?.trim() || null;
    const { error } = await supabase.from("liturgical_event_i18n").upsert(
      {
        event_id: eventId,
        lang,
        title: title || "—",
        explanation: explanation || "<p></p>",
        prayer,
      },
      { onConflict: "event_id,lang" },
    );
    if (error) throw new Error(error.message);
  }

  revalidatePath("/");
  redirect("/admin/calendar");
}
