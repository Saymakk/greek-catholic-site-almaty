import { requireStaff } from "@/lib/admin";
import {
  adminActivityActionLabel,
  adminActivityEntityLabel,
  adminDashboardCopy,
} from "@/lib/admin-activity-i18n";
import { adminRoleLabel } from "@/lib/admin-layout-i18n";
import { createClient } from "@/lib/supabase/server";
import { getLang } from "@/lib/i18n-server";
import type { Lang } from "@/lib/i18n";
import { format } from "date-fns";
import { enUS } from "date-fns/locale/en-US";
import { ru } from "date-fns/locale/ru";
import { uk } from "date-fns/locale/uk";
type LogRow = {
  id: string;
  created_at: string;
  actor_email: string;
  action: string;
  entity_type: string;
  entity_id: string | null;
  summary: string | null;
  meta: Record<string, unknown> | null;
};

function dateLocaleForUi(lang: Lang) {
  if (lang === "uk") return uk;
  if (lang === "en") return enUS;
  if (lang === "kk") return ru;
  return ru;
}

function formatLogDetails(lang: Lang, row: LogRow): string | null {
  if (row.summary) return row.summary;
  const m = row.meta;
  if (m && typeof m === "object" && "event_date" in m && typeof m.event_date === "string") {
    const k = m.kind;
    const kindStr = typeof k === "string" ? k.replace(/_/g, " ") : "";
    return [m.event_date, kindStr].filter(Boolean).join(" · ");
  }
  if (m && typeof m === "object" && "locale" in m) {
    return String(m.locale);
  }
  if (row.entity_id) {
    const id = row.entity_id;
    return id.length > 14 ? `${id.slice(0, 8)}…` : id;
  }
  return null;
}

export default async function AdminHomePage() {
  const profile = await requireStaff();
  const lang = await getLang();
  const copy = adminDashboardCopy(lang);

  const supabase = await createClient();
  const { data: rawLogs, error: logError } = await supabase
    .from("admin_activity_log")
    .select("id, created_at, actor_email, action, entity_type, entity_id, summary, meta")
    .order("created_at", { ascending: false })
    .limit(50);

  const logs = (rawLogs ?? []) as LogRow[];
  const dfLocale = dateLocaleForUi(lang);

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{copy.pageTitle}</h1>
      <p className="mt-2 text-sm text-parish-muted">
        {copy.welcomeLine}{" "}
        <span className="font-medium text-parish-text">{profile.email}</span> (
        {adminRoleLabel(lang, profile.role)}).
      </p>

      <section className="mt-10">
        <h2 className="font-display text-lg font-semibold text-parish-text">
          {copy.activityTitle}
        </h2>
        {logError ? (
          <p className="mt-3 text-sm text-amber-800 dark:text-amber-200">{copy.activityUnavailable}</p>
        ) : logs.length === 0 ? (
          <p className="mt-3 text-sm text-parish-muted">{copy.activityEmpty}</p>
        ) : (
          <div className="mt-4 overflow-x-auto rounded-xl border border-parish-border bg-parish-surface">
            <table className="w-full min-w-[36rem] border-collapse text-left text-sm">
              <thead>
                <tr className="border-b border-parish-border bg-parish-bg/80 text-xs font-semibold uppercase tracking-wide text-parish-muted">
                  <th className="px-3 py-2.5 sm:px-4">{copy.colTime}</th>
                  <th className="px-3 py-2.5 sm:px-4">{copy.colUser}</th>
                  <th className="px-3 py-2.5 sm:px-4">{copy.colAction}</th>
                  <th className="px-3 py-2.5 sm:px-4">{copy.colDetails}</th>
                </tr>
              </thead>
              <tbody>
                {logs.map((row) => (
                  <tr
                    key={row.id}
                    className="border-b border-parish-border/70 last:border-0 hover:bg-parish-accent-soft/30"
                  >
                    <td className="whitespace-nowrap px-3 py-2.5 text-parish-muted sm:px-4">
                      {format(new Date(row.created_at), "dd.MM.yyyy HH:mm", { locale: dfLocale })}
                    </td>
                    <td className="max-w-[10rem] truncate px-3 py-2.5 sm:max-w-[14rem] sm:px-4">
                      {row.actor_email || "—"}
                    </td>
                    <td className="px-3 py-2.5 sm:px-4">
                      <span className="font-medium text-parish-text">
                        {adminActivityActionLabel(lang, row.action)}
                      </span>
                      <span className="mt-0.5 block text-xs text-parish-muted">
                        {adminActivityEntityLabel(lang, row.entity_type)}
                      </span>
                    </td>
                    <td className="max-w-xs px-3 py-2.5 text-parish-muted sm:max-w-md sm:px-4">
                      {formatLogDetails(lang, row) ?? "—"}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </div>
  );
}
