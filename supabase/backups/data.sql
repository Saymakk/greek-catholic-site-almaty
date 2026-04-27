SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict I1goM2FONSLLYi4dAfDRm3mIwPOzmKjKNG3w4fhKefOaB77zFuBenw0KFsqVjX1

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
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
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	1f7fb491-43db-4ead-a0ad-31876880e847	authenticated	authenticated	vladsarana@gmail.com	$2a$10$zS57ZDv9MS1eHi.22NF/Pe6L20LOcRN4Zi4ZWtXPo2aAh8nW408o6	2026-04-26 18:23:02.722022+00	\N		\N		\N			\N	2026-04-26 20:42:18.184428+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-26 18:23:02.716935+00	2026-04-27 02:59:57.912312+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	8855aa14-c74e-489e-9bf2-737cc572b5cb	authenticated	authenticated	oleh.halushka@gmail.com	$2a$10$//KnsHHF2tkuPhRp9.HkxOwl9b.W1T3arXI8kUTGPxFbUM9o8AO1a	2026-04-27 03:16:40.853447+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-27 03:16:40.845675+00	2026-04-27 03:16:40.85401+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	41913d45-2416-4e03-9979-5029f28644e8	authenticated	authenticated	oleh.halushka1979@gmail.com	$2a$10$HvGslNt8Ut2748I.XUWBSenSKTdDEI3f.jyer3P0QGNnEKpAs6R7m	2026-04-27 03:17:27.074508+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-04-27 03:17:27.070229+00	2026-04-27 03:17:27.075012+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
1f7fb491-43db-4ead-a0ad-31876880e847	1f7fb491-43db-4ead-a0ad-31876880e847	{"sub": "1f7fb491-43db-4ead-a0ad-31876880e847", "email": "vladsarana@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-26 18:23:02.71976+00	2026-04-26 18:23:02.719793+00	2026-04-26 18:23:02.719793+00	7d2bd95c-205b-4751-80b9-bec3dabed0e7
8855aa14-c74e-489e-9bf2-737cc572b5cb	8855aa14-c74e-489e-9bf2-737cc572b5cb	{"sub": "8855aa14-c74e-489e-9bf2-737cc572b5cb", "email": "oleh.halushka@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-27 03:16:40.851145+00	2026-04-27 03:16:40.85118+00	2026-04-27 03:16:40.85118+00	c318094d-c5ba-4500-b762-eae783740e73
41913d45-2416-4e03-9979-5029f28644e8	41913d45-2416-4e03-9979-5029f28644e8	{"sub": "41913d45-2416-4e03-9979-5029f28644e8", "email": "oleh.halushka1979@gmail.com", "email_verified": false, "phone_verified": false}	email	2026-04-27 03:17:27.072653+00	2026-04-27 03:17:27.072684+00	2026-04-27 03:17:27.072684+00	e03e9f20-d2a3-407a-9e7b-ce2f653aa58f
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
eeec0e89-5488-4133-b98f-de7d533ecd64	1f7fb491-43db-4ead-a0ad-31876880e847	2026-04-26 20:42:18.184507+00	2026-04-27 03:01:15.195506+00	\N	aal1	\N	2026-04-27 03:01:15.195456	node	172.18.0.1	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
eeec0e89-5488-4133-b98f-de7d533ecd64	2026-04-26 20:42:18.191161+00	2026-04-26 20:42:18.191161+00	password	f34b79a1-6ecc-4035-9aa9-21a49bc60831
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	1	ecefb5hql7ul	1f7fb491-43db-4ead-a0ad-31876880e847	t	2026-04-26 20:42:18.187348+00	2026-04-26 21:41:04.356678+00	\N	eeec0e89-5488-4133-b98f-de7d533ecd64
00000000-0000-0000-0000-000000000000	2	uzleumrh7cmf	1f7fb491-43db-4ead-a0ad-31876880e847	t	2026-04-26 21:41:04.358219+00	2026-04-27 02:59:57.910489+00	ecefb5hql7ul	eeec0e89-5488-4133-b98f-de7d533ecd64
00000000-0000-0000-0000-000000000000	3	6cyhv2ewbfzr	1f7fb491-43db-4ead-a0ad-31876880e847	f	2026-04-27 02:59:57.911293+00	2026-04-27 02:59:57.911293+00	uzleumrh7cmf	eeec0e89-5488-4133-b98f-de7d533ecd64
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_challenges" ("id", "user_id", "challenge_type", "session_data", "created_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."webauthn_credentials" ("id", "user_id", "credential_id", "public_key", "attestation_type", "aaguid", "sign_count", "transports", "backup_eligible", "backed_up", "friendly_name", "created_at", "updated_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."profiles" ("id", "email", "full_name", "role", "created_at", "can_view_all_objects", "can_edit_all_objects") FROM stdin;
1f7fb491-43db-4ead-a0ad-31876880e847	vladsarana@gmail.com	\N	superadmin	2026-04-26 18:23:02.716686+00	t	t
8855aa14-c74e-489e-9bf2-737cc572b5cb	oleh.halushka@gmail.com	Олег Галушка	admin	2026-04-27 03:16:40.845349+00	t	t
41913d45-2416-4e03-9979-5029f28644e8	oleh.halushka1979@gmail.com	Олег Галушка	admin	2026-04-27 03:17:27.069947+00	t	t
\.


--
-- Data for Name: admin_activity_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."admin_activity_log" ("id", "created_at", "actor_id", "actor_email", "action", "entity_type", "entity_id", "summary", "meta") FROM stdin;
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

COPY "public"."clergy" ("id", "sort_order", "photo_url", "full_name", "extra_fields", "created_at", "updated_at", "full_name_ru", "full_name_uk", "full_name_kk", "full_name_en") FROM stdin;
1f84b456-d66e-4538-b69a-43f1900377f9	0	https://www.vatican.va/content/dam/vatican/leone-xiv/Foto-Ufficiale-Papa-Leone-XIV_Copyright-VATICAN-MEDIA.jpg	Лев XIV	[{"url": null, "labels": {"ru": "Титул", "uk": "Титул"}, "values": {"ru": "Его Святейшество Папа Лев XIV, Епископ Рима, верховный первосвященник Вселенской Церкви.", "uk": "Його Святість Папа Лев XIV, Єпископ Риму, верховний первосвященик Вселенської Церкви."}}]	2026-04-27 03:09:09.282371+00	2026-04-27 03:09:09.27+00	\N	Лев XIV	\N	\N
c598081d-39bc-4e02-b7e4-ba5988692a24	1	https://synod.ugcc.ua/pub/images/91049c3c939666f1.jpg	Блаженнейший Святослав Шевчук	[{"url": null, "labels": {"en": "Title", "kk": "Атауы", "ru": "Титул", "uk": "Титул"}, "values": {"en": "Father and Head of the Ukrainian Greek Catholic Church", "kk": "Украиналық грек-католик шіркеуінің әкесі және басшысы", "ru": "Отец и Глава Украинской Греко-Католической Церкви", "uk": "Отець і Глава Української Греко-Католицької Церкви"}}, {"url": null, "labels": {"en": "Short biography", "kk": "Қысқаша өмірбаян", "ru": "Краткая биография", "uk": "Коротка біографія"}, "values": {"en": "His Beatitude Sviatoslav Shevchuk is the Father and Head of the Ukrainian Greek Catholic Church.\\n\\nHe was born on May 5, 1970 in the city of Stryi (Lviv region) into a Christian family. From childhood he was involved in the life of the underground UGCC, which significantly influenced his spiritual formation. He studied at a music school, where he mastered the violin and piano.\\nAfter school, he received a medical education at the Boryslav Medical School and served as a paramedic in the Soviet Army. At the same time, he underwent training at an underground theological seminary.\\nHe was ordained a priest on June 26, 1994. He studied in Argentina and Rome, where he received a doctorate in theology. After returning to Ukraine, he held various positions at the Lviv Theological Seminary and the Ukrainian Catholic University, and was also the personal secretary of His Beatitude Lubomyr Husar.\\nIn 2009, he was ordained a bishop and served in Argentina. On March 23, 2011, he was elected Head of the Ukrainian Greek Catholic Church, and on March 27, his enthronement took place in Kyiv.\\nHe speaks many languages, is actively engaged in teaching and pastoral activities. He is known for his openness, intellectuality, and dedication to serving the Church.", "kk": "Оның ізашары Святослав Шевчук - Украина грек-католик шіркеуінің әкесі және басшысы.\\n\\nОл 1970 жылы 5 мамырда Стрый қаласында (Львов облысы) христиан отбасында дүниеге келген. Бала кезінен бастап ол жер асты UGCC өміріне араласып, рухани қалыптасуына айтарлықтай әсер етті. Ол музыка мектебінде оқыды, онда скрипка мен фортепианода ойнауды меңгерді.\\nМектептен кейін Борислав медициналық мектебінде медициналық білім алып, Кеңес Армиясында фельдшер болып қызмет етті. Сонымен қатар, жер асты теологиялық семинариясында оқудан өтті.\\n1994 жылы 26 маусымда діни қызметкер болып тағайындалды. Аргентина мен Римде білім алып, теология докторы дәрежесін алды. Украинаға оралғаннан кейін Львов теологиялық семинариясында және Украина католик университетінде әртүрлі лауазымдарды атқарды, сонымен қатар оның ізашары Любомыр Гусардың жеке хатшысы болды.\\n2009 жылы ол епископ болып тағайындалды және Аргентинада қызмет етті. 2011 жылдың 23 наурызында ол Украинаның грек-католик шіркеуінің басшысы болып сайланды, ал 27 наурызда оның таққа отыруы Киевте өтті.\\nОл көптеген тілдерде сөйлейді, оқытушылық және пасторлық қызметпен белсенді айналысады. Ол өзінің ашықтығымен, интеллектуалдылығымен және шіркеуге қызмет етуге берілгендігімен танымал.", "ru": "Блаженнейший Святослав Шевчук – Отец и Глава Украинской Греко-Католической Церкви.\\n\\nРодился 5 мая 1970 года в городе Стрый (Львовская область) в христианской семье. С детства был вовлечен в жизнь подпольной УГКЦ, что повлияло на его духовное формирование. Учился в музыкальной школе, где овладел скрипкой и фортепиано.\\nПосле школы получил медицинское образование в Бориславском медицинском училище и служил фельдшером в Советской армии. В то же время проходил подготовку в подпольной духовной семинарии.\\nСвященничества получил 26 июня 1994 года. Учился в Аргентине и Риме, где получил докторскую степень по богословию. После возвращения в Украину занимал разные должности во Львовской духовной семинарии и Украинском католическом университете, а также был личным секретарем Блаженнейшего Любомира Гузара.\\nВ 2009 году был рукоположен в епископы и служил в Аргентине. 23 марта 2011 избран Главой Украинской Греко-Католической Церкви, а 27 марта состоялась его интронизация в Киеве.\\nГоворит  на многих языках, активно занимается преподавательской и пастырской деятельностью. Известен своей открытостью, интеллектуальностью и преданностью служению Церкви.", "uk": "Блаженніший Святослав Шевчук — Отець і Глава Української Греко-Католицької Церкви.\\n\\nНародився 5 травня 1970 року в місті Стрий (Львівська область) у християнській родині. З дитинства був залучений до життя підпільної УГКЦ, що значно вплинуло на його духовне формування. Навчався у музичній школі, де опанував скрипку та фортепіано.\\nПісля школи здобув медичну освіту в Бориславському медичному училищі та служив фельдшером у Радянській армії. Водночас проходив підготовку в підпільній духовній семінарії.\\nСвященичі свячення отримав 26 червня 1994 року. Навчався в Аргентині та Римі, де здобув докторський ступінь з богослов’я. Після повернення до України обіймав різні посади у Львівській духовній семінарії та Українському католицькому університеті, а також був особистим секретарем Блаженнішого Любомира Гузара.\\nУ 2009 році був висвячений на єпископа та служив в Аргентині. 23 березня 2011 року обраний Главою Української Греко-Католицької Церкви, а 27 березня відбулася його інтронізація в Києві.\\nВолодіє багатьма мовами, активно займається викладацькою та пастирською діяльністю. Відомий своєю відкритістю, інтелектуальністю та відданістю служінню Церкві."}}, {"url": null, "labels": {"en": "Contacts", "kk": "Байланыстар", "ru": "Контакты", "uk": "Контакти"}, "values": {"en": "Address: P.O. Box 210, Kyiv 02002, Ukraine\\n\\nPhone: +38 (044) 541-11-14\\nFax: +38 (044) 541-11-14\\n\\nE-mail: Ver_Arch@ugcc.org.ua", "kk": "Мекенжайы: P.O. Box 210, Киев 02002, Украина\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЭлектрондық пошта: Ver_Arch@ugcc.org.ua", "ru": "Адрес: а/я 210, Киев 02002, Украина\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЭл. почта: Ver_Arch@ugcc.org.ua", "uk": "Адреса: а/с 210, Київ 02002, Україна\\n\\nТелефон: +38 (044) 541-11-14\\nФакс: +38 (044) 541-11-14\\n\\nЕл. пошта: Ver_Arch@ugcc.org.ua"}}]	2026-04-27 03:12:25.114754+00	2026-04-27 03:12:25.106+00	Блаженнейший Святослав Шевчук	Блаженніший Святослав Шевчук	Оның аруағы Святослав Шевчук	His Beatitude Sviatoslav Shevchuk
277b06b1-2b27-4295-81d8-4ef4d5f465ce	2	https://static.wixstatic.com/media/c3aa9c_257a46a2605e41278776f69490f0543b~mv2.jpg/v1/fill/w_953,h_1062,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_257a46a2605e41278776f69490f0543b~mv2.jpg	Митрофорный Протоиерей Василий Говера	[{"url": null, "labels": {"ru": "Титул", "uk": "Титул"}, "values": {"ru": "Апостольский Администратор для католиков византийского обряда в Казахстане и Центральной Азии.", "uk": "Апостольський Адміністратор для католиків візантійського обряду у Казахстані та Центральній Азії."}}, {"url": null, "labels": {"ru": "Краткая биография", "uk": "Коротка біографія"}, "values": {"ru": "Апостольский Администратор для католиков византийского обряда в Казахстане и Центральной Азии.\\nРодился 11 декабря 1972 года в г. Ивано-Франковск. Украина.\\nС 1990 по 1996 год учился в Люблинском Католическом Университете (Польша).\\n2 марта 1997 года во Львове рукоположен в священники.\\nС 3 апреля 1997 года по 2021 год настоятель греко-католического прихода Покрова Пресвятой Богородицы в Караганде.\\n 1 июня 2019 года назначен папой Франциском Апостольским Администратором для католиков византийского обряда в Казахстане и Центральной Азии\\nПриписан к Львовской Архиепархии.", "uk": "Апостольський Адміністратор для католиків візантійського обряду у Казахстані та Центральній Азії.\\nНародився 11 грудня 1972 року у м. Івано-Франківську. Україна.\\nЗ 1990 до 1996 року навчався в Люблінському Католицькому Університеті (Польща).\\n2 березня 1997 року у Львові висвячений на священика.\\nЗ 3 квітня 1997 року до 2021 року настоятель греко-католицької парафії Покрови Пресвятої Богородиці в Караганді. \\n1 червня 2019 року призначений папою Франциском Апостольським Адміністратором для католиків візантійського обряду в Казахстані та Центральній Азії.\\nПриписано до Львівської Архієпархії."}}, {"url": null, "labels": {"ru": "Контакты", "uk": "Контакти"}, "values": {"ru": "ул. Пищевая, 3\\n100022 г. Караганда\\nРеспублика Казахстан\\n\\nтел: +7 (7212) 51 25 64\\nмоб. тел.: +7 705 10 88 000,\\nE-mail: pokrovakaz@gmail.com\\nSkype: vasyl.hovera", "uk": "вул. Пищевая, 3\\n100022 г. Караганда\\nРеспублiка Казахстан\\n\\nтел: +7 (7212) 51 25 64\\nмоб. тел.: +7 705 10 88 000,\\nE-mail: pokrovakaz@gmail.com\\nSkype: vasyl.hovera"}}]	2026-04-27 03:14:13.515781+00	2026-04-27 03:14:13.505+00	Митрофорный Протоиерей Василий Говера	Митрофорний Протоієрей Василь Говера	\N	\N
\.


--
-- Data for Name: kazakhstan_parishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."kazakhstan_parishes" ("id", "sort_order", "parish_photo_url", "priest_photo_url", "website_url", "city_ru", "city_uk", "city_kk", "city_en", "name_ru", "name_uk", "name_kk", "name_en", "address_ru", "address_uk", "address_kk", "address_en", "priest_name_ru", "priest_name_uk", "priest_name_kk", "priest_name_en", "priest_contacts_ru", "priest_contacts_uk", "priest_contacts_kk", "priest_contacts_en", "created_at", "updated_at", "map_embed_src") FROM stdin;
3f52845f-97e6-4171-b27d-d2754bba22c8	0	https://static.wixstatic.com/media/c3aa9c_9408dbd229654e7db89267e5ec79eb3b~mv2.jpg/v1/fill/w_980,h_1236,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_9408dbd229654e7db89267e5ec79eb3b~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_ff5678a2fe9c4ba3a60df708a0072577~mv2.jpg/v1/fill/w_819,h_817,al_c,q_85,enc_avif,quality_auto/c3aa9c_ff5678a2fe9c4ba3a60df708a0072577~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%BA%D0%B0%D1%80%D0%B0%D0%B3%D0%B0%D0%BD%D0%B4%D0%B0	Караганда	Караганда	\N	\N	Греко-католический Приход Покрова Пресвятой Богородицы	Греко-католицька Парафія Покрова Пресвятої Богородиці	\N	\N	ул. Пищевая, 1\r\n100022 Караганда\r\nРеспублика Казахстан	вул. Пищевая, 1\r\n100022 Караганда\r\nРеспублiка Казахстан	\N	\N	о. Дмитрий-Роман Козак	о. Дмитро-Роман Козак	\N	\N	тел/факс: +7 (7212) 51 25 64\r\nмоб. тел.: +7 771 373 77 87,\r\nE-mail: dmytrokozak@gmail.com	тел/факс: +7 (7212) 51 25 64\r\nмоб. тел.: +7 771 373 77 87,\r\nE-mail: dmytrokozak@gmail.com	\N	\N	2026-04-27 03:01:15.36769+00	2026-04-27 03:01:15.355+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d910.5070833008743!2d73.12049207887327!3d49.7991722747861!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4243470df9b3b23f%3A0x2dc479d91a795969!2z0JPRgNC10LrQvi3QutCw0YLQvtC70LjRh9C10YHQutCw0Y8g0YbQtdGA0LrQvtCy0Ywg0J_QvtC60YDQvtCy0LAg0JHQvtCz0L7RgNC-0LTQuNGG0Ys!5e0!3m2!1sru!2skz!4v1775459866038!5m2!1sru!2skz
c9e4c61e-cc2d-4e7f-bb4b-0ffc681d3b9a	1	https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/a8/1f/18/almaty-catholic-cathedral.jpg?w=900&h=-1&s=1	https://fqqjsaztkxlrzombqdag.supabase.co/storage/v1/object/public/news-images/parishes/87e3b0af-5200-455d-950d-39beb692f516/priest_1775416717299.png	https://www.ugcc-almaty.com/	Алматы	Алмати	\N	\N	Греко-католический Приход Блаженного Алексия Зарицкого	Греко-католицька Парафія Блаженного Олексія Зарицького	\N	\N	Казахстан, г. Алматы, Тлендиева 9	Казахстан, м. Алмати, Тлендієва 9	\N	\N	Священник Олег	Священик Олег	\N	\N	+7 705 972 30 50	\N	\N	\N	2026-04-27 03:02:22.936098+00	2026-04-27 03:02:22.927+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2905.78928166767!2d76.86756577661457!3d43.255837878039785!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x388369823d000001%3A0xe5cfe59f1bfb932a!2z0KDQuNC80YHQutC-LdCa0LDRgtC-0LvQuNGH0LXRgdC60LjQuSDQodC-0LHQvtGAINCf0YDQtdGB0LLRj9GC0L7QuSDQotGA0L7QuNGG0Ys!5e0!3m2!1sru!2skz!4v1775402248459!5m2!1sru!2skz
b90965a2-f946-42e9-b7c5-94cf8c635558	2	https://static.wixstatic.com/media/c3aa9c_026a6fb55c0b4a9db2999e6571d843e0~mv2.jpeg/v1/fill/w_960,h_1211,al_c,q_85,enc_avif,quality_auto/c3aa9c_026a6fb55c0b4a9db2999e6571d843e0~mv2.jpeg	https://static.wixstatic.com/media/c3aa9c_f8ce988077a94b98b30efa3bc1888f32~mv2.jpg/v1/fill/w_953,h_995,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_f8ce988077a94b98b30efa3bc1888f32~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%B0%D1%81%D1%82%D0%B0%D0%BD%D0%B0	Астана	Астана	\N	\N	Греко-католический Приход Святого Иосифа Обручника В Астане	Греко-католицька парафія Святого Йосипа Обручника В Астані	\N	\N	ул. Арасан 2/2\r\n010000 г. Астана\r\nРеспублика Казахстан	вул. Арасан 2/2\r\n010000 м. Астана\r\nРеспублiка Казахстан	\N	\N	о. Игорь Свитовый	о. Ігор Світовий	\N	\N	Для писем:\r\nул. Арасан 2/2, а/я 622\r\n010010 г. Астана\r\nРеспублика Казахстан\r\n\r\nмоб. тел.: +7 705 157 3452\r\nigorsvitovyj@gmail.com	Для листів:\r\nвул. Арасан 2/2, а/я 622\r\n010010 г. Астана\r\nРеспублика Казахстан\r\n\r\nмоб. тел.: +7 705 157 3452\r\nigorsvitovyj@gmail.com	\N	\N	2026-04-27 03:03:56.296726+00	2026-04-27 03:03:56.289+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1052.2448667585138!2d71.44718384107685!3d51.15135948322764!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4245815c153a4e35%3A0xafc1eb86ca018a3!2z0KPQutGA0LDQuNC90YHQutCw0Y8g0LPRgNC10LrQvtC60LDRgtC-0LvQuNGH0LXRgdC60LDRjyDRhtC10YDQutC-0LLRjA!5e0!3m2!1sru!2skz!4v1775460254645!5m2!1sru!2skz
a85b8ad7-1431-4589-a283-b0773879f16c	3	https://static.wixstatic.com/media/c3aa9c_7e9db7a0a5ad4f56b54d020adb276831~mv2.jpg/v1/fill/w_980,h_667,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_7e9db7a0a5ad4f56b54d020adb276831~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_e585bb44a37a4ec48577b5d0f55a8773~mv2.jpg/v1/fill/w_716,h_720,al_c,q_85,enc_avif,quality_auto/c3aa9c_e585bb44a37a4ec48577b5d0f55a8773~mv2.jpg	https://www.ugcc-kazakhstan.com/%D0%BF%D0%B0%D0%B2%D0%BB%D0%BE%D0%B4%D0%B0%D1%80	Павлодар	Павлодар	\N	\N	Греко-католический Приход Святых Верховных Апостолов Петра И Павла	Греко-католицька парафія Святих Верховних Апостолів Петра І Павла	\N	\N	ул. Елгина, 13\r\nг. Павлодар\r\nРеспублика Казахстан	вул. Елгина, 13\r\nм. Павлодар	\N	\N	о. Ярослав Головчук	о. Ярослав Головчук	\N	\N	тел: +7 (7182) 33 58 91\r\nмоб. тел.: +7 7710420001\r\nE-mail: yaroslav.golovchuk@gmail.com\r\nSkype: pater_jaroslav	тел: +7 (7182) 33 58 91\r\nмоб. тел.: +7 7710420001\r\nE-mail: yaroslav.golovchuk@gmail.com\r\nSkype: pater_jaroslav	\N	\N	2026-04-27 03:05:07.857786+00	2026-04-27 03:05:07.847+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d512.9577579383!2d76.9871880098277!3d52.29690951782679!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x42f9cb26b1b5ef8d%3A0x9683906deab5bc58!2z0KPQutGA0LDQuNC90YHQutCw0Y8g0JPRgNC10LrQvi3QmtCw0YLQvtC70LjRh9C10YHQutCw0Y8g0KbQtdGA0LrQvtCy0Yw!5e0!3m2!1sru!2skz!4v1775460871977!5m2!1sru!2skz
962f4afe-b211-4b3c-b55d-d4f77f202136	5	https://static.wixstatic.com/media/c3aa9c_7a65924f00a74df79cee59e89d701f79~mv2.jpeg/v1/fill/w_980,h_955,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_7a65924f00a74df79cee59e89d701f79~mv2.jpeg	https://static.wixstatic.com/media/c3aa9c_d11bb6b0026d4d868162891760163b62~mv2.jpg/v1/fill/w_565,h_509,al_c,q_80,enc_avif,quality_auto/c3aa9c_d11bb6b0026d4d868162891760163b62~mv2.jpg	https://www.ugcc-kazakhstan.com/%D1%88%D0%B8%D0%B4%D0%B5%D1%80%D1%82%D1%8B	Шидерты	Шидерти	\N	\N	Греко-католический Приход Рождества Пресвятой Богородицы В Шидерты	Греко-католицька Парафія Різдва Пресвятої Богородиці У Шидерти	\N	\N	ул. Школьная 10 пос. Шидерты, г. Экибастуз, Павлодарская обл.	вул. Шкільна 10 сел. Шидерти, м. Екібастуз, Павлодарська обл.	\N	\N	о. Александр Адоменас	о. Олександр Адоменас	\N	\N	моб. тел.: +7 776 418 33 42\r\n\r\nE-mail: shidertyhram@gmail.com\\	\N	\N	\N	2026-04-27 03:07:57.308145+00	2026-04-27 03:07:57.298+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d904.3039864258567!2d74.67875152617258!3d51.714963000096425!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x42575f441b676f7b%3A0xb287287e13265824!2zMTQwMDAwINCo0LjQtNC10YDRgtGL!5e1!3m2!1sru!2skz!4v1775461621576!5m2!1sru!2skz
e7ca9d6f-a400-4f03-afd3-92cb4aacd237	4	https://static.wixstatic.com/media/c3aa9c_c07c9a0f5de648ecbd9d4a9b0ad39385~mv2.jpg/v1/fill/w_980,h_667,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_c07c9a0f5de648ecbd9d4a9b0ad39385~mv2.jpg	https://static.wixstatic.com/media/c3aa9c_c20e4d340fa748a2bd6ade927cb9295a~mv2.jpg/v1/fill/w_953,h_918,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_c20e4d340fa748a2bd6ade927cb9295a~mv2.jpg	https://www.ugcc-kazakhstan.com/%D1%81%D0%B0%D1%82%D0%BF%D0%B0%D0%B5%D0%B2	Сатпаев	Сатпаєв	\N	\N	Греко-католический Приход Святого Пророка Илии В Сатпаеве	Греко-католицька парафія Святого Пророка Іллі У Сатпаєві	\N	\N	ул. Абая Кунанбаева, дом 5/5, кв. 46\r\n200003 г. Сатпаев, обл. Ұлытау\r\nРеспублика Казахстан	вул. Абая Кунанбаева, буд. 5/5, кв. 46\r\n200003 г. Сатпаев, обл. Ұлытау\r\nРеспублiка Казахстан	\N	\N	о. Андрей Недоступ	о. Андрій Недоступ	\N	\N	моб. тел.: +7 771 6998 89\r\nмоб. тел.: +7 771 6998 893\r\nE-mail: andrij235@gmail.com	\N	\N	\N	2026-04-27 03:06:04.464551+00	2026-04-27 03:06:04.454+00	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d822.7568086992751!2d67.51845277903818!3d47.90518283695162!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x423d650696f80ea7%3A0x2a3a3aa9a3296d07!2zNSwg0YPQu9C40YbQsCDQkNCx0LDRjyA1LCDQodCw0YLQv9Cw0LXQsiAxMDAwMDA!5e1!3m2!1sru!2skz!4v1775461282816!5m2!1sru!2skz
\.


--
-- Data for Name: liturgical_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_events" ("id", "event_date", "kind", "sort_order", "created_at", "recurrence_series_id", "primary_lang", "cover_image_url", "gallery_image_urls", "created_by") FROM stdin;
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
-- Data for Name: liturgical_event_extra_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_event_extra_fields" ("id", "event_id", "sort_idx", "label_ru", "label_uk", "label_kk", "label_en", "body_ru", "body_uk", "body_kk", "body_en", "url", "created_at") FROM stdin;
\.


--
-- Data for Name: liturgical_event_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_event_i18n" ("event_id", "lang", "title", "explanation", "prayer") FROM stdin;
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
-- Data for Name: liturgical_event_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_event_templates" ("id", "name", "created_by", "created_at") FROM stdin;
\.


--
-- Data for Name: liturgical_event_template_rows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_event_template_rows" ("id", "template_id", "sort_idx", "label_ru", "label_uk", "label_kk", "label_en") FROM stdin;
\.


--
-- Data for Name: liturgical_kind_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."liturgical_kind_i18n" ("kind_slug", "lang", "label") FROM stdin;
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

COPY "public"."news" ("id", "published_at", "is_published", "created_at", "updated_at", "author_id", "cover_image_url", "primary_lang", "gallery_image_urls") FROM stdin;
290e9810-4671-4f53-8768-ffc01a7bd557	2026-04-04 12:43:00+00	t	2026-04-26 21:45:08.668183+00	2026-04-26 21:46:54.387+00	\N	http://127.0.0.1:54321/storage/v1/object/public/news-images/290e9810-4671-4f53-8768-ffc01a7bd557/cover.jpg	uk	[]
aee857b5-3ebc-44e7-a760-12d4bda46f69	2026-04-11 21:47:00+00	t	2026-04-26 21:49:36.800373+00	2026-04-26 21:49:36.800373+00	\N	https://cerkiew.net.pl/wp-content/uploads/2023/04/0419-1200.jpg	uk	[]
e641441d-f3b5-4404-bdef-5a7273150cba	2026-04-17 21:49:00+00	t	2026-04-26 21:51:12.330007+00	2026-04-26 21:51:12.330007+00	\N	<blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" data-instgrm-version="14" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:540px; min-width:326px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:16px;"> <a href="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" style=" background:#FFFFFF; line-height:0; padding:0 0; text-align:center; text-decoration:none; width:100%;" target="_blank"> <div style=" display: flex; flex-direction: row; align-items: center;"> <div style="background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 40px; margin-right: 14px; width: 40px;"></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 100px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 60px;"></div></div></div><div style="padding: 19% 0;"></div> <div style="display:block; height:50px; margin:0 auto 12px; width:50px;"><svg width="50px" height="50px" viewBox="0 0 60 60" version="1.1" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"><g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g transform="translate(-511.000000, -20.000000)" fill="#000000"><g><path d="M556.869,30.41 C554.814,30.41 553.148,32.076 553.148,34.131 C553.148,36.186 554.814,37.852 556.869,37.852 C558.924,37.852 560.59,36.186 560.59,34.131 C560.59,32.076 558.924,30.41 556.869,30.41 M541,60.657 C535.114,60.657 530.342,55.887 530.342,50 C530.342,44.114 535.114,39.342 541,39.342 C546.887,39.342 551.658,44.114 551.658,50 C551.658,55.887 546.887,60.657 541,60.657 M541,33.886 C532.1,33.886 524.886,41.1 524.886,50 C524.886,58.899 532.1,66.113 541,66.113 C549.9,66.113 557.115,58.899 557.115,50 C557.115,41.1 549.9,33.886 541,33.886 M565.378,62.101 C565.244,65.022 564.756,66.606 564.346,67.663 C563.803,69.06 563.154,70.057 562.106,71.106 C561.058,72.155 560.06,72.803 558.662,73.347 C557.607,73.757 556.021,74.244 553.102,74.378 C549.944,74.521 548.997,74.552 541,74.552 C533.003,74.552 532.056,74.521 528.898,74.378 C525.979,74.244 524.393,73.757 523.338,73.347 C521.94,72.803 520.942,72.155 519.894,71.106 C518.846,70.057 518.197,69.06 517.654,67.663 C517.244,66.606 516.755,65.022 516.623,62.101 C516.479,58.943 516.448,57.996 516.448,50 C516.448,42.003 516.479,41.056 516.623,37.899 C516.755,34.978 517.244,33.391 517.654,32.338 C518.197,30.938 518.846,29.942 519.894,28.894 C520.942,27.846 521.94,27.196 523.338,26.654 C524.393,26.244 525.979,25.756 528.898,25.623 C532.057,25.479 533.004,25.448 541,25.448 C548.997,25.448 549.943,25.479 553.102,25.623 C556.021,25.756 557.607,26.244 558.662,26.654 C560.06,27.196 561.058,27.846 562.106,28.894 C563.154,29.942 563.803,30.938 564.346,32.338 C564.756,33.391 565.244,34.978 565.378,37.899 C565.522,41.056 565.552,42.003 565.552,50 C565.552,57.996 565.522,58.943 565.378,62.101 M570.82,37.631 C570.674,34.438 570.167,32.258 569.425,30.349 C568.659,28.377 567.633,26.702 565.965,25.035 C564.297,23.368 562.623,22.342 560.652,21.575 C558.743,20.834 556.562,20.326 553.369,20.18 C550.169,20.033 549.148,20 541,20 C532.853,20 531.831,20.033 528.631,20.18 C525.438,20.326 523.257,20.834 521.349,21.575 C519.376,22.342 517.703,23.368 516.035,25.035 C514.368,26.702 513.342,28.377 512.574,30.349 C511.834,32.258 511.326,34.438 511.181,37.631 C511.035,40.831 511,41.851 511,50 C511,58.147 511.035,59.17 511.181,62.369 C511.326,65.562 511.834,67.743 512.574,69.651 C513.342,71.625 514.368,73.296 516.035,74.965 C517.703,76.634 519.376,77.658 521.349,78.425 C523.257,79.167 525.438,79.673 528.631,79.82 C531.831,79.965 532.853,80.001 541,80.001 C549.148,80.001 550.169,79.965 553.369,79.82 C556.562,79.673 558.743,79.167 560.652,78.425 C562.623,77.658 564.297,76.634 565.965,74.965 C567.633,73.296 568.659,71.625 569.425,69.651 C570.167,67.743 570.674,65.562 570.82,62.369 C570.966,59.17 571,58.147 571,50 C571,41.851 570.966,40.831 570.82,37.631"></path></g></g></g></svg></div><div style="padding-top: 8px;"> <div style=" color:#3897f0; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:550; line-height:18px;">Посмотреть эту публикацию в Instagram</div></div><div style="padding: 12.5% 0;"></div> <div style="display: flex; flex-direction: row; margin-bottom: 14px; align-items: center;"><div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(0px) translateY(7px);"></div> <div style="background-color: #F4F4F4; height: 12.5px; transform: rotate(-45deg) translateX(3px) translateY(1px); width: 12.5px; flex-grow: 0; margin-right: 14px; margin-left: 2px;"></div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(9px) translateY(-18px);"></div></div><div style="margin-left: 8px;"> <div style=" background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 20px; width: 20px;"></div> <div style=" width: 0; height: 0; border-top: 2px solid transparent; border-left: 6px solid #f4f4f4; border-bottom: 2px solid transparent; transform: translateX(16px) translateY(-4px) rotate(30deg)"></div></div><div style="margin-left: auto;"> <div style=" width: 0px; border-top: 8px solid #F4F4F4; border-right: 8px solid transparent; transform: translateY(16px);"></div> <div style=" background-color: #F4F4F4; flex-grow: 0; height: 12px; width: 16px; transform: translateY(-4px);"></div> <div style=" width: 0; height: 0; border-top: 8px solid #F4F4F4; border-left: 8px solid transparent; transform: translateY(-4px) translateX(8px);"></div></div></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center; margin-bottom: 24px;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 224px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 144px;"></div></div></a><p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;"><a href="https://www.instagram.com/reel/DXOcVVJDR6d/?utm_source=ig_embed&utm_campaign=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none;" target="_blank">Публикация от Апостольская Администратура (@apostolicadministrature)</a></p></div></blockquote>\r\n<script async src="//www.instagram.com/embed.js"></script>	uk	[]
\.


--
-- Data for Name: news_i18n; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."news_i18n" ("news_id", "lang", "title", "excerpt", "body") FROM stdin;
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

COPY "public"."page_content" ("page_key", "lang", "body", "updated_at") FROM stdin;
history	ru	<div>\r\n    <h1><strong>История Апостольской Администратуры в Казахстане и Центральной Азии</strong></h1>\r\n\r\n    <p>Первые украинские поселенцы оказались на территории Казахстана, начиная с XVII века. Но наибольшее количество украинских греко-католиков попало в Казахстан в ХХ веке во времена сталинских репрессий, особенно вследствие массовой депортации с Украины в Казахстан в 40-50 годы прошлого века. Также в концлагерях Карлага оказалось около 200 греко-католических священников.</p>\r\n\r\n    <p>Начиная с 1955 года, священников вместе с другими политическими заключенными освобождают из тюрем. Освобожденные священники начинают пастырскую опеку своих верных. Таким образом в Караганде возникает первая греко-католическая община. Богослужения совершаются подпольно по домам, землянках и бараках. Подпольные богослужения продолжались вплоть до распада Советского Союза и легализации Греко-Католической Церкви.</p>\r\n\r\n    <p>В 1993 году был зарегистрирован первый греко-католический приход в Караганде. Позже возникли приходы в других городах Казахстана.</p>\r\n\r\n    <p>В 1991 году пастырская опека была поручена епископу Яну Павлу Ленге. С 1996 по 2002 год её осуществлял епископ Василий Медвит. В 2002 году отец Василий Говера был назначен Делегатом Конгрегации Восточных Церквей.</p>\r\n\r\n    <p>1 июня 2019 года Папа Римский Франциск создал Апостольскую Администратуру для верующих византийского обряда в Казахстане и Центральной Азии и назначил отца Василия Говеру первым Апостольским Администратором.</p>\r\n\r\n    <p>Исторически ещё в конце 50-х годов митрополит Иосиф Слипый назначил апостольских администраторов для верующих в СССР. В Казахстане эту миссию выполнял блаженный священномученик Алексий Зарицкий.</p>\r\n\r\n    <p>Сегодня в Казахстане действуют греко-католические приходы в Караганде, Нур-Султане, Павлодаре, Сатпаеве, поселке Шидерты, а также существует община в Алматы.</p>\r\n\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">История прихода</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Греко-католический приход Блаженного Алексея Зарицкого города Алматы</strong></p>\r\n\r\n    <p>Приход начал пастырское служение для местных греко-католических верующих. В связи с отсутствием собственного храма богослужения проходят в римско-католическом Кафедральном соборе Пресвятой Троицы.</p>\r\n\r\n    <p>В литургической жизни принимают участие как местные греко-католики, так и украинцы, прибывшие в Алматы по профессиональным и трудовым причинам.</p>\r\n\r\n    <p>В 2017 году администратором общины был назначен священник о. Олег Галушка. С 9 августа 2023 года, после официальной регистрации прихода, он стал настоятелем и продолжил пастырскую деятельность.</p>\r\n\r\n    <p>Прихожане активно участвуют в жизни общины: проводятся занятия по катехизису и изучению Святого Писания для взрослых и детей, ежедневная молитва «Святого Розария» в телеграм-канале, детские лагеря, а также культурные мероприятия, посвящённые Рождеству и Пасхе.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	uk	<div>\r\n    <h1><strong>Історія Апостольської Адміністратури в Казахстані та Центральній Азії</strong></h1>\r\n\r\n    <p>Перші українські поселенці з’явилися на території Казахстану ще з XVII століття. Найбільша хвиля українських греко-католиків припала на ХХ століття під час сталінських репресій, особливо внаслідок масових депортацій у 40–50-х роках. У таборах Карлагу перебувало близько 200 греко-католицьких священників.</p>\r\n\r\n    <p>З 1955 року священників почали звільняти з ув’язнення. Вони відновили душпастирське служіння, і в Караганді виникла перша громада. Богослужіння відбувалися підпільно в домівках і бараках аж до легалізації Церкви після розпаду СРСР.</p>\r\n\r\n    <p>У 1993 році було зареєстровано перший греко-католицький прихід у Караганді. Згодом громади з’явилися і в інших містах.</p>\r\n\r\n    <p>У 1991 році душпастирську опіку доручено єпископу Яну Павлу Лензі. У 1996–2002 роках її здійснював єпископ Василій Медвіт. У 2002 році отця Василя Говеру призначено делегатом Конгрегації Східних Церков.</p>\r\n\r\n    <p>1 червня 2019 року Папа Франциск створив Апостольську Адміністратуру для вірних візантійського обряду та призначив отця Василя Говеру адміністратором.</p>\r\n\r\n    <p>Ще у 1950-х роках митрополит Йосиф Сліпий призначив апостольських адміністраторів для СРСР. У Казахстані ним був блаженний священномученик Олексій Зарицький.</p>\r\n\r\n    <p>Сьогодні громади діють у Караганді, Астані, Павлодарі, Сатпаєві, Шідертах, а також в Алмати.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Історія парафії</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Греко-католицька парафія блаженного Олексія Зарицького в місті Алмати</strong></p>\r\n\r\n    <p>Парафія розпочала душпастирське служіння для місцевих вірних. Богослужіння проходять у римо-католицькому кафедральному соборі Пресвятої Трійці.</p>\r\n\r\n    <p>У житті парафії беруть участь як місцеві вірні, так і українці, які проживають в Алмати.</p>\r\n\r\n    <p>У 2017 році адміністратором став о. Олег Галушка. З 9 серпня 2023 року він є настоятелем парафії.</p>\r\n\r\n    <p>Парафіяни активно беруть участь у житті громади: катехизація, молитви, дитячі табори та святкові заходи.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	kk	<div>\r\n    <h1><strong>Қазақстан мен Орталық Азиядағы Апостолдық Әкімшіліктің тарихы</strong></h1>\r\n\r\n    <p>Алғашқы украин қоныстанушылары Қазақстан аумағына XVII ғасырдан бастап келе бастады. Алайда украин грек-католиктерінің ең көп бөлігі Қазақстанға ХХ ғасырда сталиндік қуғын-сүргін кезеңінде, әсіресе 1940–50 жылдары Украинадан жаппай жер аудару нәтижесінде келді. Сондай-ақ Қарлаг лагерлерінде шамамен 200 грек-католик діни қызметкері болды.</p>\r\n\r\n    <p>1955 жылдан бастап діни қызметкерлер басқа саяси тұтқындармен бірге түрмелерден босатыла бастады. Босатылғаннан кейін олар өз қауымдарына рухани қызмет көрсете бастады. Осылайша Қарағандыда алғашқы грек-католик қауымы пайда болды. Құлшылықтар үйлерде, жертөлелерде және барақтарда жасырын түрде өткізілді. Бұл жасырын қызметтер Кеңес Одағы құлағанға дейін жалғасты.</p>\r\n\r\n    <p>1993 жылы Қарағандыда алғашқы грек-католик приходы ресми түрде тіркелді. Кейін Қазақстанның басқа қалаларында да қауымдар пайда болды.</p>\r\n\r\n    <p>1991 жылы рухани қамқорлық епископ Ян Павел Ленгаға тапсырылды. 1996–2002 жылдары бұл қызметті епископ Василий Медвит атқарды. 2002 жылы әкей Василий Говера Шығыс шіркеулер Конгрегациясының делегаты болып тағайындалды.</p>\r\n\r\n    <p>2019 жылғы 1 маусымда Рим Папасы Франциск Қазақстан мен Орталық Азиядағы византиялық дәстүрдегі сенушілер үшін Апостолдық Әкімшілікті құрды және әкей Василий Говераны алғашқы әкімші етіп тағайындады.</p>\r\n\r\n    <p>Тарихи тұрғыдан, 1950-жылдардың соңында митрополит Иосиф Слипый КСРО аумағындағы сенушілер үшін апостолдық әкімшілерді тағайындаған болатын. Қазақстанда бұл қызметті блаженный әкей Алексий Зарицкий атқарды.</p>\r\n\r\n    <p>Қазіргі уақытта Қазақстанда Қарағанды, Астана, Павлодар, Сәтбаев, Шідерті елді мекенінде грек-католик қауымдары жұмыс істейді, сондай-ақ Алматыда да қауым бар.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Приход тарихы</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Алматы қаласындағы Блаженный Алексий Зарицкий атындағы грек-католик приходы</strong></p>\r\n\r\n    <p>Приход жергілікті грек-католик сенушілеріне рухани қызмет көрсете бастады. Өз ғибадатханасы болмағандықтан, құлшылықтар Рим-католиктік Қасиетті Үштік кафедралды соборында өткізіледі.</p>\r\n\r\n    <p>Қауым өміріне жергілікті сенушілермен қатар, Алматыға жұмыс немесе кәсіби себептермен келген украиндар да қатысады.</p>\r\n\r\n    <p>2017 жылы қауым әкімшісі болып әкей Олег Галушка тағайындалды. 2023 жылғы 9 тамызда приход ресми тіркелгеннен кейін ол настоятель болып бекітілді.</p>\r\n\r\n    <p>Қауым мүшелері белсенді қатысады: катехизис сабақтары, Киелі Жазбаны оқу, күнделікті «Қасиетті Розарий» дұғасы, балалар лагерьлері және Рождество мен Пасхаға арналған мәдени шаралар өткізіледі.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
history	en	<div>\r\n    <h1><strong>History of the Apostolic Administration in Kazakhstan and Central Asia</strong></h1>\r\n\r\n    <p>The first Ukrainian settlers arrived in Kazakhstan as early as the 17th century. However, the largest number of Ukrainian Greek Catholics came during the 20th century, especially due to Stalinist repressions and mass deportations in the 1940s–50s. About 200 Greek Catholic priests were imprisoned in the Karlag camps.</p>\r\n\r\n    <p>From 1955, priests were released and resumed pastoral care. The first community emerged in Karaganda, where services were held secretly in homes and barracks until the fall of the Soviet Union.</p>\r\n\r\n    <p>In 1993, the first parish was officially registered in Karaganda, followed by others across Kazakhstan.</p>\r\n\r\n    <p>In 1991, pastoral care was entrusted to Bishop Jan Paweł Lenga. From 1996 to 2002 it was carried out by Bishop Vasyl Medvit. In 2002, Fr. Vasyl Hovera was appointed delegate of the Congregation for the Eastern Churches.</p>\r\n\r\n    <p>On June 1, 2019, Pope Francis established the Apostolic Administration for Byzantine-rite faithful and appointed Fr. Vasyl Hovera as its first administrator.</p>\r\n\r\n    <p>Historically, Metropolitan Josyf Slipyj had already appointed administrators in the 1950s. In Kazakhstan, this role was held by Blessed martyr Fr. Alexiy Zarytsky.</p>\r\n\r\n    <p>Today, parishes exist in Karaganda, Astana, Pavlodar, Satpayev, Shiderty, and a community also exists in Almaty.</p>\r\n\r\n    <h1 class="font-display text-3xl text-parish-text" style="margin-top: 40px;">Parish History</h1>\r\n\r\n    <p style="margin-top: 30px;"><strong>Greek Catholic Parish of Blessed Alexiy Zarytsky in Almaty</strong></p>\r\n\r\n    <p>The parish began pastoral service for local Greek Catholics. Due to the lack of its own church, services are held at the Roman Catholic Cathedral of the Holy Trinity.</p>\r\n\r\n    <p>Both local faithful and Ukrainians living in Almaty participate in parish life.</p>\r\n\r\n    <p>In 2017, Fr. Oleg Halushka was appointed administrator. Since August 9, 2023, he has been the parish priest.</p>\r\n\r\n    <p>Parishioners actively participate through catechism, prayer, children’s camps, and cultural events for Christmas and Easter.</p>\r\n</div>	2026-04-26 18:17:11.729995+00
\.


--
-- Data for Name: scripture_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."scripture_books" ("id", "sort_order", "created_at", "primary_lang", "gallery_image_urls") FROM stdin;
a21d48ff-4d22-45a9-b81d-a51df28fa85e	0	2026-04-26 22:07:37.422703+00	ru	[]
dcf3d897-be1d-4670-af00-0d8c3d9fadcd	0	2026-04-26 22:09:40.69322+00	uk	[]
33573b44-e003-4902-97f0-f0dd78f4c6f3	0	2026-04-26 22:11:15.789726+00	uk	[]
f768c98c-e713-45d7-8daf-229da7993460	0	2026-04-26 22:12:42.460293+00	uk	["http://127.0.0.1:54321/storage/v1/object/public/scripture-books/f768c98c-e713-45d7-8daf-229da7993460/gallery/1777241562559_0_gj7n0tr.jpg"]
\.


--
-- Data for Name: scripture_book_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."scripture_book_locales" ("id", "book_id", "lang", "title", "description", "read_url", "file_url", "cover_image_url") FROM stdin;
098c3821-ae04-4e9a-99b8-b7262a31e314	a21d48ff-4d22-45a9-b81d-a51df28fa85e	ru	Библия. Русский синодальный перевод.	\N	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/a21d48ff-4d22-45a9-b81d-a51df28fa85e/ru/upload_2026-04-27_03-07-37_430.zip	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/a21d48ff-4d22-45a9-b81d-a51df28fa85e/covers/ru.jpeg
3dee14d8-b87b-4763-91f8-408fcdbcf81b	dcf3d897-be1d-4670-af00-0d8c3d9fadcd	uk	Біблія в перекладi Івана Огієнка 1962	БІБЛІЯ ПЕРЕКЛАД ОГІЄНКА – найпопулярніший переклад оригінальної Біблії українською мовою. Робота перекладача тривала з 1917 до 1940 року, а перше видання було випущено 1962 року у столиці Великобританії Об'єднаним Біблійним товариством. В Україні книга була випущена вперше великим тиражем 1995 року.	https://ukrbible.at.ua/index/ukrajinska_biblija_pereklad_i_ogienka_onlajn/0-17	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/dcf3d897-be1d-4670-af00-0d8c3d9fadcd/uk/upload_2026-04-27_03-09-40_700.zip	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/dcf3d897-be1d-4670-af00-0d8c3d9fadcd/covers/uk.jpeg
cf404243-9991-4955-9ddb-a919a6e9e4e9	33573b44-e003-4902-97f0-f0dd78f4c6f3	uk	Катехизм Української Греко-Ка­толицької Церкви	Високопреосвященним і Преосвященним Владикам, Всесвітлішим, всечеснішим та преподобним отцям, преподобним ченцям і черницям, дорогим у Христі мирянам Української Греко-Католицької Церкви.\r\n\r\nДорогі брати і сестри! Поручаємо Вам Катехизм Української Греко-Ка­толицької Церкви, який є сповідуванням і поясненням її віри в Триєдиного Бога - Отця, і Сина, і Святого Духа. Віра ця народилася в слуханні Хрис­тового Євангелія, яке вперше пролунало на землях Руси-України, згідно з переданням, ще в проповіді апостола Андрея Первозванного; ця Благо- вість продовжила звучати в місії святих слов’янських апостолів Кирила і Методія та утвердилася у Хрещенні Руси-України за рівноапостольного князя Володимира. Слово Євангелія знайшло відгук віри в серцях слуха­чів, і Христова Церква поширилась по всій Київській Русі. Нова христи­янська традиція, згодом названа київською, стала перлиною в скарбниці віри Вселенської Церкви. На цій традиції виросли численні покоління християн як української, так і інших культур.	https://catechismugcc.org/	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/33573b44-e003-4902-97f0-f0dd78f4c6f3/covers/uk.jpg
3214d5a7-e964-412a-bf47-1a18e02c1c22	f768c98c-e713-45d7-8daf-229da7993460	uk	Біблія. Переклад о. Івана (Хоменка)	Третій повний (римський) переклад Біблії українською мовою.	https://ugcc.ua/library/bible/	\N	http://127.0.0.1:54321/storage/v1/object/public/scripture-books/f768c98c-e713-45d7-8daf-229da7993460/covers/uk.jpg
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."site_settings" ("key", "value") FROM stdin;
telegram	{"chat_id": null, "webhook_secret": null}
smoke_local	{"ok": true, "source": "local"}
external_liturgical_widget	{"gregorian": false, "new_julian": true}
footer	{"email": "oleh.halushka@gmail.com", "phone": "+7 705 972 30 50", "address_en": "Almaty, Tlendieva 9", "address_kk": "Алмати, Тлендієва 9", "address_ru": "г. Алматы, Тлендиева 9", "address_uk": "м. Алмати, Тлендиева 9", "map_embed_src": "https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2905.789280619768!2d76.8675658!3d43.2558379!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x388369823d000001%3A0xe5cfe59f1bfb932a!2z0KDQuNC80YHQutC-LdCa0LDRgtC-0LvQuNGH0LXRgdC60LjQuSDQodC-0LHQvtGAINCf0YDQtdGB0LLRj9GC0L7QuSDQotGA0L7QuNGG0Ys!5e0!3m2!1sru!2skz!4v1775406740843!5m2!1sru!2skz", "priest_name_en": "Priest Oleh Halushka", "priest_name_kk": "Діни қызметкер Олег Галушка", "priest_name_ru": "Священник Олег Галушка", "priest_name_uk": "Священик Олег Галушка", "contact_buttons": [{"url": "https://t.me/ugcc_almaty_official", "icon": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_dbOUeCrOBe-mkfGD-fEjQNECJrkromWTYg&s", "label": "Telegram"}, {"url": "https://www.ugcc-kazakhstan.com/uk/%D0%BA%D0%BE%D0%BD%D1%82%D0%B0%D0%BA%D1%82%D1%8B", "icon": "https://static.wixstatic.com/media/c3aa9c_82ed7649aabc4d8299b2a6ccd29f0541~mv2.jpg/v1/fill/w_61,h_80,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/%D0%93%D0%95%D0%A0%D0%91%201.jpg", "label": "АПОСТОЛЬСЬКА АДМІНІСТРАТУРА"}], "contact_photo_url": "https://static.wixstatic.com/media/c3aa9c_5900c28d45354dd5964039ea90ade6e3~mv2.jpg/v1/fill/w_953,h_957,al_t,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/c3aa9c_5900c28d45354dd5964039ea90ade6e3~mv2.jpg"}
\.


--
-- Data for Name: telegram_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."telegram_messages" ("id", "chat_id", "tg_message_id", "text", "sent_at") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") FROM stdin;
news-images	news-images	\N	2026-04-26 18:17:11.791291+00	2026-04-26 18:17:11.791291+00	t	f	\N	\N	\N	STANDARD
scripture-books	scripture-books	\N	2026-04-26 18:17:11.791291+00	2026-04-26 18:17:11.791291+00	t	f	\N	\N	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."iceberg_namespaces" ("id", "bucket_name", "name", "created_at", "updated_at", "metadata", "catalog_id") FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."iceberg_tables" ("id", "namespace_id", "bucket_name", "name", "location", "created_at", "updated_at", "remote_table_id", "shard_key", "shard_id", "catalog_id") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
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

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata", "metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY "supabase_functions"."hooks" ("id", "hook_table_id", "hook_name", "created_at", "request_id") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 3, true);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict I1goM2FONSLLYi4dAfDRm3mIwPOzmKjKNG3w4fhKefOaB77zFuBenw0KFsqVjX1

RESET ALL;
