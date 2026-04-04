import { requireStaff } from "@/lib/admin";
import { saveNews } from "../../actions/news";

export default async function AdminNewsNewPage() {
  await requireStaff();

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Новая новость</h1>
      <form action={saveNews} className="mt-8 max-w-3xl space-y-8">
        <input type="hidden" name="id" value="" />
        <label className="flex items-center gap-2 text-sm">
          <input type="checkbox" name="is_published" defaultChecked className="rounded" />
          Опубликовано
        </label>
        <label className="block text-sm text-parish-muted">
          Обложка (изображение)
          <input
            type="file"
            name="cover"
            accept="image/*"
            className="mt-1 block w-full text-sm text-parish-text"
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
              Заголовок
              <input
                name={`title_${lang}`}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
              />
            </label>
            <label className="mt-3 block text-sm text-parish-muted">
              Кратко
              <input
                name={`excerpt_${lang}`}
                className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
              />
            </label>
            <label className="mt-3 block text-sm text-parish-muted">
              Текст: обычный (абзацы через пустую строку) или с HTML-разметкой
              <textarea
                name={`body_${lang}`}
                rows={6}
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
