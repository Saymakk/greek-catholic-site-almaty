-- Публичный список приходов Казахстана (редактируется в админке)

create table public.kazakhstan_parishes (
  id uuid primary key default gen_random_uuid(),
  sort_order int not null default 0,
  is_published boolean not null default true,
  parish_photo_url text,
  priest_photo_url text,
  website_url text,
  city_ru text,
  city_uk text,
  city_kk text,
  city_en text,
  name_ru text,
  name_uk text,
  name_kk text,
  name_en text,
  address_ru text,
  address_uk text,
  address_kk text,
  address_en text,
  priest_name_ru text,
  priest_name_uk text,
  priest_name_kk text,
  priest_name_en text,
  priest_contacts_ru text,
  priest_contacts_uk text,
  priest_contacts_kk text,
  priest_contacts_en text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index kazakhstan_parishes_sort_idx on public.kazakhstan_parishes (sort_order, id);

alter table public.kazakhstan_parishes enable row level security;

create policy "kazakhstan_parishes_select"
  on public.kazakhstan_parishes for select
  using (is_published = true or public.is_staff());

create policy "kazakhstan_parishes_write"
  on public.kazakhstan_parishes for all
  using (public.is_staff())
  with check (public.is_staff());
