--
-- PostgreSQL database dump
--

\restrict khhIUGKmUTBKizvXbXL4hMOvcA66yAPytEdslJtJW7mKFg0b9ncJNZ6s69As3NP

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'superadmin',
    'admin'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
begin
  insert into public.profiles (id, email, role)
  values (new.id, new.email, 'admin');
  return new;
end;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: is_staff(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_staff() RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role in ('superadmin', 'admin')
  );
$$;


ALTER FUNCTION public.is_staff() OWNER TO postgres;

--
-- Name: is_superadmin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_superadmin() RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'superadmin'
  );
$$;


ALTER FUNCTION public.is_superadmin() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 1000,
    max_payload_size_in_kb integer DEFAULT 3000,
    max_client_presence_events_per_window integer,
    client_presence_window_ms integer,
    presence_enabled boolean DEFAULT false NOT NULL,
    CONSTRAINT jwt_secret_or_jwt_jwks_required CHECK (((jwt_secret IS NOT NULL) OR (jwt_jwks IS NOT NULL)))
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: admin_activity_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_activity_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    actor_id uuid NOT NULL,
    actor_email text DEFAULT ''::text NOT NULL,
    action text NOT NULL,
    entity_type text NOT NULL,
    entity_id text,
    summary text,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.admin_activity_log OWNER TO postgres;

--
-- Name: clergy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clergy (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    photo_url text,
    full_name text NOT NULL,
    extra_fields jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    full_name_ru text,
    full_name_uk text,
    full_name_kk text,
    full_name_en text
);


ALTER TABLE public.clergy OWNER TO postgres;

--
-- Name: kazakhstan_parishes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kazakhstan_parishes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    parish_photo_url text,
    priest_photo_url text,
    website_url text,
    city_ru text,
    city_uk text,
    city_kk text,
    city_en text,
    name_ru text,
    name_uk text,
    name_kk text,
    name_en text,
    address_ru text,
    address_uk text,
    address_kk text,
    address_en text,
    priest_name_ru text,
    priest_name_uk text,
    priest_name_kk text,
    priest_name_en text,
    priest_contacts_ru text,
    priest_contacts_uk text,
    priest_contacts_kk text,
    priest_contacts_en text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    map_embed_src text
);


ALTER TABLE public.kazakhstan_parishes OWNER TO postgres;

--
-- Name: liturgical_event_extra_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_event_extra_fields (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    event_id uuid NOT NULL,
    sort_idx integer DEFAULT 0 NOT NULL,
    label_ru text,
    label_uk text,
    label_kk text,
    label_en text,
    body_ru text,
    body_uk text,
    body_kk text,
    body_en text,
    url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.liturgical_event_extra_fields OWNER TO postgres;

--
-- Name: liturgical_event_i18n; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_event_i18n (
    event_id uuid NOT NULL,
    lang text NOT NULL,
    title text NOT NULL,
    explanation text NOT NULL,
    prayer text,
    CONSTRAINT liturgical_event_i18n_lang_check CHECK ((lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text])))
);


ALTER TABLE public.liturgical_event_i18n OWNER TO postgres;

--
-- Name: liturgical_event_template_rows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_event_template_rows (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    template_id uuid NOT NULL,
    sort_idx integer DEFAULT 0 NOT NULL,
    label_ru text,
    label_uk text,
    label_kk text,
    label_en text
);


ALTER TABLE public.liturgical_event_template_rows OWNER TO postgres;

--
-- Name: liturgical_event_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_event_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.liturgical_event_templates OWNER TO postgres;

--
-- Name: liturgical_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    event_date date NOT NULL,
    kind text NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    recurrence_series_id uuid,
    primary_lang text,
    cover_image_url text,
    gallery_image_urls jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_by uuid,
    CONSTRAINT liturgical_events_primary_lang_check CHECK (((primary_lang IS NULL) OR (primary_lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text]))))
);


ALTER TABLE public.liturgical_events OWNER TO postgres;

--
-- Name: liturgical_kind_i18n; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liturgical_kind_i18n (
    kind_slug text NOT NULL,
    lang text NOT NULL,
    label text NOT NULL,
    CONSTRAINT liturgical_kind_i18n_lang_check CHECK ((lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text])))
);


ALTER TABLE public.liturgical_kind_i18n OWNER TO postgres;

--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    published_at timestamp with time zone DEFAULT now() NOT NULL,
    is_published boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    author_id uuid,
    cover_image_url text,
    primary_lang text,
    gallery_image_urls jsonb DEFAULT '[]'::jsonb NOT NULL,
    CONSTRAINT news_primary_lang_check CHECK (((primary_lang IS NULL) OR (primary_lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text]))))
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: news_i18n; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_i18n (
    news_id uuid NOT NULL,
    lang text NOT NULL,
    title text NOT NULL,
    excerpt text,
    body text NOT NULL,
    CONSTRAINT news_i18n_lang_check CHECK ((lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text])))
);


ALTER TABLE public.news_i18n OWNER TO postgres;

--
-- Name: page_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page_content (
    page_key text NOT NULL,
    lang text NOT NULL,
    body text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT page_content_lang_check CHECK ((lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text])))
);


ALTER TABLE public.page_content OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text,
    full_name text,
    role public.user_role DEFAULT 'admin'::public.user_role NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    can_view_all_objects boolean DEFAULT true NOT NULL,
    can_edit_all_objects boolean DEFAULT true NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: scripture_book_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scripture_book_locales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    book_id uuid NOT NULL,
    lang text NOT NULL,
    title text,
    description text,
    read_url text,
    file_url text,
    cover_image_url text,
    CONSTRAINT scripture_book_locales_lang_check CHECK ((lang = ANY (ARRAY['main'::text, 'ru'::text, 'uk'::text, 'kk'::text, 'en'::text])))
);


ALTER TABLE public.scripture_book_locales OWNER TO postgres;

--
-- Name: scripture_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scripture_books (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    primary_lang text,
    gallery_image_urls jsonb DEFAULT '[]'::jsonb NOT NULL,
    CONSTRAINT scripture_books_primary_lang_check CHECK (((primary_lang IS NULL) OR (primary_lang = ANY (ARRAY['ru'::text, 'uk'::text, 'kk'::text, 'en'::text]))))
);


ALTER TABLE public.scripture_books OWNER TO postgres;

--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_settings (
    key text NOT NULL,
    value jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.site_settings OWNER TO postgres;

--
-- Name: telegram_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telegram_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    chat_id bigint NOT NULL,
    tg_message_id bigint NOT NULL,
    text text,
    sent_at timestamp with time zone
);


ALTER TABLE public.telegram_messages OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_04_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_25 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_25 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_26; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_26 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_26 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_27; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_27 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_27 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_28; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_28 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_28 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_29; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_29 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_30; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_30 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_30 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_namespaces OWNER TO supabase_storage_admin;

--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    remote_table_id text,
    shard_key text,
    shard_id text,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_tables OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2026_04_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_25 FOR VALUES FROM ('2026-04-25 00:00:00') TO ('2026-04-26 00:00:00');


--
-- Name: messages_2026_04_26; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_26 FOR VALUES FROM ('2026-04-26 00:00:00') TO ('2026-04-27 00:00:00');


--
-- Name: messages_2026_04_27; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00') TO ('2026-04-28 00:00:00');


--
-- Name: messages_2026_04_28; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_28 FOR VALUES FROM ('2026-04-28 00:00:00') TO ('2026-04-29 00:00:00');


--
-- Name: messages_2026_04_29; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_29 FOR VALUES FROM ('2026-04-29 00:00:00') TO ('2026-04-30 00:00:00');


