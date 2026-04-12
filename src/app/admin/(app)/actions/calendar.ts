"use server";

import { randomUUID } from "crypto";
import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import type { StaffProfile } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { parseExternalLiturgicalWidgetValue } from "@/lib/data";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { isContentLang, type ContentLang } from "../books/book-locales";
import { parseHttpImageUrlFromFormData } from "@/lib/admin-image-url";
import {
  expandLiturgicalRecurrence,
  type LiturgicalRecurrenceFreq,
} from "@/lib/liturgical-recurrence";

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

const PRESET_KINDS = new Set<string>(KINDS);

function resolveKind(formData: FormData): string {
  const mode = (formData.get("kind_mode") as string) || "preset";
  if (mode === "custom") {
    let s = (formData.get("kind_slug") as string)?.trim().toLowerCase() ?? "";
    s = s.replace(/[^a-z0-9_]/g, "_").replace(/^_+/, "");
    if (!s.length) throw new Error("Empty kind slug");
    if (!/^[a-z][a-z0-9_]{0,62}$/.test(s)) throw new Error("Invalid kind slug");
    return s;
  }
  const p = (formData.get("kind_preset") as string)?.trim() ?? "feast";
  if (!PRESET_KINDS.has(p)) throw new Error("Invalid preset kind");
  return p;
}

type ExtraIn = {
  label_ru?: string | null;
  label_uk?: string | null;
  label_kk?: string | null;
  label_en?: string | null;
  body_ru?: string | null;
  body_uk?: string | null;
  body_kk?: string | null;
  body_en?: string | null;
  url?: string | null;
};

function parseExtrasJson(raw: string): ExtraIn[] {
  try {
    const j = JSON.parse(raw || "[]");
    return Array.isArray(j) ? j : [];
  } catch {
    return [];
  }
}

function nz(s: unknown): string | null {
  const t = typeof s === "string" ? s.trim() : "";
  return t.length ? t : null;
}

async function persistLiturgicalExtras(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  rows: ExtraIn[],
) {
  await supabase.from("liturgical_event_extra_fields").delete().eq("event_id", eventId);
  let sortIdx = 0;
  for (const row of rows) {
    const bodyRu = (row.body_ru ?? "").trim();
    const bodyUk = (row.body_uk ?? "").trim();
    const bodyKk = (row.body_kk ?? "").trim();
    const bodyEn = (row.body_en ?? "").trim();
    const hasBody = !!(bodyRu || bodyUk || bodyKk || bodyEn);
    if (!hasBody) continue;
    let url: string | null = (row.url ?? "").trim() || null;
    if (url && !hasBody) url = null;
    const { error } = await supabase.from("liturgical_event_extra_fields").insert({
      event_id: eventId,
      sort_idx: sortIdx++,
      label_ru: nz(row.label_ru),
      label_uk: nz(row.label_uk),
      label_kk: nz(row.label_kk),
      label_en: nz(row.label_en),
      body_ru: bodyRu || null,
      body_uk: bodyUk || null,
      body_kk: bodyKk || null,
      body_en: bodyEn || null,
      url,
    });
    if (error) throw new Error(error.message);
  }
}

async function syncKindLabelsFromForm(
  supabase: Awaited<ReturnType<typeof createClient>>,
  kindSlug: string,
  formData: FormData,
) {
  for (const L of LANGS) {
    const label = (formData.get(`kind_label_${L}`) as string)?.trim() ?? "";
    if (label) {
      const { error } = await supabase.from("liturgical_kind_i18n").upsert(
        { kind_slug: kindSlug, lang: L, label },
        { onConflict: "kind_slug,lang" },
      );
      if (error) throw new Error(error.message);
    } else {
      const { error } = await supabase
        .from("liturgical_kind_i18n")
        .delete()
        .eq("kind_slug", kindSlug)
        .eq("lang", L);
      if (error) throw new Error(error.message);
    }
  }
}

function orderedLocales(primary: ContentLang, present: Set<string>): ContentLang[] {
  return [primary, ...LANGS.filter((l) => l !== primary && present.has(l))];
}

function parseRecurrenceForNewEvent(formData: FormData): {
  freq: LiturgicalRecurrenceFreq;
  total: number;
} | null {
  if ((formData.get("recurrence_repeat") as string) !== "1") return null;
  const freqRaw = (formData.get("recurrence_freq") as string) ?? "weekly";
  const freq: LiturgicalRecurrenceFreq =
    freqRaw === "daily" || freqRaw === "monthly" ? freqRaw : "weekly";
  let total = parseInt(String(formData.get("recurrence_total") ?? "2"), 10);
  if (!Number.isFinite(total)) total = 2;
  total = Math.min(100, Math.max(2, total));
  return { freq, total };
}

