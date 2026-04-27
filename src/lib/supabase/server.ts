import { createServerClient } from "@supabase/ssr";
import {
  createClient as createSupabaseClient,
  type SupabaseClient,
} from "@supabase/supabase-js";
import { cookies } from "next/headers";
import { cache } from "react";
import { getSupabaseEnv } from "./config";

/** Анонимный клиент без auth-cookies — публичные запросы в `data.ts` (нет refresh по битому токену). */
export const createPublicClient = cache((): SupabaseClient =>
  (() => {
    const { url, anonKey } = getSupabaseEnv();
    return createSupabaseClient(url, anonKey);
  })(),
);

export const createClient = cache(async () => {
  const cookieStore = await cookies();
  const { url, anonKey } = getSupabaseEnv();

  const supabase = createServerClient(url, anonKey, {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) =>
            cookieStore.set(name, value, options),
          );
        } catch {
          /* Server Component */
        }
      },
    },
  });

  const { error: authError } = await supabase.auth.getUser();
  if (
    authError &&
    (authError.code === "refresh_token_not_found" ||
      authError.code === "invalid_refresh_token")
  ) {
    await supabase.auth.signOut();
  }

  return supabase;
});

export function createServiceClient() {
  const { url, serviceRoleKey } = getSupabaseEnv();
  const key = serviceRoleKey;
  if (!url || !key) {
    throw new Error("Missing service role key or Supabase URL for selected target");
  }
  return createSupabaseClient(url, key);
}
