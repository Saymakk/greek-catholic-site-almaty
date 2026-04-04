import { requireStaff } from "@/lib/admin";
import { saveLiturgicalEvent } from "../../actions/calendar";

const KINDS = [
  ["great_feast", "Великий праздник"],
  ["feast", "Праздник"],
  ["sunday", "Воскресенье"],
  ["fast", "Пост"],
  ["commemoration", "Память"],
  ["other", "Другое"],
] as const;

export default async function AdminCalendarNewPage() {
  await requireStaff();

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Событие календаря</h1>
      <form action={saveLiturgicalEvent} className="mt-8 max-w-3xl space-y-6">
        <input type="hidden" name="id" value="" />
        <label className="block text-sm text-parish-muted">
          Дата
          <input
            type="date"
            name="event_date"
            required
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          />
        </label>
        <label className="block text-sm text-parish-muted">
          Тип
          <select
            name="kind"
            required
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
          Порядок в один день (число: меньше — выше в списке)
          <input
            type="number"
            name="sort_order"
            defaultValue={0}
            className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
          />
        </label>
        {(["ru", "uk", "kk", "en"] as const).map((lang) => (
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
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
              />
            </label>
            <label className="mt-3 block text-sm text-parish-muted">
              Пояснение (текст или HTML)
              <textarea
                name={`explanation_${lang}`}
                rows={5}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
              />
            </label>
            <label className="mt-3 block text-sm text-parish-muted">
              Молитва (текст или HTML, опционально)
              <textarea
                name={`prayer_${lang}`}
                rows={4}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
              />
            </label>
          </fieldset>
        ))}
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
