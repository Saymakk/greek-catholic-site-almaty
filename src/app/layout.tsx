import type { Metadata, Viewport } from "next";
import { Cormorant_Garamond, Source_Sans_3 } from "next/font/google";
import "./globals.css";
import { getLang } from "@/lib/i18n-server";
import { getSiteUrl } from "@/lib/site-url";

const display = Cormorant_Garamond({
  subsets: ["latin", "cyrillic"],
  variable: "--font-cormorant",
  display: "swap",
  weight: ["500", "600", "700"],
});

const ui = Source_Sans_3({
  subsets: ["latin", "cyrillic"],
  variable: "--font-source",
  display: "swap",
  weight: ["400", "500", "600", "700"],
});

const siteTitle = "Греко-католический приход Блаженного Алексия Зарицкого · Алматы";
const siteDescription =
  "Официальный сайт греко-католического прихода Блаженного Алексия Зарицкого в Алматы: новости, литургический календарь, библиотека, контакты.";

export const metadata: Metadata = {
  metadataBase: new URL(getSiteUrl()),
  title: {
    default: siteTitle,
    template: "%s",
  },
  description: siteDescription,
  applicationName: siteTitle,
  icons: {
    icon: [{ url: "/web-app-icon.jpg", type: "image/jpeg", sizes: "512x512" }],
    apple: [{ url: "/web-app-icon.jpg", sizes: "180x180", type: "image/jpeg" }],
  },
  appleWebApp: {
    capable: true,
    title: siteTitle,
    statusBarStyle: "default",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: { index: true, follow: true },
  },
  openGraph: {
    type: "website",
    locale: "ru_KZ",
    alternateLocale: ["uk_KZ", "kk_KZ", "en_US"],
    siteName: siteTitle,
    title: siteTitle,
    description: siteDescription,
  },
  twitter: {
    card: "summary_large_image",
    title: siteTitle,
    description: siteDescription,
  },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  viewportFit: "cover",
  themeColor: "#2c5a94",
};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const lang = await getLang();

  return (
    <html
      lang={lang}
      className={`${display.variable} ${ui.variable} h-full w-full max-w-none`}
    >
      <body className="flex min-h-full w-full max-w-none flex-col antialiased">{children}</body>
    </html>
  );
}
