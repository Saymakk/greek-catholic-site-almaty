"use client";

import { useEffect, useState } from "react";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import { isProbablyHtml, RichOrPlain } from "./RichOrPlain";

export function HistoryBody({ body, lang }: { body: string; lang: Lang }) {
  const [lightboxSrc, setLightboxSrc] = useState<string | null>(null);

  useEffect(() => {
    if (!lightboxSrc) return;
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") setLightboxSrc(null);
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, [lightboxSrc]);

  const proseClass =
    "rich-html history-page-body mt-8 max-w-none text-base font-medium leading-relaxed text-parish-text";

  if (!isProbablyHtml(body)) {
    return <RichOrPlain content={body} className={proseClass} />;
  }

  return (
    <>
      <div
        className={proseClass}
        role="presentation"
        onClick={(e) => {
          const el = e.target as HTMLElement;
          if (el.tagName !== "IMG") return;
          const img = el as HTMLImageElement;
          setLightboxSrc(img.currentSrc || img.src);
        }}
        dangerouslySetInnerHTML={{ __html: body }}
      />
      {lightboxSrc ? (
        <div
          className="fixed inset-0 z-[200] flex cursor-zoom-out items-center justify-center bg-parish-text/40 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal
          aria-label={t(lang, "imageLightboxAria")}
          onClick={() => setLightboxSrc(null)}
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={lightboxSrc}
            alt=""
            className="max-h-[95vh] max-w-[95vw] cursor-default object-contain shadow-2xl"
            onClick={(e) => e.stopPropagation()}
          />
        </div>
      ) : null}
    </>
  );
}
