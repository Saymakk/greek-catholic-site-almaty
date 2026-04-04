-- Язык основной редакции для новостей и событий календаря; обложка события
alter table public.news
  add column if not exists primary_lang text;

alter table public.news
  drop constraint if exists news_primary_lang_check;

alter table public.news
  add constraint news_primary_lang_check
  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'));

alter table public.liturgical_events
  add column if not exists primary_lang text;

alter table public.liturgical_events
  drop constraint if exists liturgical_events_primary_lang_check;

alter table public.liturgical_events
  add constraint liturgical_events_primary_lang_check
  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'));

alter table public.liturgical_events
  add column if not exists cover_image_url text;
