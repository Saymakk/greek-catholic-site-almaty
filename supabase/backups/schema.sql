


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."user_role" AS ENUM (
    'superadmin',
    'admin'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  insert into public.profiles (id, email, role)
  values (new.id, new.email, 'admin');
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_staff"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('superadmin', 'admin')
  );
$$;


ALTER FUNCTION "public"."is_staff"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_superadmin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'superadmin'
  );
$$;


ALTER FUNCTION "public"."is_superadmin"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."admin_activity_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "actor_id" "uuid" NOT NULL,
    "actor_email" "text" DEFAULT ''::"text" NOT NULL,
    "action" "text" NOT NULL,
    "entity_type" "text" NOT NULL,
    "entity_id" "text",
    "summary" "text",
    "meta" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL
);


ALTER TABLE "public"."admin_activity_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."clergy" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "photo_url" "text",
    "full_name" "text" NOT NULL,
    "extra_fields" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "full_name_ru" "text",
    "full_name_uk" "text",
    "full_name_kk" "text",
    "full_name_en" "text"
);


ALTER TABLE "public"."clergy" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."kazakhstan_parishes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "parish_photo_url" "text",
    "priest_photo_url" "text",
    "website_url" "text",
    "city_ru" "text",
    "city_uk" "text",
    "city_kk" "text",
    "city_en" "text",
    "name_ru" "text",
    "name_uk" "text",
    "name_kk" "text",
    "name_en" "text",
    "address_ru" "text",
    "address_uk" "text",
    "address_kk" "text",
    "address_en" "text",
    "priest_name_ru" "text",
    "priest_name_uk" "text",
    "priest_name_kk" "text",
    "priest_name_en" "text",
    "priest_contacts_ru" "text",
    "priest_contacts_uk" "text",
    "priest_contacts_kk" "text",
    "priest_contacts_en" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "map_embed_src" "text"
);


ALTER TABLE "public"."kazakhstan_parishes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_event_extra_fields" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_id" "uuid" NOT NULL,
    "sort_idx" integer DEFAULT 0 NOT NULL,
    "label_ru" "text",
    "label_uk" "text",
    "label_kk" "text",
    "label_en" "text",
    "body_ru" "text",
    "body_uk" "text",
    "body_kk" "text",
    "body_en" "text",
    "url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."liturgical_event_extra_fields" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_event_i18n" (
    "event_id" "uuid" NOT NULL,
    "lang" "text" NOT NULL,
    "title" "text" NOT NULL,
    "explanation" "text" NOT NULL,
    "prayer" "text",
    CONSTRAINT "liturgical_event_i18n_lang_check" CHECK (("lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"])))
);


ALTER TABLE "public"."liturgical_event_i18n" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_event_template_rows" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "template_id" "uuid" NOT NULL,
    "sort_idx" integer DEFAULT 0 NOT NULL,
    "label_ru" "text",
    "label_uk" "text",
    "label_kk" "text",
    "label_en" "text"
);


ALTER TABLE "public"."liturgical_event_template_rows" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_event_templates" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."liturgical_event_templates" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_events" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "event_date" "date" NOT NULL,
    "kind" "text" NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "recurrence_series_id" "uuid",
    "primary_lang" "text",
    "cover_image_url" "text",
    "gallery_image_urls" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "created_by" "uuid",
    CONSTRAINT "liturgical_events_primary_lang_check" CHECK ((("primary_lang" IS NULL) OR ("primary_lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"]))))
);


ALTER TABLE "public"."liturgical_events" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."liturgical_kind_i18n" (
    "kind_slug" "text" NOT NULL,
    "lang" "text" NOT NULL,
    "label" "text" NOT NULL,
    CONSTRAINT "liturgical_kind_i18n_lang_check" CHECK (("lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"])))
);


ALTER TABLE "public"."liturgical_kind_i18n" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."news" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "published_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "is_published" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "author_id" "uuid",
    "cover_image_url" "text",
    "primary_lang" "text",
    "gallery_image_urls" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    CONSTRAINT "news_primary_lang_check" CHECK ((("primary_lang" IS NULL) OR ("primary_lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"]))))
);


ALTER TABLE "public"."news" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."news_i18n" (
    "news_id" "uuid" NOT NULL,
    "lang" "text" NOT NULL,
    "title" "text" NOT NULL,
    "excerpt" "text",
    "body" "text" NOT NULL,
    CONSTRAINT "news_i18n_lang_check" CHECK (("lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"])))
);


