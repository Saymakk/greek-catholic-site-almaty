import { cookies } from "next/headers";
import { LANG_COOKIE, LANGS, type Lang } from "./i18n";

export async function getLang(): Promise<Lang> {
  const store = await cookies();
  const v = store.get(LANG_COOKIE)?.value;
  if (v && LANGS.includes(v as Lang)) return v as Lang;
  return "ru";
}
