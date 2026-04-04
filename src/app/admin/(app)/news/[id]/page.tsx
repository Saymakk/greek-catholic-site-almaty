import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { notFound } from "next/navigation";
import { saveNews } from "../../actions/news";
import Image from "next/image";

export default async function AdminNewsEditPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  await requireStaff();
  const { id } = await params;
  const supabase = await createClient();
  const { data: news } = await supabase
    .from("news")
    .select("id, is_published, cover_image_url")
    .eq("id", id)
    .single();
  if (!news) notFound();
  const { data: i18n } = await supabase
    .from("news_i18n")
    .select("lang, title, excerpt, body")
    .eq("news_id", id);

  const byLang = Object.fromEntries(
    (i18n ?? []).map((r: { lang: string; title: string; excerpt: string | null; body: string }) => [
      r.lang,
      r,
    ]),
  );

  const coverUrl = (news as { cover_image_url?: string | null }).cover_image_url;

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Редактирование</h1>
      <form action={saveNews} className="mt-8 max-w-3xl space-y-8">
        <input type="hidden" name="id" value={news.id} />
        <label className="flex items-center gap-2 text-sm">
          <input
            type="checkbox"
            name="is_published"
            defaultChecked={news.is_published}
            className="rounded"
          />
          Опубликовано
        </label>
        {coverUrl ? (
          <div className="relative h-48 w-full max-w-md overflow-hidden rounded-xl border border-parish-border">
            <Image src={coverUrl} alt="" fill className="object-cover" sizes="400px" />
          </div>
        ) : null}
        <label className="flex items-center gap-2 text-sm text-parish-muted">
          <input type="checkbox" name="remove_cover" className="rounded" />
          Удалить обложку
        </label>
        <label className="block text-sm text-parish-muted">
          Новое изображение обложки
          <input
            type="file"
            name="cover"
            accept="image/*"
            className="mt-1 block w-full text-sm text-parish-text"
          />
        </label>
        {(["ru", "uk", "kk", "en"] as const).map((lang) => {
          const row = byLang[lang] as
            | { title: string; excerpt: string | null; body: string }
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
                Заголовок
                <input
                  name={`title_${lang}`}
                  defaultValue={row?.title ?? ""}
                  className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              <label className="mt-3 block text-sm text-parish-muted">
                Кратко
                <input
                  name={`excerpt_${lang}`}
                  defaultValue={row?.excerpt ?? ""}
                  className="mt-1 w-full rounded-lg border border-parish-border px-3 py-2"
                />
              </label>
              <label className="mt-3 block text-sm text-parish-muted">
                Текст (обычный или HTML)
                <textarea
                  name={`body_${lang}`}
                  rows={6}
                  defaultValue={row?.body ?? ""}
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
