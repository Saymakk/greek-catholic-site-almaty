-- Приходы: все записи публичны; убираем флаг публикации
drop policy if exists "kazakhstan_parishes_select" on public.kazakhstan_parishes;
alter table public.kazakhstan_parishes drop column if exists is_published;
create policy "kazakhstan_parishes_select"
  on public.kazakhstan_parishes for select
  using (true);

-- Священнослужители (админка; публичное чтение для будущего раздела на сайте)
create table public.clergy (
  id uuid primary key default gen_random_uuid(),
  sort_order int not null default 0,
  photo_url text,
  full_name text not null,
  extra_fields jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index clergy_sort_idx on public.clergy (sort_order, id);

alter table public.clergy enable row level security;

create policy "clergy_select"
  on public.clergy for select
  using (true);

create policy "clergy_insert"
  on public.clergy for insert
  with check (public.is_staff());

create policy "clergy_update"
  on public.clergy for update
  using (public.is_staff())
  with check (public.is_staff());

create policy "clergy_delete"
  on public.clergy for delete
  using (public.is_staff());
