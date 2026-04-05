"use client";

import { useEffect, useState } from "react";

const MAX_MS = 15_000;

/** Круговой индикатор; через 15 с скрывается, чтобы не «висеть» бесконечно. */
export function SiteLoadingSpinner({ className }: { className?: string }) {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    const t = window.setTimeout(() => setVisible(false), MAX_MS);
    return () => window.clearTimeout(t);
  }, []);

  if (!visible) {
    return (
      <p className="text-sm font-medium text-parish-muted" role="status">
        …
      </p>
    );
  }

  return (
    <div
      className={`flex flex-col items-center gap-3 ${className ?? ""}`}
      role="status"
      aria-live="polite"
    >
      <span className="sr-only">Loading</span>
      <svg
        className="h-10 w-10 animate-spin text-parish-accent"
        viewBox="0 0 24 24"
        fill="none"
        aria-hidden
      >
        <circle
          className="opacity-25"
          cx="12"
          cy="12"
          r="10"
          stroke="currentColor"
          strokeWidth="3"
        />
        <path
          className="opacity-90"
          fill="currentColor"
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
        />
      </svg>
    </div>
  );
}
