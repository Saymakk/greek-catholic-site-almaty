"use client";

import { useEffect, useRef } from "react";
import { stripEmbedScriptsForDisplay } from "@/lib/news-cover";

const IG = /instagram-media|data-instgrm-permalink/i;
const TW = /twitter-tweet|class\s*=\s*["'][^"']*twitter-tweet/i;

declare global {
  interface Window {
    instgrm?: { Embeds?: { process: () => void } };
    twttr?: { widgets?: { load: (el?: Element | HTMLElement) => void } };
  }
}

function runInstagramEmbeds() {
  window.instgrm?.Embeds?.process();
}

function loadInstagramScriptThen(cb: () => void) {
  if (window.instgrm?.Embeds?.process) {
    cb();
    return;
  }
  const existing = document.querySelector(
    'script[src*="instagram.com/embed.js"]',
  ) as HTMLScriptElement | null;
  if (existing) {
    if (window.instgrm?.Embeds?.process) {
      cb();
    } else {
      existing.addEventListener("load", () => cb(), { once: true });
    }
    return;
  }
  const s = document.createElement("script");
  s.async = true;
  s.src = "https://www.instagram.com/embed.js";
  s.onload = () => cb();
  document.body.appendChild(s);
}

function loadTwitterScriptThen(cb: () => void) {
  if (window.twttr?.widgets?.load) {
    cb();
    return;
  }
  const existing = document.querySelector(
    'script[src*="platform.twitter.com/widgets.js"]',
  ) as HTMLScriptElement | null;
  if (existing) {
    existing.addEventListener("load", () => cb(), { once: true });
    return;
  }
  const s = document.createElement("script");
  s.async = true;
  s.src = "https://platform.twitter.com/widgets.js";
  s.charset = "utf-8";
  s.onload = () => cb();
  document.body.appendChild(s);
}

/**
 * Вставки с внешними script (Instagram, Twitter) не выполняются через innerHTML;
 * подключаем проверенные скрипты и инициализируем виджеты.
 */
export function NewsEmbedHtml({
  html,
  className,
  innerClassName,
}: {
  html: string;
  className?: string;
  innerClassName?: string;
}) {
  const ref = useRef<HTMLDivElement>(null);
  const safeHtml = stripEmbedScriptsForDisplay(html);
  const isIg = IG.test(html);
  const isTw = TW.test(html);

  useEffect(() => {
    if (isIg) {
      loadInstagramScriptThen(() => {
        runInstagramEmbeds();
        window.requestAnimationFrame(() => runInstagramEmbeds());
      });
      return;
    }
    if (isTw) {
      loadTwitterScriptThen(() => {
        if (ref.current) window.twttr?.widgets?.load(ref.current);
      });
      return;
    }
  }, [html, isIg, isTw]);

  const defaultIframe =
    "news-cover-embed rich-html relative aspect-video w-full overflow-hidden rounded-xl border border-parish-border/60 bg-black/5 [&_iframe]:absolute [&_iframe]:inset-0 [&_iframe]:h-full [&_iframe]:w-full [&_iframe]:border-0 [&_video]:h-full [&_video]:w-full [&_video]:object-contain";

  const defaultIg =
    "news-cover-embed rich-html w-full max-w-full overflow-hidden rounded-xl border border-parish-border/60 bg-black/5 [&_blockquote]:mx-auto [&_blockquote]:max-w-[540px]";

  const resolvedInner = isIg ? (innerClassName ?? defaultIg) : innerClassName ?? defaultIframe;

  return (
    <div className={className}>
      <div ref={ref} className={resolvedInner} dangerouslySetInnerHTML={{ __html: safeHtml }} />
    </div>
  );
}
