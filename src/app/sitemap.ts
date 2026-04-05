import type { MetadataRoute } from "next";
import { getSiteUrl } from "@/lib/site-url";

const PUBLIC_PATHS: { path: string; changeFrequency: MetadataRoute.Sitemap[0]["changeFrequency"]; priority: number }[] =
  [
    { path: "/", changeFrequency: "weekly", priority: 1 },
    { path: "/library", changeFrequency: "weekly", priority: 0.9 },
    { path: "/about", changeFrequency: "monthly", priority: 0.85 },
    { path: "/about/hierarchy", changeFrequency: "monthly", priority: 0.75 },
    { path: "/about/history", changeFrequency: "monthly", priority: 0.75 },
    { path: "/about/contacts", changeFrequency: "monthly", priority: 0.85 },
    { path: "/about/parishes-kz", changeFrequency: "monthly", priority: 0.75 },
  ];

export default function sitemap(): MetadataRoute.Sitemap {
  const base = getSiteUrl();
  const lastModified = new Date();
  return PUBLIC_PATHS.map(({ path, changeFrequency, priority }) => ({
    url: path === "/" ? base : `${base}${path}`,
    lastModified,
    changeFrequency,
    priority,
  }));
}
