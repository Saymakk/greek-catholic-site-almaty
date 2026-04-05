"use client";

import { useFormStatus } from "react-dom";

/** Показывает круговой индикатор на весь экран при отправке родительской `<form>`. */
export function AdminModalSavingOverlay() {
  const { pending } = useFormStatus();
  if (!pending) return null;
  return (
    <div
      className="pointer-events-auto fixed inset-0 z-[320] flex items-center justify-center bg-parish-text/30 backdrop-blur-[1px]"
      aria-busy="true"
      aria-live="polite"
    >
      <span className="sr-only">Loading</span>
      <svg
        className="h-12 w-12 animate-spin text-parish-accent"
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
