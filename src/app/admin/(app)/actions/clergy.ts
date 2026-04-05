"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { parseHttpImageUrlFromFormData } from "@/lib/admin-image-url";
import type { ClergyExtraField } from "@/lib/data";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const IMAGE_EXT = new Set(["jpg", "jpeg", "png", "webp", "gif"]);
const IMAGE_MAX = 8 * 1024 * 1024;
const MAX_EXTRA = 40;
const MAX_LABEL = 200;
const MAX_VALUE = 4000;
const MAX_URL = 2048;
const LANGS = ["ru", "uk", "kk", "en"] as const;

function strForm(formData: FormData, key: string): string | null {
  const v = (formData.get(key) as string)?.trim();
  return v ? v : null;
}

function parseExtraFieldsJson(raw: string | null): ClergyExtraField[] {
  if (!raw?.trim()) return [];
  try {
    const arr = JSON.parse(raw) as unknown;
    if (!Array.isArray(arr)) return [];
    const out: ClergyExtraField[] = [];
    for (const item of arr) {
      if (out.length >= MAX_EXTRA) break;
      const o = item as Record<string, unknown>;
      const labels: ClergyExtraField["labels"] = {};
      const values: ClergyExtraField["values"] = {};
      const lo = o.labels;
      if (lo && typeof lo === "object") {
        for (const l of LANGS) {
          const v = (lo as Record<string, unknown>)[l];
          if (typeof v === "string" && v.trim()) {
            labels[l] = v.trim().slice(0, MAX_LABEL);
          }
        }
      }
      const vo = o.values;
      if (vo && typeof vo === "object") {
        for (const l of LANGS) {
          const v = (vo as Record<string, unknown>)[l];
          if (typeof v === "string" && v.trim()) {
            values[l] = v.trim().slice(0, MAX_VALUE);
          }
        }
      }
      let url: string | null = null;
      if (typeof o.url === "string" && o.url.trim()) {
        url = o.url.trim().slice(0, MAX_URL);
      }
      if (Object.keys(labels).length === 0 && Object.keys(values).length === 0 && !url) continue;
      out.push({ labels, values, url });
    }
    return out;
  } catch {
    return [];
  }
}

function assertImageFile(file: File) {
  if (!file.type.startsWith("image/")) throw new Error("Нужен файл изображения");
  if (file.size > IMAGE_MAX) throw new Error("Файл больше 8 МБ");
}

async function uploadClergyPhoto(
  supabase: Awaited<ReturnType<typeof createClient>>,
  clergyId: string,
  file: File,
): Promise<string> {
  const extRaw = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const safeExt = IMAGE_EXT.has(extRaw) ? extRaw : "jpg";
  const path = `clergy/${clergyId}/photo_${Date.now()}.${safeExt}`;
  const buf = Buffer.from(await file.arrayBuffer());
  const contentType =
    file.type && file.type.startsWith("image/")
      ? file.type
      : safeExt === "png"
        ? "image/png"
        : safeExt === "webp"
          ? "image/webp"
          : safeExt === "gif"
            ? "image/gif"
            : "image/jpeg";
  const { error } = await supabase.storage.from("news-images").upload(path, buf, {
    contentType,
    upsert: true,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("news-images").getPublicUrl(path);
  return data.publicUrl;
}

export async function deleteClergyForm(formData: FormData) {
  const id = (formData.get("id") as string)?.trim();
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("clergy").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "clergy.delete",
    entityType: "clergy",
    entityId: id,
  });
  revalidatePath("/admin/clergy");
  redirect("/admin/clergy");
}

export async function reorderClergyForm(formData: FormData) {
  await requireStaff();
  const id = (formData.get("id") as string)?.trim();
  const dir = (formData.get("dir") as string)?.trim();
  if (!id || (dir !== "up" && dir !== "down")) {
    redirect("/admin/clergy");
  }
  const supabase = await createClient();
  const { data: rows, error } = await supabase
    .from("clergy")
    .select("id, sort_order")
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error || !rows?.length) redirect("/admin/clergy");
  const list = rows as { id: string; sort_order: number }[];
  const idx = list.findIndex((r) => r.id === id);
  if (idx < 0) redirect("/admin/clergy");
  const j = dir === "up" ? idx - 1 : idx + 1;
  if (j < 0 || j >= list.length) redirect("/admin/clergy");
  const a = list[idx];
  const b = list[j];
  const sa = a.sort_order;
  const sb = b.sort_order;
  await supabase.from("clergy").update({ sort_order: sb }).eq("id", a.id);
  await supabase.from("clergy").update({ sort_order: sa }).eq("id", b.id);
  revalidatePath("/admin/clergy");
  redirect("/admin/clergy");
}

