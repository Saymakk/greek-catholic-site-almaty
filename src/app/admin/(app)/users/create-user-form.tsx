"use client";

import { useState } from "react";
import type { AdminUsersScreenCopy } from "@/lib/admin-layout-i18n";

const MIN_LEN = 8;

export function CreateUserForm({
  copy,
  onCreated,
}: {
  copy: AdminUsersScreenCopy;
  onCreated?: () => void;
}) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [password2, setPassword2] = useState("");
  const [msg, setMsg] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);
    if (password.length < MIN_LEN) {
      setMsg(copy.errMin);
      return;
    }
    if (password !== password2) {
      setMsg(copy.errMismatch);
      return;
    }
    setLoading(true);
    try {
      const res = await fetch("/api/admin/users", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email, password }),
      });
      const data = (await res.json()) as { error?: string };
      if (!res.ok) {
        setMsg(data.error ?? copy.errGeneric);
      } else {
        setMsg(copy.success);
        setEmail("");
        setPassword("");
        setPassword2("");
        onCreated?.();
      }
    } catch {
      setMsg(copy.errNetwork);
    }
    setLoading(false);
  }

  return (
    <form onSubmit={onSubmit} className="mt-8 max-w-md space-y-4">
      <label className="block text-sm text-parish-muted">
        {copy.email}
        <input
          type="email"
          required
          autoComplete="off"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
        />
      </label>
      <label className="block text-sm text-parish-muted">
        {copy.password} ({copy.passwordHint})
        <input
          type="password"
          required
          autoComplete="new-password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
        />
      </label>
      <label className="block text-sm text-parish-muted">
        {copy.passwordAgain}
        <input
          type="password"
          required
          autoComplete="new-password"
          value={password2}
          onChange={(e) => setPassword2(e.target.value)}
          className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
        />
      </label>
      {msg ? <p className="text-sm text-parish-text">{msg}</p> : null}
      <button
        type="submit"
        disabled={loading}
        className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white disabled:opacity-50"
      >
        {loading ? copy.loading : copy.createUser}
      </button>
    </form>
  );
}
