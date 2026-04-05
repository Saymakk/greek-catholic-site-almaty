-- Перевод старого формата { enabled, variant } в { new_julian, gregorian }
update public.site_settings
set value =
  case
    when coalesce(value ? 'new_julian', false) or coalesce(value ? 'gregorian', false) then value
    when value->>'enabled' = 'true' and value->>'variant' = 'gregorian' then
      '{"new_julian": false, "gregorian": true}'::jsonb
    when value->>'enabled' = 'true' then '{"new_julian": true, "gregorian": false}'::jsonb
    else '{"new_julian": false, "gregorian": false}'::jsonb
  end
where key = 'external_liturgical_widget';
