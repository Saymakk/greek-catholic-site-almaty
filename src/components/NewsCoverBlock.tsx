"use client";

import { isNewsCoverVideoEmbed } from "@/lib/news-cover";
import { NewsEmbedHtml } from "./NewsEmbedHtml";

function AdminThumbVideoIcon() {
  return (
    <div
      className="flex h-full w-full flex-col items-center justify-center gap-0.5 bg-parish-accent/10 px-0.5 text-center text-[9px] font-semibold leading-tight text-parish-muted"
      title="Embed"
    >
      <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden>
        <path d="M8 5v14l11-7z" />
      </svg>
      <span className="max-w-full truncate">Media</span>
    </div>
  );
}

export function NewsCoverBlock({
  cover,
  variant,
  onImageClick,
  imageAriaLabel,
}: {
  cover: string | null;
  variant: "section" | "modal" | "adminForm" | "adminThumb";
  onImageClick?: () => void;
  imageAriaLabel?: string;
}) {
  if (!cover) return null;

  if (isNewsCoverVideoEmbed(cover)) {
    if (variant === "adminThumb") {
      return <AdminThumbVideoIcon />;
    }
    const adminIframe =
      "news-cover-embed rich-html relative aspect-video w-full max-h-40 overflow-hidden rounded-md border border-parish-border bg-black/5 [&_iframe]:absolute [&_iframe]:inset-0 [&_iframe]:h-full [&_iframe]:w-full [&_iframe]:border-0 [&_video]:h-full [&_video]:w-full";
    const adminIg =
      "news-cover-embed rich-html w-full max-w-md max-h-64 overflow-y-auto rounded-md border border-parish-border bg-black/5 [&_blockquote]:mx-auto [&_blockquote]:max-w-[540px]";

    if (variant === "adminForm") {
      const isIg = /instagram-media|data-instgrm-permalink/i.test(cover);
      return (
        <NewsEmbedHtml
          html={cover}
          className="mt-2 max-w-md"
          innerClassName={isIg ? adminIg : adminIframe}
        />
      );
    }
    if (variant === "modal") {
      return (
        <div className="mt-4 w-full">
          <NewsEmbedHtml html={cover} className="mx-auto w-full max-w-full" />
        </div>
      );
    }
    return (
      <div className="mx-auto mt-4 w-full max-w-[512px]">
        <NewsEmbedHtml html={cover} />
      </div>
    );
  }

  const imgSection = (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src={cover}
      alt=""
      className={
        variant === "modal"
          ? "mx-auto max-h-[min(400px,50vh)] max-w-full cursor-zoom-in rounded-xl object-contain"
          : variant === "adminForm"
            ? "mt-2 h-28 max-w-xs rounded-md border border-parish-border object-cover"
            : variant === "adminThumb"
              ? "h-full w-full object-cover"
              : "mx-auto max-h-[512px] max-w-full object-contain"
      }
    />
  );

  if (variant === "adminThumb") {
    return imgSection;
  }

  const wrapButton = onImageClick != null;

  if (wrapButton) {
    return (
      <div className={variant === "modal" ? "mt-4" : ""}>
        <button
          type="button"
          className={
            variant === "modal"
              ? "mx-auto block max-w-full rounded-xl border border-parish-border/60 bg-parish-surface p-0 focus:outline-none focus:ring-2 focus:ring-parish-accent"
              : "mx-auto mt-4 block max-w-[512px] cursor-zoom-in rounded-xl border border-parish-border/60 bg-parish-surface p-0 focus:outline-none focus:ring-2 focus:ring-parish-accent"
          }
          onClick={onImageClick}
          aria-label={imageAriaLabel ?? ""}
        >
          {imgSection}
        </button>
      </div>
    );
  }

  return variant === "adminForm" ? <div>{imgSection}</div> : <div className="mt-4">{imgSection}</div>;
}
