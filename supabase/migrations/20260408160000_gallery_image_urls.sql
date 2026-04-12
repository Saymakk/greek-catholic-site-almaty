-- Дополнительные изображения (обложка/основное фото по-прежнему в cover_image_url / cover per locale).
alter table public.news
  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb;

alter table public.liturgical_events
  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb;

alter table public.scripture_books
  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb;
