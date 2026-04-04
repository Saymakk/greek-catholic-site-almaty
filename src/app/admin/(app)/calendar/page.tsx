import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import Link from "next/link";
import { format, parseISO } from "date-fns";
import { deleteLiturgicalEventForm } from "../actions/calendar";

export default async function AdminCalendarPage() {
  await requireStaff();
  const supabase = await createClient();
  const { data: rows } = await supabase
    .from("liturgical_events")
    .select("id, event_date, kind, sort_order, liturgical_event_i18n ( lang, title )")
    .order("event_date", { ascending: true })
    .order("sort_order", { ascending: true });

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <h1 className="font-display text-2xl text-parish-text">Календарь</h1>
        <Link
          href="/admin/calendar/new"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
        >
          Добавить
        </Link>
      </div>
      <ul className="mt-8 space-y-3">
        {(rows ?? []).map(
          (e: {
            id: string;
            event_date: string;
            kind: string;
            liturgical_event_i18n: { lang: string; title: string }[];
          }) => {
            const title =
              e.liturgical_event_i18n?.find((x) => x.lang === "ru")?.title ??
              e.liturgical_event_i18n?.[0]?.title ??
              "—";
            return (
              <li
                key={e.id}
                className="flex flex-wrap items-center justify-between gap-2 rounded-xl border border-parish-border bg-parish-surface px-4 py-3"
              >
                <div>
                  <span className="text-sm text-parish-muted">
                    {format(parseISO(e.event_date), "dd.MM.yyyy")} · {e.kind}
                  </span>
                  <p className="font-medium text-parish-text">{title}</p>
                </div>
                <div className="flex gap-2">
                  <Link
                    href={`/admin/calendar/${e.id}`}
                    className="text-sm text-parish-accent hover:underline"
                  >
                    Редактировать
                  </Link>
                  <form action={deleteLiturgicalEventForm}>
                    <input type="hidden" name="id" value={e.id} />
                    <button
                      type="submit"
                      className="text-sm text-red-600 hover:underline"
                    >
                      Удалить
                    </button>
                  </form>
                </div>
              </li>
            );
          },
        )}
      </ul>
    </div>
  );
}
