"use server";

import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";

const LANGS = ["ru", "uk", "kk", "en"] as const;

export async function saveHistory(formData: FormData) {
  await requireStaff();
  const supabase = await createClient();
  for (const lang of LANGS) {
    const body = (formData.get(`history_${lang}`) as string) ?? "";
    await supabase.from("page_content").upsert(
      { page_key: "history", lang, body },
      { onConflict: "page_key,lang" },
    );
  }
  revalidatePath("/history");
  redirect("/admin/history");
}

export async function saveFooter(formData: FormData) {
  await requireStaff();
  const supabase = await createClient();
  const entry = formData.get("footer_json");
  const raw =
    typeof entry === "string"
      ? entry.replace(/^\uFEFF/, "").trim()
      : "";

  let value: object;
  if (!raw) {
    value = {};
  } else {
    try {
      value = JSON.parse(raw) as object;
    } catch {
      redirect("/admin/settings?footer_err=parse");
    }
  }
  if (value === null || typeof value !== "object" || Array.isArray(value)) {
    redirect("/admin/settings?footer_err=shape");
  }

  await supabase.from("site_settings").upsert({ key: "footer", value });
  revalidatePath("/");
  redirect("/admin/settings");
}
