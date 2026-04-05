-- Кастомные типы событий, подписи типов по языкам, автор события, доп. поля и шаблоны

alter table public.liturgical_events
  drop constraint if exists liturgical_events_kind_check;

alter table public.liturgical_events
  add column if not exists created_by uuid references public.profiles (id) on delete set null;

create table if not exists public.liturgical_event_extra_fields (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.liturgical_events (id) on delete cascade,
  sort_idx int not null default 0,
  label_ru text,
  label_uk text,
  label_kk text,
  label_en text,
  body_ru text,
  body_uk text,
  body_kk text,
  body_en text,
  url text,
  created_at timestamptz not null default now()
);

create index if not exists liturgical_event_extra_fields_event_idx
  on public.liturgical_event_extra_fields (event_id, sort_idx);

create table if not exists public.liturgical_event_templates (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.liturgical_event_template_rows (
  id uuid primary key default gen_random_uuid(),
  template_id uuid not null references public.liturgical_event_templates (id) on delete cascade,
  sort_idx int not null default 0,
  label_ru text,
  label_uk text,
  label_kk text,
  label_en text
);

create index if not exists liturgical_event_template_rows_tid
  on public.liturgical_event_template_rows (template_id, sort_idx);

create table if not exists public.liturgical_kind_i18n (
  kind_slug text not null,
  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),
  label text not null,
  primary key (kind_slug, lang)
);

insert into public.liturgical_kind_i18n (kind_slug, lang, label) values
  ('great_feast', 'ru', 'Великий праздник'),
  ('great_feast', 'uk', 'Велике свято'),
  ('great_feast', 'kk', 'Үлкен мереке'),
  ('great_feast', 'en', 'Great feast'),
  ('feast', 'ru', 'Праздник'),
  ('feast', 'uk', 'Свято'),
  ('feast', 'kk', 'Мереке'),
  ('feast', 'en', 'Feast'),
  ('sunday', 'ru', 'Воскресенье'),
  ('sunday', 'uk', 'Неділя'),
  ('sunday', 'kk', 'Жексенбі'),
  ('sunday', 'en', 'Sunday'),
  ('fast', 'ru', 'Пост'),
  ('fast', 'uk', 'Піст'),
  ('fast', 'kk', 'Ораза'),
  ('fast', 'en', 'Fast'),
  ('commemoration', 'ru', 'Память'),
  ('commemoration', 'uk', 'Пам''ять'),
  ('commemoration', 'kk', 'Еске алу'),
  ('commemoration', 'en', 'Commemoration'),
  ('other', 'ru', 'Другое'),
  ('other', 'uk', 'Інше'),
  ('other', 'kk', 'Басқа'),
  ('other', 'en', 'Other')
on conflict (kind_slug, lang) do nothing;

alter table public.liturgical_event_extra_fields enable row level security;
alter table public.liturgical_event_templates enable row level security;
alter table public.liturgical_event_template_rows enable row level security;
alter table public.liturgical_kind_i18n enable row level security;

create policy "liturgical_extra_select"
  on public.liturgical_event_extra_fields for select
  using (true);

create policy "liturgical_extra_staff_write"
  on public.liturgical_event_extra_fields for all
  using (public.is_staff())
  with check (public.is_staff());

create policy "liturgical_template_staff"
  on public.liturgical_event_templates for all
  using (public.is_staff())
  with check (public.is_staff());

create policy "liturgical_template_rows_staff"
  on public.liturgical_event_template_rows for all
  using (public.is_staff())
  with check (public.is_staff());

create policy "liturgical_kind_i18n_select"
  on public.liturgical_kind_i18n for select
  using (true);

create policy "liturgical_kind_i18n_staff_write"
  on public.liturgical_kind_i18n for all
  using (public.is_staff())
  with check (public.is_staff());
