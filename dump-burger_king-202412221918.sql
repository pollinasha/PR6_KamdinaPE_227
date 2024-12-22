--
-- PostgreSQL database cluster dump
--

-- Started on 2024-12-22 19:18:57

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "New_User";
ALTER ROLE "New_User" WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "User_227_14";
ALTER ROLE "User_227_14" WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-12-22 19:18:57

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

-- Completed on 2024-12-22 19:18:57

--
-- PostgreSQL database dump complete
--

--
-- Database "Pract4" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-12-22 19:18:57

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
-- TOC entry 4899 (class 1262 OID 17398)
-- Name: Pract4; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Pract4" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "Pract4" OWNER TO postgres;

\connect "Pract4"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 17422)
-- Name: hall_row; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hall_row (
    id_hall integer NOT NULL,
    number smallint NOT NULL,
    capacity smallint NOT NULL,
    name character varying
);


ALTER TABLE public.hall_row OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17466)
-- Name: capacity_hall_row; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.capacity_hall_row AS
 SELECT capacity
   FROM public.hall_row
  WHERE ((id_hall = 3) AND (number = 2));


ALTER VIEW public.capacity_hall_row OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17427)
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public.film OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17415)
-- Name: hall; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hall (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.hall OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17410)
-- Name: screening; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.screening (
    id integer NOT NULL,
    hall_id integer NOT NULL,
    film_id integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    name character varying
);


ALTER TABLE public.screening OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17470)
-- Name: film_screening; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.film_screening AS
 SELECT film.name,
    hall.id,
    screening."time"
   FROM public.film,
    public.screening,
    public.hall
  WHERE ((screening."time" > '2021-01-01 11:00:00'::timestamp without time zone) AND (screening.film_id = film.id) AND (screening.hall_id = hall.id) AND (hall.id = 2));


ALTER VIEW public.film_screening OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17462)
-- Name: films_screening; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.films_screening AS
 SELECT film.name,
    screening."time"
   FROM public.film,
    public.screening
  WHERE ((screening."time" > '2021-01-01 11:00:00'::timestamp without time zone) AND (screening.film_id = film.id));


ALTER VIEW public.films_screening OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17474)
-- Name: screenings_film; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.screenings_film AS
 SELECT screening.id AS screening_id,
    hall.name AS hall_name,
    screening."time"
   FROM ((public.screening
     JOIN public.film ON ((screening.film_id = film.id)))
     JOIN public.hall ON ((screening.hall_id = hall.id)))
  WHERE ((film.name)::text = 'Таро'::text);


ALTER VIEW public.screenings_film OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17399)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    id_screening integer NOT NULL,
    "row" smallint NOT NULL,
    seat smallint NOT NULL,
    cost integer NOT NULL
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 17427)
-- Dependencies: 221
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.film (id, name, description) FROM stdin;
1	Огниво	Приключение
2	Таро	Ужасы
3	Супер-Санта	Мультфильм
\.


--
-- TOC entry 4891 (class 0 OID 17415)
-- Dependencies: 219
-- Data for Name: hall; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hall (id, name) FROM stdin;
1	Зал 1
2	Зал 2
3	Зал 3
\.


--
-- TOC entry 4892 (class 0 OID 17422)
-- Dependencies: 220
-- Data for Name: hall_row; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hall_row (id_hall, number, capacity, name) FROM stdin;
1	1	10	\N
1	2	15	\N
1	3	20	\N
2	2	15	\N
3	2	12	\N
\.


--
-- TOC entry 4890 (class 0 OID 17410)
-- Dependencies: 218
-- Data for Name: screening; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.screening (id, hall_id, film_id, "time", name) FROM stdin;
1	1	1	2021-01-01 00:00:00	\N
2	1	1	2021-01-01 10:35:00	\N
3	1	2	2021-01-01 01:35:00	\N
5	3	2	2020-12-30 20:00:00	\N
7	2	3	2021-01-01 12:00:00	\N
4	2	3	2021-01-02 15:15:00	\N
6	3	3	2021-01-02 10:00:00	\N
\.


