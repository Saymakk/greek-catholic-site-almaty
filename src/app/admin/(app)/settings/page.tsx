import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { saveFooter } from "../actions/content";

const FOOTER_ERR: Record<string, string> = {
  parse:
    "Некорректный JSON. Проверьте двойные кавычки у ключей и строк, запятые между полями, без запятой после последнего поля.",
  shape: "Корнем должен быть объект в фигурных скобках { … }, не массив и не одна строка.",
};

export default async function AdminSettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ footer_err?: string }>;
}) {
  await requireStaff();
  const q = await searchParams;
  const footerErr = q.footer_err ? FOOTER_ERR[q.footer_err] ?? null : null;
  const supabase = await createClient();
  const { data } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "footer")
    .maybeSingle();

  const json = JSON.stringify(data?.value ?? {}, null, 2);

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Контакты и футер</h1>
      <p className="mt-2 max-w-2xl text-sm text-parish-muted">
        Один JSON: <code className="rounded bg-parish-accent-soft px-1">priest_name_*</code> (ФИО
        настоятеля), общие <code className="rounded bg-parish-accent-soft px-1">email</code> и{" "}
        <code className="rounded bg-parish-accent-soft px-1">phone</code>, по языкам —{" "}
        <code className="rounded bg-parish-accent-soft px-1">address_*</code> и при необходимости{" "}
        <code className="rounded bg-parish-accent-soft px-1">extra_*</code>. Пустое значение для
        языка на сайте подменяется русским.
      </p>
      {footerErr ? (
        <p className="mt-4 max-w-2xl rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-800">
          {footerErr}
        </p>
      ) : null}
      <form action={saveFooter} className="mt-8 max-w-3xl">
        <textarea
          name="footer_json"
          rows={24}
          defaultValue={json}
          className="w-full rounded-lg border border-parish-border px-3 py-2 font-mono text-sm"
        />
        <button
          type="submit"
          className="mt-4 rounded-lg bg-parish-accent px-6 py-2 text-white hover:opacity-90"
        >
          Сохранить
        </button>
      </form>
    </div>
  );
}
