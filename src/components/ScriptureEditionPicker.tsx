"use client";

import {
  useEffect,
  useLayoutEffect,
  useRef,
  useState,
  type ReactNode,
} from "react";
import { createPortal } from "react-dom";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";
import { BookFileDownload } from "@/components/BookFileDownload";
import type { ScriptureEditionMenuItem } from "@/lib/data";

const MENU_MIN_W = 224;

function useFixedMenuPosition(
  open: boolean,
  anchorRef: React.RefObject<HTMLElement | null>,
) {
  const [pos, setPos] = useState({ top: 0, left: 0, width: MENU_MIN_W });

  useLayoutEffect(() => {
    if (!open || !anchorRef.current) return;

    const update = () => {
      const r = anchorRef.current?.getBoundingClientRect();
      if (!r) return;
      const width = Math.max(MENU_MIN_W, r.width);
      let left = r.left;
      if (left + width > window.innerWidth - 8) {
        left = window.innerWidth - width - 8;
      }
      if (left < 8) left = 8;
      setPos({ top: r.bottom + 6, left, width });
    };

    update();
    window.addEventListener("resize", update);
    window.addEventListener("scroll", update, true);
    return () => {
      window.removeEventListener("resize", update);
      window.removeEventListener("scroll", update, true);
    };
  }, [open, anchorRef]);

  return pos;
}

function useCloseOnOutsideAndEscape(
  open: boolean,
  onClose: () => void,
  anchorRef: React.RefObject<HTMLElement | null>,
  menuRef: React.RefObject<HTMLElement | null>,
) {
  useEffect(() => {
    if (!open) return;
    function onDoc(e: MouseEvent) {
      const t = e.target as Node;
      if (anchorRef.current?.contains(t) || menuRef.current?.contains(t)) return;
      onClose();
    }
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") onClose();
    }
    document.addEventListener("mousedown", onDoc);
    document.addEventListener("keydown", onKey);
    return () => {
      document.removeEventListener("mousedown", onDoc);
      document.removeEventListener("keydown", onKey);
    };
  }, [open, onClose, anchorRef, menuRef]);
}

export function ScriptureReadPicker({
  lang,
  options,
  className,
  anchorClassName,
  children,
}: {
  lang: Lang;
  options: ScriptureEditionMenuItem[];
  className: string;
  /** Обёртка якоря: для `w-full` у кнопки передайте `block w-full`. */
  anchorClassName?: string;
  children: ReactNode;
}) {
  const [open, setOpen] = useState(false);
  const anchorRef = useRef<HTMLDivElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);
  const pos = useFixedMenuPosition(open, anchorRef);
  useCloseOnOutsideAndEscape(open, () => setOpen(false), anchorRef, menuRef);

  const hasUrl = options.some((o) => o.url);
  if (options.length === 0 || !hasUrl) return null;
  if (options.length === 1 && options[0].url) {
    return (
      <div className={anchorClassName ?? "inline-block"}>
        <a
          href={options[0].url}
          target="_blank"
          rel="noopener noreferrer"
          className={className}
        >
          {children}
        </a>
      </div>
    );
  }

  const menu =
    open && typeof document !== "undefined"
      ? createPortal(
          <div
            ref={menuRef}
            role="menu"
            className="fixed z-[200] rounded-lg border border-parish-border bg-parish-surface py-1 shadow-xl"
            style={{ top: pos.top, left: pos.left, minWidth: pos.width }}
          >
            <p className="border-b border-parish-border/60 px-3 py-1.5 text-xs text-parish-muted">
              {t(lang, "scripturePickLanguage")}
            </p>
            {options.map((o) =>
              o.url ? (
                <a
                  key={`${o.langCode}-read`}
                  href={o.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  role="menuitem"
                  className="block px-3 py-2 text-sm text-parish-text hover:bg-parish-accent-soft"
                  onClick={() => setOpen(false)}
                >
                  {o.label}
                </a>
              ) : (
                <div
                  key={`${o.langCode}-read-empty`}
                  role="presentation"
                  className="px-3 py-2 text-sm text-parish-muted"
                  title={t(lang, "scriptureNoLinkForEdition")}
                >
                  <span className="text-parish-text/80">{o.label}</span>
                  <span className="mt-0.5 block text-xs text-parish-muted">
                    {t(lang, "scriptureNoLinkForEdition")}
                  </span>
                </div>
              ),
            )}
          </div>,
          document.body,
        )
      : null;

  return (
    <>
      <div ref={anchorRef} className={anchorClassName ?? "inline-block"}>
        <button
          type="button"
          className={className}
          onClick={() => setOpen((o) => !o)}
          aria-expanded={open}
          aria-haspopup="menu"
        >
          {children}
        </button>
      </div>
      {menu}
    </>
  );
}

export function ScriptureFilePicker({
  lang,
  options,
  className,
  anchorClassName,
  children,
}: {
  lang: Lang;
  options: ScriptureEditionMenuItem[];
  className: string;
  anchorClassName?: string;
  children: ReactNode;
}) {
  const [open, setOpen] = useState(false);
  const anchorRef = useRef<HTMLDivElement>(null);
  const menuRef = useRef<HTMLDivElement>(null);
  const pos = useFixedMenuPosition(open, anchorRef);
  useCloseOnOutsideAndEscape(open, () => setOpen(false), anchorRef, menuRef);

  const hasUrl = options.some((o) => o.url);
  if (options.length === 0 || !hasUrl) return null;
  if (options.length === 1 && options[0].url) {
    return (
      <div className={anchorClassName ?? "inline-block"}>
        <BookFileDownload fileUrl={options[0].url} className={className}>
          {children}
        </BookFileDownload>
      </div>
    );
  }

  const menu =
    open && typeof document !== "undefined"
      ? createPortal(
          <div
            ref={menuRef}
            role="menu"
            className="fixed z-[200] rounded-lg border border-parish-border bg-parish-surface py-1 shadow-xl"
            style={{ top: pos.top, left: pos.left, minWidth: pos.width }}
          >
            <p className="border-b border-parish-border/60 px-3 py-1.5 text-xs text-parish-muted">
              {t(lang, "scripturePickLanguage")}
            </p>
            <div className="px-1 py-0.5">
              {options.map((o) =>
                o.url ? (
                  <BookFileDownload
                    key={`${o.langCode}-file`}
                    fileUrl={o.url}
                    className="block w-full rounded-md px-2 py-2 text-left text-sm text-parish-text hover:bg-parish-accent-soft"
                  >
                    {o.label}
                  </BookFileDownload>
                ) : (
                  <div
                    key={`${o.langCode}-file-empty`}
                    role="presentation"
                    className="rounded-md px-2 py-2 text-left text-sm text-parish-muted"
                    title={t(lang, "scriptureNoLinkForEdition")}
                  >
                    <span className="text-parish-text/80">{o.label}</span>
                    <span className="mt-0.5 block text-xs text-parish-muted">
                      {t(lang, "scriptureNoLinkForEdition")}
                    </span>
                  </div>
                ),
              )}
            </div>
          </div>,
          document.body,
        )
      : null;

  return (
    <>
      <div ref={anchorRef} className={anchorClassName ?? "inline-block"}>
        <button
          type="button"
          className={className}
          onClick={() => setOpen((o) => !o)}
          aria-expanded={open}
          aria-haspopup="menu"
        >
          {children}
        </button>
      </div>
      {menu}
    </>
  );
}
