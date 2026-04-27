-- 1) проверка пользователя
select id, email, email_confirmed_at
from auth.users
where email = 'vladsarana@gmail.com';

-- 2) создать профиль, если его нет
insert into public.profiles (id, email, role, can_view_all_objects, can_edit_all_objects)
select u.id, u.email, 'superadmin', true, true
from auth.users u
where u.email = 'vladsarana@gmail.com'
  and not exists (
    select 1 from public.profiles p where p.id = u.id
  );

-- 3) если профиль есть — гарантированно выдать superadmin
update public.profiles p
set
  role = 'superadmin',
  can_view_all_objects = true,
  can_edit_all_objects = true,
  email = coalesce(p.email, u.email)
from auth.users u
where u.id = p.id
  and u.email = 'vladsarana@gmail.com';

-- 4) контроль
select id, email, role, can_view_all_objects, can_edit_all_objects
from public.profiles
where email = 'vladsarana@gmail.com';