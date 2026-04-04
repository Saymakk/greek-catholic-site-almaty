import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import Link from "next/link";
import { deleteNewsForm } from "../actions/news";
import { format, parseISO } from "date-fns";

export default async function AdminNewsListPage() {
  await requireStaff();
  const supabase = await createClient();
  const { data: rows } = await supabase
    .from("news")
    .select("id, published_at, is_published, news_i18n ( lang, title )")
    .order("published_at", { ascending: false });

  return (
    <div>
      <div className="flex items-center justify-between gap-4">
        <h1 className="font-display text-2xl text-parish-text">Новости</h1>
        <Link
          href="/admin/news/new"
          className="rounded-lg bg-parish-accent px-4 py-2 text-sm text-white hover:opacity-90"
        >
          Создать
        </Link>
      </div>
      <ul className="mt-8 space-y-3">
        {(rows ?? []).map(
          (n: {
            id: string;
            published_at: string;
            is_published: boolean;
            news_i18n: { lang: string; title: string }[];
          }) => {
            const title =
              n.news_i18n?.find((x) => x.lang === "ru")?.title ??
              n.news_i18n?.[0]?.title ??
              "—";
            return (
              <li
                key={n.id}
                className="flex flex-wrap items-center justify-between gap-3 rounded-xl border border-parish-border bg-parish-surface px-4 py-3"
              >
                <div className="min-w-0 flex-1">
                  <span className="text-sm text-parish-muted">
                    {format(parseISO(n.published_at), "dd.MM.yyyy")}
                    {!n.is_published ? " · черновик" : ""}
                  </span>
                  <p className="font-medium text-parish-text">{title}</p>
                </div>
                <div className="flex shrink-0 items-center gap-3">
                  <Link
                    href={`/admin/news/${n.id}`}
                    className="inline-flex h-9 items-center justify-center rounded-lg border border-parish-border bg-parish-surface px-3 text-sm font-medium text-parish-accent hover:bg-parish-accent-soft"
                  >
                    Редактировать
                  </Link>
                  <form action={deleteNewsForm} className="inline-flex">
                    <input type="hidden" name="id" value={n.id} />
                    <button
                      type="submit"
                      className="inline-flex h-9 items-center justify-center rounded-lg border border-red-200 bg-parish-surface px-3 text-sm font-medium text-red-600 hover:bg-red-50"
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
