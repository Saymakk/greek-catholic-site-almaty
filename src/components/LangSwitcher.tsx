"use client";

import { setLang } from "@/app/actions/lang";
import { LANG_NAMES, LANGS, type Lang } from "@/lib/i18n";

export function LangSwitcher({ current }: { current: Lang }) {
  return (
    <label className="flex items-center gap-2 text-sm text-parish-muted">
      <span className="sr-only">Language</span>
      <select
        className="rounded-lg border border-parish-border bg-parish-surface px-2 py-1 text-parish-text focus:outline-none focus:ring-2 focus:ring-parish-accent/40"
        value={current}
        onChange={(e) => setLang(e.target.value)}
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
