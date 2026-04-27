type SupabaseEnv = {
  url: string;
  anonKey: string;
  serviceRoleKey?: string;
  target: "remote" | "local";
};

function requireEnv(name: string, value: string | undefined): string {
  if (!value) {
    throw new Error(`Missing required environment variable: ${name}`);
  }
  return value;
}

export function getSupabaseEnv(): SupabaseEnv {
  const isBrowser = typeof window !== "undefined";
  const browserTarget = process.env.NEXT_PUBLIC_SUPABASE_TARGET;
  const serverTarget = process.env.SUPABASE_TARGET;
  const target =
    (isBrowser ? browserTarget : serverTarget) === "local"
      ? "local"
      : ("remote" as const);

  if (target === "local") {
    const localUrl = isBrowser
      ? process.env.NEXT_PUBLIC_LOCAL_SUPABASE_URL
      : process.env.LOCAL_SUPABASE_URL;
    const localAnonKey = isBrowser
      ? process.env.NEXT_PUBLIC_LOCAL_SUPABASE_ANON_KEY
      : process.env.LOCAL_SUPABASE_ANON_KEY;

    return {
      target,
      url: requireEnv(
        isBrowser ? "NEXT_PUBLIC_LOCAL_SUPABASE_URL" : "LOCAL_SUPABASE_URL",
        localUrl ?? process.env.NEXT_PUBLIC_SUPABASE_URL,
      ),
      anonKey: requireEnv(
        isBrowser
          ? "NEXT_PUBLIC_LOCAL_SUPABASE_ANON_KEY"
          : "LOCAL_SUPABASE_ANON_KEY",
        localAnonKey ?? process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
      ),
      serviceRoleKey:
        isBrowser
          ? undefined
          : process.env.LOCAL_SUPABASE_SERVICE_ROLE_KEY ??
            process.env.SUPABASE_SERVICE_ROLE_KEY,
    };
  }

  return {
    target,
    url: requireEnv("NEXT_PUBLIC_SUPABASE_URL", process.env.NEXT_PUBLIC_SUPABASE_URL),
    anonKey: requireEnv(
      "NEXT_PUBLIC_SUPABASE_ANON_KEY",
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    ),
    serviceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  };
}
