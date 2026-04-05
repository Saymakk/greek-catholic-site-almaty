import { NextRequest, NextResponse } from "next/server";
import { getLiturgicalForDatePage } from "@/lib/data";
import type { Lang } from "@/lib/i18n";
import { LANGS } from "@/lib/i18n";

export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const date = searchParams.get("date");
  const pageRaw = searchParams.get("page");
  let lang = (searchParams.get("lang") ?? "ru") as Lang;
  if (!LANGS.includes(lang)) lang = "ru";
  if (!date) {
    return NextResponse.json({ error: "date required" }, { status: 400 });
  }
  const page = Math.max(1, Number(pageRaw) || 1);
  const { events, hasMore } = await getLiturgicalForDatePage(date, lang, page, 10);
  return NextResponse.json({ events, hasMore, page });
}
