-- Greek Catholic Almaty parish — initial schema
-- Run in Supabase SQL Editor or via CLI.

create extension if not exists "pgcrypto";

-- Roles
create type public.user_role as enum ('superadmin', 'admin');

-- Profiles (1:1 with auth.users)
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  email text,
  full_name text,
  role public.user_role not null default 'admin',
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create or replace function public.is_staff()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('superadmin', 'admin')
  );
$$;

create or replace function public.is_superadmin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'superadmin'
  );
$$;

create policy "profiles_select_own_or_super"
  on public.profiles for select
  using (auth.uid() = id or public.is_superadmin());

create policy "profiles_update_self"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

create policy "profiles_update_super"
  on public.profiles for update
  using (public.is_superadmin());

-- New auth users → profile (default admin; promote first user to superadmin manually)
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, role)
  values (new.id, new.email, 'admin');
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- News
create table public.news (
  id uuid primary key default gen_random_uuid(),
  published_at timestamptz not null default now(),
  is_published boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  author_id uuid references public.profiles (id)
);

create table public.news_i18n (
  news_id uuid not null references public.news (id) on delete cascade,
  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),
  title text not null,
  excerpt text,
  body text not null,
  primary key (news_id, lang)
);

alter table public.news enable row level security;
alter table public.news_i18n enable row level security;

create policy "news_select"
  on public.news for select
  using (is_published = true or public.is_staff());

create policy "news_write"
  on public.news for all
  using (public.is_staff())
  with check (public.is_staff());

create policy "news_i18n_select"
  on public.news_i18n for select
  using (
    exists (
      select 1 from public.news n
      where n.id = news_id and (n.is_published = true or public.is_staff())
    )
  );

create policy "news_i18n_write"
  on public.news_i18n for all
  using (public.is_staff())
  with check (public.is_staff());

-- Liturgical calendar
create table public.liturgical_events (
  id uuid primary key default gen_random_uuid(),
  event_date date not null,
  kind text not null check (kind in (
    'great_feast', 'feast', 'sunday', 'fast', 'commemoration', 'other'
  )),
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

create index liturgical_events_date_idx on public.liturgical_events (event_date);

create table public.liturgical_event_i18n (
  event_id uuid not null references public.liturgical_events (id) on delete cascade,
  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),
  title text not null,
  explanation text not null,
  prayer text,
  primary key (event_id, lang)
);

alter table public.liturgical_events enable row level security;
alter table public.liturgical_event_i18n enable row level security;

create policy "liturgical_events_public_read"
  on public.liturgical_events for select using (true);

create policy "liturgical_events_staff_write"
  on public.liturgical_events for all
  using (public.is_staff())
  with check (public.is_staff());

create policy "liturgical_event_i18n_public_read"
  on public.liturgical_event_i18n for select using (true);

create policy "liturgical_event_i18n_staff_write"
  on public.liturgical_event_i18n for all
  using (public.is_staff())
  with check (public.is_staff());

-- Scripture / books: родитель + версии по языкам (main + ru/uk/kk/en)
create table public.scripture_books (
  id uuid primary key default gen_random_uuid(),
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table public.scripture_books enable row level security;

create policy "scripture_books_public_read"
  on public.scripture_books for select using (true);

create policy "scripture_books_staff_write"
  on public.scripture_books for all
  using (public.is_staff())
  with check (public.is_staff());

create table public.scripture_book_locales (
  id uuid primary key default gen_random_uuid(),
  book_id uuid not null references public.scripture_books (id) on delete cascade,
  lang text not null check (lang in ('main', 'ru', 'uk', 'kk', 'en')),
  title text,
  description text,
  read_url text,
  file_url text,
  cover_image_url text,
  unique (book_id, lang)
);

create index scripture_book_locales_book_id_idx on public.scripture_book_locales (book_id);

alter table public.scripture_book_locales enable row level security;

create policy "scripture_book_locales_public_read"
  on public.scripture_book_locales for select using (true);

create policy "scripture_book_locales_staff_write"
  on public.scripture_book_locales for all
  using (public.is_staff())
  with check (public.is_staff());

-- Editable pages (history, etc.)
create table public.page_content (
  page_key text not null,
  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),
  body text not null,
  updated_at timestamptz not null default now(),
  primary key (page_key, lang)
);

alter table public.page_content enable row level security;

create policy "page_content_public_read"
  on public.page_content for select using (true);

create policy "page_content_staff_write"
  on public.page_content for all
  using (public.is_staff())
  with check (public.is_staff());

-- Site settings (footer, telegram chat id, etc.)
create table public.site_settings (
  key text primary key,
  value jsonb not null default '{}'::jsonb
);

alter table public.site_settings enable row level security;

create policy "site_settings_public_read"
  on public.site_settings for select using (true);

create policy "site_settings_staff_write"
  on public.site_settings for all
  using (public.is_staff())
  with check (public.is_staff());

-- Cached Telegram posts (filled via webhook + service role)
create table public.telegram_messages (
  id uuid primary key default gen_random_uuid(),
  chat_id bigint not null,
  tg_message_id bigint not null,
  text text,
  sent_at timestamptz,
  unique (chat_id, tg_message_id)
);

alter table public.telegram_messages enable row level security;

create policy "telegram_messages_public_read"
  on public.telegram_messages for select using (true);

-- Inserts from anon: none. Use service role in API route.
-- PDF Писания: создайте в Dashboard bucket `scripture-books` (public) и политики Storage при необходимости.

-- Seed: default footer / placeholders (edit in admin or SQL)
insert into public.site_settings (key, value) values
  ('footer', '{
    "priest_name_ru": "",
    "priest_name_uk": "",
    "priest_name_kk": "",
    "priest_name_en": "",
    "email": "",
    "phone": "",
    "address_ru": "г. Алматы, уточняйте адрес у прихода",
    "address_uk": "",
    "address_kk": "",
    "address_en": "",
    "extra_ru": "",
    "extra_uk": "",
    "extra_kk": "",
    "extra_en": ""
  }'::jsonb),
  ('telegram', '{"chat_id": null, "webhook_secret": null}'::jsonb)
on conflict (key) do nothing;

insert into public.page_content (page_key, lang, body) values
  ('history', 'ru', '<p>История греко-католического прихода в Алматы и Казахстане — раздел в разработке. Текст можно задать в админке.</p>'),
  ('history', 'uk', '<p>Історія греко-католицької парафії в Алмати та Казахстані — розділ у розробці.</p>'),
  ('history', 'kk', '<p>Алматы мен Қазақстандағы грек-католик қауымының тарихы — бөлім дайындалуда.</p>'),
  ('history', 'en', '<p>History of the Greek Catholic parish in Almaty and Kazakhstan — content can be edited in the admin panel.</p>')
on conflict (page_key, lang) do nothing;