--
-- Name: messages_2026_04_30; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_30 FOR VALUES FROM ('2026-04-30 00:00:00') TO ('2026-05-01 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
928f593e-010c-4130-be08-84ed7d8616bb	postgres_cdc_rls	{"region": "us-east-1", "db_host": "527R91sHPnNhkJijuBN2ZOAA0cEAOKK6sKDRYcdMYIENOV8lblqapTTxLt6SeqS8", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2026-04-27 17:49:09	2026-04-27 17:49:09
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2026-04-26 18:16:59
20220329161857	2026-04-26 18:16:59
20220410212326	2026-04-26 18:16:59
20220506102948	2026-04-26 18:16:59
20220527210857	2026-04-26 18:16:59
20220815211129	2026-04-26 18:16:59
20220815215024	2026-04-26 18:16:59
20220818141501	2026-04-26 18:16:59
20221018173709	2026-04-26 18:16:59
20221102172703	2026-04-26 18:16:59
20221223010058	2026-04-26 18:16:59
20230110180046	2026-04-26 18:16:59
20230810220907	2026-04-26 18:16:59
20230810220924	2026-04-26 18:16:59
20231024094642	2026-04-26 18:16:59
20240306114423	2026-04-26 18:16:59
20240418082835	2026-04-26 18:16:59
20240625211759	2026-04-26 18:16:59
20240704172020	2026-04-26 18:16:59
20240902173232	2026-04-26 18:16:59
20241106103258	2026-04-26 18:16:59
20250424203323	2026-04-26 18:16:59
20250613072131	2026-04-26 18:16:59
20250711044927	2026-04-26 18:16:59
20250811121559	2026-04-26 18:16:59
20250926223044	2026-04-26 18:16:59
20251204170944	2026-04-26 18:16:59
20251218000543	2026-04-26 18:16:59
20260209232800	2026-04-26 18:16:59
20260304000000	2026-04-26 18:16:59
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb, max_client_presence_events_per_window, client_presence_window_ms, presence_enabled) FROM stdin;
07c81302-4b3d-4e4a-94f3-9fb91d6b86b6	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2026-04-27 17:49:09	2026-04-27 17:49:09	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"x": "M5Sjqn5zwC9Kl1zVfUUGvv9boQjCGd45G8sdopBExB4", "y": "P6IXMvA2WYXSHSOMTBH2jsw_9rrzGy89FjPf6oOsIxQ", "alg": "ES256", "crv": "P-256", "ext": true, "kid": "b81269f1-21d8-4f2e-b719-c2240a840d90", "kty": "EC", "use": "sig", "key_ops": ["verify"]}, {"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	69	gen_rpc	1000	3000	\N	\N	f
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	dee119e8-f943-4299-b6a6-9f491c1d4f45	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"vladsarana@gmail.com","user_id":"1f7fb491-43db-4ead-a0ad-31876880e847","user_phone":""}}	2026-04-26 18:23:02.720738+00	
00000000-0000-0000-0000-000000000000	7727b57e-f8a3-4e0e-810e-45019cf0d0af	{"action":"login","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-26 20:42:18.182591+00	
00000000-0000-0000-0000-000000000000	7945736c-abdb-424b-ba2f-10327c989955	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:41:04.353059+00	
00000000-0000-0000-0000-000000000000	d3face5f-db3a-4ab4-8b79-0f8f38658853	{"action":"token_revoked","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:41:04.355717+00	
00000000-0000-0000-0000-000000000000	3ee048f4-db4e-44a5-b50c-c8210873f1a2	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:41:04.593666+00	
00000000-0000-0000-0000-000000000000	3446c23e-c913-4994-8e22-503bdf7b09df	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:41:04.683562+00	
00000000-0000-0000-0000-000000000000	3f8774f0-38b3-409c-b2bb-b8d775d3bd89	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-26 21:42:06.907106+00	
00000000-0000-0000-0000-000000000000	89c7a716-aec0-4d97-9737-706f40b3c0e1	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:59:57.908687+00	
00000000-0000-0000-0000-000000000000	d6475c14-06bf-46b4-a539-4bb54a8e753a	{"action":"token_revoked","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 02:59:57.909786+00	
00000000-0000-0000-0000-000000000000	648de397-fa54-419d-9170-338fcf611bf3	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 03:01:15.194009+00	
00000000-0000-0000-0000-000000000000	64171305-ec57-49d1-91e4-9bb575d908e7	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"oleh.halushka@gmail.com","user_id":"8855aa14-c74e-489e-9bf2-737cc572b5cb","user_phone":""}}	2026-04-27 03:16:40.852185+00	
00000000-0000-0000-0000-000000000000	346fe6dd-3beb-4178-aed3-8ec0aec12ae5	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"oleh.halushka1979@gmail.com","user_id":"41913d45-2416-4e03-9979-5029f28644e8","user_phone":""}}	2026-04-27 03:17:27.073452+00	
00000000-0000-0000-0000-000000000000	48059127-8e6d-4447-b4e9-f42d3c7a5eab	{"action":"token_refreshed","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 17:49:36.7039+00	
00000000-0000-0000-0000-000000000000	68316c86-31a9-4b0d-9fc1-320d76501fa7	{"action":"token_revoked","actor_id":"1f7fb491-43db-4ead-a0ad-31876880e847","actor_username":"vladsarana@gmail.com","actor_via_sso":false,"log_type":"token"}	2026-04-27 17:49:36.705723+00	
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
1f7fb491-43db-4ead-a0ad-31876880e847	1f7fb491-43db-4ead-a0ad-31876880e847	{"sub": "1f7fb491-43db-4ead-a0ad-31876880e847", "email": "vladsarana@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 18:23:02.71976+00	2026-04-26 18:23:02.719793+00	2026-04-26 18:23:02.719793+00	7d2bd95c-205b-4751-80b9-bec3dabed0e7
8855aa14-c74e-489e-9bf2-737cc572b5cb	8855aa14-c74e-489e-9bf2-737cc572b5cb	{"sub": "8855aa14-c74e-489e-9bf2-737cc572b5cb", "email": "oleh.halushka@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-27 03:16:40.851145+00	2026-04-27 03:16:40.85118+00	2026-04-27 03:16:40.85118+00	c318094d-c5ba-4500-b762-eae783740e73
41913d45-2416-4e03-9979-5029f28644e8	41913d45-2416-4e03-9979-5029f28644e8	{"sub": "41913d45-2416-4e03-9979-5029f28644e8", "email": "oleh.halushka1979@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-27 03:17:27.072653+00	2026-04-27 03:17:27.072684+00	2026-04-27 03:17:27.072684+00	e03e9f20-d2a3-407a-9e7b-ce2f653aa58f
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
eeec0e89-5488-4133-b98f-de7d533ecd64	2026-04-26 20:42:18.191161+00	2026-04-26 20:42:18.191161+00	password	f34b79a1-6ecc-4035-9aa9-21a49bc60831
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	ecefb5hql7ul	1f7fb491-43db-4ead-a0ad-31876880e847	t	2026-04-26 20:42:18.187348+00	2026-04-26 21:41:04.356678+00	\N	eeec0e89-5488-4133-b98f-de7d533ecd64
00000000-0000-0000-0000-000000000000	2	uzleumrh7cmf	1f7fb491-43db-4ead-a0ad-31876880e847	t	2026-04-26 21:41:04.358219+00	2026-04-27 02:59:57.910489+00	ecefb5hql7ul	eeec0e89-5488-4133-b98f-de7d533ecd64
00000000-0000-0000-0000-000000000000	3	6cyhv2ewbfzr	1f7fb491-43db-4ead-a0ad-31876880e847	t	2026-04-27 02:59:57.911293+00	2026-04-27 17:49:36.706237+00	uzleumrh7cmf	eeec0e89-5488-4133-b98f-de7d533ecd64
00000000-0000-0000-0000-000000000000	4	xixfy6nropmh	1f7fb491-43db-4ead-a0ad-31876880e847	f	2026-04-27 17:49:36.706735+00	2026-04-27 17:49:36.706735+00	6cyhv2ewbfzr	eeec0e89-5488-4133-b98f-de7d533ecd64
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
eeec0e89-5488-4133-b98f-de7d533ecd64	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 20:42:18.184507+00	2026-04-27 17:49:36.709357+00	\N	aal1	\N	2026-04-27 17:49:36.709309	node	172.18.0.1	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	8855aa14-c74e-489e-9bf2-737cc572b5cb	authenticated	authenticated	oleh.halushka@gmail.com	$2a$10$//KnsHHF2tkuPhRp9.HkxOwl9b.W1T3arXI8kUTGPxFbUM9o8AO1a	2026-04-27 03:16:40.853447+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-27 03:16:40.845675+00	2026-04-27 03:16:40.85401+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	41913d45-2416-4e03-9979-5029f28644e8	authenticated	authenticated	oleh.halushka1979@gmail.com	$2a$10$HvGslNt8Ut2748I.XUWBSenSKTdDEI3f.jyer3P0QGNnEKpAs6R7m	2026-04-27 03:17:27.074508+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-27 03:17:27.070229+00	2026-04-27 03:17:27.075012+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	1f7fb491-43db-4ead-a0ad-31876880e847	authenticated	authenticated	vladsarana@gmail.com	$2a$10$zS57ZDv9MS1eHi.22NF/Pe6L20LOcRN4Zi4ZWtXPo2aAh8nW408o6	2026-04-26 18:23:02.722022+00	\N		\N		\N			\N	2026-04-26 20:42:18.184428+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 18:23:02.716935+00	2026-04-27 17:49:36.707744+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: admin_activity_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_activity_log (id, created_at, actor_id, actor_email, action, entity_type, entity_id, summary, meta) FROM stdin;
b7f89ef0-5297-448d-b38b-4955489d4d95	2026-04-26 21:45:08.857268+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.create	news	290e9810-4671-4f53-8768-ffc01a7bd557	Приближается светлый Праздник Христова Воскресения – Пасха!	{}
4d1950ee-cf32-4fb7-b49c-a68d769d4f0a	2026-04-26 21:46:54.753068+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.update	news	290e9810-4671-4f53-8768-ffc01a7bd557	Приближается светлый Праздник Христова Воскресения – Пасха!	{}
f7862cc6-94c6-4768-8510-d265987a6997	2026-04-26 21:47:49.137934+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.create	news	bd81c8e5-0b7e-4ba5-a5bd-d5e5a05b05bc	123	{}
853f207b-03da-4d71-ada8-38ab0592899d	2026-04-26 21:47:55.665222+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.delete	news	bd81c8e5-0b7e-4ba5-a5bd-d5e5a05b05bc	\N	{}
59645491-8bd5-47cb-8f9c-ecf02436cde2	2026-04-26 21:49:36.871796+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.create	news	aee857b5-3ebc-44e7-a760-12d4bda46f69	Дорогие прихожане!	{}
3d83aaf0-ae1c-4d0f-95e9-f21d6f1e79e3	2026-04-26 21:51:12.573144+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	news.create	news	e641441d-f3b5-4404-bdef-5a7273150cba	Южная столица встретила праздник Воскресения Христова	{}
d0d0c133-5e7e-4db7-826f-8175c410d625	2026-04-26 21:51:31.294391+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.external_widget.save	site_settings	external_liturgical_widget	nj	{}
9fa91a9d-5470-4c7e-a368-0fe3915988e5	2026-04-26 21:51:45.426633+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.external_widget.save	site_settings	external_liturgical_widget	none	{}
42f23473-711a-4842-a098-4cd8be61afce	2026-04-26 21:57:38.672878+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.external_widget.save	site_settings	external_liturgical_widget	nj	{}
ea73c156-ccde-49ed-950f-151cd053a928	2026-04-26 22:00:22.100441+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.create	liturgical_event	93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	Воскресная Божественная литургия	{"kind": "feast", "event_date": "2026-04-12", "recurrence_count": 100, "recurrence_series_id": "c84c79fe-e79c-4dd6-8680-39bbdb1d436e"}
9d241896-dc84-466f-acac-be3a7ac422c6	2026-04-26 22:02:32.682422+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.create	liturgical_event	9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	Большая Пятница	{"kind": "other", "event_date": "2026-04-10"}
a2db25a2-53fe-4b7b-b24f-625ba2cff68a	2026-04-26 22:03:49.949407+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.create	liturgical_event	39185d5a-952f-4251-96a3-5bb457078e9a	Пасхальное воскресенье	{"kind": "feast", "event_date": "2026-04-12"}
eb3064df-6c83-485e-8503-a4a4a94ea37a	2026-04-26 22:07:37.723116+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.create	scripture_book	a21d48ff-4d22-45a9-b81d-a51df28fa85e	Библия. Русский синодальный перевод.	{}
0e5aa91d-0587-4fd3-abce-d8d2de5a64cf	2026-04-26 22:08:27.239958+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.update	scripture_book	a21d48ff-4d22-45a9-b81d-a51df28fa85e	Библия. Русский синодальный перевод.	{}
d942a581-a6e1-4adc-8c58-2d51b2216fe7	2026-04-26 22:09:40.960783+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.create	scripture_book	dcf3d897-be1d-4670-af00-0d8c3d9fadcd	Біблія в перекладi Івана Огієнка 1962	{}
3f147472-77fe-480e-93cd-119301286a9e	2026-04-26 22:09:46.768454+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.update	scripture_book	dcf3d897-be1d-4670-af00-0d8c3d9fadcd	Біблія в перекладi Івана Огієнка 1962	{}
4dc34d87-b271-467c-abe4-16bf73c5b4bb	2026-04-26 22:10:02.834789+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.update	scripture_book	dcf3d897-be1d-4670-af00-0d8c3d9fadcd	Біблія в перекладi Івана Огієнка 1962	{}
f9e16b78-0580-4c96-b715-aea94e38b4eb	2026-04-26 22:11:15.892779+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.create	scripture_book	33573b44-e003-4902-97f0-f0dd78f4c6f3	Катехизм Української Греко-Ка­толицької Церкви	{}
f92d6569-bb6c-4a88-afe5-2d01671ab3a4	2026-04-26 22:12:42.611894+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	scripture.create	scripture_book	f768c98c-e713-45d7-8daf-229da7993460	Біблія. Переклад о. Івана (Хоменка)	{}
a9f8441d-0f18-4fb4-8956-aac9573bb1e2	2026-04-26 22:13:41.815649+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	history.save	page_content	history	\N	{}
ccf30b76-c7b3-4d63-9081-ceab96375b79	2026-04-26 22:13:45.775017+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	history.save	page_content	history	\N	{}
fd10b153-19a9-43d9-a09d-4a3402abff59	2026-04-27 03:01:15.392515+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	3f52845f-97e6-4171-b27d-d2754bba22c8	Греко-католический Приход Покрова Пресвятой Богородицы	{}
b8da16f2-7a69-4c14-9a01-2cabd1da2177	2026-04-27 03:02:22.962331+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	c9e4c61e-cc2d-4e7f-bb4b-0ffc681d3b9a	Греко-католический Приход Блаженного Алексия Зарицкого	{}
1ce3c724-398a-402b-b111-a5b4dab324a8	2026-04-27 03:03:56.321136+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	b90965a2-f946-42e9-b7c5-94cf8c635558	Греко-католический Приход Святого Иосифа Обручника В Астане	{}
351953db-f4a3-4ff4-b4b8-11a7d574d0ab	2026-04-27 03:05:07.884372+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	a85b8ad7-1431-4589-a283-b0773879f16c	Греко-католический Приход Святых Верховных Апостолов Петра И Павла	{}
9248996f-a5f8-4b33-b17a-ca3bb7067eae	2026-04-27 03:06:04.48893+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	e7ca9d6f-a400-4f03-afd3-92cb4aacd237	Греко-католический Приход Святого Пророка Илии В Сатпаеве	{}
7dc98a50-457d-411c-a145-da568f14afd8	2026-04-27 03:07:57.333903+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	parish.create	kazakhstan_parish	962f4afe-b211-4b3c-b55d-d4f77f202136	Греко-католический Приход Рождества Пресвятой Богородицы В Шидерты	{}
585f2a3e-954f-4288-829c-26fdf900f009	2026-04-27 03:09:09.291471+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	clergy.create	clergy	1f84b456-d66e-4538-b69a-43f1900377f9	Лев XIV	{}
9fb72fbc-9134-4052-b306-d68aae7e49ed	2026-04-27 03:12:25.124493+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	clergy.create	clergy	c598081d-39bc-4e02-b7e4-ba5988692a24	Блаженнейший Святослав Шевчук	{}
02cbf854-6333-45e0-8f0f-5d8ab55e023f	2026-04-27 03:14:13.698833+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	clergy.create	clergy	277b06b1-2b27-4295-81d8-4ef4d5f465ce	Митрофорный Протоиерей Василий Говера	{}
09cad016-2563-496c-ad65-6b0e614e54d7	2026-04-27 03:16:05.719488+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	settings.footer.save	site_settings	footer	\N	{}
2b7b3d9d-2c17-4e70-98e5-1a295442e820	2026-04-27 03:16:12.287076+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	settings.footer.save	site_settings	footer	\N	{}
e6f1d799-35b8-4137-ac68-8b7b2f1e2c24	2026-04-27 03:16:40.862388+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	user.invite	auth	8855aa14-c74e-489e-9bf2-737cc572b5cb	oleh.halushka@gmail.com	{}
1bb3b3c1-c884-4e0a-9095-c100947cc5c4	2026-04-27 03:17:11.973012+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	user.update	auth	8855aa14-c74e-489e-9bf2-737cc572b5cb	oleh.halushka@gmail.com	{}
7d344104-d02b-4ad4-8eee-3834142d86ba	2026-04-27 03:17:27.083199+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	user.invite	auth	41913d45-2416-4e03-9979-5029f28644e8	oleh.halushka1979@gmail.com	{}
c911c8f5-999b-4eed-9df9-b558fa4629ac	2026-04-27 03:17:34.545909+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	user.update	auth	41913d45-2416-4e03-9979-5029f28644e8	oleh.halushka1979@gmail.com	{}
023176f7-a914-435b-9ae8-626c7bfe9595	2026-04-27 03:19:35.322298+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.create	liturgical_event	19974533-e0a6-4490-93fd-9baf950b39f1	Пасхальные богослужения на Воскресение Христово (Пасха):	{"kind": "other", "event_date": "2026-04-11"}
b7b04247-fb85-47c4-a9f6-b28ef0e47ad5	2026-04-27 03:19:51.02686+00	1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	liturgical.update	liturgical_event	19974533-e0a6-4490-93fd-9baf950b39f1	Пасхальные богослужения на Воскресение Христово (Пасха):	{"kind": "other", "event_date": "2026-04-11"}
\.


--
-- Data for Name: clergy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clergy (id, sort_order, photo_url, full_name, extra_fields, created_at, updated_at, full_name_ru, full_name_uk, full_name_kk, full_name_en) FROM stdin;
1f84b456-d66e-4538-b69a-43f1900377f9	0	https://www.vatican.va/content/dam/vatican/leone-xiv/Foto-Ufficiale-Papa-Leone-XIV_Copyright-VATICAN-MEDIA.jpg	Лев XIV	[{"url": null, "labels": {"ru": "Титул", "uk": "Титул"}, "values": {"ru": "Его Святейшество Папа Лев XIV, Епископ Рима, верховный первосвященник Вселенской Церкви.", "uk": "Його Святість Папа Лев XIV, Єпископ Риму, верховний первосвященик Вселенської Церкви."}}]	2026-04-27 03:09:09.282371+00	2026-04-27 03:09:09.27+00	\N	Лев XIV	\N	\N
c598081d-39bc-4e02-b7e4-ba5988692a24	1	https://synod.ugcc.ua/pub/images/91049c3c939666f1.jpg	Блаженнейший Святослав Шевчук	[{"url": null, "labels": {"en": "Title", "kk": "Атауы", "ru": "Титул", "uk": "Титул"}, "values": {"en": "Father and Head of the Ukrainian Greek Catholic Church", "kk": "Украиналық грек-католик шіркеуінің әкесі және басшысы", "ru": "Отец и Глава Украинской Греко-Католической Церкви", "uk": "Отець і Глава Української Греко-Католицької Церкви"}}, {"url": null, "labels": {"en": "Short biography", "kk": "Қысқаша өмірбаян", "ru": "Краткая биография", "uk": "Коротка біографія"}, "values": {"en": "His Beatitude Sviatoslav Shevchuk is the Father and Head of the Ukrainian Greek Catholic Church.\\n\\nHe was born on May 5, 1970 in the city of Stryi (Lviv region) into a Christian family. From childhood he was involved in the life of the underground UGCC, which significantly influenced his spiritual formation. He studied at a music school, where he mastered the violin and piano.\\nAfter school, he received a medical education at the Boryslav Medical School and served as a paramedic in the Soviet Army. At the same time, he underwent training at an underground theological seminary.\\nHe was ordained a priest on June 26, 1994. He studied in Argentina and Rome, where he received a doctorate in theology. After returning to Ukraine, he held various positions at the Lviv Theological Seminary and the Ukrainian Catholic University, and was also the personal secretary of His Beatitude Lubomyr Husar.\\nIn 2009, he was ordained a bishop and served in Argentina. On March 23, 2011, he was elected Head of the Ukrainian Greek Catholic Church, and on March 27, his enthronement took place in Kyiv.\\nHe speaks many languages, is actively engaged in teaching and pastoral activities. He is known for his openness, intellectuality, and dedication to serving the Church.", "kk": "Оның ізашары Святослав Шевчук - Украина грек-католик шіркеуінің әкесі және басшысы.\\n\\nОл 1970 жылы 5 мамырда Стрый қаласында (Львов облысы) христиан отбасында дүниеге келген. Бала кезінен бастап ол жер асты UGCC өміріне араласып, рухани қалыптасуына айтарлықтай әсер етті. Ол музыка мектебінде оқыды, онда скрипка мен фортепианода ойнауды меңгерді.\\nМектептен кейін Борислав медициналық мектебінде медициналық білім алып, Кеңес Армиясында фельдшер болып қызмет етті. Сонымен қатар, жер асты теологиялық семинариясында оқудан өтті.\\n1994 жылы 26 маусымда діни қызметкер болып тағайындалды. Аргентина мен Римде білім алып, теология докторы дәрежесін алды. Украинаға оралғаннан кейін Львов теологиялық семинариясында және Украина католик университетінде әртүрлі лауазымдарды атқарды, сонымен қатар оның ізашары Любомыр Гусардың жеке хатшысы болды.\\n2009 жылы ол епископ болып тағайындалды және Аргентинада қызмет етті. 2011 жылдың 23 наурызында ол Украинаның грек-католик шіркеуінің басшысы болып сайланды, ал 27 наурызда оның таққа отыруы Киевте өтті.\\nОл көптеген тілдерде сөйлейді, оқытушылық және пасторлық қызметпен белсенді айналысады. Ол өзінің ашықтығымен, интеллектуалдылығымен және шіркеуге қызмет етуге берілгендігімен танымал.", "ru": "Блаженнейший Святослав Шевчук – Отец и Глава Украинской Греко-Католической Церкви.\\n\\nРодился 5 мая 1970 года в городе Стрый (Львовская область) в христианской семье. С детства был вовлечен в жизнь подпольной УГКЦ, что повлияло на его духовное формирование. Учился в музыкальной школе, где овладел скрипкой и фортепиано.\\nПосле школы получил медицинское образование в Бориславском медицинском училище и служил фельдшером в Советской армии. В то же время проходил подготовку в подпольной духовной семинарии.\\nСвященничества получил 26 июня 1994 года. Учился в Аргентине и Риме, где получил докторскую степень по богословию. После возвращения в Украину занимал разные должности во Львовской духовной семинарии и Украинском католическом университете, а также был личным секретарем Блаженнейшего Любомира Гузара.\\nВ 2009 году был рукоположен в епископы и служил в Аргентине. 23 марта 2011 избран Главой Украинской Греко-Католической Церкви, а 27 марта состоялась его интронизация в Киеве.\\nГоворит  на многих языках, активно занимается преподавательской и пастырской деятельностью. Известен своей открытостью, интеллектуальностью и преданностью служению Церкви.", "uk": "Блаженніший Святослав Шевчук — Отець і Глава Української Греко-Католицької Церкви.\\n\\nНародився 5 травня 1970 року в місті Стрий (Львівська область) у християнській родині. З дитинства був залучений до життя підпільної УГКЦ, що значно вплинуло на його духовне формування. Навчався у музичній школі, де опанував скрипку та фортепіано.\\nПісля школи здобув медичну освіту в Бориславському медичному училищі та служив фельдшером у Радянській армії. Водночас проходив підготовку в підпільній духовній семінарії.\\nСвященичі свячення отримав 26 червня 1994 року. Навчався в Аргентині та Римі, де здобув докторський ступінь з богослов’я. Після повернення до України обіймав різні посади у Львівській духовній семінарії та Українському католицькому університеті, а також був особистим секретарем Блаженнішого Любомира Гузара.\\nУ 2009 році був висвячений на єпископа та служив в Аргентині. 23 березня 2011 року обраний Главою Української Греко-Католицької Церкви, а 27 березня відбулася його інтронізація в Києві.\\nВолодіє багатьма мовами, активно займається викладацькою та пастирською діяльністю. Відомий своєю відкритістю, інтелектуальністю та відданістю служінню Церкві."}}, {"url": null, "labels": {"en": "Contacts", "kk": "Байланыстар", "ru": "Контакты", "uk": "Контакти"}, "values": {"en": "Address: P.O. Box 210, Kyiv 02002, Ukraine\\n\\nPhone: +38 (044) 541-11-14\\nFax: +38 (044) 541-11-14\\n\\nE-mail: Ver_Arch@ugcc.org.ua", "kk": "Мекенжайы: P.O. Box 210, Киев 02002, Украина\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЭлектрондық пошта: Ver_Arch@ugcc.org.ua", "ru": "Адрес: а/я 210, Киев 02002, Украина\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЭл. почта: Ver_Arch@ugcc.org.ua", "uk": "Адреса: а/с 210, Київ 02002, Україна\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЕл. пошта: Ver_Arch@ugcc.org.ua"}}]	2026-04-27 03:12:25.114754+00	2026-04-27 03:12:25.106+00	Блаженнейший Святослав Шевчук	Блаженніший Святослав Шевчук	Оның аруағы Святослав Шевчук	His Beatitude Sviatoslav Shevchuk
277b06b1-2b27-4295-81d8-4ef4d5f465ce	2	https://static.wixstatic.com/media/c3aa9c_257a46a2605e41278776f69490f0543b~mv2.jpg/v1/fill/w_953,h_1062,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_257a46a2605e41278776f69490f0543b~mv2.jpg	Митрофорный Протоиерей Василий Говера	[{"url": null, "labels": {"ru": "Титул", "uk": "Титул"}, "values": {"ru": "Апостольский Администратор для католиков византийского обряда в Казахстане и Центральной Азии.", "uk": "Апостольський Адміністратор для католиків візантійського обряду у Казахстані та Центральній Азії."}}, {"url": null, "labels": {"ru": "Краткая биография", "uk": "Коротка біографія"}, "values": {"ru": "Апостольский Администратор для католиков византийского обряда в Казахстане и Центральной Азии.\\nРодился 11 декабря 1972 года в г. Ивано-Франковск. Украина.\\nС 1990 по 1996 год учился в Люблинском Католическом Университете (Польша).\\n2 марта 1997 года во Львове рукоположен в священники.\\nС 3 апреля 1997 года по 2021 год настоятель греко-католического прихода Покрова Пресвятой Богородицы в Караганде.\\n 1 июня 2019 года назначен папой Франциском Апостольским Администратором для католиков византийского обряда в Казахстане и Центральной Азии\\nПриписан к Львовской Архиепархии.", "uk": "Апостольський Адміністратор для католиків візантійського обряду у Казахстані та Центральній Азії.\\nНародився 11 грудня 1972 року у м. Івано-Франківську. Україна.\\nЗ 1990 до 1996 року навчався в Люблінському Католицькому Університеті (Польща).\\n2 березня 1997 року у Львові висвячений на священика.\\nЗ 3 квітня 1997 року до 2021 року настоятель греко-католицької парафії Покрови Пресвятої Богородиці в Караганді. \\n1 червня 2019 року призначений папою Франциском Апостольським Адміністратором для католиків візантійського обряду в Казахстані та Центральній Азії.\\nПриписано до Львівської Архієпархії."}}, {"url": null, "labels": {"ru": "Контакты", "uk": "Контакти"}, "values": {"ru": "ул. Пищевая, 3\\n100022 г. Караганда\\nРеспублика Казахстан\\n\\nтел: +7 (7212) 51 25 64\\nмоб. тел.: +7 705 10 88 000,\\nE-mail: pokrovakaz@gmail.com\\nSkype: vasyl.hovera", "uk": "вул. Пищевая, 3\\n100022 г. Караганда\\nРеспублiка Казахстан\\n\\nтел: +7 (7212) 51 25 64\\nмоб. тел.: +7 705 10 88 000,\\nE-mail: pokrovakaz@gmail.com\\nSkype: vasyl.hovera"}}]	2026-04-27 03:14:13.515781+00	2026-04-27 03:14:13.505+00	Митрофорный Протоиерей Василий Говера	Митрофорний Протоієрей Василь Говера	\N	\N
\.


--
-- Data for Name: kazakhstan_parishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kazakhstan_parishes (id, sort_order, parish_photo_url, priest_photo_url, website_url, city_ru, city_uk, city_kk, city_en, name_ru, name_uk, name_kk, name_en, address_ru, address_uk, address_kk, address_en, priest_name_ru, priest_name_uk, priest_name_kk, priest_name_en, priest_contacts_ru, priest_contacts_uk, priest_contacts_kk, priest_contacts_en, created_at, updated_at, map_embed_src) FROM stdin;
3f52845f-97e6-4171-b27d-d2754bba22c8	0	https://static.wixstatic.com/media/c3aa9c_9408dbd229654e7db89267e5ec79eb3b~mv2.jpg/v1/fill/w_980,h_1236,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_9408dbd229654e7db89267e5ec79eb3b~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_ff5678a2fe9c4ba3a60df708a0072577~mv2.jpg/v1/fill/w_819,h_817,al_c,q_85,enc_avif,quality_auto/c3aa9c_ff5678a2fe9c4ba3a60df708a0072577~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%BA%D0%B0%D1%80%D0%B0%D0%B3%D0%B0%D0%BD%D0%B4%D0%B0	Караганда	Караганда	\N	\N	Греко-католический Приход Покрова Пресвятой Богородицы	Греко-католицька Парафія Покрова Пресвятої Богородиці	\N	\N	ул. Пищевая, 1\r\n100022 Караганда\r\nРеспублика Казахстан	вул. Пищевая, 1\r\n100022 Караганда\r\nРеспублiка Казахстан	\N	\N	о. Дмитрий-Роман Козак	о. Дмитро-Роман Козак	\N	\N	тел/факс: +7 (7212) 51 25 64\r\nмоб. тел.: +7 771 373 77 87,\r\nE-mail: dmytrokozak@gmail.com	тел/факс: +7 (7212) 51 25 64\r\nмоб. тел.: +7 771 373 77 87,\r\nE-mail: dmytrokozak@gmail.com	\N	\N	2026-04-27 03:01:15.36769+00	2026-04-27 03:01:15.355+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d910.5070833008743!2d73.12049207887327!3d49.7991722747861!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4243470df9b3b23f%3A0x2dc479d91a795969!2z0JPRgNC10LrQvi3QutCw0YLQvtC70LjRh9C10YHQutCw0Y8g0YbQtdGA0LrQvtCy0Ywg0J_QvtC60YDQvtCy0LAg0JHQvtCz0L7RgNC-0LTQuNGG0Ys!5e0!3m2!1sru!2skz!4v1775459866038!5m2!1sru!2skz
c9e4c61e-cc2d-4e7f-bb4b-0ffc681d3b9a	1	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/a8/1f/18/almaty-catholic-cathedral.jpg?w=900&h=-1&s=1	https://fqqjsaztkxlrzombqdag.supabase.co/storage/v1/object/public/news-images/parishes/87e3b0af-5200-455d-950d-39beb692f516/priest_1775416717299.png	https://www.ugcc-almaty.com/	Алматы	Алмати	\N	\N	Греко-католический Приход Блаженного Алексия Зарицкого	Греко-католицька Парафія Блаженного Олексія Зарицького	\N	\N	Казахстан, г. Алматы, Тлендиева 9	Казахстан, м. Алмати, Тлендієва 9	\N	\N	Священник Олег	Священик Олег	\N	\N	+7 705 972 30 50	\N	\N	\N	2026-04-27 03:02:22.936098+00	2026-04-27 03:02:22.927+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2905.78928166767!2d76.86756577661457!3d43.255837878039785!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x388369823d000001%3A0xe5cfe59f1bfb932a!2z0KDQuNC80YHQutC-LdCa0LDRgtC-0LvQuNGH0LXRgdC60LjQuSDQodC-0LHQvtGAINCf0YDQtdGB0LLRj9GC0L7QuSDQotGA0L7QuNGG0Ys!5e0!3m2!1sru!2skz!4v1775402248459!5m2!1sru!2skz
b90965a2-f946-42e9-b7c5-94cf8c635558	2	https://static.wixstatic.com/media/c3aa9c_026a6fb55c0b4a9db2999e6571d843e0~mv2.jpeg/v1/fill/w_960,h_1211,al_c,q_85,enc_avif,quality_auto/c3aa9c_026a6fb55c0b4a9db2999e6571d843e0~mv2.jpeg	https://static.wixstatic.com/media/c3aa9c_f8ce988077a94b98b30efa3bc1888f32~mv2.jpg/v1/fill/w_953,h_995,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_f8ce988077a94b98b30efa3bc1888f32~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%B0%D1%81%D1%82%D0%B0%D0%BD%D0%B0	Астана	Астана	\N	\N	Греко-католический Приход Святого Иосифа Обручника В Астане	Греко-католицька парафія Святого Йосипа Обручника В Астані	\N	\N	ул. Арасан 2/2\r\n010000 г. Астана\r\nРеспублика Казахстан	вул. Арасан 2/2\r\n010000 м. Астана\r\nРеспублiка Казахстан	\N	\N	о. Игорь Свитовый	о. Ігор Світовий	\N	\N	Для писем:\r\nул. Арасан 2/2, а/я 622\r\n010010 г. Астана\r\nРеспублика Казахстан\r\n\r\nмоб. тел.: +7 705 157 3452\r\nigorsvitovyj@gmail.com	Для листів:\r\nвул. Арасан 2/2, а/я 622\r\n010010 г. Астана\r\nРеспублика Казахстан\r\n\r\nмоб. тел.: +7 705 157 3452\r\nigorsvitovyj@gmail.com	\N	\N	2026-04-27 03:03:56.296726+00	2026-04-27 03:03:56.289+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1052.2448667585138!2d71.44718384107685!3d51.15135948322764!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4245815c153a4e35%3A0xafc1eb86ca018a3!2z0KPQutGA0LDQuNC90YHQutCw0Y8g0LPRgNC10LrQvtC60LDRgtC-0LvQuNGH0LXRgdC60LDRjyDRhtC10YDQutC-0LLRjA!5e0!3m2!1sru!2skz!4v1775460254645!5m2!1sru!2skz
a85b8ad7-1431-4589-a283-b0773879f16c	3	https://static.wixstatic.com/media/c3aa9c_7e9db7a0a5ad4f56b54d020adb276831~mv2.jpg/v1/fill/w_980,h_667,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_7e9db7a0a5ad4f56b54d020adb276831~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_e585bb44a37a4ec48577b5d0f55a8773~mv2.jpg/v1/fill/w_716,h_720,al_c,q_85,enc_avif,quality_auto/c3aa9c_e585bb44a37a4ec48577b5d0f55a8773~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%BF%D0%B0%D0%B2%D0%BB%D0%BE%D0%B4%D0%B0%D1%80	Павлодар	Павлодар	\N	\N	Греко-католический Приход Святых Верховных Апостолов Петра И Павла	Греко-католицька парафія Святих Верховних Апостолів Петра І Павла	\N	\N	ул. Елгина, 13\r\nг. Павлодар\r\nРеспублика Казахстан	вул. Елгина, 13\r\nм. Павлодар	\N	\N	о. Ярослав Головчук	о. Ярослав Головчук	\N	\N	тел: +7 (7182) 33 58 91\r\nмоб. тел.: +7 7710420001\r\nE-mail: yaroslav.golovchuk@gmail.com\r\nSkype: pater_jaroslav	тел: +7 (7182) 33 58 91\r\nмоб. тел.: +7 7710420001\r\nE-mail: yaroslav.golovchuk@gmail.com\r\nSkype: pater_jaroslav	\N	\N	2026-04-27 03:05:07.857786+00	2026-04-27 03:05:07.847+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d512.9577579383!2d76.9871880098277!3d52.29690951782679!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x42f9cb26b1b5ef8d%3A0x9683906deab5bc58!2z0KPQutGA0LDQuNC90YHQutCw0Y8g0JPRgNC10LrQvi3QmtCw0YLQvtC70LjRh9C10YHQutCw0Y8g0KbQtdGA0LrQvtCy0Yw!5e0!3m2!1sru!2skz!4v1775460871977!5m2!1sru!2skz
962f4afe-b211-4b3c-b55d-d4f77f202136	5	https://static.wixstatic.com/media/c3aa9c_7a65924f00a74df79cee59e89d701f79~mv2.jpeg/v1/fill/w_980,h_955,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_7a65924f00a74df79cee59e89d701f79~mv2.jpeg	https://static.wixstatic.com/media/c3aa9c_d11bb6b0026d4d868162891760163b62~mv2.jpg/v1/fill/w_565,h_509,al_c,q_80,enc_avif,quality_auto/c3aa9c_d11bb6b0026d4d868162891760163b62~mv2.jpg	https://www.ugcc-kazakhstan.com/%D1%88%D0%B8%D0%B4%D0%B5%D1%80%D1%82%D1%8B	Шидерты	Шидерти	\N	\N	Греко-католический Приход Рождества Пресвятой Богородицы В Шидерты	Греко-католицька Парафія Різдва Пресвятої Богородиці У Шидерти	\N	\N	ул. Школьная 10 пос. Шидерты, г. Экибастуз, Павлодарская обл.	вул. Шкільна 10 сел. Шидерти, м. Екібастуз, Павлодарська обл.	\N	\N	о. Александр Адоменас	о. Олександр Адоменас	\N	\N	моб. тел.: +7 776 418 33 42\r\n\r\nE-mail: shidertyhram@gmail.com\\	\N	\N	\N	2026-04-27 03:07:57.308145+00	2026-04-27 03:07:57.298+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d904.3039864258567!2d74.67875152617258!3d51.714963000096425!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x42575f441b676f7b%3A0xb287287e13265824!2zMTQwMDAwINCo0LjQtNC10YDRgtGL!5e1!3m2!1sru!2skz!4v1775461621576!5m2!1sru!2skz
e7ca9d6f-a400-4f03-afd3-92cb4aacd237	4	https://static.wixstatic.com/media/c3aa9c_c07c9a0f5de648ecbd9d4a9b0ad39385~mv2.jpg/v1/fill/w_980,h_667,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_c07c9a0f5de648ecbd9d4a9b0ad39385~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_c20e4d340fa748a2bd6ade927cb9295a~mv2.jpg/v1/fill/w_953,h_918,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_c20e4d340fa748a2bd6ade927cb9295a~mv2.jpg	https://www.ugcc-kazakhstan.com/%D1%81%D0%B0%D1%82%D0%BF%D0%B0%D0%B5%D0%B2	Сатпаев	Сатпаєв	\N	\N	Греко-католический Приход Святого Пророка Илии В Сатпаеве	Греко-католицька парафія Святого Пророка Іллі У Сатпаєві	\N	\N	ул. Абая Кунанбаева, дом 5/5, кв. 46\r\n200003 г. Сатпаев, обл. Ұлытау\r\nРеспублика Казахстан	вул. Абая Кунанбаева, буд. 5/5, кв. 46\r\n200003 г. Сатпаев, обл. Ұлытау\r\nРеспублiка Казахстан	\N	\N	о. Андрей Недоступ	о. Андрій Недоступ	\N	\N	моб. тел.: +7 771 6998 89\r\nмоб. тел.: +7 771 6998 893\r\nE-mail: andrij235@gmail.com	\N	\N	\N	2026-04-27 03:06:04.464551+00	2026-04-27 03:06:04.454+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d822.7568086992751!2d67.51845277903818!3d47.90518283695162!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x423d650696f80ea7%3A0x2a3a3aa9a3296d07!2zNSwg0YPQu9C40YbQsCDQkNCx0LDRjyA1LCDQodCw0YLQv9Cw0LXQsiAxMDAwMDA!5e1!3m2!1sru!2skz!4v1775461282816!5m2!1sru!2skz
\.


--
-- Data for Name: liturgical_event_extra_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_event_extra_fields (id, event_id, sort_idx, label_ru, label_uk, label_kk, label_en, body_ru, body_uk, body_kk, body_en, url, created_at) FROM stdin;
\.


--
-- Data for Name: liturgical_event_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_event_i18n (event_id, lang, title, explanation, prayer) FROM stdin;
93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
e53b9cdc-14bb-44eb-b5a5-5a1d6f1efead	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
e53b9cdc-14bb-44eb-b5a5-5a1d6f1efead	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
e53b9cdc-14bb-44eb-b5a5-5a1d6f1efead	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
e53b9cdc-14bb-44eb-b5a5-5a1d6f1efead	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
f28bf325-7d1b-4b78-874b-c4ac4607041f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
f28bf325-7d1b-4b78-874b-c4ac4607041f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
f28bf325-7d1b-4b78-874b-c4ac4607041f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
f28bf325-7d1b-4b78-874b-c4ac4607041f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
21efdd5a-1928-4713-a794-dbca9f5678fd	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
21efdd5a-1928-4713-a794-dbca9f5678fd	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
21efdd5a-1928-4713-a794-dbca9f5678fd	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
21efdd5a-1928-4713-a794-dbca9f5678fd	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
d0338bea-692b-458f-88de-a61f90b2b2a8	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
d0338bea-692b-458f-88de-a61f90b2b2a8	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
d0338bea-692b-458f-88de-a61f90b2b2a8	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
d0338bea-692b-458f-88de-a61f90b2b2a8	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
7ea65915-b69a-4cf8-b058-a6eeacc8e48d	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
7ea65915-b69a-4cf8-b058-a6eeacc8e48d	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
7ea65915-b69a-4cf8-b058-a6eeacc8e48d	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
7ea65915-b69a-4cf8-b058-a6eeacc8e48d	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
a666a14f-652c-4a3d-b2a2-f43e042d7654	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
a666a14f-652c-4a3d-b2a2-f43e042d7654	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
a666a14f-652c-4a3d-b2a2-f43e042d7654	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
a666a14f-652c-4a3d-b2a2-f43e042d7654	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
a37b0e5a-9192-4ccc-96d4-7455a37acd66	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
a37b0e5a-9192-4ccc-96d4-7455a37acd66	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
a37b0e5a-9192-4ccc-96d4-7455a37acd66	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
a37b0e5a-9192-4ccc-96d4-7455a37acd66	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
3b58903f-9f55-4706-8be8-6335cb47429c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
3b58903f-9f55-4706-8be8-6335cb47429c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
3b58903f-9f55-4706-8be8-6335cb47429c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
3b58903f-9f55-4706-8be8-6335cb47429c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
db5085cb-e641-4a90-9dcb-ac6957655e8c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
db5085cb-e641-4a90-9dcb-ac6957655e8c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
db5085cb-e641-4a90-9dcb-ac6957655e8c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
db5085cb-e641-4a90-9dcb-ac6957655e8c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
6e76975b-bfdf-4d44-b3dc-3eaa41b0a4e0	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
6e76975b-bfdf-4d44-b3dc-3eaa41b0a4e0	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
6e76975b-bfdf-4d44-b3dc-3eaa41b0a4e0	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
6e76975b-bfdf-4d44-b3dc-3eaa41b0a4e0	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b12d1b57-61b0-4049-a037-a8698826fb96	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b12d1b57-61b0-4049-a037-a8698826fb96	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b12d1b57-61b0-4049-a037-a8698826fb96	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b12d1b57-61b0-4049-a037-a8698826fb96	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
45357961-838e-490e-83ff-25fac5dc95f9	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
45357961-838e-490e-83ff-25fac5dc95f9	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
45357961-838e-490e-83ff-25fac5dc95f9	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
45357961-838e-490e-83ff-25fac5dc95f9	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
c9fdf727-ba37-4fa5-a610-ab97edd81208	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
c9fdf727-ba37-4fa5-a610-ab97edd81208	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
c9fdf727-ba37-4fa5-a610-ab97edd81208	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
c9fdf727-ba37-4fa5-a610-ab97edd81208	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
28615d56-9121-4a3e-936c-8da1a047fd75	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
28615d56-9121-4a3e-936c-8da1a047fd75	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
28615d56-9121-4a3e-936c-8da1a047fd75	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
07a315b5-8efc-4760-86de-24932a66cc7e	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
9656af5a-5191-4a1d-85bd-41277d00ad61	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
67010422-b527-4a27-9285-536b723aa5aa	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
53d9fd88-307e-40ad-b091-d77747700268	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
91a687cf-5d27-4299-b198-2945bf28564e	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
1afd6dc9-1033-44fb-bf85-b958fb22d9db	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
1e48a217-d268-4c82-960c-2b4a781aefeb	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
f07da120-1c4e-4e7b-8f92-4b624b5bf1df	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
1a7ec6df-b1ed-43ab-9a79-417830e78b14	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
f096a075-fb3b-43ca-9b3d-fd2dfcb65546	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
555d6d75-9a6e-47ef-a660-ce733f7ef1dd	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b89b6fce-1583-40b3-a633-a9718fabab6b	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
6da2ee67-b5c2-4c1b-9626-a5d6b677f3c7	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
2c2d4dce-a34a-4fe4-83df-214529f3fc22	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
6e40f9de-9d1e-4112-b0d6-41cc742e2b6f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
4c212ae6-498d-4a41-bdb6-b231b2ec6b45	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
114c2584-52c7-4ae6-966d-a0a9e881e182	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5f80834d-c21e-43cc-a983-8835dc92dc88	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5e233dfa-9b64-48e1-b966-dc492bb1ec6f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
8e2e58de-9490-4f43-9f5d-99b2650082f9	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
ebe1db42-3d6b-4c7d-8300-a58f24eb9f8e	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
199edcef-faa5-4489-95a1-bcaa15c7cc96	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b214501e-8b38-4303-833c-6b2eb3478353	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
bbffa017-3087-42a7-8515-f88cdf51504c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
030d40be-3df9-4aa3-bc0f-0fc7cbbb71c6	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
496c011a-2bdd-428e-aa14-196c581cd861	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
54a5dc28-252f-4891-bcfb-600ee7be6b21	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
d073eed0-3bf5-441b-94f0-ae408af62a8b	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
48e1cc43-7f7f-42e3-b985-da43f31366fa	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5a5bec8a-85ec-485b-a018-c229ae6ab4e6	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
663aea2b-ad40-424c-9d5c-af166df392c7	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5e66a1fd-9805-4a76-a8b1-3ebfd3c9936c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
630f3994-1f25-4cc7-9642-74130fcf57a6	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
4f391c79-a9de-46e7-91b8-58cd6c2041c4	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
bb0d4ceb-095a-447b-b71f-b6e9917a3a15	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
e25a184d-3352-4bfa-a6c2-589d01e53c13	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
a893e570-ebc1-48a2-80ef-f245f242b287	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
0db86f8b-896a-4bb5-96bd-2426ba483d3c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
af87e312-59b9-4532-ba51-8f7b83c025d9	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
387b5e46-e6d0-4c26-907b-bf7872379559	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
e6c79e2a-e6a3-47ea-9b6f-9554b4ac4249	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
27875cda-c7c7-4ec0-9dd5-c17000c210f4	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
3264b5ea-b5e6-4cce-bcd3-745c939c1337	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
4e3cd54b-5f83-42d0-863f-d99096e13bbb	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
377d23dd-9901-490e-b7a1-98de98d452fd	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
a8e36c2b-4f3c-40ea-80b1-3f508f5185ad	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
c4b1751d-6cd1-4035-ba63-d18030fdc66d	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
917086ae-e00e-45d0-8e19-766ac1b2c21f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b7e99bf4-3fd2-4e73-84d6-9001b318ab10	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
28615d56-9121-4a3e-936c-8da1a047fd75	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
07a315b5-8efc-4760-86de-24932a66cc7e	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
67010422-b527-4a27-9285-536b723aa5aa	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
45f034f5-20d0-42bc-93db-fa58bebc7ff5	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
53d9fd88-307e-40ad-b091-d77747700268	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
91a687cf-5d27-4299-b198-2945bf28564e	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
1e48a217-d268-4c82-960c-2b4a781aefeb	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
ac7f0579-42d6-405f-993b-f672952037b7	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
f07da120-1c4e-4e7b-8f92-4b624b5bf1df	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
1a7ec6df-b1ed-43ab-9a79-417830e78b14	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
555d6d75-9a6e-47ef-a660-ce733f7ef1dd	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
f8523210-942b-4ee7-9e62-783752ce850f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b89b6fce-1583-40b3-a633-a9718fabab6b	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
6da2ee67-b5c2-4c1b-9626-a5d6b677f3c7	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
6e40f9de-9d1e-4112-b0d6-41cc742e2b6f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
fd2493a3-575a-4694-8bc0-27fefc1aa33a	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
4c212ae6-498d-4a41-bdb6-b231b2ec6b45	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
114c2584-52c7-4ae6-966d-a0a9e881e182	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5e233dfa-9b64-48e1-b966-dc492bb1ec6f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
8846fc8a-4d35-4baf-b8c9-9d4b15789382	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
8e2e58de-9490-4f43-9f5d-99b2650082f9	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
ebe1db42-3d6b-4c7d-8300-a58f24eb9f8e	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b214501e-8b38-4303-833c-6b2eb3478353	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
a64cd965-24c9-4d3f-a0f1-4e3db491237e	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
bbffa017-3087-42a7-8515-f88cdf51504c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
030d40be-3df9-4aa3-bc0f-0fc7cbbb71c6	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
54a5dc28-252f-4891-bcfb-600ee7be6b21	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
90b7a5aa-1fed-4920-a375-040a45020519	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
d073eed0-3bf5-441b-94f0-ae408af62a8b	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
48e1cc43-7f7f-42e3-b985-da43f31366fa	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
663aea2b-ad40-424c-9d5c-af166df392c7	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b044a59d-adc0-4b4a-91db-733e529e95a1	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5e66a1fd-9805-4a76-a8b1-3ebfd3c9936c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
630f3994-1f25-4cc7-9642-74130fcf57a6	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
bb0d4ceb-095a-447b-b71f-b6e9917a3a15	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5204c174-582c-44e8-8caa-5fab2947f111	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
e25a184d-3352-4bfa-a6c2-589d01e53c13	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
a893e570-ebc1-48a2-80ef-f245f242b287	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
af87e312-59b9-4532-ba51-8f7b83c025d9	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
2ac2ca9c-f28f-4a11-b905-18cee39b8e08	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
387b5e46-e6d0-4c26-907b-bf7872379559	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
e6c79e2a-e6a3-47ea-9b6f-9554b4ac4249	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
3264b5ea-b5e6-4cce-bcd3-745c939c1337	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
432e71d0-52aa-4b75-a1db-cb398bf8ef29	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
4e3cd54b-5f83-42d0-863f-d99096e13bbb	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
377d23dd-9901-490e-b7a1-98de98d452fd	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
c4b1751d-6cd1-4035-ba63-d18030fdc66d	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
f8c8d22e-e105-4143-9b54-ad920b050bad	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
917086ae-e00e-45d0-8e19-766ac1b2c21f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b7e99bf4-3fd2-4e73-84d6-9001b318ab10	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
07a315b5-8efc-4760-86de-24932a66cc7e	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
3155c5c7-41ec-4575-9f66-f2eb4cf695e7	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
67010422-b527-4a27-9285-536b723aa5aa	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
45f034f5-20d0-42bc-93db-fa58bebc7ff5	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
91a687cf-5d27-4299-b198-2945bf28564e	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
88475cd5-9763-46ff-9c2c-0035a7bc1a66	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
1e48a217-d268-4c82-960c-2b4a781aefeb	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
ac7f0579-42d6-405f-993b-f672952037b7	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
1a7ec6df-b1ed-43ab-9a79-417830e78b14	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
ccad87d1-44e6-43c4-a6bb-d65f3c6b5311	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
555d6d75-9a6e-47ef-a660-ce733f7ef1dd	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
f8523210-942b-4ee7-9e62-783752ce850f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
6da2ee67-b5c2-4c1b-9626-a5d6b677f3c7	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
e04bb3ec-f961-4cc1-80e1-eb00fd5961f9	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
6e40f9de-9d1e-4112-b0d6-41cc742e2b6f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
fd2493a3-575a-4694-8bc0-27fefc1aa33a	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
114c2584-52c7-4ae6-966d-a0a9e881e182	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b20908fe-1fbc-4d3d-8490-fa7b0d74457c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5e233dfa-9b64-48e1-b966-dc492bb1ec6f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
8846fc8a-4d35-4baf-b8c9-9d4b15789382	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
ebe1db42-3d6b-4c7d-8300-a58f24eb9f8e	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b70ae3d7-3f82-4af1-8093-29c14de7b38a	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b214501e-8b38-4303-833c-6b2eb3478353	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
a64cd965-24c9-4d3f-a0f1-4e3db491237e	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
030d40be-3df9-4aa3-bc0f-0fc7cbbb71c6	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
7b606172-a2ed-405f-872d-bad4dcc86495	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
54a5dc28-252f-4891-bcfb-600ee7be6b21	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
90b7a5aa-1fed-4920-a375-040a45020519	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
48e1cc43-7f7f-42e3-b985-da43f31366fa	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
61bc72de-bd57-4b7c-ac36-dcf92b3c6017	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
663aea2b-ad40-424c-9d5c-af166df392c7	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b044a59d-adc0-4b4a-91db-733e529e95a1	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
630f3994-1f25-4cc7-9642-74130fcf57a6	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
9cf72ad7-415c-436a-ab81-84d52078ddbb	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
bb0d4ceb-095a-447b-b71f-b6e9917a3a15	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5204c174-582c-44e8-8caa-5fab2947f111	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
a893e570-ebc1-48a2-80ef-f245f242b287	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
23b53e4a-0f16-4d08-ae8a-7497e1fd8a80	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
af87e312-59b9-4532-ba51-8f7b83c025d9	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
2ac2ca9c-f28f-4a11-b905-18cee39b8e08	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
e6c79e2a-e6a3-47ea-9b6f-9554b4ac4249	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
29fb3a2e-9903-437d-afb7-ffff5a3a1acd	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
3264b5ea-b5e6-4cce-bcd3-745c939c1337	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
432e71d0-52aa-4b75-a1db-cb398bf8ef29	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
377d23dd-9901-490e-b7a1-98de98d452fd	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
0856f63a-7ae5-41f1-a616-62c8c7f7fb3d	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
c4b1751d-6cd1-4035-ba63-d18030fdc66d	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
f8c8d22e-e105-4143-9b54-ad920b050bad	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b7e99bf4-3fd2-4e73-84d6-9001b318ab10	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
07a315b5-8efc-4760-86de-24932a66cc7e	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
3155c5c7-41ec-4575-9f66-f2eb4cf695e7	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
45f034f5-20d0-42bc-93db-fa58bebc7ff5	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
538749c7-dbe4-47c4-ba03-ba90677d4677	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
91a687cf-5d27-4299-b198-2945bf28564e	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
88475cd5-9763-46ff-9c2c-0035a7bc1a66	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
ac7f0579-42d6-405f-993b-f672952037b7	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
6addc00e-f4eb-450f-8121-983aad12c5b5	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
1a7ec6df-b1ed-43ab-9a79-417830e78b14	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
ccad87d1-44e6-43c4-a6bb-d65f3c6b5311	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
f8523210-942b-4ee7-9e62-783752ce850f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
16771a87-92d2-449b-9400-2c32991c1be2	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
6da2ee67-b5c2-4c1b-9626-a5d6b677f3c7	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
e04bb3ec-f961-4cc1-80e1-eb00fd5961f9	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
fd2493a3-575a-4694-8bc0-27fefc1aa33a	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
2b58c8e7-5904-4820-85f2-228cc107ba1f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
114c2584-52c7-4ae6-966d-a0a9e881e182	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b20908fe-1fbc-4d3d-8490-fa7b0d74457c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
8846fc8a-4d35-4baf-b8c9-9d4b15789382	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
274901fd-2abf-446c-aa7f-39c3a90b542e	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
ebe1db42-3d6b-4c7d-8300-a58f24eb9f8e	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b70ae3d7-3f82-4af1-8093-29c14de7b38a	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
a64cd965-24c9-4d3f-a0f1-4e3db491237e	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
46bd1a4d-9cb7-404c-9393-444aff634106	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
030d40be-3df9-4aa3-bc0f-0fc7cbbb71c6	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
7b606172-a2ed-405f-872d-bad4dcc86495	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
90b7a5aa-1fed-4920-a375-040a45020519	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
475a6c48-6689-4248-a0c5-4e03484134fb	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
48e1cc43-7f7f-42e3-b985-da43f31366fa	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
61bc72de-bd57-4b7c-ac36-dcf92b3c6017	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b044a59d-adc0-4b4a-91db-733e529e95a1	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
e6ff7dcd-6560-461e-98c2-d9099077bd24	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
630f3994-1f25-4cc7-9642-74130fcf57a6	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
9cf72ad7-415c-436a-ab81-84d52078ddbb	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5204c174-582c-44e8-8caa-5fab2947f111	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5af31c6f-d173-4664-92f1-bcb16d0b9e70	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
a893e570-ebc1-48a2-80ef-f245f242b287	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
23b53e4a-0f16-4d08-ae8a-7497e1fd8a80	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
2ac2ca9c-f28f-4a11-b905-18cee39b8e08	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
06009d87-ef76-48d9-a491-d070d8ce4e97	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
e6c79e2a-e6a3-47ea-9b6f-9554b4ac4249	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
29fb3a2e-9903-437d-afb7-ffff5a3a1acd	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
432e71d0-52aa-4b75-a1db-cb398bf8ef29	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
c6c53472-a06f-4a4c-ae3c-6795f17b981c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
377d23dd-9901-490e-b7a1-98de98d452fd	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
0856f63a-7ae5-41f1-a616-62c8c7f7fb3d	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
f8c8d22e-e105-4143-9b54-ad920b050bad	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
21d9dca4-8c11-4b83-b16a-9e7729fd76f3	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b7e99bf4-3fd2-4e73-84d6-9001b318ab10	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
3155c5c7-41ec-4575-9f66-f2eb4cf695e7	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
9656af5a-5191-4a1d-85bd-41277d00ad61	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
45f034f5-20d0-42bc-93db-fa58bebc7ff5	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
538749c7-dbe4-47c4-ba03-ba90677d4677	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
88475cd5-9763-46ff-9c2c-0035a7bc1a66	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
1afd6dc9-1033-44fb-bf85-b958fb22d9db	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
ac7f0579-42d6-405f-993b-f672952037b7	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
6addc00e-f4eb-450f-8121-983aad12c5b5	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
ccad87d1-44e6-43c4-a6bb-d65f3c6b5311	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
f096a075-fb3b-43ca-9b3d-fd2dfcb65546	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
f8523210-942b-4ee7-9e62-783752ce850f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
16771a87-92d2-449b-9400-2c32991c1be2	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
e04bb3ec-f961-4cc1-80e1-eb00fd5961f9	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
2c2d4dce-a34a-4fe4-83df-214529f3fc22	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
fd2493a3-575a-4694-8bc0-27fefc1aa33a	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
2b58c8e7-5904-4820-85f2-228cc107ba1f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b20908fe-1fbc-4d3d-8490-fa7b0d74457c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5f80834d-c21e-43cc-a983-8835dc92dc88	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
8846fc8a-4d35-4baf-b8c9-9d4b15789382	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
274901fd-2abf-446c-aa7f-39c3a90b542e	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
b70ae3d7-3f82-4af1-8093-29c14de7b38a	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
199edcef-faa5-4489-95a1-bcaa15c7cc96	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
a64cd965-24c9-4d3f-a0f1-4e3db491237e	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
46bd1a4d-9cb7-404c-9393-444aff634106	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
7b606172-a2ed-405f-872d-bad4dcc86495	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
496c011a-2bdd-428e-aa14-196c581cd861	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
90b7a5aa-1fed-4920-a375-040a45020519	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
475a6c48-6689-4248-a0c5-4e03484134fb	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
61bc72de-bd57-4b7c-ac36-dcf92b3c6017	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5a5bec8a-85ec-485b-a018-c229ae6ab4e6	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b044a59d-adc0-4b4a-91db-733e529e95a1	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
e6ff7dcd-6560-461e-98c2-d9099077bd24	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
9cf72ad7-415c-436a-ab81-84d52078ddbb	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
4f391c79-a9de-46e7-91b8-58cd6c2041c4	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5204c174-582c-44e8-8caa-5fab2947f111	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5af31c6f-d173-4664-92f1-bcb16d0b9e70	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
23b53e4a-0f16-4d08-ae8a-7497e1fd8a80	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
0db86f8b-896a-4bb5-96bd-2426ba483d3c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
2ac2ca9c-f28f-4a11-b905-18cee39b8e08	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
06009d87-ef76-48d9-a491-d070d8ce4e97	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
29fb3a2e-9903-437d-afb7-ffff5a3a1acd	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
27875cda-c7c7-4ec0-9dd5-c17000c210f4	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
432e71d0-52aa-4b75-a1db-cb398bf8ef29	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
c6c53472-a06f-4a4c-ae3c-6795f17b981c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
0856f63a-7ae5-41f1-a616-62c8c7f7fb3d	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
a8e36c2b-4f3c-40ea-80b1-3f508f5185ad	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
f8c8d22e-e105-4143-9b54-ad920b050bad	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
21d9dca4-8c11-4b83-b16a-9e7729fd76f3	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
3155c5c7-41ec-4575-9f66-f2eb4cf695e7	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
9656af5a-5191-4a1d-85bd-41277d00ad61	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
538749c7-dbe4-47c4-ba03-ba90677d4677	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
53d9fd88-307e-40ad-b091-d77747700268	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
88475cd5-9763-46ff-9c2c-0035a7bc1a66	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
1afd6dc9-1033-44fb-bf85-b958fb22d9db	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
6addc00e-f4eb-450f-8121-983aad12c5b5	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
f07da120-1c4e-4e7b-8f92-4b624b5bf1df	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
ccad87d1-44e6-43c4-a6bb-d65f3c6b5311	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
f096a075-fb3b-43ca-9b3d-fd2dfcb65546	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
16771a87-92d2-449b-9400-2c32991c1be2	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b89b6fce-1583-40b3-a633-a9718fabab6b	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
e04bb3ec-f961-4cc1-80e1-eb00fd5961f9	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
2c2d4dce-a34a-4fe4-83df-214529f3fc22	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
2b58c8e7-5904-4820-85f2-228cc107ba1f	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
4c212ae6-498d-4a41-bdb6-b231b2ec6b45	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b20908fe-1fbc-4d3d-8490-fa7b0d74457c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5f80834d-c21e-43cc-a983-8835dc92dc88	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
274901fd-2abf-446c-aa7f-39c3a90b542e	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
8e2e58de-9490-4f43-9f5d-99b2650082f9	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
b70ae3d7-3f82-4af1-8093-29c14de7b38a	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
199edcef-faa5-4489-95a1-bcaa15c7cc96	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
46bd1a4d-9cb7-404c-9393-444aff634106	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
bbffa017-3087-42a7-8515-f88cdf51504c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
7b606172-a2ed-405f-872d-bad4dcc86495	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
496c011a-2bdd-428e-aa14-196c581cd861	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
475a6c48-6689-4248-a0c5-4e03484134fb	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
d073eed0-3bf5-441b-94f0-ae408af62a8b	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
61bc72de-bd57-4b7c-ac36-dcf92b3c6017	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5a5bec8a-85ec-485b-a018-c229ae6ab4e6	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
e6ff7dcd-6560-461e-98c2-d9099077bd24	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5e66a1fd-9805-4a76-a8b1-3ebfd3c9936c	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
9cf72ad7-415c-436a-ab81-84d52078ddbb	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
4f391c79-a9de-46e7-91b8-58cd6c2041c4	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5af31c6f-d173-4664-92f1-bcb16d0b9e70	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
e25a184d-3352-4bfa-a6c2-589d01e53c13	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
23b53e4a-0f16-4d08-ae8a-7497e1fd8a80	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
0db86f8b-896a-4bb5-96bd-2426ba483d3c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
06009d87-ef76-48d9-a491-d070d8ce4e97	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
387b5e46-e6d0-4c26-907b-bf7872379559	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
29fb3a2e-9903-437d-afb7-ffff5a3a1acd	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
27875cda-c7c7-4ec0-9dd5-c17000c210f4	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
c6c53472-a06f-4a4c-ae3c-6795f17b981c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
4e3cd54b-5f83-42d0-863f-d99096e13bbb	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
0856f63a-7ae5-41f1-a616-62c8c7f7fb3d	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
a8e36c2b-4f3c-40ea-80b1-3f508f5185ad	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
21d9dca4-8c11-4b83-b16a-9e7729fd76f3	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
917086ae-e00e-45d0-8e19-766ac1b2c21f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
9656af5a-5191-4a1d-85bd-41277d00ad61	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
67010422-b527-4a27-9285-536b723aa5aa	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
538749c7-dbe4-47c4-ba03-ba90677d4677	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
53d9fd88-307e-40ad-b091-d77747700268	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
1afd6dc9-1033-44fb-bf85-b958fb22d9db	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
1e48a217-d268-4c82-960c-2b4a781aefeb	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
6addc00e-f4eb-450f-8121-983aad12c5b5	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
f07da120-1c4e-4e7b-8f92-4b624b5bf1df	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
f096a075-fb3b-43ca-9b3d-fd2dfcb65546	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
555d6d75-9a6e-47ef-a660-ce733f7ef1dd	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
16771a87-92d2-449b-9400-2c32991c1be2	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
b89b6fce-1583-40b3-a633-a9718fabab6b	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
2c2d4dce-a34a-4fe4-83df-214529f3fc22	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
6e40f9de-9d1e-4112-b0d6-41cc742e2b6f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
2b58c8e7-5904-4820-85f2-228cc107ba1f	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
4c212ae6-498d-4a41-bdb6-b231b2ec6b45	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5f80834d-c21e-43cc-a983-8835dc92dc88	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
5e233dfa-9b64-48e1-b966-dc492bb1ec6f	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
274901fd-2abf-446c-aa7f-39c3a90b542e	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
8e2e58de-9490-4f43-9f5d-99b2650082f9	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
199edcef-faa5-4489-95a1-bcaa15c7cc96	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
b214501e-8b38-4303-833c-6b2eb3478353	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
46bd1a4d-9cb7-404c-9393-444aff634106	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
bbffa017-3087-42a7-8515-f88cdf51504c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
496c011a-2bdd-428e-aa14-196c581cd861	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
54a5dc28-252f-4891-bcfb-600ee7be6b21	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
475a6c48-6689-4248-a0c5-4e03484134fb	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
d073eed0-3bf5-441b-94f0-ae408af62a8b	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
5a5bec8a-85ec-485b-a018-c229ae6ab4e6	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
663aea2b-ad40-424c-9d5c-af166df392c7	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
e6ff7dcd-6560-461e-98c2-d9099077bd24	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
5e66a1fd-9805-4a76-a8b1-3ebfd3c9936c	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
4f391c79-a9de-46e7-91b8-58cd6c2041c4	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
bb0d4ceb-095a-447b-b71f-b6e9917a3a15	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
5af31c6f-d173-4664-92f1-bcb16d0b9e70	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
e25a184d-3352-4bfa-a6c2-589d01e53c13	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
0db86f8b-896a-4bb5-96bd-2426ba483d3c	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
af87e312-59b9-4532-ba51-8f7b83c025d9	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
06009d87-ef76-48d9-a491-d070d8ce4e97	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
387b5e46-e6d0-4c26-907b-bf7872379559	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
27875cda-c7c7-4ec0-9dd5-c17000c210f4	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
3264b5ea-b5e6-4cce-bcd3-745c939c1337	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
c6c53472-a06f-4a4c-ae3c-6795f17b981c	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
4e3cd54b-5f83-42d0-863f-d99096e13bbb	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
a8e36c2b-4f3c-40ea-80b1-3f508f5185ad	kk	Жексенбілік Құдайлық Литургия	13:00 Құдайлық Литургия	\N
c4b1751d-6cd1-4035-ba63-d18030fdc66d	uk	Недільна Божественна літургія	13:00 Божественна літургія	\N
21d9dca4-8c11-4b83-b16a-9e7729fd76f3	en	Sunday Divine Liturgy	1:00 PM Divine Liturgy	\N
917086ae-e00e-45d0-8e19-766ac1b2c21f	ru	Воскресная Божественная литургия	13:00 Божественная литургия	\N
9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	uk	Велика П'ятниця	19:30 годин — Вечірня з винесенням Плащаниці!	\N
9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	ru	Большая Пятница	19:30 - Вечерняя с выносом Плащаницы!	\N
9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	kk	Қасиетті жұма:	Сағат 19:30 - Кебенді алып тастаумен кешкі ас!	\N
9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	en	Good Friday:	7:30 PM - Vespers with the Removal of the Shroud!	\N
39185d5a-952f-4251-96a3-5bb457078e9a	uk	Неділя Пасхи	Неділя Пасхи. Воскресення Христове. Великдень.	\N
39185d5a-952f-4251-96a3-5bb457078e9a	ru	Пасхальное воскресенье	Воскресенье Пасхи. Воскресение Христово. Пасха.	\N
39185d5a-952f-4251-96a3-5bb457078e9a	kk	Пасха жексенбісі	Пасха жексенбісі. Мәсіхтің қайта тірілуі. Пасха.	\N
39185d5a-952f-4251-96a3-5bb457078e9a	en	Easter Sunday	Easter Sunday. Resurrection of Christ. Easter.	\N
19974533-e0a6-4490-93fd-9baf950b39f1	uk	Пасхальні богослужіння на Воскресіння Христове (Пасха):	20:00 годин - Надгробне. Обхід. Стихири Пасхи;\r\n\r\n20:30 годин — Божественна Літургія Св. Івана Золотоустого.\r\n\r\nОпісля Літургії:\r\n- благословення пасок.	\N
19974533-e0a6-4490-93fd-9baf950b39f1	ru	Пасхальные богослужения на Воскресение Христово (Пасха):	20:00 часов – Надгробное. Обход. Стихиры Пасхи;\r\n\r\n20:30 часов - Божественная Литургия Св. Иоанна Златоуста.\r\n\r\nПосле Литургии:\r\n- благословение куличей.	\N
19974533-e0a6-4490-93fd-9baf950b39f1	kk	Мәсіхтің қайта тірілуіне арналған Пасха қызметтері (Пасха):	Сағат 20:00 - Жерлеу рәсімі. Шеру. Пасха стикерасы;\r\n\r\nСағат 20:30 - Әулие Иоанн Хризостомның құдайлық литургиясы.\r\n\r\nЛитургиядан кейін:\r\n- Пасха торттарына бата беру.	\N
19974533-e0a6-4490-93fd-9baf950b39f1	en	Easter Services for the Resurrection of Christ (Easter):	8:00 PM - Funeral. Procession. Paschal Stichera;\r\n\r\n8:30 PM - Divine Liturgy of St. John Chrysostom.\r\n\r\nAfter the Liturgy:\r\n- Blessing of the Easter Cakes.	\N
\.


--
-- Data for Name: liturgical_event_template_rows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_event_template_rows (id, template_id, sort_idx, label_ru, label_uk, label_kk, label_en) FROM stdin;
\.


--
-- Data for Name: liturgical_event_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_event_templates (id, name, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: liturgical_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_events (id, event_date, kind, sort_order, created_at, recurrence_series_id, primary_lang, cover_image_url, gallery_image_urls, created_by) FROM stdin;
93f6a7f5-024e-46a1-bd3e-a00811e0f2d9	2026-04-12	feast	0	2026-04-26 22:00:16.029274+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
e53b9cdc-14bb-44eb-b5a5-5a1d6f1efead	2026-04-19	feast	0	2026-04-26 22:00:16.204693+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
f28bf325-7d1b-4b78-874b-c4ac4607041f	2026-04-26	feast	0	2026-04-26 22:00:16.277118+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
21efdd5a-1928-4713-a794-dbca9f5678fd	2026-05-03	feast	0	2026-04-26 22:00:16.34592+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
d0338bea-692b-458f-88de-a61f90b2b2a8	2026-05-10	feast	0	2026-04-26 22:00:16.40677+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
7ea65915-b69a-4cf8-b058-a6eeacc8e48d	2026-05-17	feast	0	2026-04-26 22:00:16.487175+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
a666a14f-652c-4a3d-b2a2-f43e042d7654	2026-05-24	feast	0	2026-04-26 22:00:16.560785+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
a37b0e5a-9192-4ccc-96d4-7455a37acd66	2026-05-31	feast	0	2026-04-26 22:00:16.623017+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
3b58903f-9f55-4706-8be8-6335cb47429c	2026-06-07	feast	0	2026-04-26 22:00:16.682933+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
db5085cb-e641-4a90-9dcb-ac6957655e8c	2026-06-14	feast	0	2026-04-26 22:00:16.740413+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
6e76975b-bfdf-4d44-b3dc-3eaa41b0a4e0	2026-06-21	feast	0	2026-04-26 22:00:16.793479+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b12d1b57-61b0-4049-a037-a8698826fb96	2026-06-28	feast	0	2026-04-26 22:00:16.859075+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
45357961-838e-490e-83ff-25fac5dc95f9	2026-07-05	feast	0	2026-04-26 22:00:16.915678+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
c9fdf727-ba37-4fa5-a610-ab97edd81208	2026-07-12	feast	0	2026-04-26 22:00:16.975152+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
28615d56-9121-4a3e-936c-8da1a047fd75	2026-07-19	feast	0	2026-04-26 22:00:17.038067+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
07a315b5-8efc-4760-86de-24932a66cc7e	2026-07-26	feast	0	2026-04-26 22:00:17.098261+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
3155c5c7-41ec-4575-9f66-f2eb4cf695e7	2026-08-02	feast	0	2026-04-26 22:00:17.15576+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
9656af5a-5191-4a1d-85bd-41277d00ad61	2026-08-09	feast	0	2026-04-26 22:00:17.226724+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
67010422-b527-4a27-9285-536b723aa5aa	2026-08-16	feast	0	2026-04-26 22:00:17.293109+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
45f034f5-20d0-42bc-93db-fa58bebc7ff5	2026-08-23	feast	0	2026-04-26 22:00:17.351535+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
538749c7-dbe4-47c4-ba03-ba90677d4677	2026-08-30	feast	0	2026-04-26 22:00:17.407123+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
53d9fd88-307e-40ad-b091-d77747700268	2026-09-06	feast	0	2026-04-26 22:00:17.468169+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
91a687cf-5d27-4299-b198-2945bf28564e	2026-09-13	feast	0	2026-04-26 22:00:17.526786+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
88475cd5-9763-46ff-9c2c-0035a7bc1a66	2026-09-20	feast	0	2026-04-26 22:00:17.580465+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
1afd6dc9-1033-44fb-bf85-b958fb22d9db	2026-09-27	feast	0	2026-04-26 22:00:17.633689+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
1e48a217-d268-4c82-960c-2b4a781aefeb	2026-10-04	feast	0	2026-04-26 22:00:17.688229+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
ac7f0579-42d6-405f-993b-f672952037b7	2026-10-11	feast	0	2026-04-26 22:00:17.746478+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
6addc00e-f4eb-450f-8121-983aad12c5b5	2026-10-18	feast	0	2026-04-26 22:00:17.80607+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
f07da120-1c4e-4e7b-8f92-4b624b5bf1df	2026-10-25	feast	0	2026-04-26 22:00:17.898383+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
1a7ec6df-b1ed-43ab-9a79-417830e78b14	2026-11-01	feast	0	2026-04-26 22:00:17.960325+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
ccad87d1-44e6-43c4-a6bb-d65f3c6b5311	2026-11-08	feast	0	2026-04-26 22:00:18.020871+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
f096a075-fb3b-43ca-9b3d-fd2dfcb65546	2026-11-15	feast	0	2026-04-26 22:00:18.085328+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
555d6d75-9a6e-47ef-a660-ce733f7ef1dd	2026-11-22	feast	0	2026-04-26 22:00:18.143616+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
f8523210-942b-4ee7-9e62-783752ce850f	2026-11-29	feast	0	2026-04-26 22:00:18.203262+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
16771a87-92d2-449b-9400-2c32991c1be2	2026-12-06	feast	0	2026-04-26 22:00:18.261524+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b89b6fce-1583-40b3-a633-a9718fabab6b	2026-12-13	feast	0	2026-04-26 22:00:18.321299+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
6da2ee67-b5c2-4c1b-9626-a5d6b677f3c7	2026-12-20	feast	0	2026-04-26 22:00:18.376364+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
e04bb3ec-f961-4cc1-80e1-eb00fd5961f9	2026-12-27	feast	0	2026-04-26 22:00:18.431502+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
2c2d4dce-a34a-4fe4-83df-214529f3fc22	2027-01-03	feast	0	2026-04-26 22:00:18.487237+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
6e40f9de-9d1e-4112-b0d6-41cc742e2b6f	2027-01-10	feast	0	2026-04-26 22:00:18.540426+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
fd2493a3-575a-4694-8bc0-27fefc1aa33a	2027-01-17	feast	0	2026-04-26 22:00:18.593621+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
2b58c8e7-5904-4820-85f2-228cc107ba1f	2027-01-24	feast	0	2026-04-26 22:00:18.646949+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5f80834d-c21e-43cc-a983-8835dc92dc88	2027-02-21	feast	0	2026-04-26 22:00:18.881529+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
9aa697ca-76c2-406a-a5b0-1b278aaf9b3c	2026-04-10	other	0	2026-04-26 22:02:32.53361+00	\N	uk	https://upload.wikimedia.org/wikipedia/commons/9/9f/Crucifixion_by_Theophanes_the_Cretan.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
199edcef-faa5-4489-95a1-bcaa15c7cc96	2027-04-11	feast	0	2026-04-26 22:00:19.293381+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
496c011a-2bdd-428e-aa14-196c581cd861	2027-05-30	feast	0	2026-04-26 22:00:19.749182+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5a5bec8a-85ec-485b-a018-c229ae6ab4e6	2027-07-18	feast	0	2026-04-26 22:00:20.156964+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
4f391c79-a9de-46e7-91b8-58cd6c2041c4	2027-09-05	feast	0	2026-04-26 22:00:20.544234+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
0db86f8b-896a-4bb5-96bd-2426ba483d3c	2027-10-24	feast	0	2026-04-26 22:00:20.924919+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
27875cda-c7c7-4ec0-9dd5-c17000c210f4	2027-12-12	feast	0	2026-04-26 22:00:21.32853+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
a8e36c2b-4f3c-40ea-80b1-3f508f5185ad	2028-01-30	feast	0	2026-04-26 22:00:21.720258+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
4c212ae6-498d-4a41-bdb6-b231b2ec6b45	2027-01-31	feast	0	2026-04-26 22:00:18.697958+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5e233dfa-9b64-48e1-b966-dc492bb1ec6f	2027-02-28	feast	0	2026-04-26 22:00:18.93985+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
8e2e58de-9490-4f43-9f5d-99b2650082f9	2027-03-21	feast	0	2026-04-26 22:00:19.120927+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b214501e-8b38-4303-833c-6b2eb3478353	2027-04-18	feast	0	2026-04-26 22:00:19.356303+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
bbffa017-3087-42a7-8515-f88cdf51504c	2027-05-09	feast	0	2026-04-26 22:00:19.515221+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
39185d5a-952f-4251-96a3-5bb457078e9a	2026-04-12	feast	0	2026-04-26 22:03:49.800186+00	\N	uk	https://cerkiew.net.pl/wp-content/uploads/2023/04/0419-1200.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
54a5dc28-252f-4891-bcfb-600ee7be6b21	2027-06-06	feast	0	2026-04-26 22:00:19.804232+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
663aea2b-ad40-424c-9d5c-af166df392c7	2027-07-25	feast	0	2026-04-26 22:00:20.217625+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
bb0d4ceb-095a-447b-b71f-b6e9917a3a15	2027-09-12	feast	0	2026-04-26 22:00:20.596008+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
af87e312-59b9-4532-ba51-8f7b83c025d9	2027-10-31	feast	0	2026-04-26 22:00:20.980355+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
3264b5ea-b5e6-4cce-bcd3-745c939c1337	2027-12-19	feast	0	2026-04-26 22:00:21.382028+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
c4b1751d-6cd1-4035-ba63-d18030fdc66d	2028-02-06	feast	0	2026-04-26 22:00:21.773543+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
114c2584-52c7-4ae6-966d-a0a9e881e182	2027-02-07	feast	0	2026-04-26 22:00:18.758338+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
8846fc8a-4d35-4baf-b8c9-9d4b15789382	2027-03-07	feast	0	2026-04-26 22:00:18.997113+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
ebe1db42-3d6b-4c7d-8300-a58f24eb9f8e	2027-03-28	feast	0	2026-04-26 22:00:19.175381+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
a64cd965-24c9-4d3f-a0f1-4e3db491237e	2027-04-25	feast	0	2026-04-26 22:00:19.410321+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
030d40be-3df9-4aa3-bc0f-0fc7cbbb71c6	2027-05-16	feast	0	2026-04-26 22:00:19.570109+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
90b7a5aa-1fed-4920-a375-040a45020519	2027-06-13	feast	0	2026-04-26 22:00:19.857667+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b044a59d-adc0-4b4a-91db-733e529e95a1	2027-08-01	feast	0	2026-04-26 22:00:20.277517+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
19974533-e0a6-4490-93fd-9baf950b39f1	2026-04-11	other	0	2026-04-27 03:19:35.179035+00	\N	uk	https://mitropolia.kz/images/01_cont/87/903.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5204c174-582c-44e8-8caa-5fab2947f111	2027-09-19	feast	0	2026-04-26 22:00:20.646559+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
2ac2ca9c-f28f-4a11-b905-18cee39b8e08	2027-11-07	feast	0	2026-04-26 22:00:21.034245+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
432e71d0-52aa-4b75-a1db-cb398bf8ef29	2027-12-26	feast	0	2026-04-26 22:00:21.442672+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
f8c8d22e-e105-4143-9b54-ad920b050bad	2028-02-13	feast	0	2026-04-26 22:00:21.828402+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b20908fe-1fbc-4d3d-8490-fa7b0d74457c	2027-02-14	feast	0	2026-04-26 22:00:18.823888+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
274901fd-2abf-446c-aa7f-39c3a90b542e	2027-03-14	feast	0	2026-04-26 22:00:19.061162+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b70ae3d7-3f82-4af1-8093-29c14de7b38a	2027-04-04	feast	0	2026-04-26 22:00:19.237451+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
46bd1a4d-9cb7-404c-9393-444aff634106	2027-05-02	feast	0	2026-04-26 22:00:19.461295+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
475a6c48-6689-4248-a0c5-4e03484134fb	2027-06-20	feast	0	2026-04-26 22:00:19.928806+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
e6ff7dcd-6560-461e-98c2-d9099077bd24	2027-08-08	feast	0	2026-04-26 22:00:20.335433+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5af31c6f-d173-4664-92f1-bcb16d0b9e70	2027-09-26	feast	0	2026-04-26 22:00:20.697959+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
06009d87-ef76-48d9-a491-d070d8ce4e97	2027-11-14	feast	0	2026-04-26 22:00:21.092011+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
c6c53472-a06f-4a4c-ae3c-6795f17b981c	2028-01-02	feast	0	2026-04-26 22:00:21.499425+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
21d9dca4-8c11-4b83-b16a-9e7729fd76f3	2028-02-20	feast	0	2026-04-26 22:00:21.878514+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
7b606172-a2ed-405f-872d-bad4dcc86495	2027-05-23	feast	0	2026-04-26 22:00:19.691086+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
61bc72de-bd57-4b7c-ac36-dcf92b3c6017	2027-07-11	feast	0	2026-04-26 22:00:20.09688+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
9cf72ad7-415c-436a-ab81-84d52078ddbb	2027-08-29	feast	0	2026-04-26 22:00:20.494177+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
23b53e4a-0f16-4d08-ae8a-7497e1fd8a80	2027-10-17	feast	0	2026-04-26 22:00:20.869559+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
29fb3a2e-9903-437d-afb7-ffff5a3a1acd	2027-12-05	feast	0	2026-04-26 22:00:21.273837+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
0856f63a-7ae5-41f1-a616-62c8c7f7fb3d	2028-01-23	feast	0	2026-04-26 22:00:21.666896+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
d073eed0-3bf5-441b-94f0-ae408af62a8b	2027-06-27	feast	0	2026-04-26 22:00:19.986413+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
5e66a1fd-9805-4a76-a8b1-3ebfd3c9936c	2027-08-15	feast	0	2026-04-26 22:00:20.386438+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
e25a184d-3352-4bfa-a6c2-589d01e53c13	2027-10-03	feast	0	2026-04-26 22:00:20.755964+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
387b5e46-e6d0-4c26-907b-bf7872379559	2027-11-21	feast	0	2026-04-26 22:00:21.152933+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
4e3cd54b-5f83-42d0-863f-d99096e13bbb	2028-01-09	feast	0	2026-04-26 22:00:21.555599+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
917086ae-e00e-45d0-8e19-766ac1b2c21f	2028-02-27	feast	0	2026-04-26 22:00:21.931102+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
48e1cc43-7f7f-42e3-b985-da43f31366fa	2027-07-04	feast	0	2026-04-26 22:00:20.040415+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
630f3994-1f25-4cc7-9642-74130fcf57a6	2027-08-22	feast	0	2026-04-26 22:00:20.438523+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
a893e570-ebc1-48a2-80ef-f245f242b287	2027-10-10	feast	0	2026-04-26 22:00:20.813513+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
e6c79e2a-e6a3-47ea-9b6f-9554b4ac4249	2027-11-28	feast	0	2026-04-26 22:00:21.214551+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
377d23dd-9901-490e-b7a1-98de98d452fd	2028-01-16	feast	0	2026-04-26 22:00:21.612845+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
b7e99bf4-3fd2-4e73-84d6-9001b318ab10	2028-03-05	feast	0	2026-04-26 22:00:22.002157+00	c84c79fe-e79c-4dd6-8680-39bbdb1d436e	uk	https://catholic-kazakhstan.org/wp-content/uploads/2021/01/kafedra-v-almaty.jpg	[]	1f7fb491-43db-4ead-a0ad-31876880e847
\.


--
-- Data for Name: liturgical_kind_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liturgical_kind_i18n (kind_slug, lang, label) FROM stdin;
great_feast	ru	Великий праздник
great_feast	uk	Велике свято
great_feast	kk	Үлкен мереке
great_feast	en	Great feast
sunday	ru	Воскресенье
sunday	uk	Неділя
sunday	kk	Жексенбі
sunday	en	Sunday
fast	ru	Пост
fast	uk	Піст
fast	kk	Ораза
fast	en	Fast
commemoration	ru	Память
commemoration	uk	Пам'ять
commemoration	kk	Еске алу
commemoration	en	Commemoration
feast	ru	Праздник
feast	uk	Свято
feast	kk	Мереке
feast	en	Feast
other	ru	Другое
other	uk	Інше
other	kk	Басқа
other	en	Other
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, published_at, is_published, created_at, updated_at, author_id, cover_image_url, primary_lang, gallery_image_urls) FROM stdin;
290e9810-4671-4f53-8768-ffc01a7bd557	2026-04-04 12:43:00+00	t	2026-04-26 21:45:08.668183+00	2026-04-26 21:46:54.387+00	\N	http://127.0.0.1:54321/storage/v1/object/public/news-images/290e9810-4671-4f53-8768-ffc01a7bd557/cover.jpg	uk	[]
aee857b5-3ebc-44e7-a760-12d4bda46f69	2026-04-11 21:47:00+00	t	2026-04-26 21:49:36.800373+00	2026-04-26 21:49:36.800373+00	\N	https://cerkiew.net.pl/wp-content/uploads/2023/04/0419-1200.jpg	uk	[]
e641441d-f3b5-4404-bdef-5a7273150cba	2026-04-17 21:49:00+00	t	2026-04-26 21:51:12.330007+00	2026-04-26 21:51:12.330007+00	\N	<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" data-instgrm-version="14" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:540px; min-width:326px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:16px;"> <a href="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" style=" background:#FFFFFF; line-height:0; padding:0 0; text-align:center; text-decoration:none; width:100%;" target="_blank"> <div style=" display: flex; flex-direction: row; align-items: center;"> <div style="background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 40px; margin-right: 14px; width: 40px;"></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 100px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 60px;"></div></div></div><div style="padding: 19% 0;"></div> <div style="display:block; height:50px; margin:0 auto 12px; width:50px;"><svg width="50px" height="50px" viewBox="0 0 60 60" version="1.1" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"><g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g transform="translate(-511.000000, -20.000000)" fill="#000000"><g><path d="M556.869,30.41 C554.814,30.41 553.148,32.076 553.148,34.131 C553.148,36.186 554.814,37.852 556.869,37.852 C558.924,37.852 560.59,36.186 560.59,34.131 C560.59,32.076 558.924,30.41 556.869,30.41 M541,60.657 C535.114,60.657 530.342,55.887 530.342,50 C530.342,44.114 535.114,39.342 541,39.342 C546.887,39.342 551.658,44.114 551.658,50 C551.658,55.887 546.887,60.657 541,60.657 M541,33.886 C532.1,33.886 524.886,41.1 524.886,50 C524.886,58.899 532.1,66.113 541,66.113 C549.9,66.113 557.115,58.899 557.115,50 C557.115,41.1 549.9,33.886 541,33.886 M565.378,62.101 C565.244,65.022 564.756,66.606 564.346,67.663 C563.803,69.06 563.154,70.057 562.106,71.106 C561.058,72.155 560.06,72.803 558.662,73.347 C557.607,73.757 556.021,74.244 553.102,74.378 C549.944,74.521 548.997,74.552 541,74.552 C533.003,74.552 532.056,74.521 528.898,74.378 C525.979,74.244 524.393,73.757 523.338,73.347 C521.94,72.803 520.942,72.155 519.894,71.106 C518.846,70.057 518.197,69.06 517.654,67.663 C517.244,66.606 516.755,65.022 516.623,62.101 C516.479,58.943 516.448,57.996 516.448,50 C516.448,42.003 516.479,41.056 516.623,37.899 C516.755,34.978 517.244,33.391 517.654,32.338 C518.197,30.938 518.846,29.942 519.894,28.894 C520.942,27.846 521.94,27.196 523.338,26.654 C524.393,26.244 525.979,25.756 528.898,25.623 C532.057,25.479 533.004,25.448 541,25.448 C548.997,25.448 549.943,25.479 553.102,25.623 C556.021,25.756 557.607,26.244 558.662,26.654 C560.06,27.196 561.058,27.846 562.106,28.894 C563.154,29.942 563.803,30.938 564.346,32.338 C564.756,33.391 565.244,34.978 565.378,37.899 C565.522,41.056 565.552,42.003 565.552,50 C565.552,57.996 565.522,58.943 565.378,62.101 M570.82,37.631 C570.674,34.438 570.167,32.258 569.425,30.349 C568.659,28.377 567.633,26.702 565.965,25.035 C564.297,23.368 562.623,22.342 560.652,21.575 C558.743,20.834 556.562,20.326 553.369,20.18 C550.169,20.033 549.148,20 541,20 C532.853,20 531.831,20.033 528.631,20.18 C525.438,20.326 523.257,20.834 521.349,21.575 C519.376,22.342 517.703,23.368 516.035,25.035 C514.368,26.702 513.342,28.377 512.574,30.349 C511.834,32.258 511.326,34.438 511.181,37.631 C511.035,40.831 511,41.851 511,50 C511,58.147 511.035,59.17 511.181,62.369 C511.326,65.562 511.834,67.743 512.574,69.651 C513.342,71.625 514.368,73.296 516.035,74.965 C517.703,76.634 519.376,77.658 521.349,78.425 C523.257,79.167 525.438,79.673 528.631,79.82 C531.831,79.965 532.853,80.001 541,80.001 C549.148,80.001 550.169,79.965 553.369,79.82 C556.562,79.673 558.743,79.167 560.652,78.425 C562.623,77.658 564.297,76.634 565.965,74.965 C567.633,73.296 568.659,71.625 569.425,69.651 C570.167,67.743 570.674,65.562 570.82,62.369 C570.966,59.17 571,58.147 571,50 C571,41.851 570.966,40.831 570.82,37.631"></path></g></g></g></svg></div><div style="padding-top: 8px;"> <div style=" color:#3897f0; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:550; line-height:18px;">Посмотреть эту публикацию в Instagram</div></div><div style="padding: 12.5% 0;"></div> <div style="display: flex; flex-direction: row; margin-bottom: 14px; align-items: center;"><div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(0px) translateY(7px);"></div> <div style="background-color: #F4F4F4; height: 12.5px; transform: rotate(-45deg) translateX(3px) translateY(1px); width: 12.5px; flex-grow: 0; margin-right: 14px; margin-left: 2px;"></div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(9px) translateY(-18px);"></div></div><div style="margin-left: 8px;"> <div style=" background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 20px; width: 20px;"></div> <div style=" width: 0; height: 0; border-top: 2px solid transparent; border-left: 6px solid #f4f4f4; border-bottom: 2px solid transparent; transform: translateX(16px) translateY(-4px) rotate(30deg)"></div></div><div style="margin-left: auto;"> <div style=" width: 0px; border-top: 8px solid #F4F4F4; border-right: 8px solid transparent; transform: translateY(16px);"></div> <div style=" background-color: #F4F4F4; flex-grow: 0; height: 12px; width: 16px; transform: translateY(-4px);"></div> <div style=" width: 0; height: 0; border-top: 8px solid #F4F4F4; border-left: 8px solid transparent; transform: translateY(-4px) translateX(8px);"></div></div></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center; margin-bottom: 24px;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 224px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 144px;"></div></div></a><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none;" target="_blank">Публикация от Апостольская Администратура (@apostolicadministrature)</a></p></div></blockquote>\r\n<script async src="//www.instagram.com/embed.js"></script>	uk	[]
\.


--
-- Data for Name: news_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_i18n (news_id, lang, title, excerpt, body) FROM stdin;
290e9810-4671-4f53-8768-ffc01a7bd557	uk	Наближається світлий Празник Христового Воскресіння - Пасха!	12 квітня 2026 р. Б. Розпорядок Богослужінь!	Слава Ісусу Христу! \r\n\r\nНаближається світлий Празник Христового Воскресіння - Пасха! 12 квітня 2026 р.Б.\r\nРозпорядок Богослужінь!  \r\n\r\n10 квітня 2026 р.Б.\r\nВелика П'ятниця:\r\n19:30 годин — Вечірня з винесенням Плащаниці!\r\n\r\n11 квітня 2026 р.Б.\r\nПасхальні богослужіння на Воскресіння Христове (Пасха):\r\n\r\n20:00 годин - Надгробне. Обхід. Стихири Пасхи;\r\n\r\n20:30 годин — Божественна Літургія Св. Івана Золотоустого.\r\n\r\nОпісля Літургії:\r\n- благословення пасок.\r\n\r\nПарафія блаженного Олексія Зарицького.\r\nАдреса: вул.Тлендиева, 9, м. Алмати.\r\n\r\nЗапрошую усіх.\r\nз повагою, о. Олег
290e9810-4671-4f53-8768-ffc01a7bd557	ru	Приближается светлый Праздник Христова Воскресения – Пасха!	12 апреля 2026 г. Б. Распорядок Богослужений!	Слава Иисусу Христу!\r\n\r\nПриближается светлый Праздник Христова Воскресения – Пасха! 12 апреля 2026 г.Б.\r\nРаспорядок Богослужений!\r\n\r\n10 апреля 2026 г.Б.\r\nБольшая Пятница:\r\n19:30 - Вечерняя с выносом Плащаницы!\r\n\r\n11 апреля 2026 г.Б.\r\nПасхальные богослужения на Воскресение Христово (Пасха):\r\n\r\n20:00 часов – Надгробное. Обход. Стихиры Пасхи;\r\n\r\n20:30 часов - Божественная Литургия Св. Иоанна Златоуста.\r\n\r\nПосле Литургии:\r\n- благословение куличей.\r\n\r\nПриход блаженного Алексея Зарицкого.\r\nАдрес: ул.Тлендиева, 9, г. Алматы.\r\n\r\nПриглашаю всех.\r\nс уважением, о. Олег
290e9810-4671-4f53-8768-ffc01a7bd557	en	The bright holiday of Christ's Resurrection - Easter - is approaching!	April 12, 2026 B. Schedule of Divine Services!	Glory to Jesus Christ!\r\n\r\nThe bright Feast of Christ's Resurrection – Easter – is approaching! April 12, 2026, B.\r\nSchedule of Services!\r\n\r\nApril 10, 2026, B.\r\nGood Friday:\r\n7:30 PM - Vespers with the Removal of the Shroud!\r\n\r\nApril 11, 2026, B.\r\nEaster Services for the Resurrection of Christ (Easter):\r\n\r\n8:00 PM - Funeral. Procession. Paschal Stichera;\r\n\r\n8:30 PM - Divine Liturgy of St. John Chrysostom.\r\n\r\nAfter the Liturgy:\r\n- Blessing of the Easter Cakes.\r\n\r\nParish of Blessed Alexei Zaritsky.\r\nAddress: 9 Tlendiyev Street, Almaty.\r\n\r\nAll are invited.\r\nSincerely, Father Oleg
290e9810-4671-4f53-8768-ffc01a7bd557	kk	Мәсіхтің қайта тірілуінің жарқын мерекесі - Пасха жақындап келеді!	2026 жылғы 12 сәуір B. Құдайға қызмет ету кестесі!	Иса Мәсіхке мадақ!\r\n\r\nМәсіхтің қайта тірілуінің жарқын мерекесі – Пасха – жақындап келеді! 2026 жылғы 12 сәуір, Б.\r\nҚызмет көрсету кестесі!\r\n\r\n2026 жылғы 10 сәуір, Б.\r\nҚасиетті жұма:\r\nСағат 19:30 - Кебенді алып тастаумен кешкі ас!\r\n\r\n2026 жылғы 11 сәуір, Б.\r\nМәсіхтің қайта тірілуіне арналған Пасха қызметтері (Пасха):\r\n\r\nСағат 20:00 - Жерлеу рәсімі. Шеру. Пасха стикерасы;\r\n\r\nСағат 20:30 - Әулие Иоанн Хризостомның құдайлық литургиясы.\r\n\r\nЛитургиядан кейін:\r\n- Пасха торттарына бата беру.\r\n\r\nҚасиетті Алексей Зарицкий приходы.\r\n\r\nМекенжайы: Алматы, Тілендиев көшесі, 9.\r\n\r\nБарлығы шақырылады.\r\nҚұрметпен, Олег әкей.
aee857b5-3ebc-44e7-a760-12d4bda46f69	uk	Дорогі парафіяни!	Вітаємо вас із великим святом Великодня!	Дорогі парафіяни! Вітаємо вас із великим святом Великодня!
aee857b5-3ebc-44e7-a760-12d4bda46f69	ru	Дорогие прихожане!	Поздравляем вас с праздником Пасхи!	Дорогие прихожане! Поздравляем вас с праздником Пасхи!
aee857b5-3ebc-44e7-a760-12d4bda46f69	kk	Құрметті қауым мүшелері!	Сіздерді Ұлы Пасха мерекесімен құттықтаймыз!	Құрметті қауым мүшелері! Сіздерді Ұлы Пасха мерекесімен құттықтаймыз!
aee857b5-3ebc-44e7-a760-12d4bda46f69	en	Dear parishioners!	We congratulate you on the great holiday of Easter!	Dear parishioners! We congratulate you on the great holiday of Easter!
e641441d-f3b5-4404-bdef-5a7273150cba	uk	Південна столиця зустріла свято Воскресіння Христового.	\N	<p>Великдень в Алмати</p>
e641441d-f3b5-4404-bdef-5a7273150cba	ru	Южная столица встретила праздник Воскресения Христова	\N	<p>Пасха в Алматы</p>
e641441d-f3b5-4404-bdef-5a7273150cba	kk	Оңтүстік астана Мәсіхтің қайта тірілу мерекесін атап өтті.	\N	<p>Алматыдағы Пасха мерекесі</p>
e641441d-f3b5-4404-bdef-5a7273150cba	en	The southern capital celebrated the holiday of the Resurrection of Christ.	\N	Easter in Almaty
\.


--
-- Data for Name: page_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page_content (page_key, lang, body, updated_at) FROM stdin;
history	ru	<div>\r\n    <h1><strong>История Апостольской Администратуры в Казахстане и Центральной Азии</strong></h1>\r\n\r\n    <p>Первые украинские поселенцы оказались на территории Казахстана, начиная с XVII века. Но наибольшее количество украинских греко-католиков попало в Казахстан в ХХ веке во времена сталинских репрессий, особенно вследствие массовой депортации с Украины в Казахстан в 40-50 годы прошлого века. Также в концлагерях Карлага оказалось около 200 греко-католических священников.</p>\r\n\r\n    <p>Начиная с 1955 года, священников вместе с другими политическими заключенными освобождают из тюрем. Освобожденные священники начинают пастырскую опеку своих верных. Таким образом в Караганде возникает первая греко-католическая община. Богослужения совершаются подпольно по домам, землянках и бараках. Подпольные богослужения продолжались вплоть до распада Советского Союза и легализации Греко-Католической Церкви.</p>\r\n\r\n    <p>В 1993 году был зарегистрирован первый греко-католический приход в Караганде. Позже возникли приходы в других городах Казахстана.</p>\r\n\r\n    <p>В 1991 году пастырская опека была поручена епископу Яну Павлу Ленге. С 1996 по 2002 год её осуществлял епископ Василий Медвит. В 2002 году отец Василий Говера был назначен Делегатом Конгрегации Восточных Церквей.</p>\r\n\r\n    <p>1 июня 2019 года Папа Римский Франциск создал Апостольскую Администратуру для верующих византийского обряда в Казахстане и Центральной Азии и назначил отца Василия Говеру первым Апостольским Администратором.</p>\r\n\r\n    <p>Исторически ещё в конце 50-х годов митрополит Иосиф Слипый назначил апостольских администраторов для верующих в СССР. В Казахстане эту миссию выполнял блаженный священномученик Алексий Зарицкий.</p>\r\n\r\n    <p>Сегодня в Казахстане действуют греко-католические приходы в Караганде, Нур-Султане, Павлодаре, Сатпаеве, поселке Шидерты, а также существует община в Алматы.</p>\r\n\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">История прихода</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Греко-католический приход Блаженного Алексея Зарицкого города Алматы</strong></p>\r\n\r\n    <p>Приход начал пастырское служение для местных греко-католических верующих. В связи с отсутствием собственного храма богослужения проходят в римско-католическом Кафедральном соборе Пресвятой Троицы.</p>\r\n\r\n    <p>В литургической жизни принимают участие как местные греко-католики, так и украинцы, прибывшие в Алматы по профессиональным и трудовым причинам.</p>\r\n\r\n    <p>В 2017 году администратором общины был назначен священник о. Олег Галушка. С 9 августа 2023 года, после официальной регистрации прихода, он стал настоятелем и продолжил пастырскую деятельность.</p>\r\n\r\n    <p>Прихожане активно участвуют в жизни общины: проводятся занятия по катехизису и изучению Святого Писания для взрослых и детей, ежедневная молитва «Святого Розария» в телеграм-канале, детские лагеря, а также культурные мероприятия, посвящённые Рождеству и Пасхе.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	uk	<div>\r\n    <h1><strong>Історія Апостольської Адміністратури в Казахстані та Центральній Азії</strong></h1>\r\n\r\n    <p>Перші українські поселенці з’явилися на території Казахстану ще з XVII століття. Найбільша хвиля українських греко-католиків припала на ХХ століття під час сталінських репресій, особливо внаслідок масових депортацій у 40–50-х роках. У таборах Карлагу перебувало близько 200 греко-католицьких священників.</p>\r\n\r\n    <p>З 1955 року священників почали звільняти з ув’язнення. Вони відновили душпастирське служіння, і в Караганді виникла перша громада. Богослужіння відбувалися підпільно в домівках і бараках аж до легалізації Церкви після розпаду СРСР.</p>\r\n\r\n    <p>У 1993 році було зареєстровано перший греко-католицький прихід у Караганді. Згодом громади з’явилися і в інших містах.</p>\r\n\r\n    <p>У 1991 році душпастирську опіку доручено єпископу Яну Павлу Лензі. У 1996–2002 роках її здійснював єпископ Василій Медвіт. У 2002 році отця Василя Говеру призначено делегатом Конгрегації Східних Церков.</p>\r\n\r\n    <p>1 червня 2019 року Папа Франциск створив Апостольську Адміністратуру для вірних візантійського обряду та призначив отця Василя Говеру адміністратором.</p>\r\n\r\n    <p>Ще у 1950-х роках митрополит Йосиф Сліпий призначив апостольських адміністраторів для СРСР. У Казахстані ним був блаженний священномученик Олексій Зарицький.</p>\r\n\r\n    <p>Сьогодні громади діють у Караганді, Астані, Павлодарі, Сатпаєві, Шідертах, а також в Алмати.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Історія парафії</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Греко-католицька парафія блаженного Олексія Зарицького в місті Алмати</strong></p>\r\n\r\n    <p>Парафія розпочала душпастирське служіння для місцевих вірних. Богослужіння проходять у римо-католицькому кафедральному соборі Пресвятої Трійці.</p>\r\n\r\n    <p>У житті парафії беруть участь як місцеві вірні, так і українці, які проживають в Алмати.</p>\r\n\r\n    <p>У 2017 році адміністратором став о. Олег Галушка. З 9 серпня 2023 року він є настоятелем парафії.</p>\r\n\r\n    <p>Парафіяни активно беруть участь у житті громади: катехизація, молитви, дитячі табори та святкові заходи.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	kk	<div>\r\n    <h1><strong>Қазақстан мен Орталық Азиядағы Апостолдық Әкімшіліктің тарихы</strong></h1>\r\n\r\n    <p>Алғашқы украин қоныстанушылары Қазақстан аумағына XVII ғасырдан бастап келе бастады. Алайда украин грек-католиктерінің ең көп бөлігі Қазақстанға ХХ ғасырда сталиндік қуғын-сүргін кезеңінде, әсіресе 1940–50 жылдары Украинадан жаппай жер аудару нәтижесінде келді. Сондай-ақ Қарлаг лагерлерінде шамамен 200 грек-католик діни қызметкері болды.</p>\r\n\r\n    <p>1955 жылдан бастап діни қызметкерлер басқа саяси тұтқындармен бірге түрмелерден босатыла бастады. Босатылғаннан кейін олар өз қауымдарына рухани қызмет көрсете бастады. Осылайша Қарағандыда алғашқы грек-католик қауымы пайда болды. Құлшылықтар үйлерде, жертөлелерде және барақтарда жасырын түрде өткізілді. Бұл жасырын қызметтер Кеңес Одағы құлағанға дейін жалғасты.</p>\r\n\r\n    <p>1993 жылы Қарағандыда алғашқы грек-католик приходы ресми түрде тіркелді. Кейін Қазақстанның басқа қалаларында да қауымдар пайда болды.</p>\r\n\r\n    <p>1991 жылы рухани қамқорлық епископ Ян Павел Ленгаға тапсырылды. 1996–2002 жылдары бұл қызметті епископ Василий Медвит атқарды. 2002 жылы әкей Василий Говера Шығыс шіркеулер Конгрегациясының делегаты болып тағайындалды.</p>\r\n\r\n    <p>2019 жылғы 1 маусымда Рим Папасы Франциск Қазақстан мен Орталық Азиядағы византиялық дәстүрдегі сенушілер үшін Апостолдық Әкімшілікті құрды және әкей Василий Говераны алғашқы әкімші етіп тағайындады.</p>\r\n\r\n    <p>Тарихи тұрғыдан, 1950-жылдардың соңында митрополит Иосиф Слипый КСРО аумағындағы сенушілер үшін апостолдық әкімшілерді тағайындаған болатын. Қазақстанда бұл қызметті блаженный әкей Алексий Зарицкий атқарды.</p>\r\n\r\n    <p>Қазіргі уақытта Қазақстанда Қарағанды, Астана, Павлодар, Сәтбаев, Шідерті елді мекенінде грек-католик қауымдары жұмыс істейді, сондай-ақ Алматыда да қауым бар.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Приход тарихы</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Алматы қаласындағы Блаженный Алексий Зарицкий атындағы грек-католик приходы</strong></p>\r\n\r\n    <p>Приход жергілікті грек-католик сенушілеріне рухани қызмет көрсете бастады. Өз ғибадатханасы болмағандықтан, құлшылықтар Рим-католиктік Қасиетті Үштік кафедралды соборында өткізіледі.</p>\r\n\r\n    <p>Қауым өміріне жергілікті сенушілермен қатар, Алматыға жұмыс немесе кәсіби себептермен келген украиндар да қатысады.</p>\r\n\r\n    <p>2017 жылы қауым әкімшісі болып әкей Олег Галушка тағайындалды. 2023 жылғы 9 тамызда приход ресми тіркелгеннен кейін ол настоятель болып бекітілді.</p>\r\n\r\n    <p>Қауым мүшелері белсенді қатысады: катехизис сабақтары, Киелі Жазбаны оқу, күнделікті «Қасиетті Розарий» дұғасы, балалар лагерьлері және Рождество мен Пасхаға арналған мәдени шаралар өткізіледі.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	en	<div>\r\n    <h1><strong>History of the Apostolic Administration in Kazakhstan and Central Asia</strong></h1>\r\n\r\n    <p>The first Ukrainian settlers arrived in Kazakhstan as early as the 17th century. However, the largest number of Ukrainian Greek Catholics came during the 20th century, especially due to Stalinist repressions and mass deportations in the 1940s–50s. About 200 Greek Catholic priests were imprisoned in the Karlag camps.</p>\r\n\r\n    <p>From 1955, priests were released and resumed pastoral care. The first community emerged in Karaganda, where services were held secretly in homes and barracks until the fall of the Soviet Union.</p>\r\n\r\n    <p>In 1993, the first parish was officially registered in Karaganda, followed by others across Kazakhstan.</p>\r\n\r\n    <p>In 1991, pastoral care was entrusted to Bishop Jan Paweł Lenga. From 1996 to 2002 it was carried out by Bishop Vasyl Medvit. In 2002, Fr. Vasyl Hovera was appointed delegate of the Congregation for the Eastern Churches.</p>\r\n\r\n    <p>On June 1, 2019, Pope Francis established the Apostolic Administration for Byzantine-rite faithful and appointed Fr. Vasyl Hovera as its first administrator.</p>\r\n\r\n    <p>Historically, Metropolitan Josyf Slipyj had already appointed administrators in the 1950s. In Kazakhstan, this role was held by Blessed martyr Fr. Alexiy Zarytsky.</p>\r\n\r\n    <p>Today, parishes exist in Karaganda, Astana, Pavlodar, Satpayev, Shiderty, and a community also exists in Almaty.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Parish History</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Greek Catholic Parish of Blessed Alexiy Zarytsky in Almaty</strong></p>\r\n\r\n    <p>The parish began pastoral service for local Greek Catholics. Due to the lack of its own church, services are held at the Roman Catholic Cathedral of the Holy Trinity.</p>\r\n\r\n    <p>Both local faithful and Ukrainians living in Almaty participate in parish life.</p>\r\n\r\n    <p>In 2017, Fr. Oleg Halushka was appointed administrator. Since August 9, 2023, he has been the parish priest.</p>\r\n\r\n    <p>Parishioners actively participate through catechism, prayer, children’s camps, and cultural events for Christmas and Easter.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, email, full_name, role, created_at, can_view_all_objects, can_edit_all_objects) FROM stdin;
1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	\N	superadmin	2026-04-26 18:23:02.716686+00	t	t
8855aa14-c74e-489e-9bf2-737cc572b5cb	oleh.halushka@gmail.com	Олег Галушка	admin	2026-04-27 03:16:40.845349+00	t	t
41913d45-2416-4e03-9979-5029f28644e8	oleh.halushka1979@gmail.com	Олег Галушка	admin	2026-04-27 03:17:27.069947+00	t	t
\.


--
-- Data for Name: scripture_book_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scripture_book_locales (id, book_id, lang, title, description, read_url, file_url, cover_image_url) FROM stdin;
098c3821-ae04-4e9a-99b8-b7262a31e314	a21d48ff-4d22-45a9-b81d-a51df28fa85e	ru	Библия. Русский синодальный перевод.	\N	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/a21d48ff-4d22-45a9-b81d-a51df28fa85e/ru/upload_2026-04-27_03-07-37_430.zip	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/a21d48ff-4d22-45a9-b81d-a51df28fa85e/covers/ru.jpeg
3dee14d8-b87b-4763-91f8-408fcdbcf81b	dcf3d897-be1d-4670-af00-0d8c3d9fadcd	uk	Біблія в перекладi Івана Огієнка 1962	БІБЛІЯ ПЕРЕКЛАД ОГІЄНКА – найпопулярніший переклад оригінальної Біблії українською мовою. Робота перекладача тривала з 1917 до 1940 року, а перше видання було випущено 1962 року у столиці Великобританії Об'єднаним Біблійним товариством. В Україні книга була випущена вперше великим тиражем 1995 року.	https://ukrbible.at.ua/index/ukrajinska_biblija_pereklad_i_ogienka_onlajn/0-17	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/dcf3d897-be1d-4670-af00-0d8c3d9fadcd/uk/upload_2026-04-27_03-09-40_700.zip	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/dcf3d897-be1d-4670-af00-0d8c3d9fadcd/covers/uk.jpeg
cf404243-9991-4955-9ddb-a919a6e9e4e9	33573b44-e003-4902-97f0-f0dd78f4c6f3	uk	Катехизм Української Греко-Ка­толицької Церкви	Високопреосвященним і Преосвященним Владикам, Всесвітлішим, всечеснішим та преподобним отцям, преподобним ченцям і черницям, дорогим у Христі мирянам Української Греко-Католицької Церкви.\r\n\r\nДорогі брати і сестри! Поручаємо Вам Катехизм Української Греко-Ка­толицької Церкви, який є сповідуванням і поясненням її віри в Триєдиного Бога - Отця, і Сина, і Святого Духа. Віра ця народилася в слуханні Хрис­тового Євангелія, яке вперше пролунало на землях Руси-України, згідно з переданням, ще в проповіді апостола Андрея Первозванного; ця Благо- вість продовжила звучати в місії святих слов’янських апостолів Кирила і Методія та утвердилася у Хрещенні Руси-України за рівноапостольного князя Володимира. Слово Євангелія знайшло відгук віри в серцях слуха­чів, і Христова Церква поширилась по всій Київській Русі. Нова христи­янська традиція, згодом названа київською, стала перлиною в скарбниці віри Вселенської Церкви. На цій традиції виросли численні покоління християн як української, так і інших культур.	https://catechismugcc.org/	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/33573b44-e003-4902-97f0-f0dd78f4c6f3/covers/uk.jpg
3214d5a7-e964-412a-bf47-1a18e02c1c22	f768c98c-e713-45d7-8daf-229da7993460	uk	Біблія. Переклад о. Івана (Хоменка)	Третій повний (римський) переклад Біблії українською мовою.	https://ugcc.ua/library/bible/	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/f768c98c-e713-45d7-8daf-229da7993460/covers/uk.jpg
\.


--
-- Data for Name: scripture_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scripture_books (id, sort_order, created_at, primary_lang, gallery_image_urls) FROM stdin;
a21d48ff-4d22-45a9-b81d-a51df28fa85e	0	2026-04-26 22:07:37.422703+00	ru	[]
dcf3d897-be1d-4670-af00-0d8c3d9fadcd	0	2026-04-26 22:09:40.69322+00	uk	[]
33573b44-e003-4902-97f0-f0dd78f4c6f3	0	2026-04-26 22:11:15.789726+00	uk	[]
f768c98c-e713-45d7-8daf-229da7993460	0	2026-04-26 22:12:42.460293+00	uk	["http://127.0.0.1:54321/storage/v1/object/public/scripture-books/f768c98c-e713-45d7-8daf-229da7993460/gallery/1777241562559_0_gj7n0tr.jpg"]
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_settings (key, value) FROM stdin;
telegram	{"chat_id": null, "webhook_secret": null}
smoke_local	{"ok": true, "source": "local"}
external_liturgical_widget	{"gregorian": false, "new_julian": true}
footer	{"email": "oleh.halushka@gmail.com", "phone": "+7 705 972 30 50", "address_en": "Almaty, Tlendieva 9", "address_kk": "Алмати, Тлендієва 9", "address_ru": "г. Алматы, Тлендиева 9", "address_uk": "м. Алмати, Тлендиева 9", "map_embed_src": "https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2905.789280619768!2d76.8675658!3d43.2558379!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x388369823d000001%3A0xe5cfe59f1bfb932a!2z0KDQuNC80YHQutC-LdCa0LDRgtC-0LvQuNGH0LXRgdC60LjQuSDQodC-0LHQvtGAINCf0YDQtdGB0LLRj9GC0L7QuSDQotGA0L7QuNGG0Ys!5e0!3m2!1sru!2skz!4v1775406740843!5m2!1sru!2skz", "priest_name_en": "Priest Oleh Halushka", "priest_name_kk": "Діни қызметкер Олег Галушка", "priest_name_ru": "Священник Олег Галушка", "priest_name_uk": "Священик Олег Галушка", "contact_buttons": [{"url": "https://t.me/ugcc_almaty_official", "icon": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_dbOUeCrOBe-mkfGD-fEjQNECJrkromWTYg&s", "label": "Telegram"}, {"url": "https://www.ugcc-kazakhstan.com/uk/%D0%BA%D0%BE%D0%BD%D1%82%D0%B0%D0%BA%D1%82%D1%8B", "icon": "https://static.wixstatic.com/media/c3aa9c_82ed7649aabc4d8299b2a6ccd29f0541~mv2.jpg/v1/fill/w_61,h_80,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/%D0%93%D0%95%D0%A0%D0%91%201.jpg", "label": "АПОСТОЛЬСЬКА АДМІНІСТРАТУРА"}], "contact_photo_url": "https://static.wixstatic.com/media/c3aa9c_5900c28d45354dd5964039ea90ade6e3~mv2.jpg/v1/fill/w_953,h_957,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_5900c28d45354dd5964039ea90ade6e3~mv2.jpg"}
\.


--
-- Data for Name: telegram_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telegram_messages (id, chat_id, tg_message_id, text, sent_at) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_25 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_26; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_26 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_27; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_27 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_28; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_28 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_29; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_29 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_30; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_30 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-26 18:17:00
20211116045059	2026-04-26 18:17:00
20211116050929	2026-04-26 18:17:00
20211116051442	2026-04-26 18:17:00
20211116212300	2026-04-26 18:17:00
20211116213355	2026-04-26 18:17:00
20211116213934	2026-04-26 18:17:00
20211116214523	2026-04-26 18:17:00
20211122062447	2026-04-26 18:17:00
20211124070109	2026-04-26 18:17:00
20211202204204	2026-04-26 18:17:00
20211202204605	2026-04-26 18:17:00
20211210212804	2026-04-26 18:17:00
20211228014915	2026-04-26 18:17:00
20220107221237	2026-04-26 18:17:00
20220228202821	2026-04-26 18:17:00
20220312004840	2026-04-26 18:17:00
20220603231003	2026-04-26 18:17:00
20220603232444	2026-04-26 18:17:00
20220615214548	2026-04-26 18:17:00
20220712093339	2026-04-26 18:17:00
20220908172859	2026-04-26 18:17:00
20220916233421	2026-04-26 18:17:00
20230119133233	2026-04-26 18:17:00
20230128025114	2026-04-26 18:17:00
20230128025212	2026-04-26 18:17:00
20230227211149	2026-04-26 18:17:00
20230228184745	2026-04-26 18:17:00
20230308225145	2026-04-26 18:17:00
20230328144023	2026-04-26 18:17:01
20231018144023	2026-04-26 18:17:01
20231204144023	2026-04-26 18:17:01
20231204144024	2026-04-26 18:17:01
20231204144025	2026-04-26 18:17:01
20240108234812	2026-04-26 18:17:01
20240109165339	2026-04-26 18:17:01
20240227174441	2026-04-26 18:17:01
20240311171622	2026-04-26 18:17:01
20240321100241	2026-04-26 18:17:01
20240401105812	2026-04-26 18:17:01
20240418121054	2026-04-26 18:17:01
20240523004032	2026-04-26 18:17:01
20240618124746	2026-04-26 18:17:01
20240801235015	2026-04-26 18:17:01
20240805133720	2026-04-26 18:17:01
20240827160934	2026-04-26 18:17:01
20240919163303	2026-04-26 18:17:01
20240919163305	2026-04-26 18:17:01
20241019105805	2026-04-26 18:17:01
20241030150047	2026-04-26 18:17:01
20241108114728	2026-04-26 18:17:01
20241121104152	2026-04-26 18:17:01
20241130184212	2026-04-26 18:17:01
20241220035512	2026-04-26 18:17:01
20241220123912	2026-04-26 18:17:01
20241224161212	2026-04-26 18:17:01
20250107150512	2026-04-26 18:17:01
20250110162412	2026-04-26 18:17:01
20250123174212	2026-04-26 18:17:01
20250128220012	2026-04-26 18:17:01
20250506224012	2026-04-26 18:17:01
20250523164012	2026-04-26 18:17:01
20250714121412	2026-04-26 18:17:01
20250905041441	2026-04-26 18:17:01
20251103001201	2026-04-26 18:17:01
20251120212548	2026-04-26 18:17:01
20251120215549	2026-04-26 18:17:01
20260218120000	2026-04-26 18:17:01
20260326120000	2026-04-26 18:17:01
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
news-images	news-images	\N	2026-04-26 18:17:11.791291+00	2026-04-26 18:17:11.791291+00	t	f	\N	\N	\N	STANDARD
scripture-books	scripture-books	\N	2026-04-26 18:17:11.791291+00	2026-04-26 18:17:11.791291+00	t	f	\N	\N	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_namespaces (id, bucket_name, name, created_at, updated_at, metadata, catalog_id) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_tables (id, namespace_id, bucket_name, name, location, created_at, updated_at, remote_table_id, shard_key, shard_id, catalog_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-26 18:17:10.140424
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-26 18:17:10.15489
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-26 18:17:10.15875
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-26 18:17:10.169978
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-26 18:17:10.176033
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-26 18:17:10.179838
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-26 18:17:10.184996
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-26 18:17:10.189742
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-26 18:17:10.193806
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-26 18:17:10.197845
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-26 18:17:10.201779
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-26 18:17:10.205791
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-26 18:17:10.209889
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-26 18:17:10.213717
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-26 18:17:10.217862
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-26 18:17:10.228913
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-26 18:17:10.232912
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-26 18:17:10.236758
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-26 18:17:10.240798
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-26 18:17:10.244792
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-26 18:17:10.248797
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-26 18:17:10.25273
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-26 18:17:10.259891
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-26 18:17:10.266089
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-26 18:17:10.270698
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-26 18:17:10.274753
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-26 18:17:10.278907
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-26 18:17:10.282877
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-26 18:17:10.286696
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-26 18:17:10.289642
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-26 18:17:10.293818
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-26 18:17:10.29772
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-26 18:17:10.302076
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-26 18:17:10.305718
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-26 18:17:10.309854
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-26 18:17:10.313649
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-26 18:17:10.317695
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-26 18:17:10.321596
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-26 18:17:10.326684
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-26 18:17:10.337999
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-26 18:17:10.342744
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-26 18:17:10.345969
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-26 18:17:10.349661
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-26 18:17:10.353661
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-26 18:17:10.35731
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-26 18:17:10.361808
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-26 18:17:10.36794
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-26 18:17:10.37179
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-26 18:17:10.375855
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-26 18:17:10.392279
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-26 18:17:10.39686
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-26 18:17:10.430973
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-04-26 18:17:10.433771
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-26 18:17:10.439171
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-26 18:17:10.442356
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-26 18:17:10.44475
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-04-26 18:17:10.449762
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-26 18:17:10.454801
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-26 18:17:10.458786
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
b2e4a55b-df36-4fbd-88c3-b2fd328ae4f2	news-images	290e9810-4671-4f53-8768-ffc01a7bd557/cover.jpg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 21:46:54.619754+00	2026-04-26 21:46:54.619754+00	2026-04-26 21:46:54.619754+00	{"eTag": "\\"b800e6fd7a1d5a1c27a687563898113d\\"", "size": 497794, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T21:46:54.605Z", "contentLength": 497794, "httpStatusCode": 200}	02a9640d-9f46-451d-bd3c-7cf5bca615a4	1f7fb491-43db-4ead-a0ad-31876880e847	{}
21281c6a-5cb2-4eab-98ee-8f8300f6b82e	scripture-books	a21d48ff-4d22-45a9-b81d-a51df28fa85e/ru/upload_2026-04-27_03-07-37_430.zip	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:07:37.590321+00	2026-04-26 22:07:37.590321+00	2026-04-26 22:07:37.590321+00	{"eTag": "\\"9ada508b34e47049ea79ac1453d6bdaa\\"", "size": 1593438, "mimetype": "application/x-zip-compressed", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:07:37.581Z", "contentLength": 1593438, "httpStatusCode": 200}	ad9dbf09-20a0-476c-b6b3-c1b33884c32c	1f7fb491-43db-4ead-a0ad-31876880e847	{}
e8478ed2-e882-4a1f-983e-97a5ae861f21	scripture-books	a21d48ff-4d22-45a9-b81d-a51df28fa85e/covers/ru.jpeg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:07:37.650498+00	2026-04-26 22:07:37.650498+00	2026-04-26 22:07:37.650498+00	{"eTag": "\\"19914de19c00edff802e5e17a140f847\\"", "size": 248610, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:07:37.645Z", "contentLength": 248610, "httpStatusCode": 200}	5a72a0ad-1a4d-4b8e-8ded-24420932bf7d	1f7fb491-43db-4ead-a0ad-31876880e847	{}
8c611823-320d-42d5-bc91-8161c33e121b	scripture-books	dcf3d897-be1d-4670-af00-0d8c3d9fadcd/uk/upload_2026-04-27_03-09-40_700.zip	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:09:40.818649+00	2026-04-26 22:09:40.818649+00	2026-04-26 22:09:40.818649+00	{"eTag": "\\"9a8491a794437a2641a28d1272277252\\"", "size": 1617853, "mimetype": "application/x-zip-compressed", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:09:40.811Z", "contentLength": 1617853, "httpStatusCode": 200}	aadcc5c6-f64f-4ec8-8980-99c1265bb5d2	1f7fb491-43db-4ead-a0ad-31876880e847	{}
f9e7c188-eabf-4eb9-8377-1893b53d480c	scripture-books	dcf3d897-be1d-4670-af00-0d8c3d9fadcd/covers/uk.jpeg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:10:02.798265+00	2026-04-26 22:10:02.798265+00	2026-04-26 22:10:02.798265+00	{"eTag": "\\"07a2534bf549a2388b260f5b26a3cc3e\\"", "size": 41500, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:10:02.796Z", "contentLength": 41500, "httpStatusCode": 200}	c68b16b7-6bac-45a9-98a1-6400b25fd3c8	1f7fb491-43db-4ead-a0ad-31876880e847	{}
69c5306a-e712-4e1b-9c83-605778009389	scripture-books	33573b44-e003-4902-97f0-f0dd78f4c6f3/covers/uk.jpg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:11:15.821641+00	2026-04-26 22:11:15.821641+00	2026-04-26 22:11:15.821641+00	{"eTag": "\\"850c291b3ad0d6162bd567610e729e68\\"", "size": 95741, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:11:15.813Z", "contentLength": 95741, "httpStatusCode": 200}	2a6a8a61-f9a7-4532-a6a1-09febbb4af23	1f7fb491-43db-4ead-a0ad-31876880e847	{}
7b111ec8-884d-4365-a4c9-359f7d839935	scripture-books	f768c98c-e713-45d7-8daf-229da7993460/covers/uk.jpg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:12:42.515066+00	2026-04-26 22:12:42.515066+00	2026-04-26 22:12:42.515066+00	{"eTag": "\\"b80d45d368f985d8a9c5f39e8b06cfcb\\"", "size": 138289, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:12:42.511Z", "contentLength": 138289, "httpStatusCode": 200}	8cd13965-005a-4656-a3b3-fdf059bc4ef0	1f7fb491-43db-4ead-a0ad-31876880e847	{}
c8ce0c5e-bb6d-477e-87f2-9321440dcc44	scripture-books	f768c98c-e713-45d7-8daf-229da7993460/gallery/1777241562559_0_gj7n0tr.jpg	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 22:12:42.573571+00	2026-04-26 22:12:42.573571+00	2026-04-26 22:12:42.573571+00	{"eTag": "\\"b8da49965897346e37fd8f5c6d2756e2\\"", "size": 6209, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-04-26T22:12:42.567Z", "contentLength": 6209, "httpStatusCode": 200}	33e34dc2-f2e4-40ff-8619-6382af8fccb7	1f7fb491-43db-4ead-a0ad-31876880e847	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2026-04-26 18:16:56.321089+00
20210809183423_update_grants	2026-04-26 18:16:56.321089+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20260404000000	{"-- Greek Catholic Almaty parish — initial schema\n-- Run in Supabase SQL Editor or via CLI.\n\ncreate extension if not exists \\"pgcrypto\\"","-- Roles\ncreate type public.user_role as enum ('superadmin', 'admin')","-- Profiles (1:1 with auth.users)\ncreate table public.profiles (\n  id uuid references auth.users on delete cascade primary key,\n  email text,\n  full_name text,\n  role public.user_role not null default 'admin',\n  created_at timestamptz not null default now()\n)","alter table public.profiles enable row level security","create or replace function public.is_staff()\nreturns boolean\nlanguage sql\nsecurity definer\nset search_path = public\nstable\nas $$\n  select exists (\n    select 1 from public.profiles\n    where id = auth.uid() and role in ('superadmin', 'admin')\n  );\n$$","create or replace function public.is_superadmin()\nreturns boolean\nlanguage sql\nsecurity definer\nset search_path = public\nstable\nas $$\n  select exists (\n    select 1 from public.profiles\n    where id = auth.uid() and role = 'superadmin'\n  );\n$$","create policy \\"profiles_select_own_or_super\\"\n  on public.profiles for select\n  using (auth.uid() = id or public.is_superadmin())","create policy \\"profiles_update_self\\"\n  on public.profiles for update\n  using (auth.uid() = id)\n  with check (auth.uid() = id)","create policy \\"profiles_update_super\\"\n  on public.profiles for update\n  using (public.is_superadmin())","-- New auth users → profile (default admin; promote first user to superadmin manually)\ncreate or replace function public.handle_new_user()\nreturns trigger\nlanguage plpgsql\nsecurity definer\nset search_path = public\nas $$\nbegin\n  insert into public.profiles (id, email, role)\n  values (new.id, new.email, 'admin');\n  return new;\nend;\n$$","create trigger on_auth_user_created\n  after insert on auth.users\n  for each row execute function public.handle_new_user()","-- News\ncreate table public.news (\n  id uuid primary key default gen_random_uuid(),\n  published_at timestamptz not null default now(),\n  is_published boolean not null default true,\n  created_at timestamptz not null default now(),\n  updated_at timestamptz not null default now(),\n  author_id uuid references public.profiles (id)\n)","create table public.news_i18n (\n  news_id uuid not null references public.news (id) on delete cascade,\n  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),\n  title text not null,\n  excerpt text,\n  body text not null,\n  primary key (news_id, lang)\n)","alter table public.news enable row level security","alter table public.news_i18n enable row level security","create policy \\"news_select\\"\n  on public.news for select\n  using (is_published = true or public.is_staff())","create policy \\"news_write\\"\n  on public.news for all\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"news_i18n_select\\"\n  on public.news_i18n for select\n  using (\n    exists (\n      select 1 from public.news n\n      where n.id = news_id and (n.is_published = true or public.is_staff())\n    )\n  )","create policy \\"news_i18n_write\\"\n  on public.news_i18n for all\n  using (public.is_staff())\n  with check (public.is_staff())","-- Liturgical calendar\ncreate table public.liturgical_events (\n  id uuid primary key default gen_random_uuid(),\n  event_date date not null,\n  kind text not null check (kind in (\n    'great_feast', 'feast', 'sunday', 'fast', 'commemoration', 'other'\n  )),\n  sort_order int not null default 0,\n  created_at timestamptz not null default now()\n)","create index liturgical_events_date_idx on public.liturgical_events (event_date)","create table public.liturgical_event_i18n (\n  event_id uuid not null references public.liturgical_events (id) on delete cascade,\n  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),\n  title text not null,\n  explanation text not null,\n  prayer text,\n  primary key (event_id, lang)\n)","alter table public.liturgical_events enable row level security","alter table public.liturgical_event_i18n enable row level security","create policy \\"liturgical_events_public_read\\"\n  on public.liturgical_events for select using (true)","create policy \\"liturgical_events_staff_write\\"\n  on public.liturgical_events for all\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"liturgical_event_i18n_public_read\\"\n  on public.liturgical_event_i18n for select using (true)","create policy \\"liturgical_event_i18n_staff_write\\"\n  on public.liturgical_event_i18n for all\n  using (public.is_staff())\n  with check (public.is_staff())","-- Scripture / books: родитель + версии по языкам (main + ru/uk/kk/en)\ncreate table public.scripture_books (\n  id uuid primary key default gen_random_uuid(),\n  sort_order int not null default 0,\n  created_at timestamptz not null default now()\n)","alter table public.scripture_books enable row level security","create policy \\"scripture_books_public_read\\"\n  on public.scripture_books for select using (true)","create policy \\"scripture_books_staff_write\\"\n  on public.scripture_books for all\n  using (public.is_staff())\n  with check (public.is_staff())","create table public.scripture_book_locales (\n  id uuid primary key default gen_random_uuid(),\n  book_id uuid not null references public.scripture_books (id) on delete cascade,\n  lang text not null check (lang in ('main', 'ru', 'uk', 'kk', 'en')),\n  title text,\n  description text,\n  read_url text,\n  file_url text,\n  cover_image_url text,\n  unique (book_id, lang)\n)","create index scripture_book_locales_book_id_idx on public.scripture_book_locales (book_id)","alter table public.scripture_book_locales enable row level security","create policy \\"scripture_book_locales_public_read\\"\n  on public.scripture_book_locales for select using (true)","create policy \\"scripture_book_locales_staff_write\\"\n  on public.scripture_book_locales for all\n  using (public.is_staff())\n  with check (public.is_staff())","-- Editable pages (history, etc.)\ncreate table public.page_content (\n  page_key text not null,\n  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),\n  body text not null,\n  updated_at timestamptz not null default now(),\n  primary key (page_key, lang)\n)","alter table public.page_content enable row level security","create policy \\"page_content_public_read\\"\n  on public.page_content for select using (true)","create policy \\"page_content_staff_write\\"\n  on public.page_content for all\n  using (public.is_staff())\n  with check (public.is_staff())","-- Site settings (footer, telegram chat id, etc.)\ncreate table public.site_settings (\n  key text primary key,\n  value jsonb not null default '{}'::jsonb\n)","alter table public.site_settings enable row level security","create policy \\"site_settings_public_read\\"\n  on public.site_settings for select using (true)","create policy \\"site_settings_staff_write\\"\n  on public.site_settings for all\n  using (public.is_staff())\n  with check (public.is_staff())","-- Cached Telegram posts (filled via webhook + service role)\ncreate table public.telegram_messages (\n  id uuid primary key default gen_random_uuid(),\n  chat_id bigint not null,\n  tg_message_id bigint not null,\n  text text,\n  sent_at timestamptz,\n  unique (chat_id, tg_message_id)\n)","alter table public.telegram_messages enable row level security","create policy \\"telegram_messages_public_read\\"\n  on public.telegram_messages for select using (true)","-- Inserts from anon: none. Use service role in API route.\n-- PDF Писания: создайте в Dashboard bucket `scripture-books` (public) и политики Storage при необходимости.\n\n-- Seed: default footer / placeholders (edit in admin or SQL)\ninsert into public.site_settings (key, value) values\n  ('footer', '{\n    \\"priest_name_ru\\": \\"\\",\n    \\"priest_name_uk\\": \\"\\",\n    \\"priest_name_kk\\": \\"\\",\n    \\"priest_name_en\\": \\"\\",\n    \\"email\\": \\"\\",\n    \\"phone\\": \\"\\",\n    \\"address_ru\\": \\"г. Алматы, уточняйте адрес у прихода\\",\n    \\"address_uk\\": \\"\\",\n    \\"address_kk\\": \\"\\",\n    \\"address_en\\": \\"\\",\n    \\"extra_ru\\": \\"\\",\n    \\"extra_uk\\": \\"\\",\n    \\"extra_kk\\": \\"\\",\n    \\"extra_en\\": \\"\\"\n  }'::jsonb),\n  ('telegram', '{\\"chat_id\\": null, \\"webhook_secret\\": null}'::jsonb)\non conflict (key) do nothing","insert into public.page_content (page_key, lang, body) values\n  ('history', 'ru', '<p>История греко-католического прихода в Алматы и Казахстане — раздел в разработке. Текст можно задать в админке.</p>'),\n  ('history', 'uk', '<p>Історія греко-католицької парафії в Алмати та Казахстані — розділ у розробці.</p>'),\n  ('history', 'kk', '<p>Алматы мен Қазақстандағы грек-католик қауымының тарихы — бөлім дайындалуда.</p>'),\n  ('history', 'en', '<p>History of the Greek Catholic parish in Almaty and Kazakhstan — content can be edited in the admin panel.</p>')\non conflict (page_key, lang) do nothing"}	init
20260405120000	{"-- Обложка новости + публичные bucket'ы для картинок и файлов Писания\n\nalter table public.news add column if not exists cover_image_url text","insert into storage.buckets (id, name, public)\nvalues ('news-images', 'news-images', true)\non conflict (id) do nothing","insert into storage.buckets (id, name, public)\nvalues ('scripture-books', 'scripture-books', true)\non conflict (id) do nothing","drop policy if exists \\"news_images_public_read\\" on storage.objects","drop policy if exists \\"news_images_staff_all\\" on storage.objects","drop policy if exists \\"scripture_books_public_read\\" on storage.objects","drop policy if exists \\"scripture_books_staff_all\\" on storage.objects","create policy \\"news_images_public_read\\"\n  on storage.objects for select\n  using (bucket_id = 'news-images')","create policy \\"news_images_staff_all\\"\n  on storage.objects for all\n  using (bucket_id = 'news-images' and public.is_staff())\n  with check (bucket_id = 'news-images' and public.is_staff())","create policy \\"scripture_books_public_read\\"\n  on storage.objects for select\n  using (bucket_id = 'scripture-books')","create policy \\"scripture_books_staff_all\\"\n  on storage.objects for all\n  using (bucket_id = 'scripture-books' and public.is_staff())\n  with check (bucket_id = 'scripture-books' and public.is_staff())"}	news_cover_storage
20260406000000	{"-- Ранее: add column cover_image_url на scripture_books.\n-- Обложка хранится в scripture_book_locales.cover_image_url (см. init.sql и 20260407120000)."}	scripture_books_cover
20260407120000	{"-- Связь экземпляров одной «серии» повторяющихся событий (каждая дата — отдельная строка).\nalter table public.liturgical_events\n  add column if not exists recurrence_series_id uuid null","create index if not exists liturgical_events_recurrence_series_idx\n  on public.liturgical_events (recurrence_series_id)\n  where recurrence_series_id is not null"}	liturgical_recurrence_series
20260407120100	{"-- Миграция со старой схемы (плоские колонки) на scripture_book_locales.\n-- Если БД уже создана из обновлённого init.sql без title_ru — шаг пропускается.\ndo $scripture_locales_mig$\nbegin\n  if exists (\n    select 1 from information_schema.columns\n    where table_schema = 'public'\n      and table_name = 'scripture_books'\n      and column_name = 'title_ru'\n  ) then\n  create table public.scripture_book_locales (\n    id uuid primary key default gen_random_uuid(),\n    book_id uuid not null references public.scripture_books (id) on delete cascade,\n    lang text not null check (lang in ('main', 'ru', 'uk', 'kk', 'en')),\n    title text,\n    description text,\n    read_url text,\n    file_url text,\n    cover_image_url text,\n    unique (book_id, lang)\n  );\n\n  create index scripture_book_locales_book_id_idx on public.scripture_book_locales (book_id);\n\n  alter table public.scripture_book_locales enable row level security;\n\n  create policy \\"scripture_book_locales_public_read\\"\n    on public.scripture_book_locales for select using (true);\n\n  create policy \\"scripture_book_locales_staff_write\\"\n    on public.scripture_book_locales for all\n    using (public.is_staff())\n    with check (public.is_staff());\n\n  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)\n  select\n    b.id,\n    'main',\n    nullif(\n      trim(\n        coalesce(\n          nullif(trim(b.title_ru), ''),\n          nullif(trim(b.title_en), ''),\n          nullif(trim(b.title_uk), ''),\n          nullif(trim(b.title_kk), '')\n        )\n      ),\n      ''\n    ),\n    null,\n    nullif(\n      trim(\n        coalesce(\n          nullif(trim(b.read_url_ru), ''),\n          nullif(trim(b.read_url_en), ''),\n          nullif(trim(b.read_url_uk), ''),\n          nullif(trim(b.read_url_kk), '')\n        )\n      ),\n      ''\n    ),\n    nullif(\n      trim(\n        coalesce(\n          nullif(trim(b.file_url_ru), ''),\n          nullif(trim(b.file_url_en), ''),\n          nullif(trim(b.file_url_uk), ''),\n          nullif(trim(b.file_url_kk), '')\n        )\n      ),\n      ''\n    ),\n    b.cover_image_url\n  from public.scripture_books b;\n\n  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)\n  select\n    b.id,\n    'uk',\n    nullif(trim(b.title_uk), ''),\n    null,\n    nullif(trim(b.read_url_uk), ''),\n    nullif(trim(b.file_url_uk), ''),\n    null\n  from public.scripture_books b\n  where\n    nullif(trim(b.title_uk), '') is not null\n    or nullif(trim(b.read_url_uk), '') is not null\n    or nullif(trim(b.file_url_uk), '') is not null;\n\n  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)\n  select\n    b.id,\n    'kk',\n    nullif(trim(b.title_kk), ''),\n    null,\n    nullif(trim(b.read_url_kk), ''),\n    nullif(trim(b.file_url_kk), ''),\n    null\n  from public.scripture_books b\n  where\n    nullif(trim(b.title_kk), '') is not null\n    or nullif(trim(b.read_url_kk), '') is not null\n    or nullif(trim(b.file_url_kk), '') is not null;\n\n  insert into public.scripture_book_locales (book_id, lang, title, description, read_url, file_url, cover_image_url)\n  select\n    b.id,\n    'en',\n    nullif(trim(b.title_en), ''),\n    null,\n    nullif(trim(b.read_url_en), ''),\n    nullif(trim(b.file_url_en), ''),\n    null\n  from public.scripture_books b\n  where\n    nullif(trim(b.title_en), '') is not null\n    or nullif(trim(b.read_url_en), '') is not null\n    or nullif(trim(b.file_url_en), '') is not null;\n\n  alter table public.scripture_books\n    drop column title_ru,\n    drop column title_uk,\n    drop column title_kk,\n    drop column title_en,\n    drop column read_url_ru,\n    drop column read_url_uk,\n    drop column read_url_kk,\n    drop column read_url_en,\n    drop column file_url_ru,\n    drop column file_url_uk,\n    drop column file_url_kk,\n    drop column file_url_en,\n    drop column cover_image_url;\n  end if;\nend\n$scripture_locales_mig$"}	scripture_book_locales
20260408120000	{"-- Язык основной редакции книги (ru | uk | kk | en). NULL = старые записи с lang = 'main'.\nalter table public.scripture_books\n  add column if not exists primary_lang text","alter table public.scripture_books\n  drop constraint if exists scripture_books_primary_lang_check","alter table public.scripture_books\n  add constraint scripture_books_primary_lang_check\n  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'))"}	scripture_primary_lang
20260408140000	{"-- Язык основной редакции для новостей и событий календаря; обложка события\nalter table public.news\n  add column if not exists primary_lang text","alter table public.news\n  drop constraint if exists news_primary_lang_check","alter table public.news\n  add constraint news_primary_lang_check\n  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'))","alter table public.liturgical_events\n  add column if not exists primary_lang text","alter table public.liturgical_events\n  drop constraint if exists liturgical_events_primary_lang_check","alter table public.liturgical_events\n  add constraint liturgical_events_primary_lang_check\n  check (primary_lang is null or primary_lang in ('ru', 'uk', 'kk', 'en'))","alter table public.liturgical_events\n  add column if not exists cover_image_url text"}	news_calendar_primary_cover
20260408160000	{"-- Дополнительные изображения (обложка/основное фото по-прежнему в cover_image_url / cover per locale).\nalter table public.news\n  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb","alter table public.liturgical_events\n  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb","alter table public.scripture_books\n  add column if not exists gallery_image_urls jsonb not null default '[]'::jsonb"}	gallery_image_urls
20260409120000	{"-- Журнал действий в админке (для главной страницы /admin)\ncreate table public.admin_activity_log (\n  id uuid primary key default gen_random_uuid(),\n  created_at timestamptz not null default now(),\n  actor_id uuid not null references public.profiles (id) on delete cascade,\n  actor_email text not null default '',\n  action text not null,\n  entity_type text not null,\n  entity_id text,\n  summary text,\n  meta jsonb not null default '{}'::jsonb\n)","create index admin_activity_log_created_at_idx\n  on public.admin_activity_log (created_at desc)","alter table public.admin_activity_log enable row level security","create policy \\"admin_activity_log_select_staff\\"\n  on public.admin_activity_log for select\n  using (public.is_staff())","create policy \\"admin_activity_log_insert_self\\"\n  on public.admin_activity_log for insert\n  with check (public.is_staff() and actor_id = auth.uid())"}	admin_activity_log
20260410120000	{"-- Кастомные типы событий, подписи типов по языкам, автор события, доп. поля и шаблоны\n\nalter table public.liturgical_events\n  drop constraint if exists liturgical_events_kind_check","alter table public.liturgical_events\n  add column if not exists created_by uuid references public.profiles (id) on delete set null","create table if not exists public.liturgical_event_extra_fields (\n  id uuid primary key default gen_random_uuid(),\n  event_id uuid not null references public.liturgical_events (id) on delete cascade,\n  sort_idx int not null default 0,\n  label_ru text,\n  label_uk text,\n  label_kk text,\n  label_en text,\n  body_ru text,\n  body_uk text,\n  body_kk text,\n  body_en text,\n  url text,\n  created_at timestamptz not null default now()\n)","create index if not exists liturgical_event_extra_fields_event_idx\n  on public.liturgical_event_extra_fields (event_id, sort_idx)","create table if not exists public.liturgical_event_templates (\n  id uuid primary key default gen_random_uuid(),\n  name text not null,\n  created_by uuid references public.profiles (id) on delete set null,\n  created_at timestamptz not null default now()\n)","create table if not exists public.liturgical_event_template_rows (\n  id uuid primary key default gen_random_uuid(),\n  template_id uuid not null references public.liturgical_event_templates (id) on delete cascade,\n  sort_idx int not null default 0,\n  label_ru text,\n  label_uk text,\n  label_kk text,\n  label_en text\n)","create index if not exists liturgical_event_template_rows_tid\n  on public.liturgical_event_template_rows (template_id, sort_idx)","create table if not exists public.liturgical_kind_i18n (\n  kind_slug text not null,\n  lang text not null check (lang in ('ru', 'uk', 'kk', 'en')),\n  label text not null,\n  primary key (kind_slug, lang)\n)","insert into public.liturgical_kind_i18n (kind_slug, lang, label) values\n  ('great_feast', 'ru', 'Великий праздник'),\n  ('great_feast', 'uk', 'Велике свято'),\n  ('great_feast', 'kk', 'Үлкен мереке'),\n  ('great_feast', 'en', 'Great feast'),\n  ('feast', 'ru', 'Праздник'),\n  ('feast', 'uk', 'Свято'),\n  ('feast', 'kk', 'Мереке'),\n  ('feast', 'en', 'Feast'),\n  ('sunday', 'ru', 'Воскресенье'),\n  ('sunday', 'uk', 'Неділя'),\n  ('sunday', 'kk', 'Жексенбі'),\n  ('sunday', 'en', 'Sunday'),\n  ('fast', 'ru', 'Пост'),\n  ('fast', 'uk', 'Піст'),\n  ('fast', 'kk', 'Ораза'),\n  ('fast', 'en', 'Fast'),\n  ('commemoration', 'ru', 'Память'),\n  ('commemoration', 'uk', 'Пам''ять'),\n  ('commemoration', 'kk', 'Еске алу'),\n  ('commemoration', 'en', 'Commemoration'),\n  ('other', 'ru', 'Другое'),\n  ('other', 'uk', 'Інше'),\n  ('other', 'kk', 'Басқа'),\n  ('other', 'en', 'Other')\non conflict (kind_slug, lang) do nothing","alter table public.liturgical_event_extra_fields enable row level security","alter table public.liturgical_event_templates enable row level security","alter table public.liturgical_event_template_rows enable row level security","alter table public.liturgical_kind_i18n enable row level security","create policy \\"liturgical_extra_select\\"\n  on public.liturgical_event_extra_fields for select\n  using (true)","create policy \\"liturgical_extra_staff_write\\"\n  on public.liturgical_event_extra_fields for all\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"liturgical_template_staff\\"\n  on public.liturgical_event_templates for all\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"liturgical_template_rows_staff\\"\n  on public.liturgical_event_template_rows for all\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"liturgical_kind_i18n_select\\"\n  on public.liturgical_kind_i18n for select\n  using (true)","create policy \\"liturgical_kind_i18n_staff_write\\"\n  on public.liturgical_kind_i18n for all\n  using (public.is_staff())\n  with check (public.is_staff())"}	liturgical_extras_templates_kinds_author
20260411130000	{"-- Публичный список приходов Казахстана (редактируется в админке)\n\ncreate table public.kazakhstan_parishes (\n  id uuid primary key default gen_random_uuid(),\n  sort_order int not null default 0,\n  is_published boolean not null default true,\n  parish_photo_url text,\n  priest_photo_url text,\n  website_url text,\n  city_ru text,\n  city_uk text,\n  city_kk text,\n  city_en text,\n  name_ru text,\n  name_uk text,\n  name_kk text,\n  name_en text,\n  address_ru text,\n  address_uk text,\n  address_kk text,\n  address_en text,\n  priest_name_ru text,\n  priest_name_uk text,\n  priest_name_kk text,\n  priest_name_en text,\n  priest_contacts_ru text,\n  priest_contacts_uk text,\n  priest_contacts_kk text,\n  priest_contacts_en text,\n  created_at timestamptz not null default now(),\n  updated_at timestamptz not null default now()\n)","create index kazakhstan_parishes_sort_idx on public.kazakhstan_parishes (sort_order, id)","alter table public.kazakhstan_parishes enable row level security","create policy \\"kazakhstan_parishes_select\\"\n  on public.kazakhstan_parishes for select\n  using (is_published = true or public.is_staff())","create policy \\"kazakhstan_parishes_write\\"\n  on public.kazakhstan_parishes for all\n  using (public.is_staff())\n  with check (public.is_staff())"}	kazakhstan_parishes
20260412120000	{"alter table public.kazakhstan_parishes\n  add column map_embed_src text"}	parish_map_embed
20260413140000	{"-- Приходы: все записи публичны; убираем флаг публикации\ndrop policy if exists \\"kazakhstan_parishes_select\\" on public.kazakhstan_parishes","alter table public.kazakhstan_parishes drop column if exists is_published","create policy \\"kazakhstan_parishes_select\\"\n  on public.kazakhstan_parishes for select\n  using (true)","-- Священнослужители (админка; публичное чтение для будущего раздела на сайте)\ncreate table public.clergy (\n  id uuid primary key default gen_random_uuid(),\n  sort_order int not null default 0,\n  photo_url text,\n  full_name text not null,\n  extra_fields jsonb not null default '[]'::jsonb,\n  created_at timestamptz not null default now(),\n  updated_at timestamptz not null default now()\n)","create index clergy_sort_idx on public.clergy (sort_order, id)","alter table public.clergy enable row level security","create policy \\"clergy_select\\"\n  on public.clergy for select\n  using (true)","create policy \\"clergy_insert\\"\n  on public.clergy for insert\n  with check (public.is_staff())","create policy \\"clergy_update\\"\n  on public.clergy for update\n  using (public.is_staff())\n  with check (public.is_staff())","create policy \\"clergy_delete\\"\n  on public.clergy for delete\n  using (public.is_staff())"}	parishes_published_clergy
20260414120000	{"-- Многоязычные ФИО священнослужителей (RU по умолчанию из существующего full_name)\nalter table public.clergy\n  add column if not exists full_name_ru text,\n  add column if not exists full_name_uk text,\n  add column if not exists full_name_kk text,\n  add column if not exists full_name_en text","update public.clergy\nset full_name_ru = coalesce(nullif(trim(full_name_ru), ''), trim(full_name))\nwhere (full_name_ru is null or trim(full_name_ru) = '')\n  and full_name is not null\n  and trim(full_name) <> ''"}	clergy_i18n_names
20260415120000	{"-- Виджет стороннего литургического календаря (главная, между нашим календарём и Telegram)\ninsert into public.site_settings (key, value) values\n  (\n    'external_liturgical_widget',\n    '{\\"new_julian\\": false, \\"gregorian\\": false}'::jsonb\n  )\non conflict (key) do nothing"}	external_liturgical_widget
20260416120000	{"-- Перевод старого формата { enabled, variant } в { new_julian, gregorian }\nupdate public.site_settings\nset value =\n  case\n    when coalesce(value ? 'new_julian', false) or coalesce(value ? 'gregorian', false) then value\n    when value->>'enabled' = 'true' and value->>'variant' = 'gregorian' then\n      '{\\"new_julian\\": false, \\"gregorian\\": true}'::jsonb\n    when value->>'enabled' = 'true' then '{\\"new_julian\\": true, \\"gregorian\\": false}'::jsonb\n    else '{\\"new_julian\\": false, \\"gregorian\\": false}'::jsonb\n  end\nwhere key = 'external_liturgical_widget'"}	external_liturgical_widget_dual
20260426152500	{"alter table public.profiles\n  add column if not exists can_view_all_objects boolean not null default true,\n  add column if not exists can_edit_all_objects boolean not null default true","update public.profiles\nset\n  can_view_all_objects = true,\n  can_edit_all_objects = true\nwhere role = 'superadmin'"}	profiles_object_permissions
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 4, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: admin_activity_log admin_activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_activity_log
    ADD CONSTRAINT admin_activity_log_pkey PRIMARY KEY (id);


--
-- Name: clergy clergy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clergy
    ADD CONSTRAINT clergy_pkey PRIMARY KEY (id);


--
-- Name: kazakhstan_parishes kazakhstan_parishes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kazakhstan_parishes
    ADD CONSTRAINT kazakhstan_parishes_pkey PRIMARY KEY (id);


--
-- Name: liturgical_event_extra_fields liturgical_event_extra_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_extra_fields
    ADD CONSTRAINT liturgical_event_extra_fields_pkey PRIMARY KEY (id);


--
-- Name: liturgical_event_i18n liturgical_event_i18n_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_i18n
    ADD CONSTRAINT liturgical_event_i18n_pkey PRIMARY KEY (event_id, lang);


--
-- Name: liturgical_event_template_rows liturgical_event_template_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_template_rows
    ADD CONSTRAINT liturgical_event_template_rows_pkey PRIMARY KEY (id);


--
-- Name: liturgical_event_templates liturgical_event_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_templates
    ADD CONSTRAINT liturgical_event_templates_pkey PRIMARY KEY (id);


--
-- Name: liturgical_events liturgical_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_events
    ADD CONSTRAINT liturgical_events_pkey PRIMARY KEY (id);


--
-- Name: liturgical_kind_i18n liturgical_kind_i18n_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_kind_i18n
    ADD CONSTRAINT liturgical_kind_i18n_pkey PRIMARY KEY (kind_slug, lang);


--
-- Name: news_i18n news_i18n_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_i18n
    ADD CONSTRAINT news_i18n_pkey PRIMARY KEY (news_id, lang);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: page_content page_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_content
    ADD CONSTRAINT page_content_pkey PRIMARY KEY (page_key, lang);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: scripture_book_locales scripture_book_locales_book_id_lang_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scripture_book_locales
    ADD CONSTRAINT scripture_book_locales_book_id_lang_key UNIQUE (book_id, lang);


--
-- Name: scripture_book_locales scripture_book_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scripture_book_locales
    ADD CONSTRAINT scripture_book_locales_pkey PRIMARY KEY (id);


--
-- Name: scripture_books scripture_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scripture_books
    ADD CONSTRAINT scripture_books_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (key);


--
-- Name: telegram_messages telegram_messages_chat_id_tg_message_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telegram_messages
    ADD CONSTRAINT telegram_messages_chat_id_tg_message_id_key UNIQUE (chat_id, tg_message_id);


--
-- Name: telegram_messages telegram_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telegram_messages
    ADD CONSTRAINT telegram_messages_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_25 messages_2026_04_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_25
    ADD CONSTRAINT messages_2026_04_25_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_26 messages_2026_04_26_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_26
    ADD CONSTRAINT messages_2026_04_26_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_27 messages_2026_04_27_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_27
    ADD CONSTRAINT messages_2026_04_27_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_28 messages_2026_04_28_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_28
    ADD CONSTRAINT messages_2026_04_28_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_29 messages_2026_04_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_29
    ADD CONSTRAINT messages_2026_04_29_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_30 messages_2026_04_30_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_30
    ADD CONSTRAINT messages_2026_04_30_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: admin_activity_log_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_activity_log_created_at_idx ON public.admin_activity_log USING btree (created_at DESC);


--
-- Name: clergy_sort_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX clergy_sort_idx ON public.clergy USING btree (sort_order, id);


--
-- Name: kazakhstan_parishes_sort_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX kazakhstan_parishes_sort_idx ON public.kazakhstan_parishes USING btree (sort_order, id);


--
-- Name: liturgical_event_extra_fields_event_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX liturgical_event_extra_fields_event_idx ON public.liturgical_event_extra_fields USING btree (event_id, sort_idx);


--
-- Name: liturgical_event_template_rows_tid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX liturgical_event_template_rows_tid ON public.liturgical_event_template_rows USING btree (template_id, sort_idx);


--
-- Name: liturgical_events_date_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX liturgical_events_date_idx ON public.liturgical_events USING btree (event_date);


--
-- Name: liturgical_events_recurrence_series_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX liturgical_events_recurrence_series_idx ON public.liturgical_events USING btree (recurrence_series_id) WHERE (recurrence_series_id IS NOT NULL);


--
-- Name: scripture_book_locales_book_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scripture_book_locales_book_id_idx ON public.scripture_book_locales USING btree (book_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_25_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_25_inserted_at_topic_idx ON realtime.messages_2026_04_25 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_26_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_26_inserted_at_topic_idx ON realtime.messages_2026_04_26 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_27_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_27_inserted_at_topic_idx ON realtime.messages_2026_04_27 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_28_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_28_inserted_at_topic_idx ON realtime.messages_2026_04_28 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_29_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_29_inserted_at_topic_idx ON realtime.messages_2026_04_29 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_30_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_30_inserted_at_topic_idx ON realtime.messages_2026_04_30 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (catalog_id, name);


--
-- Name: idx_iceberg_tables_location; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_location ON storage.iceberg_tables USING btree (location);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (catalog_id, namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2026_04_25_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_25_inserted_at_topic_idx;


--
-- Name: messages_2026_04_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_25_pkey;


--
-- Name: messages_2026_04_26_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_26_inserted_at_topic_idx;


--
-- Name: messages_2026_04_26_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_26_pkey;


--
-- Name: messages_2026_04_27_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_27_inserted_at_topic_idx;


--
-- Name: messages_2026_04_27_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_27_pkey;


--
-- Name: messages_2026_04_28_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_28_inserted_at_topic_idx;


--
-- Name: messages_2026_04_28_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_28_pkey;


--
-- Name: messages_2026_04_29_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_29_inserted_at_topic_idx;


--
-- Name: messages_2026_04_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_29_pkey;


--
-- Name: messages_2026_04_30_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_30_inserted_at_topic_idx;


--
-- Name: messages_2026_04_30_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_30_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: admin_activity_log admin_activity_log_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_activity_log
    ADD CONSTRAINT admin_activity_log_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: liturgical_event_extra_fields liturgical_event_extra_fields_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_extra_fields
    ADD CONSTRAINT liturgical_event_extra_fields_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.liturgical_events(id) ON DELETE CASCADE;


--
-- Name: liturgical_event_i18n liturgical_event_i18n_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_i18n
    ADD CONSTRAINT liturgical_event_i18n_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.liturgical_events(id) ON DELETE CASCADE;


--
-- Name: liturgical_event_template_rows liturgical_event_template_rows_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_template_rows
    ADD CONSTRAINT liturgical_event_template_rows_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.liturgical_event_templates(id) ON DELETE CASCADE;


--
-- Name: liturgical_event_templates liturgical_event_templates_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_event_templates
    ADD CONSTRAINT liturgical_event_templates_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: liturgical_events liturgical_events_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liturgical_events
    ADD CONSTRAINT liturgical_events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: news news_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.profiles(id);


--
-- Name: news_i18n news_i18n_news_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_i18n
    ADD CONSTRAINT news_i18n_news_id_fkey FOREIGN KEY (news_id) REFERENCES public.news(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: scripture_book_locales scripture_book_locales_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scripture_book_locales
    ADD CONSTRAINT scripture_book_locales_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.scripture_books(id) ON DELETE CASCADE;


--
-- Name: iceberg_namespaces iceberg_namespaces_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: admin_activity_log; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.admin_activity_log ENABLE ROW LEVEL SECURITY;

--
-- Name: admin_activity_log admin_activity_log_insert_self; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_activity_log_insert_self ON public.admin_activity_log FOR INSERT WITH CHECK ((public.is_staff() AND (actor_id = auth.uid())));


--
-- Name: admin_activity_log admin_activity_log_select_staff; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_activity_log_select_staff ON public.admin_activity_log FOR SELECT USING (public.is_staff());


--
-- Name: clergy; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.clergy ENABLE ROW LEVEL SECURITY;

--
-- Name: clergy clergy_delete; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY clergy_delete ON public.clergy FOR DELETE USING (public.is_staff());


--
-- Name: clergy clergy_insert; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY clergy_insert ON public.clergy FOR INSERT WITH CHECK (public.is_staff());


--
-- Name: clergy clergy_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY clergy_select ON public.clergy FOR SELECT USING (true);


--
-- Name: clergy clergy_update; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY clergy_update ON public.clergy FOR UPDATE USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: kazakhstan_parishes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.kazakhstan_parishes ENABLE ROW LEVEL SECURITY;

--
-- Name: kazakhstan_parishes kazakhstan_parishes_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY kazakhstan_parishes_select ON public.kazakhstan_parishes FOR SELECT USING (true);


--
-- Name: kazakhstan_parishes kazakhstan_parishes_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY kazakhstan_parishes_write ON public.kazakhstan_parishes USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_event_extra_fields; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_event_extra_fields ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_event_i18n; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_event_i18n ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_event_i18n liturgical_event_i18n_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_event_i18n_public_read ON public.liturgical_event_i18n FOR SELECT USING (true);


--
-- Name: liturgical_event_i18n liturgical_event_i18n_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_event_i18n_staff_write ON public.liturgical_event_i18n USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_event_template_rows; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_event_template_rows ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_event_templates; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_event_templates ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_events; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_events ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_events liturgical_events_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_events_public_read ON public.liturgical_events FOR SELECT USING (true);


--
-- Name: liturgical_events liturgical_events_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_events_staff_write ON public.liturgical_events USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_event_extra_fields liturgical_extra_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_extra_select ON public.liturgical_event_extra_fields FOR SELECT USING (true);


--
-- Name: liturgical_event_extra_fields liturgical_extra_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_extra_staff_write ON public.liturgical_event_extra_fields USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_kind_i18n; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.liturgical_kind_i18n ENABLE ROW LEVEL SECURITY;

--
-- Name: liturgical_kind_i18n liturgical_kind_i18n_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_kind_i18n_select ON public.liturgical_kind_i18n FOR SELECT USING (true);


--
-- Name: liturgical_kind_i18n liturgical_kind_i18n_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_kind_i18n_staff_write ON public.liturgical_kind_i18n USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_event_template_rows liturgical_template_rows_staff; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_template_rows_staff ON public.liturgical_event_template_rows USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: liturgical_event_templates liturgical_template_staff; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY liturgical_template_staff ON public.liturgical_event_templates USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: news; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.news ENABLE ROW LEVEL SECURITY;

--
-- Name: news_i18n; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.news_i18n ENABLE ROW LEVEL SECURITY;

--
-- Name: news_i18n news_i18n_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY news_i18n_select ON public.news_i18n FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.news n
  WHERE ((n.id = news_i18n.news_id) AND ((n.is_published = true) OR public.is_staff())))));


--
-- Name: news_i18n news_i18n_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY news_i18n_write ON public.news_i18n USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: news news_select; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY news_select ON public.news FOR SELECT USING (((is_published = true) OR public.is_staff()));


--
-- Name: news news_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY news_write ON public.news USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: page_content; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.page_content ENABLE ROW LEVEL SECURITY;

--
-- Name: page_content page_content_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY page_content_public_read ON public.page_content FOR SELECT USING (true);


--
-- Name: page_content page_content_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY page_content_staff_write ON public.page_content USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles profiles_select_own_or_super; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_select_own_or_super ON public.profiles FOR SELECT USING (((auth.uid() = id) OR public.is_superadmin()));


--
-- Name: profiles profiles_update_self; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_update_self ON public.profiles FOR UPDATE USING ((auth.uid() = id)) WITH CHECK ((auth.uid() = id));


--
-- Name: profiles profiles_update_super; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY profiles_update_super ON public.profiles FOR UPDATE USING (public.is_superadmin());


--
-- Name: scripture_book_locales; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.scripture_book_locales ENABLE ROW LEVEL SECURITY;

--
-- Name: scripture_book_locales scripture_book_locales_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY scripture_book_locales_public_read ON public.scripture_book_locales FOR SELECT USING (true);


--
-- Name: scripture_book_locales scripture_book_locales_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY scripture_book_locales_staff_write ON public.scripture_book_locales USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: scripture_books; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.scripture_books ENABLE ROW LEVEL SECURITY;

--
-- Name: scripture_books scripture_books_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY scripture_books_public_read ON public.scripture_books FOR SELECT USING (true);


--
-- Name: scripture_books scripture_books_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY scripture_books_staff_write ON public.scripture_books USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: site_settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.site_settings ENABLE ROW LEVEL SECURITY;

--
-- Name: site_settings site_settings_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY site_settings_public_read ON public.site_settings FOR SELECT USING (true);


--
-- Name: site_settings site_settings_staff_write; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY site_settings_staff_write ON public.site_settings USING (public.is_staff()) WITH CHECK (public.is_staff());


--
-- Name: telegram_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.telegram_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: telegram_messages telegram_messages_public_read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY telegram_messages_public_read ON public.telegram_messages FOR SELECT USING (true);


--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects news_images_public_read; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY news_images_public_read ON storage.objects FOR SELECT USING ((bucket_id = 'news-images'::text));


--
-- Name: objects news_images_staff_all; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY news_images_staff_all ON storage.objects USING (((bucket_id = 'news-images'::text) AND public.is_staff())) WITH CHECK (((bucket_id = 'news-images'::text) AND public.is_staff()));


--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: objects scripture_books_public_read; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY scripture_books_public_read ON storage.objects FOR SELECT USING ((bucket_id = 'scripture-books'::text));


--
-- Name: objects scripture_books_staff_all; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY scripture_books_staff_all ON storage.objects USING (((bucket_id = 'scripture-books'::text) AND public.is_staff())) WITH CHECK (((bucket_id = 'scripture-books'::text) AND public.is_staff()));


--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION is_staff(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_staff() TO anon;
GRANT ALL ON FUNCTION public.is_staff() TO authenticated;
GRANT ALL ON FUNCTION public.is_staff() TO service_role;


--
-- Name: FUNCTION is_superadmin(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_superadmin() TO anon;
GRANT ALL ON FUNCTION public.is_superadmin() TO authenticated;
GRANT ALL ON FUNCTION public.is_superadmin() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE admin_activity_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.admin_activity_log TO anon;
GRANT ALL ON TABLE public.admin_activity_log TO authenticated;
GRANT ALL ON TABLE public.admin_activity_log TO service_role;


--
-- Name: TABLE clergy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.clergy TO anon;
GRANT ALL ON TABLE public.clergy TO authenticated;
GRANT ALL ON TABLE public.clergy TO service_role;


--
-- Name: TABLE kazakhstan_parishes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.kazakhstan_parishes TO anon;
GRANT ALL ON TABLE public.kazakhstan_parishes TO authenticated;
GRANT ALL ON TABLE public.kazakhstan_parishes TO service_role;


--
-- Name: TABLE liturgical_event_extra_fields; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_event_extra_fields TO anon;
GRANT ALL ON TABLE public.liturgical_event_extra_fields TO authenticated;
GRANT ALL ON TABLE public.liturgical_event_extra_fields TO service_role;


--
-- Name: TABLE liturgical_event_i18n; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_event_i18n TO anon;
GRANT ALL ON TABLE public.liturgical_event_i18n TO authenticated;
GRANT ALL ON TABLE public.liturgical_event_i18n TO service_role;


--
-- Name: TABLE liturgical_event_template_rows; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_event_template_rows TO anon;
GRANT ALL ON TABLE public.liturgical_event_template_rows TO authenticated;
GRANT ALL ON TABLE public.liturgical_event_template_rows TO service_role;


--
-- Name: TABLE liturgical_event_templates; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_event_templates TO anon;
GRANT ALL ON TABLE public.liturgical_event_templates TO authenticated;
GRANT ALL ON TABLE public.liturgical_event_templates TO service_role;


--
-- Name: TABLE liturgical_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_events TO anon;
GRANT ALL ON TABLE public.liturgical_events TO authenticated;
GRANT ALL ON TABLE public.liturgical_events TO service_role;


--
-- Name: TABLE liturgical_kind_i18n; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.liturgical_kind_i18n TO anon;
GRANT ALL ON TABLE public.liturgical_kind_i18n TO authenticated;
GRANT ALL ON TABLE public.liturgical_kind_i18n TO service_role;


--
-- Name: TABLE news; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news TO anon;
GRANT ALL ON TABLE public.news TO authenticated;
GRANT ALL ON TABLE public.news TO service_role;


--
-- Name: TABLE news_i18n; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.news_i18n TO anon;
GRANT ALL ON TABLE public.news_i18n TO authenticated;
GRANT ALL ON TABLE public.news_i18n TO service_role;


--
-- Name: TABLE page_content; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.page_content TO anon;
GRANT ALL ON TABLE public.page_content TO authenticated;
GRANT ALL ON TABLE public.page_content TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE scripture_book_locales; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.scripture_book_locales TO anon;
GRANT ALL ON TABLE public.scripture_book_locales TO authenticated;
GRANT ALL ON TABLE public.scripture_book_locales TO service_role;


--
-- Name: TABLE scripture_books; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.scripture_books TO anon;
GRANT ALL ON TABLE public.scripture_books TO authenticated;
GRANT ALL ON TABLE public.scripture_books TO service_role;


--
-- Name: TABLE site_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.site_settings TO anon;
GRANT ALL ON TABLE public.site_settings TO authenticated;
GRANT ALL ON TABLE public.site_settings TO service_role;


--
-- Name: TABLE telegram_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.telegram_messages TO anon;
GRANT ALL ON TABLE public.telegram_messages TO authenticated;
GRANT ALL ON TABLE public.telegram_messages TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_04_25; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_25 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_25 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_26; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_26 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_26 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_27; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_27 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_27 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_28; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_28 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_28 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_29; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_29 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_29 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_30; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_30 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_30 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE iceberg_namespaces; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_namespaces TO service_role;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO anon;


--
-- Name: TABLE iceberg_tables; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_tables TO service_role;
GRANT SELECT ON TABLE storage.iceberg_tables TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_tables TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO postgres;
GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO postgres;
GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict khhIUGKmUTBKizvXbXL4hMOvcA66yAPytEdslJtJW7mKFg0b9ncJNZ6s69As3NP

