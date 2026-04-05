-- Виджет стороннего литургического календаря (главная, между нашим календарём и Telegram)
insert into public.site_settings (key, value) values
  (
    'external_liturgical_widget',
    '{"new_julian": false, "gregorian": false}'::jsonb
  )
on conflict (key) do nothing;
