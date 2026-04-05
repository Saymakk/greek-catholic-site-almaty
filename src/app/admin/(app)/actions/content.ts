"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { logAdminActivity } from "@/lib/admin-activity-log";
import { extractMapEmbedSrc } from "@/lib/map-embed";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const LANGS = ["ru", "uk", "kk", "en"] as const;

const HISTORY_IMAGE_EXT = new Set(["jpg", "jpeg", "png", "webp", "gif", "svg"]);
const HISTORY_IMAGE_MAX_BYTES = 8 * 1024 * 1024;

/** Загрузка картинки для страницы «История» → публичный URL (bucket news-images, путь history/{lang}/…). */
export async function uploadHistoryImage(formData: FormData): Promise<string> {
  await requireStaff();
  const file = formData.get("file");
  const langRaw = (formData.get("lang") as string)?.trim().toLowerCase();
  if (!(file instanceof File) || file.size === 0) {
    throw new Error("Файл не выбран");
  }
  if (!file.type.startsWith("image/")) {
    throw new Error("Нужен файл изображения");
  }
  if (file.size > HISTORY_IMAGE_MAX_BYTES) {
    throw new Error("Файл больше 8 МБ");
  }
  if (!LANGS.includes(langRaw as (typeof LANGS)[number])) {
    throw new Error("Неверный язык");
  }
  const lang = langRaw as (typeof LANGS)[number];

  const extRaw = file.name.split(".").pop()?.toLowerCase().replace(/[^a-z0-9]/g, "") || "jpg";
  const safeExt = HISTORY_IMAGE_EXT.has(extRaw) ? extRaw : "jpg";

  const supabase = await createClient();
  const stamp = Date.now();
  const rand = Math.random().toString(36).slice(2, 10);
  const path = `history/${lang}/${stamp}_${rand}.${safeExt}`;
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
            : safeExt === "svg"
              ? "image/svg+xml"
              : "image/jpeg";

  const { error } = await supabase.storage.from("news-images").upload(path, buf, {
    contentType,
    upsert: false,
  });
  if (error) throw new Error(error.message);
  const { data } = supabase.storage.from("news-images").getPublicUrl(path);
  return data.publicUrl;
}

export async function saveHistory(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();
  for (const lang of LANGS) {
    const body = (formData.get(`history_${lang}`) as string) ?? "";
    await supabase.from("page_content").upsert(
      { page_key: "history", lang, body },
      { onConflict: "page_key,lang" },
    );
  }
  await logAdminActivity(supabase, profile, {
    action: "history.save",
    entityType: "page_content",
    entityId: "history",
  });
  revalidatePath("/about/history");
  revalidatePath("/admin/history");
  redirect("/admin/history");
}

export async function saveFooter(formData: FormData) {
  const profile = await requireStaff();
  const supabase = await createClient();

  const rec: Record<string, unknown> = {};

  const setText = (jsonKey: string, fieldName: string) => {
    const v = (formData.get(fieldName) as string)?.trim() ?? "";
    if (v) rec[jsonKey] = v;
  };

  for (const l of LANGS) {
    setText(`priest_name_${l}`, `priest_name_${l}`);
    setText(`address_${l}`, `address_${l}`);
    setText(`extra_${l}`, `extra_${l}`);
  }
  setText("phone", "phone");
  setText("email", "email");

  const mapRaw = (formData.get("map_embed_raw") as string) ?? "";
  const mapSrc = extractMapEmbedSrc(mapRaw);
  if (mapSrc) rec.map_embed_src = mapSrc;

  const buttonsRaw = (formData.get("contact_buttons_json") as string)?.trim() ?? "";
  let contact_buttons: { icon?: string; label: string; url: string }[] = [];
  if (buttonsRaw) {
    try {
      const parsed = JSON.parse(buttonsRaw) as unknown;
      if (!Array.isArray(parsed)) redirect("/admin/settings?footer_err=buttons");
      for (const item of parsed) {
        if (!item || typeof item !== "object") continue;
        const o = item as Record<string, unknown>;
        const url = typeof o.url === "string" ? o.url.trim() : "";
        const label = typeof o.label === "string" ? o.label.trim() : "";
        if (!url || !label) continue;
        const icon = typeof o.icon === "string" ? o.icon.trim() : "";
        contact_buttons.push({ url, label, ...(icon ? { icon } : {}) });
      }
    } catch {
      redirect("/admin/settings?footer_err=buttons");
    }
  }
  rec.contact_buttons = contact_buttons;

  await supabase.from("site_settings").upsert({ key: "footer", value: rec });
  await logAdminActivity(supabase, profile, {
    action: "settings.footer.save",
    entityType: "site_settings",
    entityId: "footer",
  });
  revalidatePath("/");
  revalidatePath("/about/contacts");
  redirect("/admin/settings");
}