async function insertNewLiturgicalEventRow(
  supabase: Awaited<ReturnType<typeof createClient>>,
  profile: StaffProfile,
  event_date: string,
  kind: string,
  primary_lang: ContentLang,
): Promise<string> {
  let ins = await supabase
    .from("liturgical_events")
    .insert({
      event_date,
      kind,
      primary_lang,
      created_by: profile.id,
    })
    .select("id")
    .single();
  if (ins.error && isSchemaCacheMissingColumn(ins.error, "created_by")) {
    ins = await supabase
      .from("liturgical_events")
      .insert({
        event_date,
        kind,
        primary_lang,
      })
      .select("id")
      .single();
  }
  if (ins.error && isSchemaCacheMissingColumn(ins.error, "primary_lang")) {
    ins = await supabase
      .from("liturgical_events")
      .insert({
        event_date,
        kind,
        created_by: profile.id,
      })
      .select("id")
      .single();
  }
  if (ins.error && isSchemaCacheMissingColumn(ins.error, "created_by")) {
    ins = await supabase
      .from("liturgical_events")
      .insert({
        event_date,
        kind,
      })
      .select("id")
      .single();
  }
  if (ins.error) throw new Error(ins.error.message);
  return ins.data!.id;
}

async function setLiturgicalRecurrenceSeriesId(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  seriesId: string,
) {
  const { error } = await supabase
    .from("liturgical_events")
    .update({ recurrence_series_id: seriesId })
    .eq("id", eventId);
  if (error && !isSchemaCacheMissingColumn(error, "recurrence_series_id")) {
    throw new Error(error.message);
  }
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

async function applyLiturgicalCoverFromForm(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  formData: FormData,
): Promise<string | null> {
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
    return url;
  }
  const coverUrl = parseHttpImageUrlFromFormData(formData, "cover_image_url", "Обложка (URL)");
  if (coverUrl) {
    const { error: coverErr } = await supabase
      .from("liturgical_events")
      .update({ cover_image_url: coverUrl })
      .eq("id", eventId);
    if (coverErr && !isSchemaCacheMissingColumn(coverErr, "cover_image_url")) {
      throw new Error(coverErr.message);
    }
    return coverUrl;
  }
  return null;
}

async function copyLiturgicalCoverUrl(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  coverUrl: string,
) {
  const { error } = await supabase
    .from("liturgical_events")
    .update({ cover_image_url: coverUrl })
    .eq("id", eventId);
  if (error && !isSchemaCacheMissingColumn(error, "cover_image_url")) {
    throw new Error(error.message);
  }
}

