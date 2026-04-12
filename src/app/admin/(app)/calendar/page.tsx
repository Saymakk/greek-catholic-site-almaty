import { createClient } from "@/lib/supabase/server";
import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import type { Lang } from "@/lib/i18n";
import { getExternalLiturgicalWidgetSettings } from "@/lib/data";
import { AdminCalendarClient } from "./AdminCalendarClient";
import type { AdminCalendarPayload, CalendarExtraRow } from "./calendar-admin-types";
import { normalizeCalendarLocales } from "./calendar-entity-locales";
import {
  buildKindSlugLabelMap,
  kindLabelMapToRecord,
  pickKindListLabel,
} from "./kind-labels";

type LiturgicalListRow = {
  id: string;
  event_date: string;
  kind: string;
  recurrence_series_id?: string | null;
  created_at?: string;
  primary_lang?: string | null;
  cover_image_url?: string | null;
  liturgical_event_i18n: {
    lang: string;
    title: string;
    explanation: string;
    prayer: string | null;
  }[];
};

export default async function AdminCalendarPage({
  searchParams,
}: {
  searchParams: Promise<{ id?: string; offerTemplate?: string }>;
}) {
  const profile = await requireStaff();
  const lang = await getLang();
  const { id: openEventId, offerTemplate: offerTemplateRaw } = await searchParams;
  const offerTemplate =
    offerTemplateRaw && /^[0-9a-f-]{36}$/i.test(offerTemplateRaw) ? offerTemplateRaw : null;

  const [supabase, externalWidget] = await Promise.all([
    createClient(),
    getExternalLiturgicalWidgetSettings(),
  ]);
  const i18n =
    "liturgical_event_i18n ( lang, title, explanation, prayer )";
  const selFull = `id, event_date, kind, recurrence_series_id, created_at, primary_lang, cover_image_url, ${i18n}`;
  const selCoverOnly = `id, event_date, kind, recurrence_series_id, created_at, cover_image_url, ${i18n}`;
  const selPrimaryOnly = `id, event_date, kind, recurrence_series_id, created_at, primary_lang, ${i18n}`;
  const selMin = `id, event_date, kind, recurrence_series_id, created_at, ${i18n}`;

  const run = (sel: string) => {
    let q = supabase.from("liturgical_events").select(sel);
    if (profile.role !== "superadmin") {
      q = q.or(`created_by.eq.${profile.id},created_by.is.null`);
    }
    return q.order("created_at", { ascending: false });
  };

  const stripRecurrence = (sel: string) => sel.replace("recurrence_series_id, ", "");

  let res = await run(selFull);
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) throw new Error(msg);
    if (msg.includes("recurrence_series_id")) {
      res = await run(stripRecurrence(selFull));
    } else if (msg.includes("primary_lang")) {
      res = await run(selCoverOnly);
    } else if (msg.includes("cover_image_url")) {
      res = await run(selPrimaryOnly);
    }
  }
  if (res.error) {
    const msg = res.error.message ?? "";
    if (!msg.includes("schema cache")) throw new Error(msg);
    if (msg.includes("recurrence_series_id")) {
      res = await run(stripRecurrence(selMin));
    } else {
      res = await run(selMin);
    }
  }
  if (res.error) throw new Error(res.error.message);

  const rows = (res.data ?? []) as unknown as LiturgicalListRow[];
  const eventIds = rows.map((r) => r.id);

  const extrasByEvent = new Map<string, CalendarExtraRow[]>();
  if (eventIds.length) {
    const { data: ex } = await supabase
      .from("liturgical_event_extra_fields")
      .select(
        "event_id, sort_idx, label_ru, label_uk, label_kk, label_en, body_ru, body_uk, body_kk, body_en, url",
      )
      .in("event_id", eventIds)
      .order("sort_idx", { ascending: true });
    for (const raw of ex ?? []) {
      const r = raw as CalendarExtraRow & { event_id: string };
      const { event_id, ...rest } = r;
      if (!extrasByEvent.has(event_id)) extrasByEvent.set(event_id, []);
      extrasByEvent.get(event_id)!.push(rest);
    }
  }

  const kindSlugs = [...new Set(rows.map((r) => r.kind))];
  const kiRows =
    kindSlugs.length === 0
      ? []
      : (
          await supabase
            .from("liturgical_kind_i18n")
            .select("kind_slug, lang, label")
            .in("kind_slug", kindSlugs)
        ).data ?? [];
  const bySlug = buildKindSlugLabelMap(
    kiRows as { kind_slug: string; lang: string; label: string }[],
  );

  const { data: allKindI18n } = await supabase
    .from("liturgical_kind_i18n")
    .select("kind_slug, lang, label");
  const kindLabelsBySlug = kindLabelMapToRecord(
    buildKindSlugLabelMap(
      (allKindI18n ?? []) as { kind_slug: string; lang: string; label: string }[],
    ),
  );

  const { data: tplData } = await supabase
    .from("liturgical_event_templates")
    .select(
      `
      id,
      name,
      created_at,
      liturgical_event_template_rows (
        sort_idx,
        label_ru,
        label_uk,
        label_kk,
        label_en
      )
    `,
    )
    .order("created_at", { ascending: false });

  type TplRow = {
    id: string;
    name: string;
    created_at: string;
    liturgical_event_template_rows: {
      sort_idx: number;
      label_ru: string | null;
      label_uk: string | null;
      label_kk: string | null;
      label_en: string | null;
    }[] | null;
  };

  const templates = ((tplData ?? []) as unknown as TplRow[]).map((t) => ({
    id: t.id,
    name: t.name,
    rows: [...(t.liturgical_event_template_rows ?? [])].sort((a, b) => a.sort_idx - b.sort_idx),
  }));

  const items: AdminCalendarPayload[] = rows.map((row) => {
    const pl =
      row.primary_lang && ["ru", "uk", "kk", "en"].includes(row.primary_lang)
        ? (row.primary_lang as Lang)
        : null;
    const siteLabels = { ...(bySlug.get(row.kind) ?? {}) } as Partial<Record<Lang, string>>;
    return {
      id: row.id,
      recurrence_series_id: row.recurrence_series_id ?? null,
      event_date: row.event_date,
      kind: row.kind,
      kindListLabel: pickKindListLabel(row.kind, bySlug, lang),
      kindSiteLabels: siteLabels,
      primary_lang: pl,
      cover_image_url: row.cover_image_url ?? null,
      locales: normalizeCalendarLocales(row.liturgical_event_i18n ?? [], pl, lang),
      extras: extrasByEvent.get(row.id) ?? [],
    };
  });

  return (
    <AdminCalendarClient
      lang={lang}
      items={items}
      templates={templates}
      kindLabelsBySlug={kindLabelsBySlug}
      initialEventId={openEventId ?? null}
      offerTemplateEventId={offerTemplate}
      externalWidget={externalWidget}
    />
  );
}
