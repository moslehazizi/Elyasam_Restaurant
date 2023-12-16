--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE "Elyasam_Restaurant";
DROP DATABASE mosleh;




--
-- Drop roles
--

DROP ROLE mosleh;


--
-- Roles
--

CREATE ROLE mosleh;
ALTER ROLE mosleh WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:PpEjeXABVKrWmIaSmbKQ5g==$HuceMR0owFIud+42cB+m3jUoclK6/1NyY51Hw4SLDxU=:JX5P8I7QkkDLpTj9RoEdbngot3j0XMaqM83WKO8Zi98=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: mosleh
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO mosleh;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: mosleh
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: mosleh
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: mosleh
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "Elyasam_Restaurant" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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

--
-- Name: Elyasam_Restaurant; Type: DATABASE; Schema: -; Owner: mosleh
--

CREATE DATABASE "Elyasam_Restaurant" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "Elyasam_Restaurant" OWNER TO mosleh;

\connect "Elyasam_Restaurant"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    category_title character varying NOT NULL,
    category_icon character varying NOT NULL
);


ALTER TABLE public.categories OWNER TO mosleh;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO mosleh;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    comment_content text NOT NULL,
    service_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comments OWNER TO mosleh;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO mosleh;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO mosleh;

--
-- Name: services; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    service_image character varying NOT NULL,
    service_title character varying NOT NULL,
    service_category bigint NOT NULL,
    star integer DEFAULT 0 NOT NULL,
    recipe text NOT NULL,
    price bigint NOT NULL
);


ALTER TABLE public.services OWNER TO mosleh;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO mosleh;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.categories (id, category_title, category_icon) FROM stdin;
1	سالادها	./media/icons/salad.svg
2	پیش خوراک	./media/icons/pish_ghaza.svg
3	مزه های ایران زمین	./media/icons/mazze.svg
4	کباب های ایران زمین	./media/icons/kabab.svg
5	پلوهای اعیونی	./media/icons/polo.svg
6	غذاهای فرنگی	./media/icons/farangi.svg
7	پاستاها	./media/icons/pasta.svg
8	پیتزاها	./media/icons/pizza.svg
9	موکتل ها	./media/icons/mokteil.svg
10	نوشیدنی گرم	./media/icons/nushidani_garm.svg
11	قهوه دمی	./media/icons/ghahve_dami.svg
12	دمنوش و چای	./media/icons/damnush_chai.svg
13	فراپه و آیس	./media/icons/frape_ice.svg
14	اسمونی ها	./media/icons/smooty.svg
15	نوشیدنی های سنتی	./media/icons/nushidani_sonati.svg
16	شیک ها	./media/icons/sheik.svg
17	مخصوص الیاسام	./media/icons/makhsus_lyasam.svg
18	ماکتیل ها	./media/icons/makteil.svg
19	دیزاین تولد	./media/icons/design_tawalod.svg
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.comments (id, comment_content, service_id, created_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.schema_migrations (version, dirty) FROM stdin;
1	f
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.services (id, service_image, service_title, service_category, star, recipe, price) FROM stdin;
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.categories_id_seq', 19, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.services_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: categories_category_title_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX categories_category_title_idx ON public.categories USING btree (category_title);


--
-- Name: comments_id_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX comments_id_idx ON public.comments USING btree (id);


--
-- Name: services_service_category_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX services_service_category_idx ON public.services USING btree (service_category);


--
-- Name: comments comments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: services services_service_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_service_category_fkey FOREIGN KEY (service_category) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "mosleh" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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

--
-- Name: mosleh; Type: DATABASE; Schema: -; Owner: mosleh
--

CREATE DATABASE mosleh WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE mosleh OWNER TO mosleh;

\connect mosleh

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

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: mosleh
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO mosleh;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: mosleh
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

