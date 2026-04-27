# Greek Catholic Almaty Site

Проект на Next.js с backend-слоем на Supabase (Auth + Postgres + RLS + Storage).

## Быстрый старт

1. Установите зависимости:
   - `npm install`
2. Скопируйте переменные окружения:
   - `copy env.example .env.local` (Windows)
3. Запустите приложение:
   - `npm run dev`

## Переключение между облачным и локальным Supabase

Приложение поддерживает 2 полностью совместимых режима:

- серверный режим через `SUPABASE_TARGET`
- клиентский режим через `NEXT_PUBLIC_SUPABASE_TARGET`

Значения должны совпадать:

- `remote` - облачный Supabase (`NEXT_PUBLIC_SUPABASE_*`, `SUPABASE_SERVICE_ROLE_KEY`)
- `local` - локальный Supabase (`LOCAL_SUPABASE_*` и `NEXT_PUBLIC_LOCAL_SUPABASE_*`)

Весь код (SSR client, browser client, middleware session, service-role client) читает настройки из одного резолвера: `src/lib/supabase/config.ts`.

Быстрое переключение шаблонов окружения:

- `npm run env:use:remote` - копирует `env.remote.example` в `.env.local`
- `npm run env:use:local` - копирует `env.local.example` в `.env.local`

## Локальный Supabase рядом с проектом

Добавлен `supabase/config.toml`, поэтому можно поднимать локальный Supabase CLI прямо из репозитория.

Команды:

- `npm run db:local:start` - поднять локальный Supabase и применить миграции
- `npm run db:local:status` - посмотреть URL/ключи/порты
- `npm run db:local:reset` - пересоздать БД и заново прогнать все миграции
- `npm run db:local:stop` - остановить локальный стек

После `db:local:start`:

1. возьмите значения из `npm run db:local:status`;
2. вставьте их в `LOCAL_SUPABASE_URL`, `LOCAL_SUPABASE_ANON_KEY`, `LOCAL_SUPABASE_SERVICE_ROLE_KEY`;
3. продублируйте local URL/anon в `NEXT_PUBLIC_LOCAL_SUPABASE_URL` и `NEXT_PUBLIC_LOCAL_SUPABASE_ANON_KEY`;
4. переключите `SUPABASE_TARGET=local` и `NEXT_PUBLIC_SUPABASE_TARGET=local`;
5. запустите `npm run dev`.

Если хотите переключаться без ручного редактирования `.env.local`, используйте:

1. `npm run env:use:local`
2. `npm run db:local:status`
3. вставьте реальные local ключи в `.env.local` (один раз)
4. `npm run dev`

## Миграции (проанализированы)

Порядок и назначение миграций в `supabase/migrations`:

- `20260404000000_init.sql` - базовая схема (profiles, roles, news, liturgical, scripture, page_content, site_settings, telegram), RLS и политики.
- `20260405120000_news_cover_storage.sql` - bucket'ы Storage и политики для изображений/файлов.
- `20260406000000_scripture_books_cover.sql` - пояснение по переносу обложек в новую схему.
- `20260407120100_scripture_book_locales.sql` - миграция к таблице `scripture_book_locales`.
- `20260407120000_liturgical_recurrence_series.sql` - серия повторяющихся литургических событий.
- `20260408120000_scripture_primary_lang.sql` - `primary_lang` для книг Писания.
- `20260408140000_news_calendar_primary_cover.sql` - `primary_lang` для news/calendar и cover для событий.
- `20260408160000_gallery_image_urls.sql` - галереи изображений в news/calendar/scripture.
- `20260409120000_admin_activity_log.sql` - журнал действий админки.
- `20260410120000_liturgical_extras_templates_kinds_author.sql` - доп. поля/шаблоны/локализованные типы литургии.
- `20260411130000_kazakhstan_parishes.sql` - таблица приходов Казахстана.
- `20260412120000_parish_map_embed.sql` - `map_embed_src` у приходов.
- `20260413140000_parishes_published_clergy.sql` - clergy + публичность приходов.
- `20260414120000_clergy_i18n_names.sql` - мультиязычные ФИО clergy.
- `20260415120000_external_liturgical_widget.sql` - настройка внешнего литургического виджета.
- `20260416120000_external_liturgical_widget_dual.sql` - переход формата виджета на dual flags.
- `20260426152500_profiles_object_permissions.sql` - флаги объектных прав в profiles.

## Серверный деплой с git pull и переключением БД

Добавлены скрипты без очистки БД:

- `scripts/deploy-local.sh`
- `scripts/deploy-remote.sh`

Что делают оба скрипта:

1. копируют нужный env-файл в `.env`;
2. выполняют `git pull`;
3. пересобирают и поднимают приложение через `docker compose`.

Дополнительно `deploy-local.sh` запускает `supabase start` (без `db reset`).

Подготовка на сервере:

1. Создайте в корне проекта файлы `.env.local` и `.env.remote` с вашими реальными ключами.
2. Сделайте скрипты исполняемыми:
   - `chmod +x scripts/deploy-local.sh scripts/deploy-remote.sh`

Запуск:

- Local DB режим: `./scripts/deploy-local.sh`
- Cloud DB режим: `./scripts/deploy-remote.sh`
- Проверка текущего режима и статусов: `./scripts/status.sh`

Оба deploy-скрипта не выполняют `supabase db reset`.
