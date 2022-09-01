--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.4

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
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id_categorie bigint NOT NULL,
    nom character varying(100) NOT NULL
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- Name: categorie_id_categorie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorie_id_categorie_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorie_id_categorie_seq OWNER TO postgres;

--
-- Name: categorie_id_categorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_id_categorie_seq OWNED BY public.categorie.id_categorie;


--
-- Name: cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cours (
    id_cours bigint NOT NULL,
    titre character varying(255) NOT NULL,
    vignette character varying(255),
    statut integer DEFAULT 0 NOT NULL,
    description text NOT NULL,
    description_courte text,
    id_users bigint,
    prix numeric,
    id_categorie bigint,
    id_langue bigint,
    id_niveau bigint
);


ALTER TABLE public.cours OWNER TO postgres;

--
-- Name: cours_id_cours_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cours_id_cours_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cours_id_cours_seq OWNER TO postgres;

--
-- Name: cours_id_cours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cours_id_cours_seq OWNED BY public.cours.id_cours;


--
-- Name: exigence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exigence (
    id_exigence bigint NOT NULL,
    nom character varying(255) NOT NULL,
    id_cours bigint NOT NULL
);


ALTER TABLE public.exigence OWNER TO postgres;

--
-- Name: exigence_id_exigence_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exigence_id_exigence_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exigence_id_exigence_seq OWNER TO postgres;

--
-- Name: exigence_id_exigence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exigence_id_exigence_seq OWNED BY public.exigence.id_exigence;


--
-- Name: favoris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favoris (
    id_favoris bigint NOT NULL,
    id_users bigint,
    id_cours bigint
);


ALTER TABLE public.favoris OWNER TO postgres;

--
-- Name: favoris_id_favoris_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favoris_id_favoris_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favoris_id_favoris_seq OWNER TO postgres;

--
-- Name: favoris_id_favoris_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favoris_id_favoris_seq OWNED BY public.favoris.id_favoris;


--
-- Name: langue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.langue (
    id_langue bigint NOT NULL,
    nom character varying(100) NOT NULL
);


ALTER TABLE public.langue OWNER TO postgres;

--
-- Name: langue_id_langue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.langue_id_langue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.langue_id_langue_seq OWNER TO postgres;

--
-- Name: langue_id_langue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.langue_id_langue_seq OWNED BY public.langue.id_langue;


--
-- Name: lecon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecon (
    id_lecon bigint NOT NULL,
    titre character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    resume text,
    id_cours bigint,
    id_section bigint,
    id_type_lecon bigint
);


ALTER TABLE public.lecon OWNER TO postgres;

--
-- Name: lecon_id_lecon_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lecon_id_lecon_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lecon_id_lecon_seq OWNER TO postgres;

--
-- Name: lecon_id_lecon_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lecon_id_lecon_seq OWNED BY public.lecon.id_lecon;


--
-- Name: niveau; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveau (
    id_niveau bigint NOT NULL,
    titre character varying(100) NOT NULL
);


ALTER TABLE public.niveau OWNER TO postgres;

--
-- Name: niveau_id_niveau_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveau_id_niveau_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.niveau_id_niveau_seq OWNER TO postgres;

--
-- Name: niveau_id_niveau_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveau_id_niveau_seq OWNED BY public.niveau.id_niveau;


--
-- Name: resultat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultat (
    id_resultat bigint NOT NULL,
    titre character varying(255) NOT NULL,
    id_cours bigint
);


ALTER TABLE public.resultat OWNER TO postgres;

--
-- Name: resultat_id_resultat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resultat_id_resultat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resultat_id_resultat_seq OWNER TO postgres;

--
-- Name: resultat_id_resultat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resultat_id_resultat_seq OWNED BY public.resultat.id_resultat;


--
-- Name: section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section (
    id_section bigint NOT NULL,
    titre character varying(255) NOT NULL,
    id_cours bigint
);


ALTER TABLE public.section OWNER TO postgres;

--
-- Name: section_id_section_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.section_id_section_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.section_id_section_seq OWNER TO postgres;

--
-- Name: section_id_section_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.section_id_section_seq OWNED BY public.section.id_section;


--
-- Name: tarif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarif (
    id_tarif bigint NOT NULL,
    prix numeric NOT NULL
);


ALTER TABLE public.tarif OWNER TO postgres;

--
-- Name: tarif_id_tarif_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarif_id_tarif_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tarif_id_tarif_seq OWNER TO postgres;

--
-- Name: tarif_id_tarif_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_id_tarif_seq OWNED BY public.tarif.id_tarif;


--
-- Name: type_lecon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_lecon (
    id_type_lecon bigint NOT NULL,
    nom character varying(50) NOT NULL
);