ALTER TABLE "public"."news_i18n" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."page_content" (
    "page_key" "text" NOT NULL,
    "lang" "text" NOT NULL,
    "body" "text" NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "page_content_lang_check" CHECK (("lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"])))
);


ALTER TABLE "public"."page_content" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "email" "text",
    "full_name" "text",
    "role" "public"."user_role" DEFAULT 'admin'::"public"."user_role" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "can_view_all_objects" boolean DEFAULT true NOT NULL,
    "can_edit_all_objects" boolean DEFAULT true NOT NULL
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scripture_book_locales" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "book_id" "uuid" NOT NULL,
    "lang" "text" NOT NULL,
    "title" "text",
    "description" "text",
    "read_url" "text",
    "file_url" "text",
    "cover_image_url" "text",
    CONSTRAINT "scripture_book_locales_lang_check" CHECK (("lang" = ANY (ARRAY['main'::"text", 'ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"])))
);


ALTER TABLE "public"."scripture_book_locales" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scripture_books" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "primary_lang" "text",
    "gallery_image_urls" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    CONSTRAINT "scripture_books_primary_lang_check" CHECK ((("primary_lang" IS NULL) OR ("primary_lang" = ANY (ARRAY['ru'::"text", 'uk'::"text", 'kk'::"text", 'en'::"text"]))))
);


ALTER TABLE "public"."scripture_books" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."site_settings" (
    "key" "text" NOT NULL,
    "value" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL
);


ALTER TABLE "public"."site_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."telegram_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chat_id" bigint NOT NULL,
    "tg_message_id" bigint NOT NULL,
    "text" "text",
    "sent_at" timestamp with time zone
);


ALTER TABLE "public"."telegram_messages" OWNER TO "postgres";


ALTER TABLE ONLY "public"."admin_activity_log"
    ADD CONSTRAINT "admin_activity_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."clergy"
    ADD CONSTRAINT "clergy_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."kazakhstan_parishes"
    ADD CONSTRAINT "kazakhstan_parishes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."liturgical_event_extra_fields"
    ADD CONSTRAINT "liturgical_event_extra_fields_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."liturgical_event_i18n"
    ADD CONSTRAINT "liturgical_event_i18n_pkey" PRIMARY KEY ("event_id", "lang");



ALTER TABLE ONLY "public"."liturgical_event_template_rows"
    ADD CONSTRAINT "liturgical_event_template_rows_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."liturgical_event_templates"
    ADD CONSTRAINT "liturgical_event_templates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."liturgical_events"
    ADD CONSTRAINT "liturgical_events_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."liturgical_kind_i18n"
    ADD CONSTRAINT "liturgical_kind_i18n_pkey" PRIMARY KEY ("kind_slug", "lang");



ALTER TABLE ONLY "public"."news_i18n"
    ADD CONSTRAINT "news_i18n_pkey" PRIMARY KEY ("news_id", "lang");



ALTER TABLE ONLY "public"."news"
    ADD CONSTRAINT "news_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."page_content"
    ADD CONSTRAINT "page_content_pkey" PRIMARY KEY ("page_key", "lang");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scripture_book_locales"
    ADD CONSTRAINT "scripture_book_locales_book_id_lang_key" UNIQUE ("book_id", "lang");



ALTER TABLE ONLY "public"."scripture_book_locales"
    ADD CONSTRAINT "scripture_book_locales_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scripture_books"
    ADD CONSTRAINT "scripture_books_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."site_settings"
    ADD CONSTRAINT "site_settings_pkey" PRIMARY KEY ("key");



ALTER TABLE ONLY "public"."telegram_messages"
    ADD CONSTRAINT "telegram_messages_chat_id_tg_message_id_key" UNIQUE ("chat_id", "tg_message_id");



ALTER TABLE ONLY "public"."telegram_messages"
    ADD CONSTRAINT "telegram_messages_pkey" PRIMARY KEY ("id");



CREATE INDEX "admin_activity_log_created_at_idx" ON "public"."admin_activity_log" USING "btree" ("created_at" DESC);



CREATE INDEX "clergy_sort_idx" ON "public"."clergy" USING "btree" ("sort_order", "id");



CREATE INDEX "kazakhstan_parishes_sort_idx" ON "public"."kazakhstan_parishes" USING "btree" ("sort_order", "id");



CREATE INDEX "liturgical_event_extra_fields_event_idx" ON "public"."liturgical_event_extra_fields" USING "btree" ("event_id", "sort_idx");



CREATE INDEX "liturgical_event_template_rows_tid" ON "public"."liturgical_event_template_rows" USING "btree" ("template_id", "sort_idx");



CREATE INDEX "liturgical_events_date_idx" ON "public"."liturgical_events" USING "btree" ("event_date");



CREATE INDEX "liturgical_events_recurrence_series_idx" ON "public"."liturgical_events" USING "btree" ("recurrence_series_id") WHERE ("recurrence_series_id" IS NOT NULL);



CREATE INDEX "scripture_book_locales_book_id_idx" ON "public"."scripture_book_locales" USING "btree" ("book_id");



ALTER TABLE ONLY "public"."admin_activity_log"
    ADD CONSTRAINT "admin_activity_log_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."liturgical_event_extra_fields"
    ADD CONSTRAINT "liturgical_event_extra_fields_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."liturgical_events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."liturgical_event_i18n"
    ADD CONSTRAINT "liturgical_event_i18n_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "public"."liturgical_events"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."liturgical_event_template_rows"
    ADD CONSTRAINT "liturgical_event_template_rows_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "public"."liturgical_event_templates"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."liturgical_event_templates"
    ADD CONSTRAINT "liturgical_event_templates_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."profiles"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."liturgical_events"
    ADD CONSTRAINT "liturgical_events_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."profiles"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."news"
    ADD CONSTRAINT "news_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."news_i18n"
    ADD CONSTRAINT "news_i18n_news_id_fkey" FOREIGN KEY ("news_id") REFERENCES "public"."news"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scripture_book_locales"
    ADD CONSTRAINT "scripture_book_locales_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."scripture_books"("id") ON DELETE CASCADE;



ALTER TABLE "public"."admin_activity_log" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "admin_activity_log_insert_self" ON "public"."admin_activity_log" FOR INSERT WITH CHECK (("public"."is_staff"() AND ("actor_id" = "auth"."uid"())));



CREATE POLICY "admin_activity_log_select_staff" ON "public"."admin_activity_log" FOR SELECT USING ("public"."is_staff"());



ALTER TABLE "public"."clergy" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "clergy_delete" ON "public"."clergy" FOR DELETE USING ("public"."is_staff"());



CREATE POLICY "clergy_insert" ON "public"."clergy" FOR INSERT WITH CHECK ("public"."is_staff"());



CREATE POLICY "clergy_select" ON "public"."clergy" FOR SELECT USING (true);



CREATE POLICY "clergy_update" ON "public"."clergy" FOR UPDATE USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."kazakhstan_parishes" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "kazakhstan_parishes_select" ON "public"."kazakhstan_parishes" FOR SELECT USING (true);



CREATE POLICY "kazakhstan_parishes_write" ON "public"."kazakhstan_parishes" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."liturgical_event_extra_fields" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."liturgical_event_i18n" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "liturgical_event_i18n_public_read" ON "public"."liturgical_event_i18n" FOR SELECT USING (true);



CREATE POLICY "liturgical_event_i18n_staff_write" ON "public"."liturgical_event_i18n" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."liturgical_event_template_rows" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."liturgical_event_templates" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."liturgical_events" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "liturgical_events_public_read" ON "public"."liturgical_events" FOR SELECT USING (true);



CREATE POLICY "liturgical_events_staff_write" ON "public"."liturgical_events" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



CREATE POLICY "liturgical_extra_select" ON "public"."liturgical_event_extra_fields" FOR SELECT USING (true);



CREATE POLICY "liturgical_extra_staff_write" ON "public"."liturgical_event_extra_fields" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."liturgical_kind_i18n" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "liturgical_kind_i18n_select" ON "public"."liturgical_kind_i18n" FOR SELECT USING (true);



CREATE POLICY "liturgical_kind_i18n_staff_write" ON "public"."liturgical_kind_i18n" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



CREATE POLICY "liturgical_template_rows_staff" ON "public"."liturgical_event_template_rows" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



CREATE POLICY "liturgical_template_staff" ON "public"."liturgical_event_templates" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."news" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."news_i18n" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "news_i18n_select" ON "public"."news_i18n" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."news" "n"
  WHERE (("n"."id" = "news_i18n"."news_id") AND (("n"."is_published" = true) OR "public"."is_staff"())))));