async function persistLiturgicalEventTranslations(
  supabase: Awaited<ReturnType<typeof createClient>>,
  eventId: string,
  formData: FormData,
  locales: ContentLang[],
) {
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
  const kind = resolveKind(formData);
  if (!event_date) {
    throw new Error("Invalid date");
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

  const extrasRows = parseExtrasJson((formData.get("extras_json") as string) ?? "[]");

  const recurrenceOpts = !id ? parseRecurrenceForNewEvent(formData) : null;
  if (!id && recurrenceOpts) {
    const dates = expandLiturgicalRecurrence(
      event_date,
      recurrenceOpts.freq,
      recurrenceOpts.total,
    );
    if (dates.length >= 2) {
      const titleHint = firstTitleFromCalendarForm(formData);
      const seriesId = randomUUID();
      let firstEventId = "";
      let sharedCover: string | null = null;
      for (let i = 0; i < dates.length; i++) {
        const d = dates[i]!;
        const eid = await insertNewLiturgicalEventRow(supabase, profile, d, kind, primary_lang);
        await setLiturgicalRecurrenceSeriesId(supabase, eid, seriesId);
        if (i === 0) {
          sharedCover = await applyLiturgicalCoverFromForm(supabase, eid, formData);
          firstEventId = eid;
        } else if (sharedCover) {
          await copyLiturgicalCoverUrl(supabase, eid, sharedCover);
        }
        await persistLiturgicalEventTranslations(supabase, eid, formData, locales);
        await persistLiturgicalExtras(supabase, eid, extrasRows);
      }
      await syncKindLabelsFromForm(supabase, kind, formData);
      await logAdminActivity(supabase, profile, {
        action: "liturgical.create",
        entityType: "liturgical_event",
        entityId: firstEventId,
        summary: titleHint,
        meta: {
          event_date,
          kind,
          recurrence_series_id: seriesId,
          recurrence_count: dates.length,
        },
      });
      revalidatePath("/");
      revalidatePath("/library");
      const skipOffer = (formData.get("skip_offer_template") as string) === "1";
      if (skipOffer) {
        redirect("/admin/calendar");
      }
      redirect(`/admin/calendar?offerTemplate=${encodeURIComponent(firstEventId)}`);
    }
  }

  let eventId = id;
  if (!eventId) {
    eventId = await insertNewLiturgicalEventRow(supabase, profile, event_date, kind, primary_lang);
  } else {
    let up = await supabase
      .from("liturgical_events")
      .update({
        event_date,
        kind,
        primary_lang,
      })
      .eq("id", eventId);
    if (up.error && isSchemaCacheMissingColumn(up.error, "primary_lang")) {
      up = await supabase
        .from("liturgical_events")
        .update({
          event_date,
          kind,
        })
        .eq("id", eventId);
    }
    if (up.error) throw new Error(up.error.message);
  }

  await applyLiturgicalCoverFromForm(supabase, eventId, formData);

  await persistLiturgicalEventTranslations(supabase, eventId, formData, locales);

  await persistLiturgicalExtras(supabase, eventId, extrasRows);
  await syncKindLabelsFromForm(supabase, kind, formData);

  const titleHint = firstTitleFromCalendarForm(formData);
  await logAdminActivity(supabase, profile, {
    action: id ? "liturgical.update" : "liturgical.create",
    entityType: "liturgical_event",
    entityId: eventId,
    summary: titleHint,
    meta: { event_date, kind },
  });

  revalidatePath("/");
  revalidatePath("/library");
  const skipOffer = (formData.get("skip_offer_template") as string) === "1";
  if (skipOffer) {
    redirect("/admin/calendar");
  }
  redirect(`/admin/calendar?offerTemplate=${encodeURIComponent(eventId)}`);
}

export async function saveLiturgicalTemplateForm(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const name = (formData.get("template_name") as string)?.trim();
  const rowsRaw = (formData.get("template_rows_json") as string) ?? "[]";
  if (!name) throw new Error("Template name required");
  let rows: { label_ru?: string | null; label_uk?: string | null; label_kk?: string | null; label_en?: string | null }[] =
    [];
  try {
    const j = JSON.parse(rowsRaw);
    if (Array.isArray(j)) rows = j;
  } catch {
    rows = [];
  }
  const { data: ins, error: insErr } = await supabase
    .from("liturgical_event_templates")
    .insert({ name, created_by: profile.id })
    .select("id")
    .single();
  let templateId: string;
  if (insErr && isSchemaCacheMissingColumn(insErr, "created_by")) {
    const retry = await supabase
      .from("liturgical_event_templates")
      .insert({ name })
      .select("id")
      .single();
    if (retry.error) throw new Error(retry.error.message);
    templateId = retry.data!.id;
  } else if (insErr) {
    throw new Error(insErr.message);
  } else {
    templateId = ins!.id;
  }
  await insertTemplateRows(supabase, templateId, rows);
  await logAdminActivity(supabase, profile, {
    action: "liturgical.template_create",
    entityType: "liturgical_template",
    entityId: null,
    summary: name,
  });
  revalidatePath("/admin/calendar");
  redirect("/admin/calendar");
}

async function insertTemplateRows(
  supabase: Awaited<ReturnType<typeof createClient>>,
  templateId: string,
  rows: { label_ru?: string | null; label_uk?: string | null; label_kk?: string | null; label_en?: string | null }[],
) {
  let i = 0;
  for (const row of rows) {
    const { error } = await supabase.from("liturgical_event_template_rows").insert({
      template_id: templateId,
      sort_idx: i++,
      label_ru: nz(row.label_ru),
      label_uk: nz(row.label_uk),
      label_kk: nz(row.label_kk),
      label_en: nz(row.label_en),
    });
    if (error) throw new Error(error.message);
  }
}

export async function deleteLiturgicalTemplateForm(formData: FormData) {
  const id = formData.get("id") as string;
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("liturgical_event_templates").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "liturgical.template_delete",
    entityType: "liturgical_template",
    entityId: id,
  });
  revalidatePath("/admin/calendar");
  redirect("/admin/calendar");
}

