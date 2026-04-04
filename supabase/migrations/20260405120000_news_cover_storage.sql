-- Обложка новости + публичные bucket'ы для картинок и файлов Писания

alter table public.news add column if not exists cover_image_url text;

insert into storage.buckets (id, name, public)
values ('news-images', 'news-images', true)
on conflict (id) do nothing;

insert into storage.buckets (id, name, public)
values ('scripture-books', 'scripture-books', true)
on conflict (id) do nothing;

drop policy if exists "news_images_public_read" on storage.objects;
drop policy if exists "news_images_staff_all" on storage.objects;
drop policy if exists "scripture_books_public_read" on storage.objects;
drop policy if exists "scripture_books_staff_all" on storage.objects;

create policy "news_images_public_read"
  on storage.objects for select
  using (bucket_id = 'news-images');

create policy "news_images_staff_all"
  on storage.objects for all
  using (bucket_id = 'news-images' and public.is_staff())
  with check (bucket_id = 'news-images' and public.is_staff());

create policy "scripture_books_public_read"
  on storage.objects for select
  using (bucket_id = 'scripture-books');

create policy "scripture_books_staff_all"
  on storage.objects for all
  using (bucket_id = 'scripture-books' and public.is_staff())
  with check (bucket_id = 'scripture-books' and public.is_staff());
