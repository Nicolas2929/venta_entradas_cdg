--
-- PostgreSQL database dump
--

-- Dumped from database version 10.16
-- Dumped by pg_dump version 13.2

-- Started on 2022-06-30 23:42:03 -04

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
-- TOC entry 3718 (class 1262 OID 94949)
-- Name: venta_entrada_cdg; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE venta_entrada_cdg WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE venta_entrada_cdg OWNER TO postgres;

\connect venta_entrada_cdg

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 202 (class 1255 OID 95040)
-- Name: desc_tabla(character varying); Type: FUNCTION; Schema: public; Owner: nnieme
--

CREATE FUNCTION public.desc_tabla(_nombre_tabla character varying) RETURNS SETOF character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec RECORD;
    respuesta character varying;
    distancia_permitida character varying;
    s_consulta character varying;
    cant_in integer;
BEGIN
    s_consulta :=format(' SELECT
                array_to_json(array_agg(sq.*))
				FROM (
                    SELECT
                        column_name, data_type
					FROM information_schema.columns
					WHERE  table_name = %L
				) sq
					',_nombre_tabla);
    EXECUTE s_consulta INTO respuesta;
    RETURN NEXT respuesta;
END;
$$;


ALTER FUNCTION public.desc_tabla(_nombre_tabla character varying) OWNER TO nnieme;

SET default_tablespace = '';

--
-- TOC entry 196 (class 1259 OID 94961)
-- Name: evento; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.evento (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    hora time without time zone,
    fecha date,
    descripcion character varying
);


ALTER TABLE public.evento OWNER TO nnieme;

--
-- TOC entry 200 (class 1259 OID 94999)
-- Name: orden_pago; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.orden_pago (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    key_venta character varying,
    metodo character varying,
    monto double precision,
    qr character varying
);


ALTER TABLE public.orden_pago OWNER TO nnieme;

--
-- TOC entry 197 (class 1259 OID 94969)
-- Name: sector; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.sector (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    key_evento character varying NOT NULL,
    nombre character varying,
    precio double precision,
    capacidad integer
);


ALTER TABLE public.sector OWNER TO nnieme;

--
-- TOC entry 198 (class 1259 OID 94983)
-- Name: ticket; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.ticket (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    key_sector character varying,
    key_venta character varying
);


ALTER TABLE public.ticket OWNER TO nnieme;

--
-- TOC entry 201 (class 1259 OID 95007)
-- Name: usuario; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.usuario (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    ci character varying,
    nombre character varying,
    apellido character varying,
    correo character varying,
    telefono character varying,
    password character varying
);


ALTER TABLE public.usuario OWNER TO nnieme;

--
-- TOC entry 199 (class 1259 OID 94991)
-- Name: venta; Type: TABLE; Schema: public; Owner: nnieme
--

CREATE TABLE public.venta (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    codigo character varying,
    key_usuario_cliente character varying,
    nit character varying
);


ALTER TABLE public.venta OWNER TO nnieme;

--
-- TOC entry 3707 (class 0 OID 94961)
-- Dependencies: 196
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: nnieme
--

INSERT INTO public.evento (key, key_usuario, fecha_on, estado, hora, fecha, descripcion) VALUES ('dda2aab1-658e-4942-86ea-029fa9610268', NULL, '2022-06-30 08:31:24.000778', 1, '17:00:00', '2022-10-07', 'Partido inportante entre dos equipos');


--
-- TOC entry 3711 (class 0 OID 94999)
-- Dependencies: 200
-- Data for Name: orden_pago; Type: TABLE DATA; Schema: public; Owner: nnieme
--



--
-- TOC entry 3708 (class 0 OID 94969)
-- Dependencies: 197
-- Data for Name: sector; Type: TABLE DATA; Schema: public; Owner: nnieme
--

INSERT INTO public.sector (key, key_usuario, fecha_on, estado, key_evento, nombre, precio, capacidad) VALUES ('c499936f-0309-416a-aa01-0d40dfa62260', NULL, '2022-06-30 08:36:56.000375', 1, 'dda2aab1-658e-4942-86ea-029fa9610268', 'General', 59.990000000000002, 1000);


--
-- TOC entry 3709 (class 0 OID 94983)
-- Dependencies: 198
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: nnieme
--



--
-- TOC entry 3712 (class 0 OID 95007)
-- Dependencies: 201
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: nnieme
--

INSERT INTO public.usuario (key, key_usuario, fecha_on, estado, ci, nombre, apellido, correo, telefono, password) VALUES ('a2326b91-c711-438a-8190-0004e5320802', NULL, '2022-06-30 08:23:17.000973', 1, '123', '123', '123', '123', '123', '123');
INSERT INTO public.usuario (key, key_usuario, fecha_on, estado, ci, nombre, apellido, correo, telefono, password) VALUES ('001c8f63-f5b2-428e-9b19-8643e7e6f42c', NULL, '2022-06-30 08:23:41.000637', 1, 'testEdi', 'testEdi', 'testEdi', 'testEdi', 'testEdi', 'testEdi');


--
-- TOC entry 3710 (class 0 OID 94991)
-- Dependencies: 199
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: nnieme
--

INSERT INTO public.venta (key, key_usuario, fecha_on, estado, codigo, key_usuario_cliente, nit) VALUES ('da9bdd71-3140-4922-915f-fb10a1c73a4c', NULL, '2022-06-30 09:19:27.000135', 1, NULL, NULL, NULL);


--
-- TOC entry 3565 (class 2606 OID 94968)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (key);


--
-- TOC entry 3578 (class 2606 OID 95006)
-- Name: orden_pago orden_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.orden_pago
    ADD CONSTRAINT orden_pago_pkey PRIMARY KEY (key);


--
-- TOC entry 3568 (class 2606 OID 94976)
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (key);


--
-- TOC entry 3572 (class 2606 OID 94990)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (key);


--
-- TOC entry 3580 (class 2606 OID 95014)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (key);


--
-- TOC entry 3575 (class 2606 OID 94998)
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (key);


--
-- TOC entry 3566 (class 1259 OID 94982)
-- Name: fki_fk_key_evento_sector; Type: INDEX; Schema: public; Owner: nnieme
--

CREATE INDEX fki_fk_key_evento_sector ON public.sector USING btree (key_evento);


--
-- TOC entry 3569 (class 1259 OID 95032)
-- Name: fki_fk_key_sector_ticket; Type: INDEX; Schema: public; Owner: nnieme
--

CREATE INDEX fki_fk_key_sector_ticket ON public.ticket USING btree (key_sector);


--
-- TOC entry 3573 (class 1259 OID 95020)
-- Name: fki_fk_key_usuario_cliente_venta; Type: INDEX; Schema: public; Owner: nnieme
--

CREATE INDEX fki_fk_key_usuario_cliente_venta ON public.venta USING btree (key_usuario_cliente);


--
-- TOC entry 3576 (class 1259 OID 95038)
-- Name: fki_fk_key_venta_orden_pago; Type: INDEX; Schema: public; Owner: nnieme
--

CREATE INDEX fki_fk_key_venta_orden_pago ON public.orden_pago USING btree (key_venta);


--
-- TOC entry 3570 (class 1259 OID 95026)
-- Name: fki_fk_key_venta_ticket; Type: INDEX; Schema: public; Owner: nnieme
--

CREATE INDEX fki_fk_key_venta_ticket ON public.ticket USING btree (key_venta);


--
-- TOC entry 3581 (class 2606 OID 94977)
-- Name: sector fk_key_evento_sector; Type: FK CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT fk_key_evento_sector FOREIGN KEY (key_evento) REFERENCES public.evento(key) NOT VALID;


--
-- TOC entry 3583 (class 2606 OID 95027)
-- Name: ticket fk_key_sector_ticket; Type: FK CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_key_sector_ticket FOREIGN KEY (key_sector) REFERENCES public.sector(key) NOT VALID;


--
-- TOC entry 3584 (class 2606 OID 95015)
-- Name: venta fk_key_usuario_cliente_venta; Type: FK CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_key_usuario_cliente_venta FOREIGN KEY (key_usuario_cliente) REFERENCES public.usuario(key) NOT VALID;


--
-- TOC entry 3585 (class 2606 OID 95033)
-- Name: orden_pago fk_key_venta_orden_pago; Type: FK CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.orden_pago
    ADD CONSTRAINT fk_key_venta_orden_pago FOREIGN KEY (key_venta) REFERENCES public.venta(key) NOT VALID;


--
-- TOC entry 3582 (class 2606 OID 95021)
-- Name: ticket fk_key_venta_ticket; Type: FK CONSTRAINT; Schema: public; Owner: nnieme
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_key_venta_ticket FOREIGN KEY (key_venta) REFERENCES public.venta(key) NOT VALID;


-- Completed on 2022-06-30 23:42:04 -04

--
-- PostgreSQL database dump complete
--

