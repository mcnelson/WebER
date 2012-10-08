--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO weber;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO weber;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('categories_id_seq', 1, true);


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE equipment (
    id integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    status character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    brand character varying(100),
    model character varying(100),
    serial character varying(100),
    max_reservation_period integer,
    photo_file_name character varying(255),
    photo_content_type character varying(255),
    photo_file_size integer,
    photo_updated_at timestamp without time zone,
    category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.equipment OWNER TO weber;

--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE equipment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipment_id_seq OWNER TO weber;

--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE equipment_id_seq OWNED BY equipment.id;


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('equipment_id_seq', 29, true);


--
-- Name: equipment_packages; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE equipment_packages (
    id integer NOT NULL,
    equipment_id integer NOT NULL,
    package_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.equipment_packages OWNER TO weber;

--
-- Name: equipment_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE equipment_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipment_packages_id_seq OWNER TO weber;

--
-- Name: equipment_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE equipment_packages_id_seq OWNED BY equipment_packages.id;


--
-- Name: equipment_packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('equipment_packages_id_seq', 1, false);


--
-- Name: equipment_reservations; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE equipment_reservations (
    id integer NOT NULL,
    equipment_id integer NOT NULL,
    reservation_id integer NOT NULL,
    package_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.equipment_reservations OWNER TO weber;

--
-- Name: equipment_reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE equipment_reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipment_reservations_id_seq OWNER TO weber;

--
-- Name: equipment_reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE equipment_reservations_id_seq OWNED BY equipment_reservations.id;


--
-- Name: equipment_reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('equipment_reservations_id_seq', 1, false);


--
-- Name: er_hours; Type: TABLE; Schema: public; Owner: michael; Tablespace: 
--

CREATE TABLE er_hours (
    id integer NOT NULL,
    starts_at time without time zone NOT NULL,
    ends_at time without time zone NOT NULL,
    day character varying(3) NOT NULL,
    semester_id integer NOT NULL,
    associated_hour_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.er_hours OWNER TO michael;

--
-- Name: er_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: michael
--

CREATE SEQUENCE er_hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.er_hours_id_seq OWNER TO michael;

--
-- Name: er_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michael
--

ALTER SEQUENCE er_hours_id_seq OWNED BY er_hours.id;


--
-- Name: er_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michael
--

SELECT pg_catalog.setval('er_hours_id_seq', 2, true);


--
-- Name: packages; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE packages (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    max_reservation_period integer,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.packages OWNER TO weber;

--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.packages_id_seq OWNER TO weber;

--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE packages_id_seq OWNED BY packages.id;


--
-- Name: packages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('packages_id_seq', 1, false);


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE reservations (
    id integer NOT NULL,
    starts_at timestamp without time zone NOT NULL,
    ends_at timestamp without time zone NOT NULL,
    status character varying(30) NOT NULL,
    notes text,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.reservations OWNER TO weber;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO weber;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE reservations_id_seq OWNED BY reservations.id;


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('reservations_id_seq', 8, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: michael; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO michael;

--
-- Name: semesters; Type: TABLE; Schema: public; Owner: michael; Tablespace: 
--

CREATE TABLE semesters (
    id integer NOT NULL,
    starts_at date NOT NULL,
    ends_at date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.semesters OWNER TO michael;

--
-- Name: semesters_id_seq; Type: SEQUENCE; Schema: public; Owner: michael
--

CREATE SEQUENCE semesters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.semesters_id_seq OWNER TO michael;

--
-- Name: semesters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: michael
--

ALTER SEQUENCE semesters_id_seq OWNED BY semesters.id;


--
-- Name: semesters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michael
--

SELECT pg_catalog.setval('semesters_id_seq', 3, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: weber; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    active boolean DEFAULT true,
    punet character varying(8) NOT NULL,
    pu_student_id integer,
    strikes integer DEFAULT 0,
    can_reserve boolean DEFAULT true,
    notes text,
    password_digest character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying(255) NOT NULL,
    permission_level character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO weber;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: weber
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO weber;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weber
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weber
--

SELECT pg_catalog.setval('users_id_seq', 6, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY equipment ALTER COLUMN id SET DEFAULT nextval('equipment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY equipment_packages ALTER COLUMN id SET DEFAULT nextval('equipment_packages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY equipment_reservations ALTER COLUMN id SET DEFAULT nextval('equipment_reservations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: michael
--

ALTER TABLE ONLY er_hours ALTER COLUMN id SET DEFAULT nextval('er_hours_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY packages ALTER COLUMN id SET DEFAULT nextval('packages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY reservations ALTER COLUMN id SET DEFAULT nextval('reservations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: michael
--

ALTER TABLE ONLY semesters ALTER COLUMN id SET DEFAULT nextval('semesters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: weber
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY categories (id, title, created_at, updated_at) FROM stdin;
1	Tripods	2012-09-24 22:06:17.992123	2012-09-24 22:07:20.571431
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY equipment (id, active, status, name, brand, model, serial, max_reservation_period, photo_file_name, photo_content_type, photo_file_size, photo_updated_at, category_id, created_at, updated_at) FROM stdin;
3	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.882163	2012-10-01 21:22:57.882163
1	t	available	Cam-1	Sony	TRV-17	09258902859	\N	fantasy-lights.jpg	image/jpeg	526252	2012-10-07 19:57:26.535248	1	2012-09-24 22:06:29.931487	2012-10-07 19:57:26.925274
4	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
5	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
6	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
7	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
8	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
9	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
10	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
12	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
13	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
14	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
15	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
16	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
17	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
18	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
19	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
20	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
21	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
22	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
23	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
24	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
25	t	available	Cam-1	Sony	TRV-17	09258902859	\N	fantasy-lights.jpg	image/jpeg	526252	2012-10-07 19:57:26.1096	1	2012-09-24 22:06:29.13983	2012-10-07 19:57:26.777
26	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
27	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
28	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
29	t	available	TP-1	Manfrotto	BPX-T220	aklsjsu8943025	\N	\N	\N	\N	\N	1	2012-10-01 21:22:57.30195	2012-10-01 21:22:57.30195
\.


--
-- Data for Name: equipment_packages; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY equipment_packages (id, equipment_id, package_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: equipment_reservations; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY equipment_reservations (id, equipment_id, reservation_id, package_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: er_hours; Type: TABLE DATA; Schema: public; Owner: michael
--

COPY er_hours (id, starts_at, ends_at, day, semester_id, associated_hour_id, created_at, updated_at) FROM stdin;
2	16:00:00	17:00:00	wed	2	1	2012-09-23 04:41:06.337067	2012-09-23 06:03:55.960719
1	14:30:00	15:00:00	mon	2	2	2012-09-18 04:30:38.337332	2012-09-24 01:36:55.953158
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY packages (id, title, max_reservation_period, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY reservations (id, starts_at, ends_at, status, notes, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: michael
--

COPY schema_migrations (version) FROM stdin;
20120917002441
20120918000705
20120923045647
20120923222023
20120923222517
20120924011947
20120928230901
20120928232254
20120929182710
20120929230255
20120929230409
20120929230516
20120930024248
\.


--
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: michael
--

COPY semesters (id, starts_at, ends_at, created_at, updated_at) FROM stdin;
1	2012-01-31	2012-04-28	2012-09-18 01:46:11.135187	2012-09-18 03:54:40.943609
2	2012-08-14	2012-12-05	2012-09-18 03:55:39.178823	2012-09-18 03:55:39.178823
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: weber
--

COPY users (id, active, punet, pu_student_id, strikes, can_reserve, notes, password_digest, created_at, updated_at, email, permission_level) FROM stdin;
5	t	asdf1234	911990	0	t		$2a$10$QCagxCHc86eWq.TjT2oV6er1PlGeL2f8d3u1b03aaH5lD3cRkRygW	2012-09-30 03:05:20.496046	2012-09-30 03:05:20.496046	asdf@asdf.com	student
4	t	nels0991	900991	0	t		$2a$10$0eXCtu37YbIgRZIf1g2.pe464Gd0HNN6PXfcGRtgDlPD/BVqYWH/.	2012-09-30 02:56:42.255778	2012-10-07 18:07:42.639707	nels0991@pacificu.edu	admin
\.


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: equipment_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY equipment_packages
    ADD CONSTRAINT equipment_packages_pkey PRIMARY KEY (id);


--
-- Name: equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: equipment_reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY equipment_reservations
    ADD CONSTRAINT equipment_reservations_pkey PRIMARY KEY (id);


--
-- Name: er_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: michael; Tablespace: 
--

ALTER TABLE ONLY er_hours
    ADD CONSTRAINT er_hours_pkey PRIMARY KEY (id);


--
-- Name: packages_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: michael; Tablespace: 
--

ALTER TABLE ONLY semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (id);


--
-- Name: user_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: weber; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_infos_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: michael; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

