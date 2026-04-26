import { createClient } from "@/lib/supabase/server";
import { requireStaffCanViewObjects } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { AdminHistoryClient } from "./AdminHistoryClient";
import { normalizeHistoryLocales } from "./history-entity-locales";

export default async function AdminHistoryPage({
  searchParams,
}: {
  searchParams: Promise<{ edit?: string }>;
}) {
  await requireStaffCanViewObjects();
  const uiLang = await getLang();
  const { edit } = await searchParams;
  const autoOpen = edit === "1" || edit === "true";

  const supabase = await createClient();
  const { data: rows } = await supabase
    .from("page_content")
    .select("lang, body")
    .eq("page_key", "history");

  const locales = normalizeHistoryLocales(
    (rows ?? []) as { lang: string; body: string | null }[],
  );

  return (
    <AdminHistoryClient uiLang={uiLang} locales={locales} autoOpen={autoOpen} />
  );
}
