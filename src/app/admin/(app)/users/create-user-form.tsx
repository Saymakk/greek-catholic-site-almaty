"use client";

import { useState } from "react";

const MIN_LEN = 8;

export function CreateUserForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [password2, setPassword2] = useState("");
  const [msg, setMsg] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);
    if (password.length < MIN_LEN) {
      setMsg(`Пароль не короче ${MIN_LEN} символов`);
      return;
    }
    if (password !== password2) {
      setMsg("Пароли не совпадают");
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
        setMsg(data.error ?? "Ошибка");
      } else {
        setMsg("Пользователь создан. Передайте ему email и пароль любым способом.");
        setEmail("");
        setPassword("");
        setPassword2("");
      }
    } catch {
      setMsg("Сеть недоступна");
    }
    setLoading(false);
  }

  return (
    <form onSubmit={onSubmit} className="mt-8 max-w-md space-y-4">
      <label className="block text-sm text-parish-muted">
        Email
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
        Пароль (не короче {MIN_LEN} символов)
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
        Пароль ещё раз
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
        {loading ? "…" : "Создать пользователя"}
      </button>
    </form>
  );
}
