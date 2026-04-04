import { createClient, createServiceClient } from "@/lib/supabase/server";
import { NextResponse } from "next/server";

const MIN_PASSWORD_LEN = 8;

export async function POST(req: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();
  if (profile?.role !== "superadmin") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  let body: { email?: string; password?: string };
  try {
    body = (await req.json()) as { email?: string; password?: string };
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }
  const email = body.email?.trim().toLowerCase();
  const password = body.password;
  if (!email) {
    return NextResponse.json({ error: "Укажите email" }, { status: 400 });
  }
  if (typeof password !== "string" || password.length < MIN_PASSWORD_LEN) {
    return NextResponse.json(
      { error: `Пароль не короче ${MIN_PASSWORD_LEN} символов` },
      { status: 400 },
    );
  }

  let admin;
  try {
    admin = createServiceClient();
  } catch {
    return NextResponse.json(
      { error: "SUPABASE_SERVICE_ROLE_KEY не настроен" },
      { status: 500 },
    );
  }

  const { data: created, error: createErr } = await admin.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
  });

  if (createErr || !created.user) {
    return NextResponse.json(
      { error: createErr?.message ?? "Не удалось создать пользователя" },
      { status: 400 },
    );
  }

  return NextResponse.json({ ok: true });
}
