"use server";

import { cookies } from "next/headers";
import { LANG_COOKIE, LANGS, type Lang } from "@/lib/i18n";
import { revalidatePath } from "next/cache";

export async function setLang(lang: string) {
  if (!LANGS.includes(lang as Lang)) return;
  const store = await cookies();
  store.set(LANG_COOKIE, lang, {
    path: "/",
    maxAge: 60 * 60 * 24 * 365,
    sameSite: "lax",
  });
  revalidatePath("/");
  revalidatePath("/history");
  revalidatePath("/admin", "layout");
}
