import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { AdminCalendarClient, type AdminCalendarPayload } from "./AdminCalendarClient";
import { normalizeCalendarLocales } from "./calendar-entity-locales";

export default async function AdminCalendarPage({
  searchParams,
}: {
  searchParams: Promise<{ id?: string }>;
}) {
  await requireStaff();
  const lang = await getLang();
  const { id: openEventId } = await searchParams;
  const supabase = await createClient();
  const i18n =
    "liturgical_event_i18n ( lang, title, explanation, prayer )";
  const selFull = `id, event_date, kind, sort_order, primary_lang, cover_image_url, ${i18n}`;
  const selCoverOnly = `id, event_date, kind, sort_order, cover_image_url, ${i18n}`;
  const selPrimaryOnly = `id, event_date, kind, sort_order, primary_lang, ${i18n}`;
  const selMin = `id, event_date, kind, sort_order, ${i18n}`;

  const q = (sel: string) =>
    supabase
      .from("liturgical_events")
      .select(sel)
      .order("event_date", { ascending: true })
      .order("sort_order", { ascending: true });

  let res = await q(selFull);
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) throw new Error(msg);
    if (msg.includes("primary_lang")) {
      res = await q(selCoverOnly);
    } else if (msg.includes("cover_image_url")) {
      res = await q(selPrimaryOnly);
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) throw new Error(msg);
    res = await q(selMin);
  }
  if (res.error) throw new Error(res.error.message);
  type LiturgicalListRow = {
    id: string;
    event_date: string;
    kind: string;
    sort_order: number;
    primary_lang?: string | null;
    cover_image_url?: string | null;
    liturgical_event_i18n: {
      lang: string;
      title: string;
      explanation: string;
      prayer: string | null;
    }[];
  };
  const rows = (res.data ?? []) as unknown as LiturgicalListRow[];

  const items: AdminCalendarPayload[] = rows.map((row) => {
    const pl =
      row.primary_lang && ["ru", "uk", "kk", "en"].includes(row.primary_lang)
        ? row.primary_lang
        : null;
    return {
      id: row.id,
      event_date: row.event_date,
      kind: row.kind,
      sort_order: Number(row.sort_order ?? 0),
      primary_lang: pl,
      cover_image_url: row.cover_image_url ?? null,
      locales: normalizeCalendarLocales(row.liturgical_event_i18n ?? [], pl),
    };
  });

  return (
    <AdminCalendarClient
      lang={lang}
      items={items}
      initialEventId={openEventId ?? null}
    />
  );
}
