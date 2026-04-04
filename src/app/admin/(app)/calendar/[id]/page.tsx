import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { notFound } from "next/navigation";
import { saveLiturgicalEvent } from "../../actions/calendar";

const KINDS = [
  ["great_feast", "Великий праздник"],
  ["feast", "Праздник"],
  ["sunday", "Воскресенье"],
  ["fast", "Пост"],
  ["commemoration", "Память"],
  ["other", "Другое"],
] as const;

export default async function AdminCalendarEditPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  await requireStaff();
  const { id } = await params;
  const supabase = await createClient();
  const { data: ev } = await supabase
    .from("liturgical_events")
    .select("id, event_date, kind, sort_order")
    .eq("id", id)
    .single();
  if (!ev) notFound();
  const { data: i18n } = await supabase
    .from("liturgical_event_i18n")
    .select("lang, title, explanation, prayer")
    .eq("event_id", id);

  const byLang = Object.fromEntries(
    (i18n ?? []).map(
      (r: {
        lang: string;
        title: string;
        explanation: string;
        prayer: string | null;
      }) => [r.lang, r],
    ),
  );

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Редактирование события</h1>
      <form action={saveLiturgicalEvent} className="mt-8 max-w-3xl space-y-6">
        <input type="hidden" name="id" value={ev.id} />
        <label className="block text-sm text-parish-muted">
          Дата
          <input
            type="date"
            name="event_date"
            required
            defaultValue={ev.event_date}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          />
        </label>
        <label className="block text-sm text-parish-muted">
          Тип
          <select
            name="kind"
            required
            defaultValue={ev.kind}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          >
            {KINDS.map(([v, label]) => (
              <option key={v} value={v}>
                {label}
              </option>
            ))}
          </select>
        </label>
        <label className="block text-sm text-parish-muted">
          Порядок в один день (меньше — выше)
          <input
            type="number"
            name="sort_order"
            defaultValue={ev.sort_order}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          />
        </label>
        {(["ru", "uk", "kk", "en"] as const).map((lang) => {
          const row = byLang[lang] as
            | { title: string; explanation: string; prayer: string | null }
            | undefined;
          return (
            <fieldset
              key={lang}
              className="rounded-xl border border-parish-border p-4"
            >
              <legend className="px-2 text-sm font-medium text-parish-accent">
                {lang.toUpperCase()}
              </legend>
              <label className="mt-2 block text-sm text-parish-muted">
                Название
                <input
                  name={`title_${lang}`}
                  defaultValue={row?.title ?? ""}
                  className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              <label className="mt-3 block text-sm text-parish-muted">
                Пояснение (текст или HTML)
                <textarea
                  name={`explanation_${lang}`}
                  rows={5}
                  defaultValue={row?.explanation ?? ""}
                  className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
                />
              </label>
              <label className="mt-3 block text-sm text-parish-muted">
                Молитва (текст или HTML)
                <textarea
                  name={`prayer_${lang}`}
                  rows={4}
                  defaultValue={row?.prayer ?? ""}
                  className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
                />
              </label>
            </fieldset>
          );
        })}
        <button
          type="submit"
          className="rounded-lg bg-parish-accent px-6 py-2 text-white hover:opacity-90"
        >
          Сохранить
        </button>
      </form>
    </div>
  );
}
