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

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: discount_offers; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.discount_offers (
    id bigint NOT NULL,
    service_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expired_at timestamp with time zone DEFAULT (now() + '08:00:00'::interval) NOT NULL
);


ALTER TABLE public.discount_offers OWNER TO mosleh;

--
-- Name: discount_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.discount_offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_offers_id_seq OWNER TO mosleh;

--
-- Name: discount_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.discount_offers_id_seq OWNED BY public.discount_offers.id;


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
-- Name: slider_images; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.slider_images (
    id bigint NOT NULL,
    image_path character varying NOT NULL
);


ALTER TABLE public.slider_images OWNER TO mosleh;

--
-- Name: slider_images_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.slider_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.slider_images_id_seq OWNER TO mosleh;

--
-- Name: slider_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.slider_images_id_seq OWNED BY public.slider_images.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: mosleh
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    phone_number character varying NOT NULL,
    hashed_password character varying NOT NULL,
    full_name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO mosleh;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mosleh
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO mosleh;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mosleh
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: discount_offers id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.discount_offers ALTER COLUMN id SET DEFAULT nextval('public.discount_offers_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: slider_images id; Type: DEFAULT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.slider_images ALTER COLUMN id SET DEFAULT nextval('public.slider_images_id_seq'::regclass);


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
-- Data for Name: discount_offers; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.discount_offers (id, service_id, created_at, expired_at) FROM stdin;
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
1	./media/services/1/salad_khatun.jpg	سالاد خاتون / Khatoon salad	1	0	میکس کاهو، ریحان، گوجه، خیار، فلفل دلمه کبابی، پیازچه، پنیر فتا، مرغ گریل شده، گردو، سس مه لقا Lettuce mix, basil, tomato, cucumber, grilled bell pepper, onion, feta cheese, grilled chicken, walnuts, Mehlaqa sauce	145000
2	./media/services/1/salad_sezar.jpg	سالاد سزار مرغ / Caesar chicken salad	1	0	کاهو رسمی، مرغ گریل، سس سزار، کروتان، پنیر پارمزان Formal lettuce, grilled chicken, Caesar sauce, croutons, Parmesan cheese	155000
3	./media/services/1/hokkaido.jpg	سالاد هوکایدو / Hokkaido Salad	1	0	میکس کاهو، اسفناج، روکولا، خیار، گوجه، تربچه، پیازچه، جوانه، مرغ گریل، نودل کریسپی، سس جینجرلیمو Lettuce mix, spinach, arugula, cucumber, tomato, radish, onion, sprouts, grilled chicken, crispy noodles, ginger lemon sauce	155000
4	./media/services/1/fruit_salad.jpg	فروتی سالاد / Fruit salad	1	0	میکس کاهو، گوجه، توت فرنگی، مغز گردو، سیب درختی، موز، قیسی، سس خردل و عسل Mix lettuce, tomato, strawberry, walnut kernel, apple, banana, ghee, mustard sauce and honey	145000
5	./media/services/2/spice_wings.jpg	بال اسپایسی / Spice wings	2	0	بال مرغ تنوری جاافتاده در سس چیلی، ملودی سبزیجات Grilled chicken wings embedded in chili sauce, vegetable melody	110000
6	./media/services/2/bozghorme.jpg	بزقرمه / Bozghorme	2	0	گوشت گوسفندی، نخود فرنگی، کشک، پیاز داغ، نعنا داغ Mutton, peas, curd, hot onion, hot mint	110000
7	./media/services/2/sup.jpg	سوپ روز / Soup of the day	2	0	سبزیجات فصل تفت خورده با کره و جا افتاده در عصاره مرغ Roasted seasonal vegetables with butter and soaked in chicken broth	60000
8	./media/services/2/fries.jpg	فرایز لاور / Fries Lover	2	0	سیب زمینی سرخ شده، بیکن گوساله، سس چدار، پیاز سوخاری Fried potatoes, beef bacon, cheddar sauce, fried onions	110000
9	./media/services/2/kashk_bademjan.jpg	کشک بادمجان / Eggplant curd	2	0	بادمجان سرخ شده، پیاز داغ، کشک، نعنا داغ Fried eggplant, hot onion, curd, hot mint	105000
10	./media/services/2/mirza_ghasemi.jpg	میرزا قاسمی / Mirza Ghasemi	2	0	بادمجان کبابی پخته شده، سیر تفت خورده، پوره گوجه، تخم مرغ Baked grilled eggplant, roasted garlic, tomato puree, eggs	110000
11	./media/services/3/burani.jpg	بورانی اسفناج / Spinach borani	3	0	اسفناج. ماست چکیده. نمک. فلفل. سیر	45000
12	./media/services/3/torshi.jpg	ترشی / Pickle	3	0	کلم سیر ...	35000
13	./media/services/3/zeitun_p.jpg	زیتون پرورده / Olive	3	0	زیتون. سیر. گردو. ...	65000
14	./media/services/3/salad_shirazi.jpg	سالاد شیرازی / Shirazi salad	3	0	خیار. گوجه....	35000
15	./media/services/3/musir.jpg	ماست موسیر / Shallot yogurt	3	0	ماست. سیر ...	40000
16	./media/services/4/1.jpg	جوجه کباب با استخوان زعفرانی / Grilled chicken with saffron bones	4	0	600 گرم جوجه با استخوان، سس کره لیمو، دورچین 600 grams of chicken with bones, lemon butter sauce, cinnamon	250000
17	./media/services/4/2.jpg	جوجه کباب بی استخوان زعفرانی / Boneless saffron chicken	4	0	350 گرم سینه مرغ زعفرانی، سس کره لیمو، دورچین 350 grams of saffron chicken breast, lemon butter sauce, cinnamon	220000
18	./media/general.png	سینی کباب اعیونی / Ayoni Kebab Tray	4	0	کباب شیشلیک شاندیز، کباب لقمه، کباب برگ، جوجه با استخوان، کباب ترش شمال، دورچین Shandiz Shishlik Kebab, Bite Kebab, Leaf Kebab, Chicken with Bones, Northern Sour Kebab, Durchin	1780000
19	./media/services/4/4.jpg	فیله کباب بره درباری / Court lamb fillet	4	0	300 گرم فیله بره، دلمه رنگی کباب شده، سس کره و سماق، دورچین 300 g of lamb fillet, grilled colored curd, butter sauce and sumac, cinnamon	450000
20	./media/services/4/5_1.jpg	کباب برگ اعلا / Roast the highest leaves	4	0	300 گرم راسته گوسفندی، سس سماق، دورچین 300 grams of mutton, sumac sauce, turmeric	450000
21	./media/services/4/6.jpg	کباب ترش گیلان / Gilan sour kebab	4	0	300 گرم فیله کوساله، سس انار ترش جنگلی، مغز گردو، دورچین 300 grams of kosale fillet, sour forest pomegranate sauce, walnut kernels, durchin	420000
22	./media/services/4/7.jpg	کباب شیشلیک شاندیزی / Shashlik Shashlik Kebab	4	0	500 گرم راسته با استخوان گوسفندی، سس کره و زعفران، دورچین 500 grams of rosemary with mutton, butter and saffron sauce, Durchin	520000
23	./media/services/4/8.jpg	کباب لقمه ممتاز / Premium kebab	4	0	300 گرم گوشت خورده گوسفندی، پیاز، سس کره و زعفران، دورچین 300 grams of mutton, onion, butter sauce and saffron, fennel	235000
24	./media/general.png	کباب لقمه ممتازکباب ماهی شیر بوشهری	4	0	250 گرم فیله ماهی شیر بوشهری، سس قلیه بوشهری، دورچین	295000
25	./media/services/4/10.jpg	کباب میکس صدراعظم / Kebab Mix Chancellor	4	0	میکس 200 گرم راسته گوسفندی با 200 گرم سینه مرغ زعفرانی، سس خالواش، دورچین Mix 200 g of mutton with 200 g of saffron chicken breast, khalavash sauce, durchin	390000
26	./media/general.png	ماهی قزل آلا (450 گرمی)	4	0	ماهی . دورچین ...	185000
27	./media/services/5/1.jpg	باقالی پلو / Baghalipolo	5	0	برنج ...	70000
28	./media/services/5/2.jpg	چلو کره زعفرانی / Chloe Saffron Butter	5	0	برنج ...	65000
29	./media/services/5/3.jpg	گردن اعیونی / Ayeuni neck	5	0	برنج. گردن ...	450000
30	./media/services/5/4_1.jpg	ماهیچه شاندیزی / Shandizi muscle	5	0	برنج. ماهیچه ...	490000
103	./media/services/19/4.jpg	A-110	19	0	--	3000000
104	./media/services/19/5.jpg	A-112	19	0	--	3500000
31	./media/general.png	اورنج سلمن	6	0	فیله سلمن تنوری به همراه سس پرتقال بادام، کراکت سیب زمینی، سالاد کینوا، سالسا انبه	380000
32	./media/general.png	تی بن استیک	6	0	برش دنده گوساله با استخوان به همراه سس مجیک تریاکی، سالاد سبزیجات گرم، سیب تنوری	320000
33	./media/general.png	چری چیکن	6	0	سینه مرغ جا افتاده در سس چری به همراه کراکت سیب زمینی، سبزیجات سوته شده	250000
34	./media/general.png	فونگی استیک	6	0	فیله گوساله گریل شده یه همراه سس ماشروم، سالاد سبزیجات گرم، سیب تنوری	295000
35	./media/general.png	فیله مینیون	6	0	فیله گوساله گریل شده به همراه سس چری بری،سالاد سبزیجات گرم، سیب تنوری	295000
36	./media/general.png	میپل چیکن	6	0	سینه ی مرغ جا افتاده در سس میپل به همراه کراکت سیب زمینی ، هویج کاراملایز، بروکلی، نودل کریسپی	250000
37	./media/services/7/1.jpg	بیف آلفردو / Beef Alfredo	7	0	فیله گوساله، سس الفردو، پنه، قارچ، پارمزان، گوجه گیلاسی Beef fillet, alfredo sauce, penne, mushrooms, parmesan, cherry tomatoes	240000
38	./media/services/7/2.jpg	پولو رمانا / Polo Romana	7	0	سینه مرغ گریل، سس پنیر، سس مارینارا، پنه، قارچ، کدو، پنیر پارمزان Grilled chicken breast, cheese sauce, marinara sauce, penne, mushrooms, pumpkin, Parmesan cheese	220000
39	./media/services/7/3.jpg	چیکن آلفردو / Chiken Alfredo	7	0	سینه مرغ گریل، سس آلفردو، پنه، قارچ، پارمزان، گوجه گیلاسی Grilled chicken breast, alfredo sauce, penne, mushrooms, parmesan, cherry tomatoes	220000
40	./media/services/7/4.jpg	چیکن وردورا / Chicken Verdera	7	0	سینه مرغ گریل، پستو ریحان، سس خامه، پنه، قارچ، کدو، بروکلی، پارمزان Grilled chicken breast, basil pesto, cream sauce, penne, mushrooms, squash, broccoli, parmesan	220000
41	./media/services/7/5_1.jpg	میتی روزتا / Mitty Rosetta	7	0	فیله گوساله، سس روزتا، پنه، قارچ، گوجه خشک، دلمه رنگی، پیاز پارمزان Beef fillet, rosette sauce, penne, mushrooms, dried tomatoes, colored curd, Parmesan onion	240000
42	./media/services/8/1.jpg	امپریال چیکن / Imperial Chicken	8	0	خمیر خانگی، سس ناپل، فیله مرغ سوخاری، کدو کبابی، زیتون، موتزارلا Homemade dough, napel sauce, fried chicken fillet, grilled squash, olives, mozzarella	235000
43	./media/services/8/2.jpg	پپرونی لاور / Lover pepperoni	8	0	خمیر خانگی، سس ناپل، پپرونی، بیکن گوساله، دلمه رنگی، هالوپینو، موتزارلا Homemade dough, Naples sauce, pepperoni, beef bacon, colored jam, halopino, mozzarella	260000
44	./media/services/8/3.jpg	چیکن بازیلیکو / Chicken Basiliko	8	0	خمیر خانگی، سس پستو ریحان، فیله مرغ، سالامی، کدو کبابی، زیتون، موتزارلا Homemade dough, basil pesto sauce, chicken fillet, salami, grilled squash, olives, mozzarella	225000
45	./media/services/8/4.jpg	چیکو بیکن / Chico Bacon	8	0	خمیر خانگی، سس ناپل، فیله مرغ، بیکن مرغ، دلمه رنگی، پیاز کبابی، قارچ، سس انبه،، موتزارلا Homemade Dough, Naples Sauce, Chicken Fillet, Chicken Bacon, Colored Courgettes, Grilled Onions, Mushrooms, Mango Sauce , Mozzarella	245000
46	./media/services/8/5.jpg	فونگی کارانه / Foongi karane	8	0	خمیر خانگی، گوشت چرخ شده مزه دار شده، سس ناپل، قارچ، پیاز کاراملایز، گودا، موتزارلا Homemade dough, flavored minced meat, napel sauce, mushrooms, caramelized onion, gouda, mozzarella	235000
47	./media/services/8/6.jpg	گارلیف بیف / Garlic Beef	8	0	خمیر خانگی، سس ناپل، فیله گوساله، قارچ؛ دلمه رنگی کبابی، سس سیر، پیاز کبابی، موتزارلا، سالسا انبه Homemade dough, Naples sauce, veal fillet, mushrooms; Grilled colored jam, garlic sauce, grilled onion, mozzarella, mango salsa	270000
48	./media/services/8/7.jpg	ماشروم بیف / Mashrom Beef	8	0	خمیر خانگی، سس ناپل، گوشت رشته رشته شده، گودا، قارچ، پیاز، گوجه گیلاسی، موتزارلا Homemade dough, Naples sauce, minced meat, gouda, mushrooms, onions, cloves, mozzarella	260000
49	./media/services/9/1_1.jpg	بلوبریانا	9	0	زنجبیل، نعنا، آب پرتقال، آب سودا Ginger, mint, orange juice, soda juice	85000
50	./media/services/9/2.jpg	ردسوج	9	0	فلفل کبابی، فلفل هالوپینو، زنجبیل، آب آلبالو، آب انار، پرتقال Grilled peppers, halopino peppers, ginger, cherry juice, pomegranate juice, oranges	75000
51	./media/services/9/3.jpg	کاکتوس	9	0	آب لیمو، آب پرتقال، هایپ Lemon juice, orange juice, hype	78000
52	./media/services/9/4.jpg	لیموناد	9	0	فیله لیمو، شکر، آب سودا Lemon fillet, sugar, soda water	75000
53	./media/services/9/5.jpg	موهیتو	9	0	فیله لیمو، نعناع، آب سودا، شکر Lemon fillet, mint, soda water, sugar	85000
54	./media/services/9/6.jpg	نوشیدنی فصل / Drinks of the season	9	0	--	70000
55	./media/services/10/1.jpg	آمریکانو / Americano	10	0	قهوه با میکس آب جوش Coffee with boiling water mix	85000
56	./media/services/10/2.jpg	اسپرسو دبل / Double espresso	10	0	قهوه بلند شده Coffee has risen	87000
95	./media/services/18/2_1.jpg	ردسوج / Redsuj	18	0	--	75000
57	./media/services/10/3.jpg	اسپرسو سینگل / Single espresso	10	0	قهوه بلند شده Coffee has risen	85000
58	./media/services/10/4.jpg	کاپوچینو / Cappuccino	10	0	قهوه، شیر Coffee, milk	78000
59	./media/services/10/5.jpg	کارامل ماکیاتو / Caramel Macchiato	10	0	قهوه، شیر، سس کارامل Coffee, milk, caramel sauce	85000
105	./media/services/19/6.jpg	A-114	19	0	--	3500000
106	./media/services/19/7.jpg	E-102	19	0	--	1500000
60	./media/services/10/6.jpg	کافه بیچرين/ Beauty Cafe	10	0	قهوه، شیر، هات چاکلت، خامه Coffee, milk, caramel sauce	93000
61	./media/services/10/7.jpg	کورتادو / Cortado	10	0	شیر، قهوه، دارچین Milk, coffee, cinnamon	88000
62	./media/services/10/8_1.jpg	لته / Latte	10	0	قهوه، شیر Coffee, milk	88000
63	./media/services/10/9.jpg	موکانوتلا / Moka Nutella	10	0	نوتلا، شیر، قهوه Nutella, milk, coffee	100000
64	./media/services/11/1.jpg	v60	11	0	قهوه بلند شده، آب جوش Raised coffee, boiling water	78000
65	./media/services/11/2.jpg	ترک / Turkish	11	0	قهوه ترک، آب Turkish coffee, water	78000
66	./media/services/11/3.jpg	سایفون / Siphon	11	0	قهوه دمی، آب Brewed coffee, water	78000
67	./media/services/11/4_1.jpg	فرانسه با شیر / France with milk	11	0	قهوه بلند شده با آب جوش، شیر Coffee brewed with boiling water, milk	80000
68	./media/services/11/5.jpg	کمکس / Comics	11	0	قهوه بلند شده با آب جوش، شیر Coffee brewed with boiling water, milk	76000
69	./media/services/12/1.jpg	آرامش بخش (هندی) / Relaxing (Hindi)	12	0	توت فرنگی، سیب، بهار نارنج، سنبلاتیو، به لیمو Strawberries, apples, spring orange, valerian, lemons	85000
70	./media/services/12/2.jpg	چای ترش / Sour tea	12	0	چای	85000
71	./media/services/12/3.jpg	چای لیوانی با باقلو / A cup of tea with beans	12	0	چای	25000
72	./media/services/12/4.jpg	چای ماسالا / Masala tea	12	0	زنجبیل، هل، دارچین، میخک، شیر Ginger, cardamom, cinnamon, cloves, milk	80000
73	./media/services/12/5.jpg	مراکشی / Moroccan tea	12	0	چای سبز، نعنا، نبات خرد شده Green tea, mint, chopped candy	75000
75	./media/services/13/2.jpg	آیس لاته / Ice Latte	13	0	شیر، قهوه، یخ Milk, coffee, ice	80000
74	./media/services/13/1.png	آفوگاتو / Afugato	13	0	اسکوپ بستنی وانیل، قهوه Scoop of vanilla ice cream, coffee	75000
76	./media/services/13/3.jpg	فراپه شکلات / Chocolate Frappe	13	0	اسکوپ بستنی وانیل، قهوهاسکوپ بستنی وانیل، قهوه، شکلات، یخ Scoops of vanilla ice cream, coffee, chocolate, ice	78000
77	./media/services/13/4.jpg	فراپه کارامل / Caramel Frappe	13	0	اسکوپ بستنی وانیل، سس کارامل Scoop of vanilla ice cream, caramel sauce	78000
78	./media/services/13/5.jpg	فراپه وانیل / Vanilla extract	13	0	بستنی وانیل Vanilla ice cream	78000
79	./media/services/14/1.jpg	رزبری مارگاریتا / Raspberry Margarita	14	0	آب انار، آب زغالخته، آب آلبالو، نمک، توت فرنگی Pomegranate juice, charcoal juice, cherry juice, salt, strawberries	88000
80	./media/services/14/2.jpg	ساحلی / Coastal	14	0	نعنا، آب آلوورا، آب انبه، توت فرنگی Mint, aloe vera juice, mango juice, strawberries	85000
81	./media/services/14/3.jpg	منگوپین / Mengopin	14	0	توت فرنگی، انبه، پرتقال، یخ Strawberries, mangoes, oranges, ice	85000
82	./media/services/14/4.jpg	هاوایی / Hawaii	14	0	آناناس، آب انبه، نعناع Pineapple, mango juice, mint	87000
83	./media/services/15/1.jpg	سالیان / Salian	15	0	تخم شربتی، لیمو، شهد گل محمدی، بهار نارنج، یخ Syrup seeds, lemon, nectar of nectar, orange spring, ice	88000
84	./media/services/15/2.jpg	سراب / Mirage	15	0	لیمو، تخم شربتی، زعفران، شهد بهارنارنج Lemon, egg syrup, saffron, spring orange nectar	88000
85	./media/services/15/3.jpg	سیدا / Sida	15	0	آب لیمو، عرق نعنا، خیار رنده شده، آب سودا Lemon juice, mint juice, grated cucumber, soda water	88000
86	./media/services/15/4.jpg	ماسوله / Masoole	15	0	انار طبیعی، زغالخته، رب انار، آب آلبالو، خاکشیر، تخم شربتی Natural pomegranate, charcoal, pomegranate paste, cherry juice, sorrel, egg syrup	92000
87	./media/services/16/1.jpg	پشن فروت / Fruit	16	0	موز، بستنی، توت فرنگی، آب زغالخته Bananas, ice cream, strawberries, blueberry juice	86000
88	./media/services/16/2.jpg	تیرامیسو / Tiramisoo	16	0	بیسکویت پتی بور، بستنی وانیلی، قهوه، دارچین، پنیر کاله Petty Biscuits, Vanilla Ice Cream, Coffee, Cinnamon, kale Cheese	86000
89	./media/services/16/3.jpg	فراپه پسته / Pistachio Frappe	16	0	بستنی وانیلی، شیر، پسته Vanilla ice cream, milk, pistachios	96000
90	./media/services/16/4.jpg	کره بادام زمینی / peanut butter	16	0	موز، بستنی، کره بادام زمینی، شیر Bananas, ice cream, peanut butter, milk	86000
91	./media/services/16/5.jpg	نوتلا / Nutella	16	0	شیر، 4 اسکوپ بستنی Milk, 4 scoops of ice cream	88000
92	./media/services/17/1.jpg	سوپرایز الیاسام / Eliasam Surprise	17	0	بستنی وانیلی، بیسکوییت اورئو، گل خوراکی، رزبری، بلوبری Vanilla ice cream, Oreo biscuits, edible flowers, raspberries, blueberries	120000
93	./media/services/17/2.jpg	کهکشان الیاسام / Eliasam Galaxy	17	0	تخم شربتی، شکر قهوه ای، طلایی، عرق نعناع، عرق بیدمشک، عرق بهارنارنج Egg syrup, brown sugar, golden, mint sweat, pussy sweat, spring orange sweat	120000
94	./media/services/18/1_1.jpg	بلوبریانا / Bluberiana	18	0	--	85000
96	./media/services/18/3.jpg	کاکتوس / Cactus	18	0	--	78000
97	./media/services/18/4.jpg	لیموناد / Lemonade	18	0	--	75000
98	./media/services/18/5.jpg	موهیتو / Moohito	18	0	--	85000
99	./media/services/18/6.jpg	نوشیدنی فصل / Drinks of the season	18	0	--	70000
100	./media/services/19/1.jpg	A-104	19	0	--	3500000
101	./media/services/19/2.jpg	A-106	19	0	--	4500000
102	./media/services/19/3.jpg	A-108	19	0	--	4500000
107	./media/services/19/8.jpg	E-105	19	0	--	3000000
108	./media/services/19/9.jpg	E-107	19	0	--	2000000
109	./media/services/19/10.jpg	L-203	19	0	--	4500000
110	./media/services/19/11.jpg	L-204	19	0	--	4700000
111	./media/services/19/12.jpg	M-400	19	0	--	700000
112	./media/services/19/13.jpg	M-401	19	0	--	900000
113	./media/services/19/14.jpg	M-402	19	0	--	600000
114	./media/services/19/15.jpg	M-403	19	0	--	350000
115	./media/services/19/16.jpg	M-404	19	0	--	350000
116	./media/services/19/17.jpg	M-405	19	0	--	300000
117	./media/services/19/18.jpg	M-406	19	0	--	350000
118	./media/services/19/19.jpg	S-301	19	0	--	1000000
119	./media/services/19/20.jpg	S-303	19	0	--	1200000
120	./media/services/19/21.jpg	S-305	19	0	--	900000
121	./media/services/19/22.jpg	S-307	19	0	--	1200000
122	./media/services/19/23.jpg	S-309	19	0	--	1800000
123	./media/services/19/24.jpg	S-311	19	0	--	800000
\.


--
-- Data for Name: slider_images; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.slider_images (id, image_path) FROM stdin;
1	./media/slider/1.webp
2	./media/slider/2.webp
3	./media/slider/3.webp
4	./media/slider/4.webp
5	./media/slider/5.webp
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mosleh
--

COPY public.users (id, phone_number, hashed_password, full_name, email, created_at) FROM stdin;
1	09186645434	$2a$10$V04dNlqc0njvaIZ20TCsnuceGoNx5LTvkugIG7I/fH1jj7sPLHDle	مصلح عزیزی	moslehazizi@gmail.com	2024-01-09 12:45:09.472634+00
2	09184521306	$2a$10$QsMLIuxZXh8hnLNJBS4Gd.P5xxoEz2z5jBZsnP1lU/aISwB349c6W	مصلح عزیزی	moslehazizi@gmail.com	2024-01-09 12:45:43.862801+00
3	09101231234	$2a$10$fwiyeJz8psf28Kz3XHg02.h4lgQzBB.F9wgB6tcNOJjhB0S4uI2zG	نوشین	nooshin@gmail.com	2024-01-09 12:46:16.926931+00
4	09181234567	$2a$10$eIJbtix00BxmR01dkCptGuJw82sb5DkrqwYBVOc.XCTnOkJHF83qa	مرضیه	marziyeh@gmail.com	2024-01-09 12:46:40.636263+00
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
-- Name: discount_offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.discount_offers_id_seq', 20, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.services_id_seq', 1, false);


--
-- Name: slider_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.slider_images_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mosleh
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


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
-- Name: discount_offers discount_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.discount_offers
    ADD CONSTRAINT discount_offers_pkey PRIMARY KEY (id);


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
-- Name: slider_images slider_images_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.slider_images
    ADD CONSTRAINT slider_images_pkey PRIMARY KEY (id);
    

--
-- Name: users users_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_key UNIQUE (phone_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: categories_category_title_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX categories_category_title_idx ON public.categories USING btree (category_title);


--
-- Name: comments_id_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX comments_id_idx ON public.comments USING btree (id);


--
-- Name: discount_offers_id_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX discount_offers_id_idx ON public.discount_offers USING btree (id);


--
-- Name: services_service_category_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX services_service_category_idx ON public.services USING btree (service_category);


--
-- Name: slider_images_id_idx; Type: INDEX; Schema: public; Owner: mosleh
--

CREATE INDEX slider_images_id_idx ON public.slider_images USING btree (id);


--
-- Name: comments comments_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: discount_offers discount_offers_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mosleh
--

ALTER TABLE ONLY public.discount_offers
    ADD CONSTRAINT discount_offers_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


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

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