ALTER TABLE public.type_lecon OWNER TO postgres;

--
-- Name: type_lecon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.type_lecon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_lecon_id_seq OWNER TO postgres;

--
-- Name: type_lecon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.type_lecon_id_seq OWNED BY public.type_lecon.id_type_lecon;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    nom character varying(50) NOT NULL,
    prenom character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    telephone character varying(50),
    photo character varying(255),
    sexe character varying(5),
    localisation character varying(255),
    qualification character varying(50),
    numcompte character varying(50),
    cv character varying(255),
    role bigint NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categorie id_categorie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id_categorie SET DEFAULT nextval('public.categorie_id_categorie_seq'::regclass);


--
-- Name: cours id_cours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours ALTER COLUMN id_cours SET DEFAULT nextval('public.cours_id_cours_seq'::regclass);


--
-- Name: exigence id_exigence; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exigence ALTER COLUMN id_exigence SET DEFAULT nextval('public.exigence_id_exigence_seq'::regclass);


--
-- Name: favoris id_favoris; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris ALTER COLUMN id_favoris SET DEFAULT nextval('public.favoris_id_favoris_seq'::regclass);


--
-- Name: langue id_langue; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.langue ALTER COLUMN id_langue SET DEFAULT nextval('public.langue_id_langue_seq'::regclass);


--
-- Name: lecon id_lecon; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon ALTER COLUMN id_lecon SET DEFAULT nextval('public.lecon_id_lecon_seq'::regclass);


--
-- Name: niveau id_niveau; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau ALTER COLUMN id_niveau SET DEFAULT nextval('public.niveau_id_niveau_seq'::regclass);


--
-- Name: resultat id_resultat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat ALTER COLUMN id_resultat SET DEFAULT nextval('public.resultat_id_resultat_seq'::regclass);


--
-- Name: section id_section; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section ALTER COLUMN id_section SET DEFAULT nextval('public.section_id_section_seq'::regclass);


--
-- Name: tarif id_tarif; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif ALTER COLUMN id_tarif SET DEFAULT nextval('public.tarif_id_tarif_seq'::regclass);


--
-- Name: type_lecon id_type_lecon; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_lecon ALTER COLUMN id_type_lecon SET DEFAULT nextval('public.type_lecon_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_categorie);


--
-- Name: cours cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_pkey PRIMARY KEY (id_cours);


--
-- Name: exigence exigence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exigence
    ADD CONSTRAINT exigence_pkey PRIMARY KEY (id_exigence);


--
-- Name: favoris favoris_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_pkey PRIMARY KEY (id_favoris);


--
-- Name: langue langue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.langue
    ADD CONSTRAINT langue_pkey PRIMARY KEY (id_langue);


--
-- Name: lecon lecon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_pkey PRIMARY KEY (id_lecon);


--
-- Name: niveau niveau_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau
    ADD CONSTRAINT niveau_pkey PRIMARY KEY (id_niveau);


--
-- Name: resultat resultat_id_cours_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat
    ADD CONSTRAINT resultat_id_cours_key UNIQUE (id_cours);


--
-- Name: resultat resultat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat
    ADD CONSTRAINT resultat_pkey PRIMARY KEY (id_resultat);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id_section);


--
-- Name: tarif tarif_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif
    ADD CONSTRAINT tarif_pkey PRIMARY KEY (id_tarif);


--
-- Name: type_lecon type_lecon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_lecon
    ADD CONSTRAINT type_lecon_pkey PRIMARY KEY (id_type_lecon);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cours cours_id_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_categorie_fkey FOREIGN KEY (id_categorie) REFERENCES public.categorie(id_categorie);


--
-- Name: cours cours_id_langue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_langue_fkey FOREIGN KEY (id_langue) REFERENCES public.langue(id_langue);


--
-- Name: cours cours_id_niveau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_niveau_fkey FOREIGN KEY (id_niveau) REFERENCES public.niveau(id_niveau);


--
-- Name: cours cours_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id);


--
-- Name: exigence exigence_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exigence
    ADD CONSTRAINT exigence_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours);


--
-- Name: favoris favoris_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours);


--
-- Name: favoris favoris_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id);


--
-- Name: lecon lecon_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours);


--
-- Name: lecon lecon_id_section_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_section_fkey FOREIGN KEY (id_section) REFERENCES public.section(id_section);


--
-- Name: lecon lecon_id_type_lecon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_type_lecon_fkey FOREIGN KEY (id_type_lecon) REFERENCES public.type_lecon(id_type_lecon);


--
-- Name: resultat resultat_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat
    ADD CONSTRAINT resultat_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours);


--
-- Name: section section_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours);


--
-- PostgreSQL database dump complete
--