CREATE POLICY "news_i18n_write" ON "public"."news_i18n" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



CREATE POLICY "news_select" ON "public"."news" FOR SELECT USING ((("is_published" = true) OR "public"."is_staff"()));



CREATE POLICY "news_write" ON "public"."news" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."page_content" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "page_content_public_read" ON "public"."page_content" FOR SELECT USING (true);



CREATE POLICY "page_content_staff_write" ON "public"."page_content" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "profiles_select_own_or_super" ON "public"."profiles" FOR SELECT USING ((("auth"."uid"() = "id") OR "public"."is_superadmin"()));



CREATE POLICY "profiles_update_self" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id")) WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "profiles_update_super" ON "public"."profiles" FOR UPDATE USING ("public"."is_superadmin"());



ALTER TABLE "public"."scripture_book_locales" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "scripture_book_locales_public_read" ON "public"."scripture_book_locales" FOR SELECT USING (true);



CREATE POLICY "scripture_book_locales_staff_write" ON "public"."scripture_book_locales" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."scripture_books" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "scripture_books_public_read" ON "public"."scripture_books" FOR SELECT USING (true);



CREATE POLICY "scripture_books_staff_write" ON "public"."scripture_books" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."site_settings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "site_settings_public_read" ON "public"."site_settings" FOR SELECT USING (true);



