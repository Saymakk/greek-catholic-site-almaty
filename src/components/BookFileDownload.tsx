"use client";

import { useState, type ReactNode } from "react";

/** Расширение по MIME, если в URL нет суффикса или сервер отдал octet-stream */
const MIME_TO_EXT: Record<string, string> = {
  "application/pdf": ".pdf",
  "application/epub+zip": ".epub",
  "application/x-mobipocket-ebook": ".mobi",
  "application/msword": ".doc",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document": ".docx",
  "text/plain": ".txt",
  "application/rtf": ".rtf",
  "application/zip": ".zip",
};

function filenameFromUrl(url: string): string {
  try {
    const seg = decodeURIComponent(new URL(url).pathname.split("/").pop() || "");
    return seg.replace(/[/\\]/g, "_") || "download";
  } catch {
    return "download";
  }
}

function ensureExtension(name: string, blob: Blob): string {
  if (/\.[a-z0-9]{2,8}$/i.test(name)) return name;
  const ext = MIME_TO_EXT[blob.type];
  if (ext) return `${name}${ext}`;
  return `${name}.bin`;
}

export function BookFileDownload({
  fileUrl,
  className,
  children,
}: {
  fileUrl: string;
  className?: string;
  children: ReactNode;
}) {
  const [busy, setBusy] = useState(false);

  async function onClick(e: React.MouseEvent<HTMLAnchorElement>) {
    e.preventDefault();
    if (busy) return;
    setBusy(true);
    try {
      const res = await fetch(fileUrl);
      if (!res.ok) throw new Error(String(res.status));
      const blob = await res.blob();
      const name = ensureExtension(filenameFromUrl(fileUrl), blob);
      const obj = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = obj;
      a.download = name;
      document.body.appendChild(a);
      a.click();
      a.remove();
      URL.revokeObjectURL(obj);
    } catch {
      window.open(fileUrl, "_blank", "noopener,noreferrer");
    } finally {
      setBusy(false);
    }
  }

  return (
    <a
      href={fileUrl}
      className={className}
      onClick={onClick}
      rel="noopener noreferrer"
      aria-busy={busy}
    >
      {children}
    </a>
  );
}
