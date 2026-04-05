import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { adminSettingsCopy } from "@/lib/admin-layout-i18n";
import { saveFooter } from "../actions/content";

export default async function AdminSettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ footer_err?: string }>;
}) {
  await requireStaff();
  const lang = await getLang();
  const s = adminSettingsCopy(lang);
  const q = await searchParams;
  const errKey = q.footer_err === "parse" || q.footer_err === "shape" ? q.footer_err : null;
  const footerErr = errKey ? (errKey === "parse" ? s.errParse : s.errShape) : null;

  const supabase = await createClient();
  const { data } = await supabase
    .from("site_settings")
    .select("value")
    .eq("key", "footer")
    .maybeSingle();

  const json = JSON.stringify(data?.value ?? {}, null, 2);

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{s.pageTitle}</h1>
      <p className="mt-2 max-w-2xl text-sm text-parish-muted">
        {s.introBeforeJson}{" "}
        <code className="rounded bg-parish-accent-soft px-1">{s.introPriestCode}</code>{" "}
        {s.introPriestDesc}{" "}
        <code className="rounded bg-parish-accent-soft px-1">{s.introEmailCode}</code> {s.introAnd}{" "}
        <code className="rounded bg-parish-accent-soft px-1">{s.introPhoneCode}</code>
        {s.introPerLang}{" "}
        <code className="rounded bg-parish-accent-soft px-1">{s.introAddressCode}</code>,{" "}
        {s.introExtraPart}{" "}
        <code className="rounded bg-parish-accent-soft px-1">{s.introExtraCode}</code>
        {s.introFallback}
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
          {s.save}
        </button>
      </form>
    </div>
  );
}
