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
-- Name: commentaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commentaire (
    id_commentaire bigint NOT NULL,
    intitule text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    lecon_id bigint,
    users_id bigint
);


ALTER TABLE public.commentaire OWNER TO postgres;

--
-- Name: commentaire_id_commentaire_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commentaire_id_commentaire_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commentaire_id_commentaire_seq OWNER TO postgres;

--
-- Name: commentaire_id_commentaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commentaire_id_commentaire_seq OWNED BY public.commentaire.id_commentaire;


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
    prix numeric,
    id_categorie bigint,
    id_langue bigint,
    id_niveau bigint,
    id_users bigint
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
-- Name: cours_suivis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cours_suivis (
    id_cours_suivis bigint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    users_id bigint,
    cours_id bigint
);


ALTER TABLE public.cours_suivis OWNER TO postgres;

--
-- Name: cours_suivis_id_cours_suivis_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cours_suivis_id_cours_suivis_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cours_suivis_id_cours_suivis_seq OWNER TO postgres;

--
-- Name: cours_suivis_id_cours_suivis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cours_suivis_id_cours_suivis_seq OWNED BY public.cours_suivis.id_cours_suivis;


--
-- Name: exigence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exigence (
    id_exigence bigint NOT NULL,
    nom character varying(255) NOT NULL,
    id_cours bigint
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
    id_type_lecon bigint,
    id_section bigint,
    id_cours bigint
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
-- Name: lecon_suivi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecon_suivi (
    id_lecon_suivi bigint NOT NULL,
    users_id bigint,
    lecon_id bigint
);


ALTER TABLE public.lecon_suivi OWNER TO postgres;

--
-- Name: lecon_suivi_id_lecon_suivi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lecon_suivi_id_lecon_suivi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lecon_suivi_id_lecon_suivi_seq OWNER TO postgres;

--
-- Name: lecon_suivi_id_lecon_suivi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lecon_suivi_id_lecon_suivi_seq OWNED BY public.lecon_suivi.id_lecon_suivi;


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
-- Name: notation_cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notation_cours (
    id_notation_cours bigint NOT NULL,
    note numeric NOT NULL,
    testimonial text NOT NULL,
    id_users bigint,
    id_cours bigint
);


ALTER TABLE public.notation_cours OWNER TO postgres;

--
-- Name: notation_cours_id_notation_cours_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notation_cours_id_notation_cours_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notation_cours_id_notation_cours_seq OWNER TO postgres;

--
-- Name: notation_cours_id_notation_cours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notation_cours_id_notation_cours_seq OWNED BY public.notation_cours.id_notation_cours;


--
-- Name: reponse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reponse (
    id_reponse bigint NOT NULL,
    intitule_reponse text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    commentaire_id bigint,
    users_id bigint
);


ALTER TABLE public.reponse OWNER TO postgres;

--
-- Name: reponse_id_reponse_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reponse_id_reponse_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reponse_id_reponse_seq OWNER TO postgres;

--
-- Name: reponse_id_reponse_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reponse_id_reponse_seq OWNED BY public.reponse.id_reponse;


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
    id bigint NOT NULL,
    verify_code character varying(225),
    role character varying(50) DEFAULT 1,
    statut_users bigint DEFAULT 0,
    id_users bigint
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
-- Name: commentaire id_commentaire; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire ALTER COLUMN id_commentaire SET DEFAULT nextval('public.commentaire_id_commentaire_seq'::regclass);


--
-- Name: cours id_cours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours ALTER COLUMN id_cours SET DEFAULT nextval('public.cours_id_cours_seq'::regclass);


--
-- Name: cours_suivis id_cours_suivis; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours_suivis ALTER COLUMN id_cours_suivis SET DEFAULT nextval('public.cours_suivis_id_cours_suivis_seq'::regclass);


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
-- Name: lecon_suivi id_lecon_suivi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon_suivi ALTER COLUMN id_lecon_suivi SET DEFAULT nextval('public.lecon_suivi_id_lecon_suivi_seq'::regclass);


--
-- Name: niveau id_niveau; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau ALTER COLUMN id_niveau SET DEFAULT nextval('public.niveau_id_niveau_seq'::regclass);


--
-- Name: notation_cours id_notation_cours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notation_cours ALTER COLUMN id_notation_cours SET DEFAULT nextval('public.notation_cours_id_notation_cours_seq'::regclass);


--
-- Name: reponse id_reponse; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponse ALTER COLUMN id_reponse SET DEFAULT nextval('public.reponse_id_reponse_seq'::regclass);


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
-- Name: commentaire commentaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_pkey PRIMARY KEY (id_commentaire);


--
-- Name: cours cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_pkey PRIMARY KEY (id_cours);


--
-- Name: cours_suivis cours_suivis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours_suivis
    ADD CONSTRAINT cours_suivis_pkey PRIMARY KEY (id_cours_suivis);


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
-- Name: lecon_suivi lecon_suivi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon_suivi
    ADD CONSTRAINT lecon_suivi_pkey PRIMARY KEY (id_lecon_suivi);


--
-- Name: niveau niveau_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveau
    ADD CONSTRAINT niveau_pkey PRIMARY KEY (id_niveau);


--
-- Name: notation_cours notation_cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notation_cours
    ADD CONSTRAINT notation_cours_pkey PRIMARY KEY (id_notation_cours);


--
-- Name: reponse reponse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponse
    ADD CONSTRAINT reponse_pkey PRIMARY KEY (id_reponse);


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
-- Name: commentaire commentaire_lecon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_lecon_id_fkey FOREIGN KEY (lecon_id) REFERENCES public.lecon(id_lecon) ON DELETE CASCADE;


--
-- Name: commentaire commentaire_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cours cours_id_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_categorie_fkey FOREIGN KEY (id_categorie) REFERENCES public.categorie(id_categorie) ON DELETE CASCADE;


--
-- Name: cours cours_id_langue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_langue_fkey FOREIGN KEY (id_langue) REFERENCES public.langue(id_langue) ON DELETE CASCADE;


--
-- Name: cours cours_id_niveau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_niveau_fkey FOREIGN KEY (id_niveau) REFERENCES public.niveau(id_niveau) ON DELETE CASCADE;


--
-- Name: cours cours_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours
    ADD CONSTRAINT cours_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cours_suivis cours_suivis_cours_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours_suivis
    ADD CONSTRAINT cours_suivis_cours_id_fkey FOREIGN KEY (cours_id) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: cours_suivis cours_suivis_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cours_suivis
    ADD CONSTRAINT cours_suivis_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: exigence exigence_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exigence
    ADD CONSTRAINT exigence_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: favoris favoris_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: favoris favoris_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: lecon lecon_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: lecon lecon_id_section_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_section_fkey FOREIGN KEY (id_section) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: lecon lecon_id_type_lecon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon
    ADD CONSTRAINT lecon_id_type_lecon_fkey FOREIGN KEY (id_type_lecon) REFERENCES public.type_lecon(id_type_lecon);


--
-- Name: lecon_suivi lecon_suivi_lecon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon_suivi
    ADD CONSTRAINT lecon_suivi_lecon_id_fkey FOREIGN KEY (lecon_id) REFERENCES public.lecon(id_lecon) ON DELETE CASCADE;


--
-- Name: lecon_suivi lecon_suivi_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecon_suivi
    ADD CONSTRAINT lecon_suivi_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notation_cours notation_cours_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notation_cours
    ADD CONSTRAINT notation_cours_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: notation_cours notation_cours_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notation_cours
    ADD CONSTRAINT notation_cours_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reponse reponse_commentaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponse
    ADD CONSTRAINT reponse_commentaire_id_fkey FOREIGN KEY (commentaire_id) REFERENCES public.commentaire(id_commentaire) ON DELETE CASCADE;


--
-- Name: reponse reponse_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponse
    ADD CONSTRAINT reponse_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: resultat resultat_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat
    ADD CONSTRAINT resultat_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: section section_id_cours_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_cours_fkey FOREIGN KEY (id_cours) REFERENCES public.cours(id_cours) ON DELETE CASCADE;


--
-- Name: users users_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

