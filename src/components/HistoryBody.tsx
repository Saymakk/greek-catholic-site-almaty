"use client";

import { useState } from "react";
import type { Lang } from "@/lib/i18n";
import { ImageLightboxOverlay } from "./ImageLightboxOverlay";
import { isProbablyHtml, RichOrPlain } from "./RichOrPlain";

export function HistoryBody({ body, lang }: { body: string; lang: Lang }) {
  const [lightboxSrc, setLightboxSrc] = useState<string | null>(null);

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
      <ImageLightboxOverlay
        lang={lang}
        images={lightboxSrc ? [lightboxSrc] : []}
        initialIndex={0}
        open={lightboxSrc !== null}
        onClose={() => setLightboxSrc(null)}
        zClass="z-[200]"
      />
    </>
  );
}
