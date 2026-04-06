import { createServerClient } from "@supabase/ssr";
import {
  createClient as createSupabaseClient,
  type SupabaseClient,
} from "@supabase/supabase-js";
import { cookies } from "next/headers";
import { cache } from "react";

/** Анонимный клиент без auth-cookies — публичные запросы в `data.ts` (нет refresh по битому токену). */
export const createPublicClient = cache((): SupabaseClient =>
  createSupabaseClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
  ),
);

export const createClient = cache(async () => {
  const cookieStore = await cookies();

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
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
    },
  );

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
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key) {
    throw new Error("Missing SUPABASE_SERVICE_ROLE_KEY or URL");
  }
  return createSupabaseClient(url, key);
}
