"use client";

import { useEffect, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

/** Cover first, then gallery URLs; duplicates omitted. */
export function gatherLightboxUrls(
  cover: string | null | undefined,
  gallery: string[],
): string[] {
  const out: string[] = [];
  if (cover) out.push(cover);
  for (const u of gallery) {
    if (!out.includes(u)) out.push(u);
  }
  return out;
}

export function ImageLightboxOverlay({
  lang,
  images,
  initialIndex,
  open,
  onClose,
  zClass = "z-[200]",
}: {
  lang: Lang;
  images: string[];
  initialIndex: number;
  open: boolean;
  onClose: () => void;
  zClass?: string;
}) {
  const [index, setIndex] = useState(0);

  useEffect(() => {
    if (!open || images.length === 0) return;
    const i = Math.min(Math.max(0, initialIndex), images.length - 1);
    setIndex(i);
  }, [open, initialIndex, images]);

  useEffect(() => {
    if (!open || images.length === 0) return;
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") {
        e.preventDefault();
        onClose();
        return;
      }
      if (images.length < 2) return;
      if (e.key === "ArrowLeft") {
        e.preventDefault();
        setIndex((i) => Math.max(0, i - 1));
      }
      if (e.key === "ArrowRight") {
        e.preventDefault();
        setIndex((i) => Math.min(images.length - 1, i + 1));
      }
    }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open, images.length, onClose]);

  if (!open || images.length === 0) return null;

  const src = images[index] ?? images[0];
  const hasNav = images.length > 1;

  return (
    <div
      className={`fixed inset-0 ${zClass} flex items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm`}
      role="dialog"
      aria-modal
      aria-label={t(lang, "imageLightboxAria")}
      onClick={onClose}
    >
      <div
        className="relative mx-auto w-max max-h-[95vh] max-w-[95vw]"
        onClick={(e) => e.stopPropagation()}
      >
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src={src}
          alt=""
          className="block max-h-[95vh] max-w-[95vw] h-auto w-auto object-contain shadow-2xl"
        />
        {hasNav ? (
          <p
            className="pointer-events-none absolute bottom-[10px] left-1/2 z-10 -translate-x-1/2 rounded-full bg-parish-text/85 px-3 py-1.5 text-sm font-medium tabular-nums text-white"
            aria-live="polite"
          >
            {index + 1} / {images.length}
          </p>
        ) : null}
      </div>
    </div>
  );
}