CREATE POLICY "site_settings_staff_write" ON "public"."site_settings" USING ("public"."is_staff"()) WITH CHECK ("public"."is_staff"());



ALTER TABLE "public"."telegram_messages" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "telegram_messages_public_read" ON "public"."telegram_messages" FOR SELECT USING (true);





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";































































































































































GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_staff"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_staff"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_staff"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_superadmin"() TO "service_role";


















GRANT ALL ON TABLE "public"."admin_activity_log" TO "anon";
GRANT ALL ON TABLE "public"."admin_activity_log" TO "authenticated";
GRANT ALL ON TABLE "public"."admin_activity_log" TO "service_role";



GRANT ALL ON TABLE "public"."clergy" TO "anon";
GRANT ALL ON TABLE "public"."clergy" TO "authenticated";
GRANT ALL ON TABLE "public"."clergy" TO "service_role";



GRANT ALL ON TABLE "public"."kazakhstan_parishes" TO "anon";
GRANT ALL ON TABLE "public"."kazakhstan_parishes" TO "authenticated";
GRANT ALL ON TABLE "public"."kazakhstan_parishes" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_event_extra_fields" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_event_extra_fields" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_event_extra_fields" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_event_i18n" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_event_i18n" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_event_i18n" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_event_template_rows" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_event_template_rows" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_event_template_rows" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_event_templates" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_event_templates" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_event_templates" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_events" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_events" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_events" TO "service_role";



GRANT ALL ON TABLE "public"."liturgical_kind_i18n" TO "anon";
GRANT ALL ON TABLE "public"."liturgical_kind_i18n" TO "authenticated";
GRANT ALL ON TABLE "public"."liturgical_kind_i18n" TO "service_role";



GRANT ALL ON TABLE "public"."news" TO "anon";
GRANT ALL ON TABLE "public"."news" TO "authenticated";
GRANT ALL ON TABLE "public"."news" TO "service_role";



GRANT ALL ON TABLE "public"."news_i18n" TO "anon";
GRANT ALL ON TABLE "public"."news_i18n" TO "authenticated";
GRANT ALL ON TABLE "public"."news_i18n" TO "service_role";



GRANT ALL ON TABLE "public"."page_content" TO "anon";
GRANT ALL ON TABLE "public"."page_content" TO "authenticated";
GRANT ALL ON TABLE "public"."page_content" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."scripture_book_locales" TO "anon";
GRANT ALL ON TABLE "public"."scripture_book_locales" TO "authenticated";
GRANT ALL ON TABLE "public"."scripture_book_locales" TO "service_role";



GRANT ALL ON TABLE "public"."scripture_books" TO "anon";
GRANT ALL ON TABLE "public"."scripture_books" TO "authenticated";
GRANT ALL ON TABLE "public"."scripture_books" TO "service_role";



GRANT ALL ON TABLE "public"."site_settings" TO "anon";
GRANT ALL ON TABLE "public"."site_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."site_settings" TO "service_role";



GRANT ALL ON TABLE "public"."telegram_messages" TO "anon";
GRANT ALL ON TABLE "public"."telegram_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."telegram_messages" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































