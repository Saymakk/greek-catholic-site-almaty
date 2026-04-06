import type { UiKey } from "@/lib/ui-strings";

/** Подразделы «О церкви»: шапка (dropdown) и страница /about */
export const ABOUT_SUBNAV_SECTIONS: { href: string; key: UiKey }[] = [
  { href: "/about/hierarchy", key: "aboutNavHierarchy" },
  { href: "/about/history", key: "aboutNavHistory" },
  { href: "/about/parishes-kz", key: "aboutNavKazakhstanParishes" },
  { href: "/about/contacts", key: "aboutNavContacts" },
];
