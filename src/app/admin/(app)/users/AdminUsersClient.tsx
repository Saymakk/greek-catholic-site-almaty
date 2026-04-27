"use client";

import { useRouter } from "next/navigation";
import { useRef, useState, useEffect } from "react";
import type { Lang } from "@/lib/i18n";
import type { AdminUsersScreenCopy } from "@/lib/admin-layout-i18n";
import { CreateUserForm } from "./create-user-form";

export type AdminUserRow = {
  id: string;
  email: string | null;
  full_name: string | null;
  role: string;
  created_at: string;
};

const MIN_LEN = 8;

function localeForUi(lang: Lang): string {
  const m: Record<Lang, string> = { ru: "ru-RU", uk: "uk-UA", kk: "kk-KZ", en: "en-US" };
  return m[lang] ?? "ru-RU";
}

function formatCreated(iso: string, lang: Lang): string {
  try {
    return new Date(iso).toLocaleDateString(localeForUi(lang), {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  } catch {
    return iso;
  }
}

export function AdminUsersClient({
  lang,
  copy,
  currentUserId,
  initialUsers,
}: {
  lang: Lang;
  copy: AdminUsersScreenCopy;
  currentUserId: string;
  initialUsers: AdminUserRow[];
}) {
  const router = useRouter();
  const dialogRef = useRef<HTMLDialogElement>(null);
  const [editing, setEditing] = useState<AdminUserRow | null>(null);
  const [err, setErr] = useState<string | null>(null);
  const [pending, setPending] = useState(false);

  const [email, setEmail] = useState("");
  const [fullName, setFullName] = useState("");
  const [role, setRole] = useState<"admin" | "superadmin">("admin");
  const [password, setPassword] = useState("");
  const [password2, setPassword2] = useState("");

  useEffect(() => {
    const d = dialogRef.current;
    if (!d) return;
    function onClose() {
      setEditing(null);
      setErr(null);
      setPassword("");
      setPassword2("");
    }
    d.addEventListener("close", onClose);
    return () => d.removeEventListener("close", onClose);
  }, []);

  function openEdit(u: AdminUserRow) {
    setEditing(u);
    setEmail(u.email ?? "");
    setFullName(u.full_name ?? "");
    setRole(u.role === "superadmin" ? "superadmin" : "admin");
    setPassword("");
    setPassword2("");
    setErr(null);
    requestAnimationFrame(() => dialogRef.current?.showModal());
  }

  function closeDialog() {
    dialogRef.current?.close();
  }

  async function saveEdit(e: React.FormEvent) {
    e.preventDefault();
    if (!editing) return;
    setErr(null);
    if (password.length > 0) {
      if (password.length < MIN_LEN) {
        setErr(copy.errMin);
        return;
      }
      if (password !== password2) {
        setErr(copy.errMismatch);
        return;
      }
    }
    setPending(true);
    try {
      const body: Record<string, unknown> = {
        id: editing.id,
        email: email.trim().toLowerCase(),
        full_name: fullName.trim() || null,
        role,
      };
      if (password.length > 0) body.password = password;
      const res = await fetch("/api/admin/users", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      const data = (await res.json()) as { error?: string };
      if (!res.ok) {
        setErr(data.error ?? copy.errGeneric);
      } else {
        router.refresh();
        closeDialog();
      }
    } catch {
      setErr(copy.errNetwork);
    }
    setPending(false);
  }

  async function removeUser(u: AdminUserRow) {
    if (!confirm(copy.confirmDelete)) return;
    setErr(null);
    try {
      const res = await fetch("/api/admin/users", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: u.id }),
      });
      const data = (await res.json()) as { error?: string };
      if (!res.ok) {
        alert(data.error ?? copy.errGeneric);
        return;
      }
      router.refresh();
    } catch {
      alert(copy.errNetwork);
    }
  }

  function roleLabel(r: string): string {
    return r === "superadmin" ? copy.roleSuperadmin : copy.roleAdmin;
  }

  return (
    <div>
      <CreateUserForm copy={copy} onCreated={() => router.refresh()} />

      <h2 className="mt-12 font-display text-lg font-semibold text-parish-text">{copy.listTitle}</h2>
      <div className="mt-4 overflow-x-auto rounded-xl border border-parish-border bg-parish-surface shadow-sm">
        <table className="w-full min-w-[36rem] text-left text-sm">
          <thead className="border-b border-parish-border bg-parish-bg/50 text-xs font-semibold uppercase tracking-wide text-parish-muted">
            <tr>
              <th className="px-4 py-3">{copy.colEmail}</th>
              <th className="px-4 py-3">{copy.colName}</th>
              <th className="px-4 py-3">{copy.colRole}</th>
              <th className="px-4 py-3">{copy.colCreated}</th>
              <th className="px-4 py-3 text-right">{copy.colActions}</th>
            </tr>
          </thead>
          <tbody>
            {initialUsers.map((u) => (
              <tr key={u.id} className="border-b border-parish-border/70 last:border-0">
                <td className="px-4 py-3 font-medium text-parish-text">
                  {u.email ?? "—"}
                  {u.id === currentUserId ? (
                    <span className="ml-2 rounded bg-parish-accent-soft px-1.5 py-0.5 text-xs font-normal text-parish-accent">
                      {copy.youBadge}
                    </span>
                  ) : null}
                </td>
                <td className="px-4 py-3 text-parish-muted">{u.full_name?.trim() || "—"}</td>
                <td className="px-4 py-3 text-parish-muted">{roleLabel(u.role)}</td>
                <td className="px-4 py-3 text-parish-muted">{formatCreated(u.created_at, lang)}</td>
                <td className="px-4 py-3 text-right">
                  <div className="flex flex-wrap justify-end gap-2">
                    <button
                      type="button"
                      onClick={() => openEdit(u)}
                      className="rounded-lg border border-parish-border px-2 py-1 text-xs font-medium text-parish-accent hover:bg-parish-accent-soft"
                    >
                      {copy.edit}
                    </button>
                    <button
                      type="button"
                      disabled={u.id === currentUserId}
                      onClick={() => removeUser(u)}
                      className="rounded-lg border border-parish-border px-2 py-1 text-xs font-medium text-red-600 hover:bg-red-50 disabled:cursor-not-allowed disabled:opacity-40"
                    >
                      {copy.delete}
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <dialog
        ref={dialogRef}
        className="fixed left-1/2 top-1/2 z-50 m-0 max-h-[min(90dvh,calc(100vh-1.5rem))] w-[min(26rem,calc(100vw-1.5rem))] -translate-x-1/2 -translate-y-1/2 overflow-y-auto rounded-2xl border border-parish-border bg-parish-surface p-0 text-parish-text shadow-2xl backdrop:bg-parish-text/45"
      >
        {editing ? (
          <form onSubmit={saveEdit} className="flex flex-col">
            <div className="border-b border-parish-border px-4 py-3">
              <h3 className="font-display text-lg font-semibold">{copy.editTitle}</h3>
              <p className="mt-0.5 truncate text-xs text-parish-muted">{editing.email}</p>
            </div>
            <div className="space-y-3 px-4 py-4">
              <label className="flex flex-col gap-1 text-sm text-parish-muted">
                <span className="font-medium text-parish-text">{copy.email}</span>
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              <label className="flex flex-col gap-1 text-sm text-parish-muted">
                <span className="font-medium text-parish-text">{copy.fullName}</span>
                <input
                  type="text"
                  value={fullName}
                  onChange={(e) => setFullName(e.target.value)}
                  className="rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              <label className="flex flex-col gap-1 text-sm text-parish-muted">
                <span className="font-medium text-parish-text">{copy.roleLabel}</span>
                <select
                  value={role}
                  onChange={(e) => setRole(e.target.value as "admin" | "superadmin")}
                  className="rounded-lg border border-parish-border px-3 py-2"
                >
                  <option value="admin">{copy.roleAdmin}</option>
                  <option value="superadmin">{copy.roleSuperadmin}</option>
                </select>
              </label>
              <label className="flex flex-col gap-1 text-sm text-parish-muted">
                <span className="font-medium text-parish-text">
                  {copy.newPasswordOptional}{" "}
                  <span className="font-normal text-parish-muted">({copy.newPasswordHint})</span>
                </span>
                <input
                  type="password"
                  autoComplete="new-password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              {password.length > 0 ? (
                <label className="flex flex-col gap-1 text-sm text-parish-muted">
                  <span className="font-medium text-parish-text">{copy.passwordAgain}</span>
                  <input
                    type="password"
                    autoComplete="new-password"
                    value={password2}
                    onChange={(e) => setPassword2(e.target.value)}
                    className="rounded-lg border border-parish-border px-3 py-2"
                  />
                </label>
              ) : null}
              {err ? <p className="text-sm text-red-600">{err}</p> : null}
            </div>
            <div className="flex flex-wrap gap-2 border-t border-parish-border px-4 py-3">
              <button
                type="button"
                onClick={closeDialog}
                className="rounded-lg border border-parish-border px-4 py-2 text-sm text-parish-muted hover:bg-parish-accent-soft"
              >
                {copy.cancel}
              </button>
              <button
                type="submit"
                disabled={pending}
                className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white disabled:opacity-50"
              >
                {pending ? copy.loading : copy.saveEdits}
              </button>
            </div>
          </form>
        ) : null}
      </dialog>
    </div>
  );
}
