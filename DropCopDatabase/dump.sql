--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: cop; Type: TABLE; Schema: public; Owner: mo; Tablespace: 
--

CREATE TABLE cop (
    cid integer NOT NULL,
    name character varying(36) NOT NULL,
    price integer NOT NULL,
    details character varying(150) NOT NULL,
    count integer NOT NULL,
    pic character varying(150) NOT NULL,
    "currCount" integer NOT NULL
);


ALTER TABLE cop OWNER TO mo;

--
-- Name: deals; Type: TABLE; Schema: public; Owner: mo; Tablespace: 
--

CREATE TABLE deals (
    id integer NOT NULL,
    username character varying(36),
    name character varying(50),
    details character varying(200),
    price character varying(10),
    link character varying(2000),
    likes integer
);


ALTER TABLE deals OWNER TO mo;

--
-- Name: deals_id_seq; Type: SEQUENCE; Schema: public; Owner: mo
--

CREATE SEQUENCE deals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE deals_id_seq OWNER TO mo;

--
-- Name: deals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mo
--

ALTER SEQUENCE deals_id_seq OWNED BY deals.id;


--
-- Name: login; Type: TABLE; Schema: public; Owner: mo; Tablespace: 
--

CREATE TABLE login (
    username character varying(32) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE login OWNER TO mo;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: mo; Tablespace: 
--

CREATE TABLE orders (
    username character varying(36) NOT NULL,
    item character varying(36) NOT NULL,
    sname character varying(100),
    city character varying(50),
    state character varying(20),
    phone character varying(10),
    zip integer,
    bname character varying(100),
    cc integer,
    sc integer,
    exp integer,
    address character varying(100),
    oid bigint NOT NULL
);


ALTER TABLE orders OWNER TO mo;

--
-- Name: orders_oid_seq; Type: SEQUENCE; Schema: public; Owner: mo
--

CREATE SEQUENCE orders_oid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_oid_seq OWNER TO mo;

--
-- Name: orders_oid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mo
--

ALTER SEQUENCE orders_oid_seq OWNED BY orders.oid;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mo
--

ALTER TABLE ONLY deals ALTER COLUMN id SET DEFAULT nextval('deals_id_seq'::regclass);


--
-- Name: oid; Type: DEFAULT; Schema: public; Owner: mo
--

ALTER TABLE ONLY orders ALTER COLUMN oid SET DEFAULT nextval('orders_oid_seq'::regclass);


--
-- Data for Name: cop; Type: TABLE DATA; Schema: public; Owner: mo
--

COPY cop (cid, name, price, details, count, pic, "currCount") FROM stdin;
2	Spigen Neo Hybrid	20	Slim sleek case for iphone 4/4s/5/5s/6/6plus	88	http://i.imgur.com/38taRl8.png	15
3	Timbuk 2 Classic Messenger Bag	49	Classic messenger bag with refined aesthetics, clean contours, and smarter organization. 	50	http://i.imgur.com/MdyMDG5.png	25
1	Sennheiser HD518	100	Open ear circumaural headphones	50	http://i.imgur.com/grJjvI4.png	128
\.


--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: mo
--

COPY deals (id, username, name, details, price, link, likes) FROM stdin;
10	bj	Some Router	Excellent Router	56.33	http://www.newegg.com/Product/Product.aspx?sdtid=7826283&SID=53a31227d99a41ebae329997e17c72e5&AID=10440897&PID=1225267&nm_mc=AFC-C8Junction&cm_mmc=AFC-C8Junction-_-cables-_-na-_-na&Item=N82E16833704121&cm_sp=	20
12	dj	rf	fr	34	www.google.com	1
4	mo	Seagate 1TB HDD / 8GB SSD Hybrid Drive. 	1TB harddrive that includes 8gb of SSD storage. Free Shipping. 	70	http://www.newegg.com/Product/Product.aspx?sdtid=7828845&SID=434d5559bffe4bb7a39977a0d7f999ce&AID=10440897&PID=1225267&nm_mc=AFC-C8Junction&cm_mmc=AFC-C8Junction-_-cables-_-na-_-na&Item=N82E16822178340&cm_sp=	1
3	mo	ASUS RT-N66U Dual-Band Router	Includes a $10 Rebate. 	113.99	http://www.newegg.com/Product/Product.aspx?sdtid=7827077&SID=0ee8a77de7984ba591d6122ca83a7e3e&AID=10440897&PID=1225267&nm_mc=AFC-C8Junction&cm_mmc=AFC-C8Junction-_-cables-_-na-_-na&Item=N82E16833320091&FM=1&cm_sp=	2
2	mo	Gillette Mach3 Men's Razor Blade Refills 8 Count	Clip the coupon on the page to save $6 & free shipping.	9.49	http://www.amazon.com/gp/product/B000JGP1HC/ref=amb_link_432095262_1_ttl_ttl?tag=slickdeals&ascsubtag=5ae400181f894032899bf9990eb58e43&ie=UTF8&m=ATVPDKIKX0DER&s=beauty	4
5	mo	Ninja Professional Blender 1000	Use MYFAMILY to get 25% off this blender at JCPENNEY. 	75	http://www.jcpenney.com/ninja-professional-blender-1000/prod.jump?ppId=pp5004820104&searchTerm=ninja+blender&catId=SearchResults&_dyncharset=UTF-8&cm_mmc=Affiliates-_-lw9MynSeamY-_-1-_-10&utm_medium=affiliate&utm_source=lw9MynSeamY&utm_campaign=1&utm_content=10&cvosrc=affiliate.lw9MynSeamY.1_10&siteID=lw9MynSeamY-wfuJUmdr9d7O0YQLLpmqVQ	18
6	mo	Kill-A-Watt P4400	Online only at homedepot	15.94	http://www.homedepot.com/p/Unbranded-Kill-A-Watt-Electricity-Monitor-P4400/202196386?cm_mmc=CJ-_-1225267-_-10368321&AID=10368321&PID=1225267&SID=179b46f15e1448b8ab5739d8df35f383&cj=true	23
11	demo2	Fibit Charge	fitbit	129.69	http://www.newegg.com/Product/Product.aspx?sdtid=7826283&SID=53a31227d99a41ebae329997e17c72e5&AID=10440897&PID=1225267&nm_mc=AFC-C8Junction&cm_mmc=AFC-C8Junction-_-cables-_-na-_-na&Item=N82E16833704121&cm_sp=	7
13	dj	ede	deed	23	www.google.com	2
9	mo	Sandisk SSD 128GB	128GB SSD offering upto 475 MB/s reads 	55	http://www.newegg.com/Product/Product.aspx?Item=N82E16820171646&nm_mc=AFC-dealnews&cm_mmc=AFC-dealnews-_-NA-_-NA-_-N82E16820171646	10
7	mo	Hershey's Chocolate Full Size Variety Pack	30-Count Pack for $13.99	13.99	http://www.amazon.com/Hersheys-Chocolate-Full-Variety-30-Count/dp/B000WL39JQ/ref=sr_1_1?tag=slickdeals&ascsubtag=fc5c83684139412b9c09df2b6aee218a&ie=UTF8&qid=1430271661&sr=8-1&keywords=Hershey%27s+Chocolate+Full+Size+Variety+Pack%2C+30-Count+Pack	59
8	mo	Anker 8A (40W) 5-Port USB HUB	Includes 3-pack 3 ft lightning cables too!	30	http://www.amazon.com/dp/B00RZDJRAO?tag=slickdeals&ascsubtag=c020ae6a3b664913aa9817d4e548f8ee	11
\.


--
-- Name: deals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mo
--

SELECT pg_catalog.setval('deals_id_seq', 13, true);


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: mo
--

COPY login (username, email, password) FROM stdin;
mo	moalam@nyu.edu	blahblah
pavan	pavan@gmail.com	bloobloo
justin	masterjman@yahoo.com	blueblue
Demo	demo@demo.com	demo
mow	swws	sw
do	swwssss	sw
swsw	wss	wsw
emo	mo	qws
wsw	swswsw	map
dj	dj@dj.com	dj
guggy	gugg3edheh	gg
bs	msxihcibe	bs
ede	eded	ed
edee	ededed	ed
wsde	dee	ed
bj	bj	bj
rfr	rfr	er
dee	edd	ed
dedede	eddedde	ed
wddede	ededede	ed
wdew	ewed	ed
suckdemnuts	eba@xxx.com	sold
demo2	demo@gmail.com	malam
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: mo
--

COPY orders (username, item, sname, city, state, phone, zip, bname, cc, sc, exp, address, oid) FROM stdin;
mo	Sennheiser HD518	xx	xx	xx	2	2	xx	3	3	3	xx	1
dj	Timbuk 2 Classic Messenger Bag	edd	de	ed	1	1	ede	1	1	1	edd	2
dj	Timbuk 2 Classic Messenger Bag	dede	ede	dede	2	2	dede	2	2	2	dede	3
dj	Timbuk 2 Classic Messenger Bag	edde	edde	edde	2	2	dee	2	2	2	edd	4
dj	Spigen Neo Hybrid	ed	edde	edd	3	33	ed	3	3	3	dede	5
dj	Timbuk 2 Classic Messenger Bag	ded	edd	ed	3	3	ed	3	3	3	ded	6
dj	Sennheiser HD518	dede	edde	e3	2	2	ee	2	2	2	ede	7
dj	Spigen Neo Hybrid	edede	eddede	ed	2	2	eded	2	2	2	ede	8
dj	Sennheiser HD518	dee	ede	ede	2	2	eded	2	2	2	edde	9
dj	Timbuk 2 Classic Messenger Bag	edded	ded	ed	3	2	ed	3	3	3	ede	10
dj	Sennheiser HD518	deed	edde	dede	2	2	edeeeded	2	2	2	dede	11
bj	Spigen Neo Hybrid	dede	edde	edeed	2	2	eded	2	2	2	ded	12
dj	Timbuk 2 Classic Messenger Bag	dede	edde	edde	2	2	ede	2	2	2	edde	13
dj	Sennheiser HD518	dj	fobz	bj	911	2525911	h	5	888	6	124	14
demo2	Sennheiser HD518	xsxs	xsxs	sxx	34	34	fefee	34	34	43	xss	15
\.


--
-- Name: orders_oid_seq; Type: SEQUENCE SET; Schema: public; Owner: mo
--

SELECT pg_catalog.setval('orders_oid_seq', 15, true);


--
-- Name: cop_name_key; Type: CONSTRAINT; Schema: public; Owner: mo; Tablespace: 
--

ALTER TABLE ONLY cop
    ADD CONSTRAINT cop_name_key UNIQUE (name);


--
-- Name: cop_pkey; Type: CONSTRAINT; Schema: public; Owner: mo; Tablespace: 
--

ALTER TABLE ONLY cop
    ADD CONSTRAINT cop_pkey PRIMARY KEY (cid);


--
-- Name: deals_pkey; Type: CONSTRAINT; Schema: public; Owner: mo; Tablespace: 
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: login_pkey; Type: CONSTRAINT; Schema: public; Owner: mo; Tablespace: 
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_pkey PRIMARY KEY (username);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: mo; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (oid);


--
-- Name: deals_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mo
--

ALTER TABLE ONLY deals
    ADD CONSTRAINT deals_username_fkey FOREIGN KEY (username) REFERENCES login(username);


--
-- Name: orders_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mo
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_item_fkey FOREIGN KEY (item) REFERENCES cop(name);


--
-- Name: orders_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mo
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_username_fkey FOREIGN KEY (username) REFERENCES login(username);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO mo;


--
-- PostgreSQL database dump complete
--

