alter table public.profiles
  add column if not exists can_view_all_objects boolean not null default true,
  add column if not exists can_edit_all_objects boolean not null default true;

update public.profiles
set
  can_view_all_objects = true,
  can_edit_all_objects = true
where role = 'superadmin';
