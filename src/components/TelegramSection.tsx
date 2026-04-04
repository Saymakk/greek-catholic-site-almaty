import { format, parseISO } from "date-fns";
import type { Lang } from "@/lib/i18n";
import { t } from "@/lib/ui-strings";

type Msg = { id: string; text: string | null; sent_at: string | null };

export function TelegramSection({
  lang,
  messages,
  variant = "default",
}: {
  lang: Lang;
  messages: Msg[];
  variant?: "default" | "sidebar";
}) {
  const isSidebar = variant === "sidebar";

  return (
    <section id="telegram" className="scroll-mt-24">
      <h2
        className={
          isSidebar
            ? "font-display text-lg font-semibold leading-tight text-parish-text lg:text-xl"
            : "font-display text-2xl font-semibold text-parish-text"
        }
      >
        {t(lang, "telegramTitle")}
      </h2>
      <ul className={isSidebar ? "mt-4 space-y-3" : "mt-6 space-y-4"}>
        {messages.length === 0 ? (
          <li
            className={
              isSidebar
                ? "text-xs font-medium text-parish-muted"
                : "font-medium text-parish-muted"
            }
          >
            {t(lang, "telegramEmpty")}
          </li>
        ) : (
          messages.map((m) => (
            <li
              key={m.id}
              className={
                isSidebar
                  ? "rounded-xl border border-parish-border bg-parish-surface px-3 py-2.5 text-xs font-medium text-parish-text"
                  : "rounded-xl border border-parish-border bg-parish-surface px-4 py-3 text-sm font-medium text-parish-text"
              }
            >
              {m.sent_at ? (
                <time
                  className={
                    isSidebar
                      ? "text-[10px] font-semibold text-parish-muted"
                      : "text-xs font-semibold text-parish-muted"
                  }
                  dateTime={m.sent_at}
                >
                  {format(parseISO(m.sent_at), "PPp")}
                </time>
              ) : null}
              <p className="mt-1.5 whitespace-pre-wrap leading-snug">{m.text ?? ""}</p>
            </li>
          ))
        )}
      </ul>
    </section>
  );
}
