-- Миграция со старой схемы (плоские колонки) на scripture_book_locales.
-- Если БД уже создана из обновлённого init.sql без title_ru — шаг пропускается.
do $scripture_locales_mig$
begin
  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public'
      and table_name = 'scripture_books'
      and column_name = 'title_ru'
  ) then
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

  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)
  select
    b.id,
    'main',
    nullif(
      trim(
        coalesce(
          nullif(trim(b.title_ru), ''),
          nullif(trim(b.title_en), ''),
          nullif(trim(b.title_uk), ''),
          nullif(trim(b.title_kk), '')
        )
      ),
      ''
    ),
    null,
    nullif(
      trim(
        coalesce(
          nullif(trim(b.read_url_ru), ''),
          nullif(trim(b.read_url_en), ''),
          nullif(trim(b.read_url_uk), ''),
          nullif(trim(b.read_url_kk), '')
        )
      ),
      ''
    ),
    nullif(
      trim(
        coalesce(
          nullif(trim(b.file_url_ru), ''),
          nullif(trim(b.file_url_en), ''),
          nullif(trim(b.file_url_uk), ''),
          nullif(trim(b.file_url_kk), '')
        )
      ),
      ''
    ),
    b.cover_image_url
  from public.scripture_books b;

  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)
  select
    b.id,
    'uk',
    nullif(trim(b.title_uk), ''),
    null,
    nullif(trim(b.read_url_uk), ''),
    nullif(trim(b.file_url_uk), ''),
    null
  from public.scripture_books b
  where
    nullif(trim(b.title_uk), '') is not null
    or nullif(trim(b.read_url_uk), '') is not null
    or nullif(trim(b.file_url_uk), '') is not null;

  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)
  select
    b.id,
    'kk',
    nullif(trim(b.title_kk), ''),
    null,
    nullif(trim(b.read_url_kk), ''),
    nullif(trim(b.file_url_kk), ''),
    null
  from public.scripture_books b
  where
    nullif(trim(b.title_kk), '') is not null
    or nullif(trim(b.read_url_kk), '') is not null
    or nullif(trim(b.file_url_kk), '') is not null;

  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)
  select
    b.id,
    'en',
    nullif(trim(b.title_en), ''),
    null,
    nullif(trim(b.read_url_en), ''),
    nullif(trim(b.file_url_en), ''),
    null
  from public.scripture_books b
  where
    nullif(trim(b.title_en), '') is not null
    or nullif(trim(b.read_url_en), '') is not null
    or nullif(trim(b.file_url_en), '') is not null;

  alter table public.scripture_books
    drop column title_ru,
    drop column title_uk,
    drop column title_kk,
    drop column title_en,
    drop column read_url_ru,
    drop column read_url_uk,
    drop column read_url_kk,
    drop column read_url_en,
    drop column file_url_ru,
    drop column file_url_uk,
    drop column file_url_kk,
    drop column file_url_en,
    drop column cover_image_url;
  end if;
end
$scripture_locales_mig$;
