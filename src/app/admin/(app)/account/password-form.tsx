"use client";

import { createClient } from "@/lib/supabase/client";
import { useState } from "react";

export function PasswordChangeForm() {
  const [password, setPassword] = useState("");
  const [again, setAgain] = useState("");
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);
    setErr(null);
    if (password.length < 8) {
      setErr("Минимум 8 символов.");
      return;
    }
    if (password !== again) {
      setErr("Пароли не совпадают.");
      return;
    }
    setLoading(true);
    const supabase = createClient();
    const { error } = await supabase.auth.updateUser({ password });
    setLoading(false);
    if (error) {
      setErr(error.message);
      return;
    }
    setMsg("Пароль обновлён.");
    setPassword("");
    setAgain("");
  }

  return (
    <form onSubmit={onSubmit} className="mt-8 max-w-sm space-y-4">
      <label className="block text-sm text-parish-muted">
        Новый пароль
        <input
          type="password"
          autoComplete="new-password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          minLength={8}
        />
      </label>
      <label className="block text-sm text-parish-muted">
        Повторите пароль
        <input
          type="password"
          autoComplete="new-password"
          value={again}
          onChange={(e) => setAgain(e.target.value)}
          className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          minLength={8}
        />
      </label>
      {err ? <p className="text-sm text-red-600">{err}</p> : null}
      {msg ? <p className="text-sm text-green-700">{msg}</p> : null}
      <button
        type="submit"
        disabled={loading}
        className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white disabled:opacity-50"
      >
        {loading ? "…" : "Сохранить пароль"}
      </button>
    </form>
  );
}
