insert into public.site_settings (key, value)
values ('smoke_local', '{"ok": true, "source": "local"}'::jsonb)
on conflict (key) do update set value = excluded.value;