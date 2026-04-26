import { logAdminActivity } from "@/lib/admin-activity-log";
import { createClient, createServiceClient } from "@/lib/supabase/server";
import { isSchemaCacheMissingColumn } from "@/lib/supabase-column-fallback";
import { NextResponse } from "next/server";

const MIN_PASSWORD_LEN = 8;

type ProfileRow = {
  id: string;
  email: string | null;
  full_name: string | null;
  role: string;
  can_view_all_objects: boolean;
  can_edit_all_objects: boolean;
  created_at: string;
};

async function requireSuperadminApi() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return { error: NextResponse.json({ error: "Unauthorized" }, { status: 401 }) };
  }
  const { data: profile } = await supabase
    .from("profiles")
    .select("id, email, role")
    .eq("id", user.id)
    .single();
  if (profile?.role !== "superadmin") {
    return { error: NextResponse.json({ error: "Forbidden" }, { status: 403 }) };
  }
  return { supabase, profile, actorUserId: user.id };
}

async function countSuperadmins(supabase: Awaited<ReturnType<typeof createClient>>): Promise<number> {
  const { count, error } = await supabase
    .from("profiles")
    .select("*", { count: "exact", head: true })
    .eq("role", "superadmin");
  if (error) return 0;
  return count ?? 0;
}

export async function GET() {
  const ctx = await requireSuperadminApi();
  if ("error" in ctx) return ctx.error;

  const q = await ctx.supabase
    .from("profiles")
    .select("id, email, full_name, role, can_view_all_objects, can_edit_all_objects, created_at")
    .order("created_at", { ascending: true });
  let data = q.data as
    | {
        id: string;
        email: string | null;
        full_name: string | null;
        role: string;
        can_view_all_objects?: boolean;
        can_edit_all_objects?: boolean;
        created_at: string;
      }[]
    | null;
  let error = q.error;
  if (error && isSchemaCacheMissingColumn(error, "can_view_all_objects")) {
    const fallback = await ctx.supabase
      .from("profiles")
      .select("id, email, full_name, role, created_at")
      .order("created_at", { ascending: true });
    data = fallback.data as typeof data;
    error = fallback.error;
  }

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
  return NextResponse.json({ users: (data ?? []) as ProfileRow[] });
}

export async function POST(req: Request) {
  const ctx = await requireSuperadminApi();
  if ("error" in ctx) return ctx.error;
  const { supabase, profile } = ctx;

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

  await logAdminActivity(supabase, profile, {
    action: "user.invite",
    entityType: "auth",
    entityId: created.user.id,
    summary: email,
  });

  return NextResponse.json({ ok: true });
}

