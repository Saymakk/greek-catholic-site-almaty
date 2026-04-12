-- Связь экземпляров одной «серии» повторяющихся событий (каждая дата — отдельная строка).
alter table public.liturgical_events
  add column if not exists recurrence_series_id uuid null;

create index if not exists liturgical_events_recurrence_series_idx
  on public.liturgical_events (recurrence_series_id)
  where recurrence_series_id is not null;
