--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6
-- Dumped by pg_dump version 11.6

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

SET default_with_oids = false;

--
-- Name: brands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name character varying
);


--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: car_services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.car_services (
    id integer NOT NULL,
    license character varying,
    details character varying,
    type character varying,
    location_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: car_services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.car_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: car_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.car_services_id_seq OWNED BY public.car_services.id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cars (
    id integer NOT NULL,
    vin character varying,
    plate character varying,
    engine_number character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    model character varying,
    brand_id integer
);


--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cars_id_seq OWNED BY public.cars.id;


--
-- Name: histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.histories (
    id integer NOT NULL,
    mileage integer,
    cost numeric(8,2),
    details character varying,
    car_id integer,
    type character varying,
    valid_until timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    happened_at timestamp without time zone
);


--
-- Name: histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.histories_id_seq OWNED BY public.histories.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying,
    settlement character varying,
    settlement_type integer,
    address character varying,
    longitude double precision,
    latitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying DEFAULT '0'::character varying NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer,
    notifiable_id integer,
    notifiable_type character varying,
    read_at timestamp without time zone,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    user_id integer,
    receives_history_expiration_emails boolean DEFAULT false,
    receives_inactivity_emails boolean DEFAULT false,
    receives_history_expiration_facebook_notifications boolean DEFAULT true,
    receives_inactivity_facebook_notifications boolean DEFAULT true
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    provider character varying,
    uid character varying,
    email character varying,
    password_digest character varying,
    admin boolean,
    last_login_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_reset_token character varying,
    password_reset_sent_at timestamp without time zone,
    guest boolean,
    login_count integer DEFAULT 0 NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: car_services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.car_services ALTER COLUMN id SET DEFAULT nextval('public.car_services_id_seq'::regclass);


--
-- Name: cars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cars ALTER COLUMN id SET DEFAULT nextval('public.cars_id_seq'::regclass);


--
-- Name: histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.histories ALTER COLUMN id SET DEFAULT nextval('public.histories_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: car_services car_services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.car_services
    ADD CONSTRAINT car_services_pkey PRIMARY KEY (id);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: histories histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.histories
    ADD CONSTRAINT histories_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_car_services_on_location_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_car_services_on_location_id ON public.car_services USING btree (location_id);


--
-- Name: index_cars_on_brand_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cars_on_brand_id ON public.cars USING btree (brand_id);


--
-- Name: index_notifications_on_notifiable_id_and_notifiable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_notifiable_id_and_notifiable_type ON public.notifications USING btree (notifiable_id, notifiable_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160308105143');

INSERT INTO schema_migrations (version) VALUES ('20160310092406');

INSERT INTO schema_migrations (version) VALUES ('20160310154359');

INSERT INTO schema_migrations (version) VALUES ('20160408111348');

INSERT INTO schema_migrations (version) VALUES ('20160408134229');

INSERT INTO schema_migrations (version) VALUES ('20160408170715');

INSERT INTO schema_migrations (version) VALUES ('20160410154612');

INSERT INTO schema_migrations (version) VALUES ('20160505104800');

INSERT INTO schema_migrations (version) VALUES ('20160701074204');

INSERT INTO schema_migrations (version) VALUES ('20160720215244');

INSERT INTO schema_migrations (version) VALUES ('20160904104138');

INSERT INTO schema_migrations (version) VALUES ('20160906144932');

INSERT INTO schema_migrations (version) VALUES ('20161008114401');

INSERT INTO schema_migrations (version) VALUES ('20161008115227');

INSERT INTO schema_migrations (version) VALUES ('20161008115636');

INSERT INTO schema_migrations (version) VALUES ('20161022102551');

INSERT INTO schema_migrations (version) VALUES ('20161022175203');

INSERT INTO schema_migrations (version) VALUES ('20161022175218');

INSERT INTO schema_migrations (version) VALUES ('20161023220735');

INSERT INTO schema_migrations (version) VALUES ('20170218150624');

INSERT INTO schema_migrations (version) VALUES ('20180523185915');

INSERT INTO schema_migrations (version) VALUES ('20180523203415');

