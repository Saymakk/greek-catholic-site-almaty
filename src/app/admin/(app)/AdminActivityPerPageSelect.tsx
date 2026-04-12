"use client";

import { usePathname, useRouter } from "next/navigation";

const OPTIONS = [20, 50, 100] as const;

export function AdminActivityPerPageSelect({
  label,
  value,
}: {
  label: string;
  value: number;
}) {
  const router = useRouter();
  const pathname = usePathname();

  return (
    <label className="flex items-center gap-2 text-sm text-parish-muted">
      <span className="whitespace-nowrap">{label}</span>
      <select
        className="rounded-lg border border-parish-border bg-parish-surface px-2 py-1.5 text-sm font-medium text-parish-text"
        value={value}
        onChange={(e) => {
          const per = Number(e.target.value);
          const q = new URLSearchParams();
          if (per !== 20) q.set("per", String(per));
          const s = q.toString();
          router.push(s ? `${pathname}?${s}` : pathname);
        }}
      >
        {OPTIONS.map((n) => (
          <option key={n} value={n}>
            {n}
          </option>
        ))}
      </select>
    </label>
  );
}
