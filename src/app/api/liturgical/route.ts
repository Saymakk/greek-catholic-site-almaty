import { NextRequest, NextResponse } from "next/server";
import { getLiturgicalRange } from "@/lib/data";
import type { Lang } from "@/lib/i18n";
import { LANGS } from "@/lib/i18n";

export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const start = searchParams.get("start");
  const end = searchParams.get("end");
  let lang = (searchParams.get("lang") ?? "ru") as Lang;
  if (!LANGS.includes(lang)) lang = "ru";
  if (!start || !end) {
    return NextResponse.json({ error: "start and end required" }, { status: 400 });
  }
  const events = await getLiturgicalRange(start, end, lang);
  return NextResponse.json(events);
}
