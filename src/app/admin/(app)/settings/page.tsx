import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { adminSettingsCopy } from "@/lib/admin-layout-i18n";
import { FooterSettingsForm } from "./FooterSettingsForm";
import { getFooterSettings, type FooterContactButton, type FooterSettings } from "@/lib/data";
import { mapEmbedRawForForm } from "@/lib/map-embed";

function initialButtons(footer: FooterSettings): FooterContactButton[] {
  const raw = footer.contact_buttons;
  if (!Array.isArray(raw)) return [];
  return raw
    .filter(
      (b): b is FooterContactButton =>
        !!b && typeof b === "object" && typeof (b as FooterContactButton).url === "string",
    )
    .map((b) => ({
      url: b.url.trim(),
      label: typeof b.label === "string" ? b.label.trim() : "",
      icon: typeof b.icon === "string" ? b.icon.trim() : undefined,
    }))
    .filter((b) => b.url && b.label);
}

export default async function AdminSettingsPage({
  searchParams,
}: {
  searchParams: Promise<{ footer_err?: string }>;
}) {
  await requireStaff();
  const lang = await getLang();
  const s = adminSettingsCopy(lang);
  const q = await searchParams;
  const footerErr = q.footer_err === "buttons" ? s.errButtons : null;

  const footer = await getFooterSettings();

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{s.pageTitle}</h1>
      <p className="mt-2 max-w-2xl text-sm text-parish-muted">{s.intro}</p>
      {footerErr ? (
        <p className="mt-4 max-w-2xl rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-800">
          {footerErr}
        </p>
      ) : null}
      <FooterSettingsForm
        copy={s}
        footer={footer}
        mapEmbedRaw={mapEmbedRawForForm(footer.map_embed_src)}
        initialButtons={initialButtons(footer)}
      />
    </div>
  );
}
