import type { Lang } from "@/lib/i18n";
import { getSiteUrl } from "@/lib/site-url";
import { t } from "@/lib/ui-strings";

/** Schema.org для расширенных сниппетов (церковь, город). */
export function SeoJsonLd({ lang }: { lang: Lang }) {
  const base = getSiteUrl();
  const payload = {
    "@context": "https://schema.org",
    "@type": "Church",
    name: t(lang, "parishName"),
    url: base,
    address: {
      "@type": "PostalAddress",
      addressLocality: t(lang, "city"),
      addressCountry: "KZ",
    },
  };
  return (
    <script
      type="application/ld+json"
      // eslint-disable-next-line react/no-danger -- JSON-LD по рекомендации Google
      dangerouslySetInnerHTML={{ __html: JSON.stringify(payload) }}
    />
  );
}
