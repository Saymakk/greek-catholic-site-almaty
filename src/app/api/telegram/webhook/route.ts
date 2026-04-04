import { createServiceClient } from "@/lib/supabase/server";
import { NextRequest, NextResponse } from "next/server";

/**
 * Укажите этот URL в BotFather /setwebhook с секретом в заголовке.
 * Добавьте бота в группу и отключите privacy mode (или используйте канал),
 * чтобы бот получал сообщения.
 */
export async function POST(req: NextRequest) {
  const secret = process.env.TELEGRAM_WEBHOOK_SECRET;
  if (!secret || req.headers.get("x-telegram-secret") !== secret) {
    return NextResponse.json({ error: "forbidden" }, { status: 403 });
  }

  let admin;
  try {
    admin = createServiceClient();
  } catch {
    return NextResponse.json({ error: "misconfigured" }, { status: 500 });
  }

  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ ok: true });
  }

  const u = body as {
    message?: {
      message_id: number;
      chat?: { id: number };
      text?: string;
      caption?: string;
      date?: number;
    };
    channel_post?: {
      message_id: number;
      chat?: { id: number };
      text?: string;
      caption?: string;
      date?: number;
    };
  };

  const msg = u.message ?? u.channel_post;
  if (!msg?.chat?.id || msg.message_id == null) {
    return NextResponse.json({ ok: true });
  }

  const text = msg.text ?? msg.caption ?? "";
  const sentAt = msg.date
    ? new Date(msg.date * 1000).toISOString()
    : new Date().toISOString();

  await admin.from("telegram_messages").upsert(
    {
      chat_id: msg.chat.id,
      tg_message_id: msg.message_id,
      text,
      sent_at: sentAt,
    },
    { onConflict: "chat_id,tg_message_id" },
  );

  return NextResponse.json({ ok: true });
}
