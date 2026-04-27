"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { extractMapEmbedSrc } from "@/lib/map-embed";
import { parseHttpImageUrlFromFormData } from "@/lib/admin-image-url";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const LANGS = ["ru", "uk", "kk", "en"] as const;
const IMAGE_EXT = new Set(["jpg", "jpeg", "png", "webp", "gif"]);
const IMAGE_MAX = 8 * 1024 * 1024;

function str(formData: FormData, key: string): string | null {
  const v = (formData.get(key) as string)?.trim();
  return v ? v : null;
}

async function uploadParishImage(
  supabase: Awaited<ReturnType<typeof createClient>>,
  parishId: string,
  role: "parish" | "priest",
  file: File,
): Promise<string> {
  const extRaw = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const safeExt = IMAGE_EXT.has(extRaw) ? extRaw : "jpg";
  const path = `parishes/${parishId}/${role}_${Date.now()}.${safeExt}`;
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

export async function deleteParishForm(formData: FormData) {
  const id = (formData.get("id") as string)?.trim();
  if (!id) return;
  const profile = await requireStaff();
  const supabase = await createClient();
  await supabase.from("kazakhstan_parishes").delete().eq("id", id);
  await logAdminActivity(supabase, profile, {
    action: "parish.delete",
    entityType: "kazakhstan_parish",
    entityId: id,
  });
  revalidatePath("/about/parishes-kz");
  revalidatePath("/admin/parishes");
  redirect("/admin/parishes");
}

export async function reorderParishForm(formData: FormData) {
  await requireStaff();
  const id = (formData.get("id") as string)?.trim();
  const dir = (formData.get("dir") as string)?.trim();
  if (!id || (dir !== "up" && dir !== "down")) {
    redirect("/admin/parishes");
  }
  const supabase = await createClient();
  const { data: rows, error } = await supabase
    .from("kazakhstan_parishes")
    .select("id, sort_order")
    .order("sort_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error || !rows?.length) redirect("/admin/parishes");
  const list = rows as { id: string; sort_order: number }[];
  const idx = list.findIndex((r) => r.id === id);
  if (idx < 0) redirect("/admin/parishes");
  const j = dir === "up" ? idx - 1 : idx + 1;
  if (j < 0 || j >= list.length) redirect("/admin/parishes");
  const a = list[idx];
  const b = list[j];
  const sa = a.sort_order;
  const sb = b.sort_order;
  await supabase.from("kazakhstan_parishes").update({ sort_order: sb }).eq("id", a.id);
  await supabase.from("kazakhstan_parishes").update({ sort_order: sa }).eq("id", b.id);
  revalidatePath("/admin/parishes");
  revalidatePath("/about/parishes-kz");
  redirect("/admin/parishes");
}

export async function removeParishImage(parishId: string, role: "parish" | "priest") {
  const profile = await requireStaff();
  if (!parishId || (role !== "parish" && role !== "priest")) return;
  const supabase = await createClient();
  const col = role === "parish" ? "parish_photo_url" : "priest_photo_url";
  const { error } = await supabase
    .from("kazakhstan_parishes")
    .update({ [col]: null, updated_at: new Date().toISOString() })
    .eq("id", parishId);
  if (error) throw new Error(error.message);
  await logAdminActivity(supabase, profile, {
    action: role === "parish" ? "parish.photo_remove" : "parish.priest_photo_remove",
    entityType: "kazakhstan_parish",
    entityId: parishId,
  });
  revalidatePath("/about/parishes-kz");
  revalidatePath("/admin/parishes");
}

export async function saveParish(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  const id = ((formData.get("id") as string) ?? "").trim();
  const mapRaw = (formData.get("map_embed_raw") as string) ?? "";
  const mapEmbedSrc = extractMapEmbedSrc(mapRaw);

  const patch: Record<string, string | number | boolean | null> = {
    website_url: str(formData, "website_url"),
    map_embed_src: mapEmbedSrc,
    updated_at: new Date().toISOString(),
  };
  for (const l of LANGS) {
    patch[`city_${l}`] = str(formData, `city_${l}`);
    patch[`name_${l}`] = str(formData, `name_${l}`);
    patch[`address_${l}`] = str(formData, `address_${l}`);
    patch[`priest_name_${l}`] = str(formData, `priest_name_${l}`);
    patch[`priest_contacts_${l}`] = str(formData, `priest_contacts_${l}`);
  }

  let parishId = id;
  if (!parishId) {
    const { data: maxRow } = await supabase
      .from("kazakhstan_parishes")
      .select("sort_order")
      .order("sort_order", { ascending: false })
      .limit(1)
      .maybeSingle();
    const nextOrder = (maxRow?.sort_order ?? -1) + 1;
    const ins = await supabase
      .from("kazakhstan_parishes")
      .insert({
        ...patch,
        sort_order: nextOrder,
      })
      .select("id")
      .single();
    if (ins.error) throw new Error(ins.error.message);
    parishId = ins.data!.id as string;
  } else {
    const up = await supabase.from("kazakhstan_parishes").update(patch).eq("id", parishId);
    if (up.error) throw new Error(up.error.message);
  }

  const parishPhoto = formData.get("parish_photo");
  if (parishPhoto instanceof File && parishPhoto.size > 0) {
    if (!parishPhoto.type.startsWith("image/")) throw new Error("Нужен файл изображения");
    if (parishPhoto.size > IMAGE_MAX) throw new Error("Файл больше 8 МБ");
    const url = await uploadParishImage(supabase, parishId, "parish", parishPhoto);
    await supabase.from("kazakhstan_parishes").update({ parish_photo_url: url }).eq("id", parishId);
  } else {
    const parishUrl = parseHttpImageUrlFromFormData(formData, "parish_photo_url", "Фото прихода (URL)");
    if (parishUrl) {
      await supabase.from("kazakhstan_parishes").update({ parish_photo_url: parishUrl }).eq("id", parishId);
    }
  }

  const priestPhoto = formData.get("priest_photo");
  if (priestPhoto instanceof File && priestPhoto.size > 0) {
    if (!priestPhoto.type.startsWith("image/")) throw new Error("Нужен файл изображения");
    if (priestPhoto.size > IMAGE_MAX) throw new Error("Файл больше 8 МБ");
    const url = await uploadParishImage(supabase, parishId, "priest", priestPhoto);
    await supabase.from("kazakhstan_parishes").update({ priest_photo_url: url }).eq("id", parishId);
  } else {
    const priestUrl = parseHttpImageUrlFromFormData(formData, "priest_photo_url", "Фото настоятеля (URL)");
    if (priestUrl) {
      await supabase.from("kazakhstan_parishes").update({ priest_photo_url: priestUrl }).eq("id", parishId);
    }
  }

  const titleHint =
    str(formData, "name_ru") ?? str(formData, "name_uk") ?? str(formData, "name_en") ?? null;
  await logAdminActivity(supabase, profile, {
    action: id ? "parish.update" : "parish.create",
    entityType: "kazakhstan_parish",
    entityId: parishId,
    summary: titleHint,
  });

  revalidatePath("/about/parishes-kz");
  revalidatePath("/admin/parishes");
  redirect("/admin/parishes?saved=1");
}
