"use client";

import { createClient } from "@/lib/supabase/client";
import { useEffect, useState } from "react";
import type { AdminAccountCopy } from "@/lib/admin-layout-i18n";

export function AccountPasswordClient({ copy }: { copy: AdminAccountCopy }) {
  const [open, setOpen] = useState(false);

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        className="mt-6 rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white hover:opacity-90"
      >
        {copy.openChangePassword}
      </button>
      {open ? (
        <PasswordChangeModal copy={copy} onClose={() => setOpen(false)} />
      ) : null}
    </>
  );
}

function PasswordChangeModal({
  copy,
  onClose,
}: {
  copy: AdminAccountCopy;
  onClose: () => void;
}) {
  const [password, setPassword] = useState("");
  const [again, setAgain] = useState("");
  const [msg, setMsg] = useState<string | null>(null);
  const [err, setErr] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [onClose]);

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setMsg(null);
    setErr(null);
    if (password.length < 8) {
      setErr(copy.errMinLen);
      return;
    }
    if (password !== again) {
      setErr(copy.errMismatch);
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
    setMsg(copy.success);
    setPassword("");
    setAgain("");
  }

  return (
    <div
      className="fixed inset-0 z-[125] flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
      role="dialog"
      aria-modal
      aria-labelledby="admin-password-modal-title"
      onClick={onClose}
    >
      <div
        className="w-full max-w-md rounded-2xl border border-parish-border bg-parish-surface p-6 shadow-xl"
        onClick={(e) => e.stopPropagation()}
      >
        <h2 id="admin-password-modal-title" className="font-display text-xl text-parish-text">
          {copy.pageTitle}
        </h2>
        <form onSubmit={onSubmit} className="mt-5 space-y-4">
          <label className="block text-sm text-parish-muted">
            {copy.newPassword}
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
            {copy.repeatPassword}
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
          <div className="flex flex-col-reverse gap-2 pt-2 sm:flex-row sm:justify-end">
            <button
              type="button"
              onClick={onClose}
              className="rounded-lg border border-parish-border px-4 py-2 text-sm font-medium text-parish-text hover:bg-parish-accent-soft"
            >
              {copy.cancel}
            </button>
            <button
              type="submit"
              disabled={loading}
              className="rounded-lg bg-parish-accent px-4 py-2 text-sm font-medium text-white disabled:opacity-50"
            >
              {loading ? copy.loading : copy.savePassword}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
