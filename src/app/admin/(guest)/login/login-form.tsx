"use client";

import { createClient } from "@/lib/supabase/client";
import { useRouter, useSearchParams } from "next/navigation";
import { useState } from "react";
import type { AdminLoginCopy } from "@/lib/admin-layout-i18n";

export function AdminLoginForm({ copy }: { copy: AdminLoginCopy }) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const next = searchParams.get("next") ?? "/admin";
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setError(null);
    const supabase = createClient();
    const { error: err } = await supabase.auth.signInWithPassword({ email, password });
    setLoading(false);
    if (err) {
      setError(err.message);
      return;
    }
    router.push(next);
    router.refresh();
  }

  return (
    <main className="w-full max-w-sm rounded-2xl border border-parish-border bg-parish-surface p-8 shadow-sm">
      <h1 className="font-display text-2xl text-parish-text">{copy.title}</h1>
      <p className="mt-2 text-sm text-parish-muted">{copy.subtitle}</p>
      <form onSubmit={onSubmit} className="mt-8 space-y-4">
        <label className="block text-sm text-parish-muted">
          {copy.email}
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 text-parish-text"
          />
        </label>
        <label className="block text-sm text-parish-muted">
          {copy.password}
          <input
            type="password"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 text-parish-text"
          />
        </label>
        {error ? <p className="text-sm text-red-600">{error}</p> : null}
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-lg bg-parish-accent py-2 text-white hover:opacity-90 disabled:opacity-50"
        >
          {loading ? copy.loading : copy.signIn}
        </button>
      </form>
    </main>
  );
}
