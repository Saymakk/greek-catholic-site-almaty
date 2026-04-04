-- Журнал действий в админке (для главной страницы /admin)
create table public.admin_activity_log (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  actor_id uuid not null references public.profiles (id) on delete cascade,
  actor_email text not null default '',
  action text not null,
  entity_type text not null,
  entity_id text,
  summary text,
  meta jsonb not null default '{}'::jsonb
);

create index admin_activity_log_created_at_idx
  on public.admin_activity_log (created_at desc);

alter table public.admin_activity_log enable row level security;

create policy "admin_activity_log_select_staff"
  on public.admin_activity_log for select
  using (public.is_staff());

create policy "admin_activity_log_insert_self"
  on public.admin_activity_log for insert
  with check (public.is_staff() and actor_id = auth.uid());