export async function saveLiturgicalTemplateFromEventForm(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const eventId = (formData.get("event_id") as string)?.trim();
  const name = (formData.get("template_name") as string)?.trim();
  if (!eventId || !name) throw new Error("Missing event or template name");

  const { data: ev, error: evErr } = await supabase
    .from("liturgical_events")
    .select("id, created_by")
    .eq("id", eventId)
    .single();
  if (evErr || !ev) throw new Error("Event not found");
  const row = ev as { id: string; created_by: string | null };
  if (profile.role !== "superadmin") {
    if (row.created_by != null && row.created_by !== profile.id) {
      throw new Error("Forbidden");
    }
  }

  const { data: exRows, error: exErr } = await supabase
    .from("liturgical_event_extra_fields")
    .select("label_ru, label_uk, label_kk, label_en")
    .eq("event_id", eventId)
    .order("sort_idx", { ascending: true });
  if (exErr) throw new Error(exErr.message);

  const rows =
    (exRows ?? []) as {
      label_ru: string | null;
      label_uk: string | null;
      label_kk: string | null;
      label_en: string | null;
    }[];

  const { data: ins, error: insErr } = await supabase
    .from("liturgical_event_templates")
    .insert({ name, created_by: profile.id })
    .select("id")
    .single();
  let templateId: string;
  if (insErr && isSchemaCacheMissingColumn(insErr, "created_by")) {
    const retry = await supabase
      .from("liturgical_event_templates")
      .insert({ name })
      .select("id")
      .single();
    if (retry.error) throw new Error(retry.error.message);
    templateId = retry.data!.id;
  } else if (insErr) {
    throw new Error(insErr.message);
  } else {
    templateId = ins!.id;
  }
  await insertTemplateRows(supabase, templateId, rows);
  await logAdminActivity(supabase, profile, {
    action: "liturgical.template_create",
    entityType: "liturgical_template",
    entityId: templateId,
    summary: name,
  });
  revalidatePath("/admin/calendar");
  redirect("/admin/calendar");
}

export async function updateLiturgicalTemplateForm(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = (formData.get("id") as string)?.trim();
  const name = (formData.get("template_name") as string)?.trim();
  const rowsRaw = (formData.get("template_rows_json") as string) ?? "[]";
  if (!id || !name) throw new Error("Missing template id or name");

  let rows: { label_ru?: string | null; label_uk?: string | null; label_kk?: string | null; label_en?: string | null }[] =
    [];
  try {
    const j = JSON.parse(rowsRaw);
    if (Array.isArray(j)) rows = j;
  } catch {
    rows = [];
  }

  const { error: upErr } = await supabase
    .from("liturgical_event_templates")
    .update({ name })
    .eq("id", id);
  if (upErr) throw new Error(upErr.message);

  const { error: delErr } = await supabase
    .from("liturgical_event_template_rows")
    .delete()
    .eq("template_id", id);
  if (delErr) throw new Error(delErr.message);

  await insertTemplateRows(supabase, id, rows);
  await logAdminActivity(supabase, profile, {
    action: "liturgical.template_update",
    entityType: "liturgical_template",
    entityId: id,
    summary: name,
  });
  revalidatePath("/admin/calendar");
  redirect("/admin/calendar");
}

export async function saveExternalLiturgicalWidgetForm(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const { data: row } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "external_liturgical_widget")
    .maybeSingle();
  const cur = parseExternalLiturgicalWidgetValue(row?.value);

  const action = (formData.get("widget_action") as string)?.trim();
  let next: { new_julian: boolean; gregorian: boolean };
  if (action === "toggle_new_julian") {
    next = { ...cur, new_julian: !cur.new_julian };
  } else if (action === "toggle_gregorian") {
    next = { ...cur, gregorian: !cur.gregorian };
  } else {
    redirect("/admin/calendar");
    return;
  }

  const { error } = await supabase.from("site_settings").upsert({
    key: "external_liturgical_widget",
    value: next,
  });
  if (error) throw new Error(error.message);

  const summary = `${next.new_julian ? "nj" : ""}${next.gregorian ? "g" : ""}` || "none";
  await logAdminActivity(supabase, profile, {
    action: "liturgical.external_widget.save",
    entityType: "site_settings",
    entityId: "external_liturgical_widget",
    summary,
  });
  revalidatePath("/");
  revalidatePath("/admin/calendar");
  redirect("/admin/calendar");
}
