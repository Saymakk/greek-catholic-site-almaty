"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { isContentLang, type ContentLang } from "../books/book-locales";

const LANGS: ContentLang[] = ["ru", "uk", "kk", "en"];

function firstTitleFromCalendarForm(formData: FormData): string | null {
  for (const l of LANGS) {
    const t = (formData.get(`title_${l}`) as string)?.trim();
    if (t) return t.length > 200 ? `${t.slice(0, 200)}…` : t;
  }
  return null;
}
const KINDS = [
  "great_feast",
  "feast",
  "sunday",
  "fast",
  "commemoration",
  "other",
] as const;

function orderedLocales(primary: ContentLang, present: Set<string>): ContentLang[] {
  return [primary, ...LANGS.filter((l) => l !== primary && present.has(l))];
}

async function uploadLiturgicalCover(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  file: File,
) {
  const ext = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const path = `liturgical/${eventId}/cover.${ext}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const { error } = await supabase.storage.from("news-images").upload(path, buf, {
    contentType: file.type || "image/jpeg",
    upsert: true,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("news-images").getPublicUrl(path);
  return data.publicUrl;
}

export async function removeLiturgicalCover(eventId: string) {
  const profile = await requireStaff();
  if (!eventId) return;
  const supabase = await createClient();
  const { error } = await supabase
    .from("liturgical_events")
    .update({ cover_image_url: null })
    .eq("id", eventId);
  if (error && !isSchemaCacheMissingColumn(error, "cover_image_url")) {
    throw new Error(error.message);
  }
  await logAdminActivity(supabase, profile, {
    action: "liturgical.cover_remove",
    entityType: "liturgical_event",
    entityId: eventId,
  });
  revalidatePath("/");
  revalidatePath("/admin/calendar");
}

export async function deleteLiturgicalEventForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("liturgical_events").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "liturgical.delete",
    entityType: "liturgical_event",
    entityId: id,
  });
  revalidatePath("/");
  revalidatePath("/admin/calendar");
}

export async function saveLiturgicalEvent(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string) || "";
  const event_date = formData.get("event_date") as string;
  const kind = formData.get("kind") as string;
  if (!event_date || !KINDS.includes(kind as (typeof KINDS)[number])) {
    throw new Error("Неверные дата или тип");
  }

  const primaryRaw = (formData.get("primary_lang") as string)?.trim() ?? "ru";
  if (!isContentLang(primaryRaw)) throw new Error("Invalid primary_lang");
  const primary_lang = primaryRaw;

  const localesRaw = ((formData.get("locales") as string) ?? primary_lang)
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);
  const present = new Set<string>();
  for (const l of localesRaw) {
    if (isContentLang(l)) present.add(l);
  }
  present.add(primary_lang);
  const locales = orderedLocales(primary_lang, present);

  let eventId = id;
  if (!eventId) {
    let ins = await supabase
      .from("liturgical_events")
      .insert({
        event_date,
        kind,
        sort_order: Number(formData.get("sort_order") || 0),
        primary_lang,
      })
      .select("id")
      .single();
    if (ins.error && isSchemaCacheMissingColumn(ins.error, "primary_lang")) {
      ins = await supabase
        .from("liturgical_events")
        .insert({
          event_date,
          kind,
          sort_order: Number(formData.get("sort_order") || 0),
        })
        .select("id")
        .single();
    }
    if (ins.error) throw new Error(ins.error.message);
    eventId = ins.data!.id;
  } else {
    let up = await supabase
      .from("liturgical_events")
      .update({
        event_date,
        kind,
        sort_order: Number(formData.get("sort_order") || 0),
        primary_lang,
      })
      .eq("id", eventId);
    if (up.error && isSchemaCacheMissingColumn(up.error, "primary_lang")) {
      up = await supabase
        .from("liturgical_events")
        .update({
          event_date,
          kind,
          sort_order: Number(formData.get("sort_order") || 0),
        })
        .eq("id", eventId);
    }
    if (up.error) throw new Error(up.error.message);
  }

  const cover = formData.get("cover");
  if (cover instanceof File && cover.size > 0) {
    const url = await uploadLiturgicalCover(supabase, eventId, cover);
    const { error: coverErr } = await supabase
      .from("liturgical_events")
      .update({ cover_image_url: url })
      .eq("id", eventId);
    if (coverErr && !isSchemaCacheMissingColumn(coverErr, "cover_image_url")) {
      throw new Error(coverErr.message);
    }
  }

  for (const lang of locales) {
    const title = (formData.get(`title_${lang}`) as string)?.trim() ?? "";
    const explanation = (formData.get(`explanation_${lang}`) as string)?.trim() ?? "";
    if (!title && !explanation) {
      await supabase
        .from("liturgical_event_i18n")
        .delete()
        .eq("event_id", eventId)
        .eq("lang", lang);
      continue;
    }
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

  const { data: existingRows } = await supabase
    .from("liturgical_event_i18n")
    .select("lang")
    .eq("event_id", eventId);
  for (const r of existingRows ?? []) {
    const lg = (r as { lang: string }).lang;
    if (!(locales as readonly string[]).includes(lg)) {
      const { error } = await supabase
        .from("liturgical_event_i18n")
        .delete()
        .eq("event_id", eventId)
        .eq("lang", lg);
      if (error) throw new Error(error.message);
    }
  }

  const titleHint = firstTitleFromCalendarForm(formData);
  await logAdminActivity(supabase, profile, {
    action: id ? "liturgical.update" : "liturgical.create",
    entityType: "liturgical_event",
    entityId: eventId,
    summary: titleHint,
    meta: { event_date, kind },
  });

  revalidatePath("/");
  redirect("/admin/calendar");
}
