-- Язык основной редакции книги (ru | uk | kk | en). NULL = старые записи с lang = 'main'.
alter table public.scripture_books
  add column if not exists primary_lang text;

alter table public.scripture_books
  drop constraint if exists scripture_books_primary_lang_check;

alter table public.scripture_books
  add constraint scripture_books_primary_lang_check
  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'));