--
-- TOC entry 4889 (class 0 OID 17399)
-- Dependencies: 217
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (id_screening, "row", seat, cost) FROM stdin;
2	4	15	100
3	5	15	100
4	6	15	100
5	7	15	100
1	2	10	150
1	3	15	200
1	3	6	150
\.


--
-- TOC entry 4735 (class 2606 OID 17433)
-- Name: film film_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pk PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 17421)
-- Name: hall hall_pk_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hall
    ADD CONSTRAINT hall_pk_1 PRIMARY KEY (name, id);


--
-- TOC entry 4733 (class 2606 OID 17426)
-- Name: hall_row hall_row_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hall_row
    ADD CONSTRAINT hall_row_pk PRIMARY KEY (id_hall, number);


--
-- TOC entry 4729 (class 2606 OID 17414)
-- Name: screening screening_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening
    ADD CONSTRAINT screening_pk PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 17409)
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id_screening, "row", seat);


--
-- TOC entry 4739 (class 2606 OID 17440)
-- Name: hall_row hall_row_hall_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hall_row
    ADD CONSTRAINT hall_row_hall_fk FOREIGN KEY (name, id_hall) REFERENCES public.hall(name, id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4737 (class 2606 OID 17457)
-- Name: screening screening_film_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening
    ADD CONSTRAINT screening_film_fk FOREIGN KEY (film_id) REFERENCES public.film(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4738 (class 2606 OID 17447)
-- Name: screening screening_hall_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.screening
    ADD CONSTRAINT screening_hall_fk FOREIGN KEY (name, hall_id) REFERENCES public.hall(name, id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4736 (class 2606 OID 17452)
-- Name: tickets tickets_screening_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_screening_fk FOREIGN KEY (id_screening) REFERENCES public.screening(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-12-22 19:18:58

--
-- PostgreSQL database dump complete
--

--
-- Database "burger_king" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2024-12-22 19:18:58

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
-- TOC entry 4904 (class 1262 OID 17482)
-- Name: burger_king; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE burger_king WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE burger_king OWNER TO postgres;

\connect burger_king

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17587)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    phone character varying(15) NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17586)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO postgres;

--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 225
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- TOC entry 228 (class 1259 OID 17594)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    client_id integer,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(50) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17593)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 220 (class 1259 OID 17556)
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    salary numeric(10,2) NOT NULL
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17555)
-- Name: position_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.position_id_seq OWNER TO postgres;

--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 219
-- Name: position_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_id_seq OWNED BY public."position".id;


--
-- TOC entry 218 (class 1259 OID 17549)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17548)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 217
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 224 (class 1259 OID 17575)
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    position_id integer
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17574)
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_id_seq OWNER TO postgres;

--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 223
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- TOC entry 222 (class 1259 OID 17563)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    product_id integer,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17562)
-- Name: supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_id_seq OWNER TO postgres;

--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 221
-- Name: supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_id_seq OWNED BY public.supplier.id;


--
-- TOC entry 4724 (class 2604 OID 17590)
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 17597)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4721 (class 2604 OID 17559)
-- Name: position id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position" ALTER COLUMN id SET DEFAULT nextval('public.position_id_seq'::regclass);


--
-- TOC entry 4720 (class 2604 OID 17552)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4723 (class 2604 OID 17578)
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- TOC entry 4722 (class 2604 OID 17566)
-- Name: supplier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN id SET DEFAULT nextval('public.supplier_id_seq'::regclass);


--
-- TOC entry 4896 (class 0 OID 17587)
-- Dependencies: 226
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, full_name, phone) FROM stdin;
1	Александров А.А.	1234567890
2	Борисова Б.Б.	0987654321
3	Григорьев Г.Г.	1112223333
4	Дмитриев Д.Д.	1231231234
5	Егорова Е.Е.	2342342345
6	Захаров З.З.	3453453456
7	Ильинична И.И.	4564564567
8	Кириллова К.К.	5675675678
9	Леонтьев Л.Л.	6786786789
10	Моисеева М.М.	7897897890
\.