export async function saveClergy(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = ((formData.get("id") as string) ?? "").trim();

  const full_name_ru = strForm(formData, "full_name_ru");
  const full_name_uk = strForm(formData, "full_name_uk");
  const full_name_kk = strForm(formData, "full_name_kk");
  const full_name_en = strForm(formData, "full_name_en");
  const full_name = full_name_ru || full_name_uk || full_name_kk || full_name_en;
  if (!full_name) throw new Error("Укажите ФИО хотя бы на одном языке");

  const extra_fields = parseExtraFieldsJson(formData.get("extra_fields") as string | null);
  const photo = formData.get("photo");
  const hasPhotoFile = photo instanceof File && photo.size > 0;
  const photoUrlField = parseHttpImageUrlFromFormData(formData, "photo_url", "Фото (URL)");

  const sortRaw = (formData.get("sort_order") as string)?.trim() ?? "";
  let sortOrderParsed: number | undefined;
  if (sortRaw !== "") {
    const n = parseInt(sortRaw, 10);
    if (!Number.isNaN(n)) sortOrderParsed = n;
  }

  const patch: Record<string, unknown> = {
    full_name,
    full_name_ru,
    full_name_uk,
    full_name_kk,
    full_name_en,
    extra_fields,
    updated_at: new Date().toISOString(),
  };
  if (sortOrderParsed !== undefined) {
    patch.sort_order = sortOrderParsed;
  }

  if (!id) {
    if (!hasPhotoFile && !photoUrlField) {
      throw new Error("Загрузите фотографию или укажите ссылку на изображение");
    }

    const { data: maxRow } = await supabase
      .from("clergy")
      .select("sort_order")
      .order("sort_order", { ascending: false })
      .limit(1)
      .maybeSingle();
    const nextOrder = (maxRow?.sort_order ?? -1) + 1;
    const insSort = sortOrderParsed !== undefined ? sortOrderParsed : nextOrder;
    patch.sort_order = insSort;

    let clergyId: string;

    if (hasPhotoFile) {
      assertImageFile(photo);
      const ins = await supabase
        .from("clergy")
        .insert({
          ...patch,
        })
        .select("id")
        .single();
      if (ins.error) throw new Error(ins.error.message);
      clergyId = ins.data!.id as string;
      try {
        const url = await uploadClergyPhoto(supabase, clergyId, photo);
        const up = await supabase
          .from("clergy")
          .update({ photo_url: url, updated_at: new Date().toISOString() })
          .eq("id", clergyId);
        if (up.error) throw new Error(up.error.message);
      } catch (e) {
        await supabase.from("clergy").delete().eq("id", clergyId);
        throw e;
      }
    } else {
      const ins = await supabase
        .from("clergy")
        .insert({
          ...patch,
          photo_url: photoUrlField,
        })
        .select("id")
        .single();
      if (ins.error) throw new Error(ins.error.message);
      clergyId = ins.data!.id as string;
    }

    await logAdminActivity(supabase, profile, {
      action: "clergy.create",
      entityType: "clergy",
      entityId: clergyId,
      summary: full_name,
    });
  } else {
    const up = await supabase.from("clergy").update(patch).eq("id", id);
    if (up.error) throw new Error(up.error.message);

    if (hasPhotoFile) {
      assertImageFile(photo);
      const url = await uploadClergyPhoto(supabase, id, photo);
      const upPhoto = await supabase
        .from("clergy")
        .update({ photo_url: url, updated_at: new Date().toISOString() })
        .eq("id", id);
      if (upPhoto.error) throw new Error(upPhoto.error.message);
    } else if (photoUrlField) {
      const upPhoto = await supabase
        .from("clergy")
        .update({ photo_url: photoUrlField, updated_at: new Date().toISOString() })
        .eq("id", id);
      if (upPhoto.error) throw new Error(upPhoto.error.message);
    } else {
      const { data: row } = await supabase.from("clergy").select("photo_url").eq("id", id).single();
      const hasPhoto = !!(row?.photo_url as string | null)?.trim();
      if (!hasPhoto) throw new Error("Загрузите фотографию или укажите ссылку на изображение");
    }

    await logAdminActivity(supabase, profile, {
      action: "clergy.update",
      entityType: "clergy",
      entityId: id,
      summary: full_name,
    });
  }

  revalidatePath("/admin/clergy");
  redirect("/admin/clergy");
}
