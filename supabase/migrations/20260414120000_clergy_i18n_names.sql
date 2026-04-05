-- Многоязычные ФИО священнослужителей (RU по умолчанию из существующего full_name)
alter table public.clergy
  add column if not exists full_name_ru text,
  add column if not exists full_name_uk text,
  add column if not exists full_name_kk text,
  add column if not exists full_name_en text;

update public.clergy
set full_name_ru = coalesce(nullif(trim(full_name_ru), ''), trim(full_name))
where (full_name_ru is null or trim(full_name_ru) = '')
  and full_name is not null
  and trim(full_name) <> '';
