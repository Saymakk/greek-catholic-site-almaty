import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { saveHistory } from "../actions/content";

export default async function AdminHistoryPage() {
  await requireStaff();
  const supabase = await createClient();
  const { data: rows } = await supabase
    .from("page_content")
    .select("lang, body")
    .eq("page_key", "history");

  const byLang = Object.fromEntries(
    (rows ?? []).map((r: { lang: string; body: string }) => [r.lang, r.body]),
  );

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Страница «История»</h1>
      <p className="mt-2 text-sm text-parish-muted">
        Для каждого языка: обычный текст (абзацы через пустую строку) или HTML.
      </p>
      <form action={saveHistory} className="mt-8 max-w-4xl space-y-6">
        {(["ru", "uk", "kk", "en"] as const).map((lang) => (
          <label key={lang} className="block text-sm text-parish-muted">
            {lang.toUpperCase()}
            <textarea
              name={`history_${lang}`}
              rows={12}
              defaultValue={byLang[lang] ?? ""}
              className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
            />
          </label>
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