--
-- TOC entry 4898 (class 0 OID 17594)
-- Dependencies: 228
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, client_id, date, status) FROM stdin;
1	1	2024-12-22 19:16:33.065177	Приготовлен
2	2	2024-12-22 19:16:33.065177	На заказ
3	3	2024-12-22 19:16:33.065177	Выполнен
4	4	2024-12-22 19:16:33.065177	Приготовлен
5	5	2024-12-22 19:16:33.065177	Отменён
6	6	2024-12-22 19:16:33.065177	Выполнен
7	7	2024-12-22 19:16:33.065177	На заказ
8	8	2024-12-22 19:16:33.065177	Приготовлен
9	9	2024-12-22 19:16:33.065177	Отменён
10	10	2024-12-22 19:16:33.065177	Выполнен
\.


--
-- TOC entry 4890 (class 0 OID 17556)
-- Dependencies: 220
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (id, name, salary) FROM stdin;
1	Менеджер	30000.00
2	Кассир	25000.00
3	Повар	35000.00
4	Управляющий	50000.00
5	Уборщик	20000.00
\.


--
-- TOC entry 4888 (class 0 OID 17549)
-- Dependencies: 218
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, quantity, price) FROM stdin;
1	Бургер 1	100	120.00
2	Бургер 2	50	150.00
3	Бургер 3	200	180.00
4	Бургер 4	75	90.00
5	Бургер 5	120	100.00
6	Наггетсы	300	150.00
7	Коктейль 1	250	60.00
8	Коктейль 2	100	70.00
9	Салат 1	150	80.00
10	Салат 2	50	90.00
\.


--
-- TOC entry 4894 (class 0 OID 17575)
-- Dependencies: 224
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, full_name, position_id) FROM stdin;
1	Иванов И.И.	1
2	Петров П.П.	2
3	Сидоров С.С.	1
4	Кузнецова К.Р.	2
5	Соловьев С.С.	3
6	Михайлова М.М.	2
7	Федоров Ф.Ф.	1
8	Коваленко К.К.	3
9	Николаев Н.Н.	2
10	Маслов М.М.	1
\.


--
-- TOC entry 4892 (class 0 OID 17563)
-- Dependencies: 222
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (id, name, product_id, price) FROM stdin;
1	Поставщик 1	1	100.00
2	Поставщик 2	2	150.00
3	Поставщик 3	3	200.00
4	Поставщик 4	4	75.00
5	Поставщик 5	5	120.00
6	Поставщик 6	6	90.00
7	Поставщик 7	7	110.00
8	Поставщик 8	8	180.00
9	Поставщик 9	9	160.00
10	Поставщик 10	10	130.00
\.


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 225
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 10, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 10, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 219
-- Name: position_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_id_seq', 5, true);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 217
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 10, true);


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 223
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 10, true);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 221
-- Name: supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_id_seq', 10, true);


--
-- TOC entry 4736 (class 2606 OID 17592)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 4738 (class 2606 OID 17600)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4730 (class 2606 OID 17561)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id);


--
-- TOC entry 4728 (class 2606 OID 17554)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4734 (class 2606 OID 17580)
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- TOC entry 4732 (class 2606 OID 17568)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);


--
-- TOC entry 4741 (class 2606 OID 17601)
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 4740 (class 2606 OID 17581)
-- Name: staff staff_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_position_id_fkey FOREIGN KEY (position_id) REFERENCES public."position"(id);


--
-- TOC entry 4739 (class 2606 OID 17569)
-- Name: supplier supplier_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


-- Completed on 2024-12-22 19:18:58

--
-- PostgreSQL database dump complete
--

-- Completed on 2024-12-22 19:18:58

--
-- PostgreSQL database cluster dump complete
--

