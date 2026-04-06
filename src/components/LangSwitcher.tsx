"use client";

import { useRouter } from "next/navigation";
import { setLang } from "@/app/actions/lang";
import { LANG_NAMES, LANGS, type Lang } from "@/lib/i18n";

export function LangSwitcher({
  current,
  srOnlyLabel,
  className,
}: {
  current: Lang;
  /** Accessible name for the select (site or admin UI language). */
  srOnlyLabel?: string;
  className?: string;
}) {
  const router = useRouter();
  return (
    <label
      className={`flex items-center gap-2 text-sm text-parish-muted${className ? ` ${className}` : ""}`}
    >
      <span className="sr-only">{srOnlyLabel ?? "Language"}</span>
      <select
        className="min-h-11 min-w-[5.5rem] touch-manipulation rounded-lg border border-parish-border bg-parish-surface px-2 py-2 text-base text-parish-text focus:outline-none focus:ring-2 focus:ring-parish-accent/40 sm:min-h-0 sm:py-1 sm:text-sm"
        value={current}
        onChange={async (e) => {
          await setLang(e.target.value);
          router.refresh();
        }}
      >
        {LANGS.map((l) => (
          <option key={l} value={l}>
            {LANG_NAMES[l]}
          </option>
        ))}
      </select>
    </label>
  );
}
