import type { Metadata } from "next";
import { Cormorant_Garamond, Source_Sans_3 } from "next/font/google";
import "./globals.css";
import { getLang } from "@/lib/i18n-server";

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

export const metadata: Metadata = {
  title: "Греко-католический приход Блаженного Алексия Зарицкого · Алматы",
  description:
    "Официальный сайт греко-католического прихода Блаженного Алексия Зарицкого в Алматы",
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
