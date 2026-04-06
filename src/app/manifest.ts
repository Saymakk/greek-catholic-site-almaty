import type { MetadataRoute } from "next";

const name = "Греко-католический приход Блаженного Алексия Зарицкого · Алматы";
const description =
  "Официальный сайт греко-католического прихода Блаженного Алексия Зарицкого в Алматы: новости, литургический календарь, библиотека, контакты.";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name,
    short_name: "ГКПБАЗ · Алматы",
    description,
    start_url: "/",
    scope: "/",
    display: "standalone",
    orientation: "portrait-primary",
    background_color: "#f4f7fb",
    theme_color: "#2c5a94",
    icons: [
      {
        src: "/web-app-icon.jpg",
        sizes: "512x512",
        type: "image/jpeg",
        purpose: "any",
      },
      {
        src: "/web-app-icon.jpg",
        sizes: "192x192",
        type: "image/jpeg",
        purpose: "any",
      },
    ],
  };
}