export async function PATCH(req: Request) {
  const ctx = await requireSuperadminApi();
  if ("error" in ctx) return ctx.error;
  const { supabase, profile } = ctx;

  let body: {
    id?: string;
    role?: "admin" | "superadmin";
    full_name?: string | null;
    email?: string;
    password?: string;
    can_view_all_objects?: boolean;
    can_edit_all_objects?: boolean;
  };
  try {
    body = (await req.json()) as typeof body;
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const targetId = body.id?.trim();
  if (!targetId) {
    return NextResponse.json({ error: "Укажите id" }, { status: 400 });
  }

  const targetRes = await supabase
    .from("profiles")
    .select("id, role, email, can_view_all_objects, can_edit_all_objects")
    .eq("id", targetId)
    .single();
  let target = targetRes.data as
    | {
        id: string;
        role: string;
        email: string | null;
        can_view_all_objects?: boolean;
        can_edit_all_objects?: boolean;
      }
    | null;
  if (targetRes.error && isSchemaCacheMissingColumn(targetRes.error, "can_view_all_objects")) {
    const fallback = await supabase
      .from("profiles")
      .select("id, role, email")
      .eq("id", targetId)
      .single();
    target = fallback.data as typeof target;
  }
  if (!target) {
    return NextResponse.json({ error: "Пользователь не найден" }, { status: 404 });
  }

  if (body.role !== undefined && body.role !== "admin" && body.role !== "superadmin") {
    return NextResponse.json({ error: "Неверная роль" }, { status: 400 });
  }

  const superCount = await countSuperadmins(supabase);
  if (target.role === "superadmin" && body.role === "admin" && superCount <= 1) {
    return NextResponse.json(
      { error: "Нельзя снять роль суперадмина с единственного суперадмина" },
      { status: 400 },
    );
  }

  let service;
  try {
    service = createServiceClient();
  } catch {
    return NextResponse.json({ error: "SUPABASE_SERVICE_ROLE_KEY не настроен" }, { status: 500 });
  }

  const emailNext = body.email?.trim().toLowerCase() ?? "";
  const prevEmail = (target.email ?? "").trim().toLowerCase();
  if (emailNext && emailNext !== prevEmail) {
    const { error: authEmailErr } = await service.auth.admin.updateUserById(targetId, { email: emailNext });
    if (authEmailErr) {
      return NextResponse.json({ error: authEmailErr.message }, { status: 400 });
    }
  }

  if (typeof body.password === "string" && body.password.length > 0) {
    if (body.password.length < MIN_PASSWORD_LEN) {
      return NextResponse.json(
        { error: `Пароль не короче ${MIN_PASSWORD_LEN} символов` },
        { status: 400 },
      );
    }
    const { error: pwdErr } = await service.auth.admin.updateUserById(targetId, { password: body.password });
    if (pwdErr) {
      return NextResponse.json({ error: pwdErr.message }, { status: 400 });
    }
  }

  const profilePatch: Record<string, unknown> = {};
  if (body.role !== undefined) profilePatch.role = body.role;
  if (body.full_name !== undefined) profilePatch.full_name = body.full_name?.trim() || null;
  if (body.role === "superadmin") {
    profilePatch.can_view_all_objects = true;
    profilePatch.can_edit_all_objects = true;
  }
  if (typeof body.can_view_all_objects === "boolean") {
    profilePatch.can_view_all_objects = body.role === "superadmin" ? true : body.can_view_all_objects;
  }
  if (typeof body.can_edit_all_objects === "boolean") {
    profilePatch.can_edit_all_objects = body.role === "superadmin" ? true : body.can_edit_all_objects;
  }
  if (emailNext) profilePatch.email = emailNext;
  else if (body.email !== undefined && !emailNext) {
    return NextResponse.json({ error: "Укажите email" }, { status: 400 });
  }

  if (Object.keys(profilePatch).length > 0) {
    const { error: upErr } = await supabase.from("profiles").update(profilePatch).eq("id", targetId);
    if (upErr) {
      return NextResponse.json({ error: upErr.message }, { status: 400 });
    }
  }

  await logAdminActivity(supabase, profile, {
    action: "user.update",
    entityType: "auth",
    entityId: targetId,
    summary: emailNext || target.email || undefined,
  });

  return NextResponse.json({ ok: true });
}

export async function DELETE(req: Request) {
  const ctx = await requireSuperadminApi();
  if ("error" in ctx) return ctx.error;
  const { supabase, profile, actorUserId } = ctx;

  let body: { id?: string };
  try {
    body = (await req.json()) as { id?: string };
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }
  const targetId = body.id?.trim();
  if (!targetId) {
    return NextResponse.json({ error: "Укажите id" }, { status: 400 });
  }
  if (targetId === actorUserId) {
    return NextResponse.json({ error: "Нельзя удалить свою учётную запись" }, { status: 400 });
  }

  const { data: target } = await supabase.from("profiles").select("id, role, email").eq("id", targetId).single();
  if (!target) {
    return NextResponse.json({ error: "Пользователь не найден" }, { status: 404 });
  }

  const superCount = await countSuperadmins(supabase);
  if (target.role === "superadmin" && superCount <= 1) {
    return NextResponse.json({ error: "Нельзя удалить единственного суперадмина" }, { status: 400 });
  }

  let service;
  try {
    service = createServiceClient();
  } catch {
    return NextResponse.json({ error: "SUPABASE_SERVICE_ROLE_KEY не настроен" }, { status: 500 });
  }

  const { error: delErr } = await service.auth.admin.deleteUser(targetId);
  if (delErr) {
    return NextResponse.json({ error: delErr.message }, { status: 400 });
  }

  await logAdminActivity(supabase, profile, {
    action: "user.delete",
    entityType: "auth",
    entityId: targetId,
    summary: target.email ?? undefined,
  });

  return NextResponse.json({ ok: true });
}
