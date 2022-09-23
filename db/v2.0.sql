--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7 (Debian 13.7-1.pgdg110+1)
-- Dumped by pg_dump version 13.2

-- Started on 2022-09-23 01:31:04 -04

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
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 210 (class 1255 OID 16385)
-- Name: desc_tabla(character varying); Type: FUNCTION; Schema: public; Owner: postgres
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


ALTER FUNCTION public.desc_tabla(_nombre_tabla character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 200 (class 1259 OID 16386)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16392)
-- Name: orden_pago; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.orden_pago OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16398)
-- Name: sector; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.sector OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16404)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    key_sector character varying,
    key_venta character varying,
    descripcion character varying
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16410)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
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
    password character varying,
    admin boolean DEFAULT false
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16416)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    key character varying NOT NULL,
    key_usuario character varying,
    fecha_on timestamp without time zone,
    estado integer,
    codigo character varying,
    nit character varying,
    razon_social character varying
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24698)
-- Name: ventas_por_clientes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ventas_por_clientes AS
 SELECT venta.fecha_on,
    ticket.key,
    ticket.descripcion,
    sector.precio,
    evento.descripcion AS descripcion_evento
   FROM public.venta,
    public.ticket,
    public.sector,
    public.evento
  WHERE (((venta.key)::text = (ticket.key_venta)::text) AND (venta.estado > 1) AND ((ticket.key_sector)::text = (sector.key)::text) AND ((evento.key)::text = (sector.key_evento)::text));


ALTER TABLE public.ventas_por_clientes OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 41082)
-- Name: ventas_por_sector; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ventas_por_sector AS
SELECT
    NULL::character varying AS key,
    NULL::character varying AS nombre_evento,
    NULL::character varying AS nombre_sector,
    NULL::double precision AS precio,
    NULL::integer AS capacidad,
    NULL::double precision AS total_pagado,
    NULL::bigint AS cantidad_entradas;


ALTER TABLE public.ventas_por_sector OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 41092)
-- Name: view_sector; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_sector AS
SELECT
    NULL::character varying AS key,
    NULL::character varying AS key_usuario,
    NULL::timestamp without time zone AS fecha_on,
    NULL::integer AS estado,
    NULL::character varying AS key_evento,
    NULL::character varying AS nombre,
    NULL::double precision AS precio,
    NULL::integer AS capacidad,
    NULL::bigint AS vendidas;


ALTER TABLE public.view_sector OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16553)
-- Name: view_venta_detalle; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_venta_detalle AS
SELECT
    NULL::character varying AS key,
    NULL::character varying AS key_usuario,
    NULL::timestamp without time zone AS fecha_on,
    NULL::integer AS estado,
    NULL::character varying AS codigo,
    NULL::character varying AS nit,
    NULL::character varying AS razon_social,
    NULL::double precision AS total,
    NULL::bigint AS cantidad,
    NULL::json AS detalle;


ALTER TABLE public.view_venta_detalle OWNER TO postgres;

--
-- TOC entry 3051 (class 0 OID 16386)
-- Dependencies: 200
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.evento VALUES ('85dbfa2a-1efa-475e-b738-75c7559f65b3', NULL, '2022-07-18 18:32:24.00016', 0, '16:00:00', '2022-10-07', 'Partido inportante entre dos equipos');
INSERT INTO public.evento VALUES ('a2e13f89-4dcd-439c-92fa-8d741b236767', NULL, '2022-07-19 02:43:48.000004', 0, '04:00:00', '2022-07-19', 'asdasd');
INSERT INTO public.evento VALUES ('dda2aab1-658e-4942-86ea-029fa9610268', NULL, '2022-06-30 08:31:24.000778', 0, '17:00:00', '2022-10-07', 'Algo sadasd');
INSERT INTO public.evento VALUES ('5b919f36-f8e9-4d61-aed1-545e4fc67f4b', NULL, '2022-07-19 03:24:46.000897', 0, '12:00:00', '2022-12-05', 'partido ');
INSERT INTO public.evento VALUES ('eb5a1fea-e1f7-4a55-a96a-1c5eacba4a20', NULL, '2022-08-16 02:17:00.00008', 0, '12:30:00', '2022-12-11', 'Guabira vs blooming');
INSERT INTO public.evento VALUES ('f812798b-d8a0-436d-87d7-231bc284e71e', NULL, '2022-07-13 20:57:00.000005', 0, '16:00:00', '2022-10-07', 'Guabira Vs Oriente');
INSERT INTO public.evento VALUES ('6616ba10-000e-4c25-bcb2-7f0002c8f82a', NULL, '2022-07-21 04:12:21.000017', 0, '15:00:00', '2022-08-05', 'Juan Pablo vs Rene Moreno');
INSERT INTO public.evento VALUES ('c14e73a8-91cf-4ede-a017-f7e2aef8e549', NULL, '2022-07-19 04:44:17.000064', 0, '12:35:00', '2022-07-05', 'guabira vs blooming');
INSERT INTO public.evento VALUES ('70d7c15b-9c14-4049-a48a-8847b1090a7d', NULL, '2022-07-19 04:40:18.00097', 0, '12:30:00', '2022-07-04', 'guabira vs bolivar');
INSERT INTO public.evento VALUES ('8129ddc1-7434-472f-9717-8c5aef54c22a', NULL, '2022-07-21 03:59:53.000871', 0, '15:00:00', '2022-09-15', 'Guabira vs Bolivar');
INSERT INTO public.evento VALUES ('14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', NULL, '2022-08-18 00:31:55.000329', 0, '12:35:00', '2022-12-10', 'Guabira vs Blooming');
INSERT INTO public.evento VALUES ('e631e4ca-c88f-4fbf-a6cc-df6a71d34436', NULL, '2022-08-23 00:55:34.0007', 0, '12:30:00', '2022-12-11', 'Guabira vs Bolivar');
INSERT INTO public.evento VALUES ('4532d380-f6ad-4d4d-a546-99914c2a8744', NULL, '2022-08-23 01:00:34.000444', 1, '12:30:00', '2022-12-11', 'Guabira vs Bolivar');
INSERT INTO public.evento VALUES ('ac0f77dc-b3a0-43de-9c3f-aaea0e3fc2cf', NULL, '2022-08-23 03:59:44.000746', 0, '12:30:00', '2022-12-12', 'Guabira vs Real santa cruz');
INSERT INTO public.evento VALUES ('4d54ccb5-4f60-47f8-9167-3a21a3660836', NULL, '2022-07-27 03:27:04.000112', 1, '12:00:00', '2022-10-30', 'Guabira vs Oriente P.');
INSERT INTO public.evento VALUES ('dca1d048-75ca-42e4-a1e7-4a6f877e66e1', NULL, '2022-08-23 01:04:57.000923', 0, '12:35:00', '2022-12-13', 'Guabira vs Blooming');
INSERT INTO public.evento VALUES ('d3d7abfd-b6b7-494c-8584-c62868ea3f30', NULL, '2022-09-22 23:32:28.000838', 1, '12:30:00', '2022-11-04', 'Guabira vs Blooming');


--
-- TOC entry 3052 (class 0 OID 16392)
-- Dependencies: 201
-- Data for Name: orden_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3053 (class 0 OID 16398)
-- Dependencies: 202
-- Data for Name: sector; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sector VALUES ('fd650fc2-36d0-4a3d-8a93-0342362590f1', NULL, '2022-07-13 20:57:03.000763', 1, 'dda2aab1-658e-4942-86ea-029fa9610268', 'General', 49.99, 100);
INSERT INTO public.sector VALUES ('9db59ddc-aa81-48d9-9668-94d8ab6510f0', NULL, '2022-07-18 18:32:41.000648', 1, 'dda2aab1-658e-4942-86ea-029fa9610268', 'General', 49.99, 100);
INSERT INTO public.sector VALUES ('526c57f9-5205-4923-b914-9bc385cf4a6b', NULL, '2022-07-19 03:18:58.000787', 1, '85dbfa2a-1efa-475e-b738-75c7559f65b3', 'General', 20, 10);
INSERT INTO public.sector VALUES ('3e3b2413-7d43-4eb5-8250-2d85bd50aa26', NULL, '2022-07-19 03:19:22.000877', 1, 'a2e13f89-4dcd-439c-92fa-8d741b236767', 'Preferencia', 50, 100);
INSERT INTO public.sector VALUES ('500db62e-0a0b-4467-9e04-3071b06e5464', NULL, '2022-07-19 03:19:30.00067', 1, 'a2e13f89-4dcd-439c-92fa-8d741b236767', 'General', 30, 100);
INSERT INTO public.sector VALUES ('463ea920-9f3b-40bc-8ceb-1f4aff43da80', NULL, '2022-07-27 03:27:33.000147', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'PREFERENCIA MENOR', 30, 50);
INSERT INTO public.sector VALUES ('b0fad61e-87be-4f91-bac5-e90efb8eb9a1', NULL, '2022-07-05 07:55:54.000699', 1, 'dda2aab1-658e-4942-86ea-029fa9610268', 'General', 49.99, 100);
INSERT INTO public.sector VALUES ('c499936f-0309-416a-aa01-0d40dfa62260', NULL, '2022-06-30 08:36:56.000375', 1, 'dda2aab1-658e-4942-86ea-029fa9610268', 'General', 59.99, 100);
INSERT INTO public.sector VALUES ('14dc0fc5-26a0-461e-aff8-dd341c03ef1f', NULL, '2022-08-23 01:01:36.000413', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'PREFERENCIA MENOR', 30, 50);
INSERT INTO public.sector VALUES ('a34fa73c-ae9e-469a-9f71-0f5500844dad', NULL, '2022-08-18 00:29:46.000475', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'PALCO', 120, 100);
INSERT INTO public.sector VALUES ('9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', NULL, '2022-08-18 00:30:12.000606', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'BUTACA', 90, 50);
INSERT INTO public.sector VALUES ('24fe9b5e-027b-45a4-9526-a9ae4425a956', NULL, '2022-07-20 19:02:51.000013', 1, '70d7c15b-9c14-4049-a48a-8847b1090a7d', 'general', 50, 80);
INSERT INTO public.sector VALUES ('f9eb99c4-e995-444a-8b83-f5b331a4a374', NULL, '2022-07-20 19:02:20.000104', 1, '70d7c15b-9c14-4049-a48a-8847b1090a7d', 'preferencia ', 20, 100);
INSERT INTO public.sector VALUES ('6def7fce-6271-4b67-b18d-8da28090fda1', NULL, '2022-08-23 01:05:26.000219', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'BUTACA', 90, 100);
INSERT INTO public.sector VALUES ('4eb98ff8-c203-4e44-b90a-f4aa9d251e13', NULL, '2022-07-20 19:11:14.0004', 1, 'f812798b-d8a0-436d-87d7-231bc284e71e', 'General', 50, 500);
INSERT INTO public.sector VALUES ('9f483b08-6e48-4fab-9805-60d12d03ad7b', NULL, '2022-07-20 19:11:43.000009', 1, 'c14e73a8-91cf-4ede-a017-f7e2aef8e549', 'general', 85, 200);
INSERT INTO public.sector VALUES ('f98bc6a8-16b9-41bd-96ec-93b6719a8e62', NULL, '2022-07-21 04:16:08.000599', 1, '6616ba10-000e-4c25-bcb2-7f0002c8f82a', 'general', 100, 100);
INSERT INTO public.sector VALUES ('51ff5e81-5389-4f2a-a976-5e8ed7656f1d', NULL, '2022-07-21 04:23:40.00071', 1, '6616ba10-000e-4c25-bcb2-7f0002c8f82a', 'Curva', 10, 100);
INSERT INTO public.sector VALUES ('8de9ecbd-9383-4166-97b9-8c8a1e7834f5', NULL, '2022-08-16 02:17:43.000521', 1, 'eb5a1fea-e1f7-4a55-a96a-1c5eacba4a20', 'curva', 10, 200);
INSERT INTO public.sector VALUES ('93e96c87-20fe-47ed-94fd-a25736798f0b', NULL, '2022-08-16 02:18:19.000371', 1, 'eb5a1fea-e1f7-4a55-a96a-1c5eacba4a20', 'preferencia ', 50, 100);
INSERT INTO public.sector VALUES ('06168446-dd92-4814-978a-1cf3487034ce', NULL, '2022-08-16 02:18:33.000465', 1, 'eb5a1fea-e1f7-4a55-a96a-1c5eacba4a20', 'general ', 30, 50);
INSERT INTO public.sector VALUES ('5ef2b787-3610-485f-b7f4-26f91197fc23', NULL, '2022-08-18 00:22:13.00012', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'PREFERENCIA MAYOR.', 100, 200);
INSERT INTO public.sector VALUES ('f919f085-a23e-4ec6-acb9-5776b0eb8de4', NULL, '2022-08-18 00:22:53.000286', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'PREFERENCIA MENOR.', 50, 200);
INSERT INTO public.sector VALUES ('4aa5bd0f-4378-47e4-843d-94dd1553866d', NULL, '2022-08-18 00:23:08.000627', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'GENERAL MAYOR', 40, 100);
INSERT INTO public.sector VALUES ('1920edd1-062b-4759-a663-52acaffcc0bb', NULL, '2022-08-18 00:23:21.000748', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'GENERAL MENOR.', 20, 100);
INSERT INTO public.sector VALUES ('c7b35529-8dc1-44ff-9a72-8a700f755b2d', NULL, '2022-08-18 00:23:45.000876', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'CURVA MAYOR.', 10, 100);
INSERT INTO public.sector VALUES ('f367d0b3-4b9a-4070-bbb4-afd887327de3', NULL, '2022-08-18 00:24:02.000091', 1, '8129ddc1-7434-472f-9717-8c5aef54c22a', 'CURVA MENOR.', 20, 100);
INSERT INTO public.sector VALUES ('e3b6151f-5ffd-45f2-ae42-3beb18e39b09', NULL, '2022-08-23 01:00:58.000325', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'PALCO', 120, 200);
INSERT INTO public.sector VALUES ('3c9e0acb-075f-480a-9553-4572412fc116', NULL, '2022-08-23 01:01:16.000579', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'BUTACA', 90, 100);
INSERT INTO public.sector VALUES ('edb7d837-29a5-481d-97ca-d3d06b291a5b', NULL, '2022-08-18 00:32:09.000191', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'PREFERENCIA MAYOR', 100, 50);
INSERT INTO public.sector VALUES ('79edbf71-a62a-405f-8f84-e83fb9d3430d', NULL, '2022-08-18 00:32:17.000876', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'PREFERENCIA MENOR', 50, 200);
INSERT INTO public.sector VALUES ('d24b8ec8-7879-4735-b139-984d1d66366c', NULL, '2022-08-18 00:32:32.000948', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'GENERAL MAYOR', 30, 100);
INSERT INTO public.sector VALUES ('317dc491-ddec-4acc-afd0-9e8c46fd4d8a', NULL, '2022-08-18 00:32:46.000876', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'GENERAL MENOR.', 30, 80);
INSERT INTO public.sector VALUES ('914fe453-8165-4b36-99f1-54f445d8118a', NULL, '2022-08-18 00:32:59.000517', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'CURVA MAYOR.', 20, 50);
INSERT INTO public.sector VALUES ('8810fd98-097f-4ba4-86b9-4a2e2ff23d1e', NULL, '2022-08-18 00:33:09.000715', 1, '14cf0e2f-ac7b-4efc-b30b-07d9cf82a62a', 'CURVA MENOR.', 20, 80);
INSERT INTO public.sector VALUES ('ed59943d-6847-4fb0-ab55-01f84165e010', NULL, '2022-08-18 00:28:33.000085', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'GENERAL Y CURVA', 30, 200);
INSERT INTO public.sector VALUES ('fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', NULL, '2022-07-27 03:27:22.000114', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'PREFERENCIA ', 60, 100);
INSERT INTO public.sector VALUES ('61177ff0-2afc-4337-892b-7de765b2e9e7', NULL, '2022-08-23 00:55:50.000436', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'PALCO', 120, 200);
INSERT INTO public.sector VALUES ('5d6b5d3b-c37a-44af-9c3c-e23da4a305fd', NULL, '2022-08-23 00:56:11.000155', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'BUTACA', 90, 100);
INSERT INTO public.sector VALUES ('26856220-aec9-4fe7-b113-a568584b7dbe', NULL, '2022-08-23 00:56:24.000019', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'PREFERENCIA ', 60, 100);
INSERT INTO public.sector VALUES ('4113ee91-1e7f-4592-9107-803a42ec89e0', NULL, '2022-08-23 00:56:36.000228', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'PREFERENCIA MENOR', 30, 200);
INSERT INTO public.sector VALUES ('c6570e66-2f9d-4ce2-8de5-d2f307f15af6', NULL, '2022-08-23 01:01:27.000243', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'PREFERENCIA ', 60, 200);
INSERT INTO public.sector VALUES ('f67e1e04-c964-4394-9d51-5a3e06db938f', NULL, '2022-08-23 00:57:52.000772', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'GENERAL Y CURVA', 30, 100);
INSERT INTO public.sector VALUES ('54127830-8c7e-462a-a17e-d32497f54781', NULL, '2022-08-23 00:57:00.000525', 1, 'e631e4ca-c88f-4fbf-a6cc-df6a71d34436', 'GENERAL Y CURVA MENOR', 30, 100);
INSERT INTO public.sector VALUES ('5cd82215-cf5a-4163-a611-68ae520168cf', NULL, '2022-08-23 01:05:12.000973', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'PALCO', 120, 100);
INSERT INTO public.sector VALUES ('ca4ec6fb-0e81-4f64-9c28-79b4cef3e08f', NULL, '2022-08-23 01:02:18.000765', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'GENERAL Y  CURVA MENOR', 30, 100);
INSERT INTO public.sector VALUES ('ecb4ab80-4d81-4d49-84fb-57d581146188', NULL, '2022-08-23 01:06:11.000378', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'PREFERENCIA MENOR', 30, 200);
INSERT INTO public.sector VALUES ('80e61799-c925-4a08-82d9-2a0440c769ec', NULL, '2022-08-23 01:06:34.000971', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'GENERAL Y CURVA MENOR', 30, 100);
INSERT INTO public.sector VALUES ('fc2a8a97-a6cb-408a-8f27-470a8e4a3a1f', NULL, '2022-08-23 01:01:59.000818', 1, '4532d380-f6ad-4d4d-a546-99914c2a8744', 'GENEREAL Y CURVA ', 30, 50);
INSERT INTO public.sector VALUES ('7539b680-8ec9-4c16-852b-fbcdb8b2737f', NULL, '2022-08-23 01:06:59.000531', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'GENERAL Y CURVA', 30, 100);
INSERT INTO public.sector VALUES ('c91b8a2b-6c6b-441f-af5f-3de50d3a948d', NULL, '2022-08-23 03:59:59.000894', 1, 'ac0f77dc-b3a0-43de-9c3f-aaea0e3fc2cf', 'PALCO', 120, 200);
INSERT INTO public.sector VALUES ('66501823-c874-4806-8101-0911137e8c37', NULL, '2022-08-23 04:01:05.000197', 1, 'ac0f77dc-b3a0-43de-9c3f-aaea0e3fc2cf', 'BUTACA', 90, 100);
INSERT INTO public.sector VALUES ('cc0d71df-6081-4d18-af84-7f2dba4c05c1', NULL, '2022-08-23 01:05:49.000084', 1, 'dca1d048-75ca-42e4-a1e7-4a6f877e66e1', 'PREFERENCIA ', 60, 10);
INSERT INTO public.sector VALUES ('ecc91506-6b7a-4094-98cb-ebdac32b71b2', NULL, '2022-08-18 00:29:21.000132', 1, '4d54ccb5-4f60-47f8-9167-3a21a3660836', 'GENERAL Y CURVA MENOR', 30, 200);
INSERT INTO public.sector VALUES ('f5b7353b-6f3f-4379-a978-1554a5a79c04', NULL, '2022-09-22 23:33:06.00037', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'PALCO', 120, 10);
INSERT INTO public.sector VALUES ('400a12e7-b418-4bcf-8785-bd8aa25a8517', NULL, '2022-09-22 23:33:19.000856', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'BUTACA', 90, 10);
INSERT INTO public.sector VALUES ('e8326386-8d8d-43e8-89c4-9060cc36570c', NULL, '2022-09-22 23:33:36.000079', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'PREFERENCIA ', 60, 10);
INSERT INTO public.sector VALUES ('fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', NULL, '2022-09-22 23:33:51.00008', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'GENEREAL Y CURVA MENOR', 30, 10);
INSERT INTO public.sector VALUES ('a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', NULL, '2022-09-22 23:34:24.000113', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'GENEREAL Y CURVA ', 30, 10);
INSERT INTO public.sector VALUES ('d7438f56-ece4-4f22-81cd-415d09e94dfe', NULL, '2022-09-22 23:34:52.000036', 1, 'd3d7abfd-b6b7-494c-8584-c62868ea3f30', 'PREFERENCIA MENOR', 30, 10);


--
-- TOC entry 3054 (class 0 OID 16404)
-- Dependencies: 203
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ticket VALUES ('2156818d-cddb-47e3-8159-9d2baaaa6014', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-16 04:10:08.000484', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '286cdf1b-a2ee-4bf4-89c4-8451d1fb1663', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('8821bc12-0dc9-494a-8b4b-d7e0f781d579', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-16 04:25:08.000051', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '06027f97-b9e9-46da-bb6a-3822468a516f', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('856d4d00-8806-4508-866f-f5f067e9b2b3', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-16 04:25:08.000058', 1, '4eb98ff8-c203-4e44-b90a-f4aa9d251e13', '06027f97-b9e9-46da-bb6a-3822468a516f', 'Entradas para Guabira Vs Oriente en el sector General');
INSERT INTO public.ticket VALUES ('0d5e92ec-8907-4888-9528-a6761f7fc3e6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 04:35:29.000018', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'd0c2748a-7ebe-4715-abbf-2d19f5d4b82b', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('5f3e4745-4a22-4ef3-baf7-74fc560515ed', '8ffbfddc-6f1c-4500-92bb-a7abc2de7b63', '2022-08-16 05:51:56.000718', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'ebe03c6c-226d-407c-95a4-7e64295b8ce6', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('91d3ff1e-d4cb-4135-9fad-b77856449e95', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:01:37.000421', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '5ca1bd83-3d7f-406d-a435-1ece0602ebb5', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('53753622-bd7e-4eed-9b1f-7394902d0537', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:01:37.000428', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5ca1bd83-3d7f-406d-a435-1ece0602ebb5', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('bd69c5b1-1c86-4b3f-9642-c17b0d60633b', '8ffbfddc-6f1c-4500-92bb-a7abc2de7b63', '2022-08-16 06:03:55.000915', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'd0571b02-ece2-4394-9c4c-3052d1617e73', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('06597093-485a-4a14-811e-018bc97cf32a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:04:25.000028', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '8c1abfa3-a863-4424-a013-de3b4c1adccf', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('00523afd-9beb-4ad3-ae2f-0d2375ed241a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:10.000835', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'c8ba33ae-52f2-4f23-bcfb-0ecf13c9c105', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('2355ab29-2d82-4852-8181-f71538daa564', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:10.000843', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'c8ba33ae-52f2-4f23-bcfb-0ecf13c9c105', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('5dd632d7-ecb1-4f77-aff7-46f58f5afc79', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:37.000898', 1, '8de9ecbd-9383-4166-97b9-8c8a1e7834f5', '4321574e-c172-405d-9fde-c4b83915954b', 'Entradas para Guabira vs blooming en el sector curva');
INSERT INTO public.ticket VALUES ('23ef1fd4-61e5-4e6a-8956-4d88701c28ca', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:37.000904', 1, '93e96c87-20fe-47ed-94fd-a25736798f0b', '4321574e-c172-405d-9fde-c4b83915954b', 'Entradas para Guabira vs blooming en el sector preferencia ');
INSERT INTO public.ticket VALUES ('3d81b1ea-414b-4996-b5f5-de7d8063fd9f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:15.000358', 1, '06168446-dd92-4814-978a-1cf3487034ce', '46e29179-3861-4d95-b551-a4bf1030b3fc', 'Entradas para Guabira vs blooming en el sector general ');
INSERT INTO public.ticket VALUES ('1653e5d9-3627-4975-ae68-1a23214c064e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:15.000362', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '46e29179-3861-4d95-b551-a4bf1030b3fc', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('09d701d9-b461-4de5-9fd3-ce1825338c79', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:15.000368', 1, '93e96c87-20fe-47ed-94fd-a25736798f0b', '46e29179-3861-4d95-b551-a4bf1030b3fc', 'Entradas para Guabira vs blooming en el sector preferencia ');
INSERT INTO public.ticket VALUES ('2124c148-0dda-43e4-a7ee-e74eeaedf9c0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:36.00099', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '6ae39af9-0e2a-4bf9-8c68-29542a0d1abd', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('8dd3b45e-762d-4c8d-9a12-5fe520ef2080', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:55.000403', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '96c0a9f0-6fab-41ab-9c58-6939bfa9ad00', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('40463d2f-13e0-4684-8301-17b94bebf198', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:55.00041', 1, '4eb98ff8-c203-4e44-b90a-f4aa9d251e13', '96c0a9f0-6fab-41ab-9c58-6939bfa9ad00', 'Entradas para Guabira Vs Oriente en el sector General');
INSERT INTO public.ticket VALUES ('e4e95bf9-faa9-40b9-a9a5-17b8b8db6484', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:35:29.000293', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '56d21d25-3cac-479e-901f-6354d0e5359f', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('fca02e0b-ccbb-4ddb-84a4-4b33120dd0c8', '75fc67bc-3033-42b4-8ee8-c81d341497de', '2022-08-16 13:35:02.000014', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '128b1904-cdf4-486b-bdd1-e969a59484a1', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('c159acaf-489c-4b52-9acd-7033fb7585e0', '75fc67bc-3033-42b4-8ee8-c81d341497de', '2022-08-16 13:35:02.000037', 1, '4eb98ff8-c203-4e44-b90a-f4aa9d251e13', '128b1904-cdf4-486b-bdd1-e969a59484a1', 'Entradas para Guabira Vs Oriente en el sector General');
INSERT INTO public.ticket VALUES ('072b2e23-8704-4227-bb32-09e9a662a70a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:21:43.000168', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '1fbfa0aa-35a8-4598-88c8-cbba602aa21f', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('ed2bb40c-8e66-4f4e-9f73-599b0de4f4bd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:22:46.000331', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '691be3d3-21ea-4a57-ba12-d8eaac7451f1', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Menor');
INSERT INTO public.ticket VALUES ('dabd1079-608e-4a84-a01a-fa9c98b40774', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:28:01.000327', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'e2c5a6d8-123b-498c-9927-fa4e891e9fa5', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('bae996ec-6e6f-4778-bab6-985ba82d07a4', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:28:35.000536', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5840ae07-9c06-4d65-8dea-217488938513', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('7453a7de-3116-4385-9a6c-2d4c71ecc7ee', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:34:04.000243', 1, '4eb98ff8-c203-4e44-b90a-f4aa9d251e13', '5f6a34cd-5d55-4b76-af25-0c7c474930e0', 'Entradas para Guabira Vs Oriente en el sector General');
INSERT INTO public.ticket VALUES ('1128ba31-d6ae-4cff-9e59-14f429ec705e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:44:23.000311', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '39f106c9-882e-471e-a48d-d3d21f915c09', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('e6b14d6a-4b71-43db-a105-5fdfee0d385b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:44:23.000329', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '2b861fc9-3d66-4f33-a06a-02ca7b13d8e4', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('fdec57bf-dfd7-4b6d-9f28-3391654f1a22', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:50:52.000339', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '7f8e57fd-1f55-4a86-b8e0-0e19c0f8d325', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('61689c6c-8173-4063-83b7-b1bfdb11f9a1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 23:20:17.000519', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'b64695b9-b47d-4984-ae6e-b5c6d330a771', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('5e657506-8a38-4707-abbc-043ef1ef3ecb', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-17 23:41:49.000013', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '58f374de-aced-4119-92d0-9cc65c2accad', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('9b41ff61-09e8-4ce5-afc5-51a87ad0dac4', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 00:06:05.000855', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '7cfb4424-5d1d-4648-b941-5289c1ea4a99', 'Entradas para Guabira vs Tomayapo en el sector Preferencia Mayor');
INSERT INTO public.ticket VALUES ('3cdefcf3-66cb-4500-b78c-a03cd2a01983', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 00:33:39.000402', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'a133324c-9e8a-4aca-af52-0a61036414c6', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('f7dbf856-94e6-47a8-9bb0-fb8a738c3f1a', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000451', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'e9d4011a-5cf2-4725-8d68-fd52d21c3090', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('21751379-5ba0-458b-9629-ef1c0942f711', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000475', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'e9d4011a-5cf2-4725-8d68-fd52d21c3090', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('ae97ff04-4586-4082-bf8d-ffe62830e1a6', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000489', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'ccae2721-7713-476c-90eb-26a189e452d8', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('e57403be-14ef-4a08-a463-cbbea5c4018a', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000495', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'ccae2721-7713-476c-90eb-26a189e452d8', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('16edc8cd-69fc-46c6-a30b-5276d12e94d0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:39:28.000214', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'df674c6a-4ca0-4d25-9a70-6e2535e6f07d', 'Entradas para Guabira vs Tomayapo en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('34db694f-f0a8-4c6c-befc-59fb53420edf', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:39:28.000251', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'df674c6a-4ca0-4d25-9a70-6e2535e6f07d', 'Entradas para Guabira vs Tomayapo en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('c5a5a4b0-e1ba-41c2-b720-29d6bccbaabd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:39:28.000257', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'df674c6a-4ca0-4d25-9a70-6e2535e6f07d', 'Entradas para Guabira vs Tomayapo en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('2426c81b-d232-4c6e-9910-b2c8f17a07ae', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:56:29.000245', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'c0e65171-277c-4b4a-9939-9df9e37bf9b7', 'Entradas para Guabira vs Tomayapo en el sector CURVA MAYOR');
INSERT INTO public.ticket VALUES ('0190577a-30c6-439c-99cb-3f3ff14bdde6', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:17.000702', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '70c2b318-5fc3-4566-8a5d-78e96fd2432a', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('26a62eb5-a0ec-4e9e-aac6-6185ab8493c6', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:17.000723', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '70c2b318-5fc3-4566-8a5d-78e96fd2432a', 'Entradas para Guabira vs Tomayapo en el sector CURVA MAYOR');
INSERT INTO public.ticket VALUES ('5c8d7df0-c1c5-400a-b150-7d9e914c92f6', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:31.000197', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5f2a0d2a-2caa-47ae-82a1-89e4216daf8c', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('2a612c4e-3838-4750-9ffd-c4e5ef4851db', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:31.000212', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5f2a0d2a-2caa-47ae-82a1-89e4216daf8c', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('cda95ce4-6947-4725-9499-f237ded3d82c', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:31.000226', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5f2a0d2a-2caa-47ae-82a1-89e4216daf8c', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('3a3de437-349f-41e7-980e-dc34acb8956b', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:31.000233', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '5f2a0d2a-2caa-47ae-82a1-89e4216daf8c', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('7a313317-c3fd-4b02-affc-63cc0eaae21e', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 05:53:04.000896', 1, 'd24b8ec8-7879-4735-b139-984d1d66366c', 'e27488ca-4dc1-44f5-898e-c0b62d43f47a', 'Entradas para Guabira vs Blooming en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('9a95ba43-4ca0-46eb-9fdd-580c3e7128b1', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:27:45.000404', 1, '5ef2b787-3610-485f-b7f4-26f91197fc23', '864559d2-046e-421a-a120-ee9e9d4071ce', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA MAYOR.');
INSERT INTO public.ticket VALUES ('99e4581e-842b-47b3-a216-16900803fe11', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:59:46.000323', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'ea8b2f92-99f3-4c18-a942-bca6c85b477f', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('b47c6069-cd2b-4da4-a6d0-33059e341896', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:59:46.000373', 1, '5ef2b787-3610-485f-b7f4-26f91197fc23', 'ea8b2f92-99f3-4c18-a942-bca6c85b477f', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA MAYOR.');
INSERT INTO public.ticket VALUES ('45a1aa72-a115-4d06-9b1a-770a33715f52', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:59:46.000383', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'ea8b2f92-99f3-4c18-a942-bca6c85b477f', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('2cf35c6b-30eb-4a2d-9039-977505849734', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:59:46.000731', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'ea8b2f92-99f3-4c18-a942-bca6c85b477f', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('53787896-2b77-415d-8b9e-cf049798dd18', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000632', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('90080f16-1e54-49b8-8736-32a407d88885', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000664', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('b7bdc7a0-0fa1-4d05-ac41-ff6be78ce5b6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000802', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('d49d76fa-1309-41fc-949e-59434de87ddd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000812', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('bd18ee59-5bf9-4034-97c4-3522a7b8c0fb', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000821', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('8fcea46a-05fc-4712-9139-be468e4ce21e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.00083', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('7208c1a4-5829-4a09-8f6e-d9e1e59ac069', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000839', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('9e16dcb7-6e01-4a59-9635-f9b5d10b7aa2', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.00088', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('61d4c903-ff17-4b24-a663-67a958703be8', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:02.000949', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('ffe9d00e-b4c6-44f2-81a2-1e46c7455dbf', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:02.000962', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('a6c19e6c-2155-4f52-93f8-6e910aad9d54', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:02.000971', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('222f7348-5232-43d0-b3d1-e7ebbb5517fa', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:02.000986', 1, 'edb7d837-29a5-481d-97ca-d3d06b291a5b', 'fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('672fb309-d09e-40fb-9fda-a585c1955bd5', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:19:23.000241', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', '9174dd98-3629-4ad9-bad0-d7b9229e7e8e', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('c2d1056b-91e3-4813-91a1-c03b2067c29d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:19:23.000263', 1, 'ed59943d-6847-4fb0-ab55-01f84165e010', '9174dd98-3629-4ad9-bad0-d7b9229e7e8e', 'Entradas para Guabira vs Tomayapo en el sector GENERAL MAYOR');
INSERT INTO public.ticket VALUES ('f99c5e0d-c66a-48db-9444-7e7518a11ffa', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000593', 1, '914fe453-8165-4b36-99f1-54f445d8118a', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MAYOR.');
INSERT INTO public.ticket VALUES ('645f9ae9-22ef-426b-885c-b7aac2f4ff49', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000601', 1, '914fe453-8165-4b36-99f1-54f445d8118a', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MAYOR.');
INSERT INTO public.ticket VALUES ('42182d73-e0e3-419c-b25a-ee56f81de48a', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000608', 1, '914fe453-8165-4b36-99f1-54f445d8118a', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MAYOR.');
INSERT INTO public.ticket VALUES ('4c9e8868-78cc-4914-b623-fbbf61a93d63', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000615', 1, '914fe453-8165-4b36-99f1-54f445d8118a', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MAYOR.');
INSERT INTO public.ticket VALUES ('2f9de654-23c4-422d-bc05-1299f779e715', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000622', 1, '8810fd98-097f-4ba4-86b9-4a2e2ff23d1e', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('eb0c0aab-ef76-4e14-822f-5647168d9c45', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000628', 1, '8810fd98-097f-4ba4-86b9-4a2e2ff23d1e', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('c156d11c-c267-49d0-ab2c-0083be48384c', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000635', 1, '8810fd98-097f-4ba4-86b9-4a2e2ff23d1e', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('d9850e77-175f-455c-bd60-7cd0c52e5685', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000641', 1, '8810fd98-097f-4ba4-86b9-4a2e2ff23d1e', 'df42391b-5f64-4083-8dd2-a6e60ac3770c', 'Entradas para Guabira vs Blooming en el sector CURVA MENOR.');
INSERT INTO public.ticket VALUES ('246bf984-ec6f-49f0-b92a-a8b82f89c56e', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:12:20.000085', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '907cfefe-f43a-422f-9d4b-f8eb6d7971e3', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('cbffa24a-837f-403f-91ac-6484fc7934d4', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:12:20.000157', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '907cfefe-f43a-422f-9d4b-f8eb6d7971e3', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('92f8eec1-9a44-41f9-8a4f-631a5bb99e5a', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:12:20.000164', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '907cfefe-f43a-422f-9d4b-f8eb6d7971e3', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MAYOR');
INSERT INTO public.ticket VALUES ('db85ea4b-75fc-4fc5-8a81-7fe5fc7c0b12', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:13:12.000385', 1, 'f919f085-a23e-4ec6-acb9-5776b0eb8de4', '0c23ce19-b870-4ea7-96d5-6b2557b4e27f', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA MENOR.');
INSERT INTO public.ticket VALUES ('e5cb6be5-853a-4222-a90b-2b8679180f18', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:13:12.000392', 1, 'f919f085-a23e-4ec6-acb9-5776b0eb8de4', '0c23ce19-b870-4ea7-96d5-6b2557b4e27f', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA MENOR.');
INSERT INTO public.ticket VALUES ('eeb1c70b-eac7-45d8-a4f9-bd0c0f2dadcb', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:07:28.000298', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '6a36518b-b14e-4887-993f-3b4e10a3dafa', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('0bf1a690-bf5e-452a-a5ec-48f09276d1b3', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:07:28.000334', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '6a36518b-b14e-4887-993f-3b4e10a3dafa', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('f28deaab-07cf-4866-8f5e-21b252151efd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:10:03.000475', 1, 'e3b6151f-5ffd-45f2-ae42-3beb18e39b09', 'f4f57dc8-7606-4c78-aad7-f813977de4d9', 'Entradas para Guabira vs Bolivar en el sector PALCO');
INSERT INTO public.ticket VALUES ('eead4012-d82b-4c3c-ba30-2df59c062a25', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-23 03:10:46.000866', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '997415ac-2de2-4cba-9b13-108e98f65197', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('aca21b86-f826-4aef-bcaf-50b16aa084f6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:15:44.000258', 1, 'c6570e66-2f9d-4ce2-8de5-d2f307f15af6', '125c5ff7-b2db-4ab4-ae0f-b45dee791c20', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('3b985795-259e-4dcd-ae46-fafe43ae5cb5', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:17:38.000142', 1, '3c9e0acb-075f-480a-9553-4572412fc116', '35fd27ca-9c37-4db2-84a7-91a0ac0a9041', 'Entradas para Guabira vs Bolivar en el sector BUTACA');
INSERT INTO public.ticket VALUES ('90dc6583-a579-488e-99ad-98c56d91a015', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 04:25:09.000432', 1, 'e3b6151f-5ffd-45f2-ae42-3beb18e39b09', '7441f75a-6a34-466b-88f5-4cee31466d68', 'Entradas para Guabira vs Bolivar en el sector PALCO');
INSERT INTO public.ticket VALUES ('8f58053a-4b53-4622-b171-3410e5b512bb', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-24 20:03:06.000707', 1, '3c9e0acb-075f-480a-9553-4572412fc116', '230c90f0-55cf-466d-8ce2-e4cc072520cf', 'Entradas para Guabira vs Bolivar en el sector BUTACA');
INSERT INTO public.ticket VALUES ('c7d9d82f-a02c-4189-8226-b770d87f873a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-24 20:03:06.000729', 1, '3c9e0acb-075f-480a-9553-4572412fc116', '230c90f0-55cf-466d-8ce2-e4cc072520cf', 'Entradas para Guabira vs Bolivar en el sector BUTACA');
INSERT INTO public.ticket VALUES ('a6be5714-60d6-40a4-b87d-1394c875f2b9', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-24 23:40:12.000458', 1, 'e3b6151f-5ffd-45f2-ae42-3beb18e39b09', 'b89cb4ba-a61e-4abe-aaa6-53e0e95300bd', 'Entradas para Guabira vs Bolivar en el sector PALCO');
INSERT INTO public.ticket VALUES ('b9d104f7-3e5e-4667-9af9-4cbe86c0e63d', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-13 23:34:45.000372', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'f258b5e2-29f9-48ec-a98f-945a4642a1e3', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('2e2c24e1-60bd-413f-8ca5-488494a6a91a', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-13 23:34:45.000401', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'f258b5e2-29f9-48ec-a98f-945a4642a1e3', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('b743fb46-5c1c-46da-9e72-ca7894662a36', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-14 00:04:58.000184', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '3c4019a5-d822-4818-8f8b-a9a902a49b9b', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('6ad23683-fb50-4636-861a-0f1ca4747f54', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-14 00:04:58.000221', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '3c4019a5-d822-4818-8f8b-a9a902a49b9b', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('cf618dfb-b04c-4666-8901-432b14d0466e', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-14 00:04:58.000226', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '3c4019a5-d822-4818-8f8b-a9a902a49b9b', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('9b123629-44d6-451e-8a9c-c66827a1a2ab', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 00:59:08.000994', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '54c87618-c370-4a0a-a570-43550ebba8fd', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('7b86ee8b-9879-4d8e-ab92-f9f9f56e58c8', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 01:00:39.000924', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'deb00d61-7282-4f8a-aaeb-74e25ede1a10', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('a4540f95-1098-48e6-ad0f-f67d5acc33f2', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 02:14:48.000718', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'e2fbc860-57e1-4f1f-9c8d-b348673f5930', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('b087d639-243b-4f83-9bc5-1c9e15444800', 'a6f432b0-5e80-4c23-8fdb-d9833ce4aeb4', '2022-09-14 16:00:01.000818', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '146e0032-e144-4717-8571-381db2a1b9fa', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('56f819df-d4cc-449d-9091-bec78148005c', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 16:00:53.000884', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '4f6194b7-550e-4d23-bfaa-1fad235ee8b7', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('c768796f-ff44-4ff3-a2b4-846e04da4d65', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:05:43.000116', 1, '3c9e0acb-075f-480a-9553-4572412fc116', '77c663d4-7dbb-46e0-b188-fdcd97b6a5bb', 'Entradas para Guabira vs Bolivar en el sector BUTACA');
INSERT INTO public.ticket VALUES ('31146587-58b5-45c5-952f-b385a6757393', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:08:40.000792', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '049e0e51-6161-447a-a693-88c2d7b0100d', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('586184f9-7b4e-4ab2-a006-e12c8e7662fc', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:08:40.000799', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '049e0e51-6161-447a-a693-88c2d7b0100d', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('129a70c2-6f67-4baa-bed0-bc7005dbc19c', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:08:40.000804', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '049e0e51-6161-447a-a693-88c2d7b0100d', 'Entradas para Guabira vs Tomayapo en el sector PALCO');
INSERT INTO public.ticket VALUES ('9146299f-4484-4222-8d1b-4e3e8159721c', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.00065', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '59693d5a-347d-40b7-8a22-5ab295ad4933', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('7e05a11b-a485-4bd5-b94c-3e587e27b1a3', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000666', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '59693d5a-347d-40b7-8a22-5ab295ad4933', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('5dadf37e-79db-42c7-ad71-94e1ada6e192', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000675', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '59693d5a-347d-40b7-8a22-5ab295ad4933', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('cbbee708-6abf-429e-8c66-716ccfa940c9', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000682', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '59693d5a-347d-40b7-8a22-5ab295ad4933', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('8c9d7351-ab27-4c87-a1e5-3868a9ee3f35', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.0007', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '282e00a9-da49-46db-9f53-9655ca1ab347', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('aa6a93d6-f8f7-4a39-bb97-c182168e281d', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000708', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '282e00a9-da49-46db-9f53-9655ca1ab347', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('f1b1b6ab-c235-403b-93f7-48f58f869028', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000724', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '282e00a9-da49-46db-9f53-9655ca1ab347', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('57bfed93-ea80-4f0d-a93a-4d27b6612857', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000731', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '282e00a9-da49-46db-9f53-9655ca1ab347', 'Entradas para Guabira vs Tomayapo en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('1b282570-3879-401b-b1f9-94db9317b2bb', '637a70ce-98a4-4060-820d-b7bf567cb04c', '2022-09-16 20:12:14.000731', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '1ecba9f1-1a36-4841-9c80-2fd9cf74c64c', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('50410747-fb5a-48a7-8d32-7726d715fbb5', '637a70ce-98a4-4060-820d-b7bf567cb04c', '2022-09-16 20:12:14.000761', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '1ecba9f1-1a36-4841-9c80-2fd9cf74c64c', 'Entradas para Guabira vs Tomayapo en el sector BUTACA');
INSERT INTO public.ticket VALUES ('c950d100-befd-42ca-a55d-633ce40f637e', '637a70ce-98a4-4060-820d-b7bf567cb04c', '2022-09-16 20:12:14.000765', 1, 'c6570e66-2f9d-4ce2-8de5-d2f307f15af6', '1ecba9f1-1a36-4841-9c80-2fd9cf74c64c', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('220db447-c48e-41b3-9850-65bedd845997', 'f2726451-5bdd-443a-8c88-c2461ed8b1d3', '2022-09-16 22:19:09.000245', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '8a866c5d-c75f-4d6d-9528-78450ce14dab', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('3854e4aa-19ab-4466-9352-572bd910d9b4', 'f2726451-5bdd-443a-8c88-c2461ed8b1d3', '2022-09-16 22:19:09.000256', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '8a866c5d-c75f-4d6d-9528-78450ce14dab', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('cfc974b5-5eda-4294-afe7-ccfab1dd81e3', 'f2726451-5bdd-443a-8c88-c2461ed8b1d3', '2022-09-16 22:19:09.000263', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', '8a866c5d-c75f-4d6d-9528-78450ce14dab', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('cec9f61e-9774-4aac-a483-faf8957dccf7', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 03:24:34.000147', 1, 'c6570e66-2f9d-4ce2-8de5-d2f307f15af6', '1760ea8e-4b1a-4b59-b3e5-a640b9b98a5a', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('3b0cbaa4-5311-4369-b889-71b1cc908809', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 03:30:52.000721', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '7c7b65e5-ef3b-4cef-935d-760650dc4105', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('af329e15-dc82-49fb-a983-c6ea93be1e73', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:31:14.000046', 1, 'c6570e66-2f9d-4ce2-8de5-d2f307f15af6', 'e3d4df43-7d61-45ee-abc9-73f032a96341', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('50d5a6ca-9c52-4e9c-a43d-23bb7e87395b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:31:14.000059', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'e3d4df43-7d61-45ee-abc9-73f032a96341', 'Entradas para Guabira vs Oriente P. en el sector PALCO');
INSERT INTO public.ticket VALUES ('d41d38d1-85f6-4b23-8488-e5b961ef5f3a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:36:22.000295', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'd40e5306-6a92-42bf-afe6-fa68a19ec4fd', 'Entradas para Guabira vs Oriente P. en el sector PALCO');
INSERT INTO public.ticket VALUES ('475332b9-74be-405f-b093-b25ffd1fca71', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:36:22.000307', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'd40e5306-6a92-42bf-afe6-fa68a19ec4fd', 'Entradas para Guabira vs Oriente P. en el sector PALCO');
INSERT INTO public.ticket VALUES ('c6635803-4827-4d2c-ad94-7bcbd0acf055', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:36:22.000321', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', 'd40e5306-6a92-42bf-afe6-fa68a19ec4fd', 'Entradas para Guabira vs Oriente P. en el sector PALCO');
INSERT INTO public.ticket VALUES ('1b9520e8-8bfd-4d52-8a58-85a6d8d26384', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:54:46.000851', 1, 'e3b6151f-5ffd-45f2-ae42-3beb18e39b09', '319c2af5-1bf3-4656-b144-41ce7f43eb5e', 'Entradas para Guabira vs Bolivar en el sector PALCO');
INSERT INTO public.ticket VALUES ('c867e0a9-0b9f-44a6-9c26-fddb7c4c3426', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:00:22.000356', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'c8213451-e478-4d1a-b056-947f9113e611', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('0c744abf-284f-4b65-9300-7be09d97a55d', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:00:22.000368', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'c8213451-e478-4d1a-b056-947f9113e611', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('c859ab45-d7fc-41ed-a360-6ed2173c1c61', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:01:03.000678', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', '2fe724df-9549-4cf0-8bb3-388400773da7', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('fb331576-f527-4f40-a831-715b598ecf87', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 05:03:55.00002', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'bc5a977c-0802-4bc8-8c75-dc353375b8c5', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('28426c8f-bb36-420a-a992-d653bfeccc83', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 05:03:55.000025', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'bc5a977c-0802-4bc8-8c75-dc353375b8c5', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('3df7b5ff-beda-403e-8039-287ab5b5c47e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 05:03:55.00003', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'bc5a977c-0802-4bc8-8c75-dc353375b8c5', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('05cf5330-bec7-4631-b74e-307bffc8552e', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:05:42.000869', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '67509e02-f921-4ced-a687-a53acd5a7163', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('04324ec0-7e8a-4d52-b66e-841ab918b614', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:05:42.000876', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '67509e02-f921-4ced-a687-a53acd5a7163', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('12d4593d-a3cf-4b6d-8665-9f11de5d95ca', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:05:42.000881', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '67509e02-f921-4ced-a687-a53acd5a7163', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('92922d52-7733-4451-9fbf-e3e258e2820d', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:05:42.000885', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', '67509e02-f921-4ced-a687-a53acd5a7163', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('bcccd5cc-8c15-48aa-959b-f1a034e0591d', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:09:34.000259', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'e5cea307-d6c5-4e0b-bfcf-d26b3329b00c', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('4dad8d66-d288-468d-98c1-1fffbaae0e8e', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:09:34.000269', 1, '9c6755ed-d9a5-4dd7-812e-e5b4c4a3d30f', 'e5cea307-d6c5-4e0b-bfcf-d26b3329b00c', 'Entradas para Guabira vs Oriente P. en el sector BUTACA');
INSERT INTO public.ticket VALUES ('05c243ed-a539-48c4-931c-99616a9ba5cb', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:11:19.000029', 1, '6def7fce-6271-4b67-b18d-8da28090fda1', 'e2b7b24c-bb85-45c8-bfe9-abe1382833d5', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('beecdf77-d94d-4dcc-ba51-c46577e11770', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:11:19.000035', 1, '6def7fce-6271-4b67-b18d-8da28090fda1', 'e2b7b24c-bb85-45c8-bfe9-abe1382833d5', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('f79fa631-f268-45dc-b1cf-895f03448974', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:22:06.000339', 1, '7539b680-8ec9-4c16-852b-fbcdb8b2737f', '10875ac4-9a09-40cc-8ec1-23f8d0426cc5', 'Entradas para Guabira vs Blooming en el sector GENERAL Y CURVA');
INSERT INTO public.ticket VALUES ('c5bf27b8-0ed9-4dc4-bb82-8bb65c94bbb0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.00042', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('00ea05c2-52b1-49fe-995a-088e3095b8b0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000432', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('cb38f3b7-0fdc-4043-8c26-cb3e7663c11d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000439', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('9f6530ba-f78b-4312-9733-b420befb4942', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000446', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('6fa8e2a2-7776-4e3c-80a8-99726466ca53', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000453', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('2418242d-1e7d-4f2b-93ea-a92757b37b2b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.00046', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('20dd84ef-e637-4b84-8ca7-7df4811c53c3', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000467', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('7831bad8-b28e-49cf-8550-102c9fa06005', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000473', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('93b61895-1eca-472c-99b9-1a12ddd8bf5d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000479', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('18b037de-5666-4694-9650-2e1006608eda', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000486', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('7cba6c3e-1083-4dd9-876b-2809815228fa', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:37:05.000372', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '6741fcdf-d2d9-41a1-add5-a557d4ae6ea1', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('8bae05f2-a25b-4ddf-8809-d7c27b07f529', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:38:47.000074', 1, '400a12e7-b418-4bcf-8785-bd8aa25a8517', '99beddff-e788-4b45-b28a-cf29ee34420d', 'Entradas para Guabira vs Blooming en el sector BUTACA');
INSERT INTO public.ticket VALUES ('4454eacb-654b-4967-8563-f618e87fec7c', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000439', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('321f57aa-d59a-48ca-a236-5f61a8a5bf77', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000444', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('eb1d2073-f147-4459-8d2b-587eaf69d862', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000452', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('14f00d6c-e88b-4fc3-b31c-8ae8b47f8aee', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000462', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('bcf9e591-a13d-4e85-a777-4c7d2dd5b26f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000469', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('57fcb2d7-4b01-4573-80a4-db6b2e38ae56', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000475', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('1c2057c7-63d9-4555-9ded-d30d766e46c1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000481', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('0f92d9d2-9cad-4219-ae7a-d917d68469b6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000486', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('eafbef48-2c79-46ac-be8a-065f2857df52', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.00049', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('ea9f0baa-218f-4031-935b-3f66eda65086', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000495', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', 'c8e3eb41-14d8-41ac-b640-473c203982ce', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('645232b4-39f1-4c5e-ad8f-869fc2dbc340', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000753', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('f4a92a2d-6853-4eec-8c5f-222a79a4a3cc', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.00076', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('d2fb71f7-dbbb-467f-8c33-1d15c6c4d915', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000767', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('c5d37727-1b78-4cd1-9a91-603d9090299c', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000774', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('9c430056-e770-43df-843a-6a58f2703890', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000781', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('8f766dae-8e73-424d-b7be-b534ff6ddbc6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000787', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('237b9218-8f5e-46db-8b51-e0f8568ad2cc', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000793', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('550bf6e5-f425-44b2-8506-ae4038d396dd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000797', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('18e2b31b-662c-43a6-b80d-cf8d5c6a5931', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000803', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('7682238e-0034-4726-abc3-642f4ae2698e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000807', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '91fd6d78-cece-45cc-a3ee-83f6d524f164', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('f56912a8-8960-4ec8-89b9-edd15ab6c89d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.000816', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('467958db-2e6d-463b-a4f7-2315efee293a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.00082', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('36b1b20b-f339-4515-aecb-0957476b6d7f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.000826', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('1cc97a2b-f7c4-45c0-b77b-af411035abd6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.000835', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('698e683a-f094-4832-96e3-539711f201e4', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.00084', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('702dca50-3416-4039-a475-14324ef9e887', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.000844', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('57b566c0-dc5c-41dc-94e1-028b3a937535', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.000879', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('5cc4718b-14cb-4e95-9d18-93ebfb8e9111', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.000886', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('b9d9860a-5316-4f2c-a1ae-a2df225857d9', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.000892', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('29241d59-cee8-4ee2-9b5b-d95f85efa436', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.0009', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('24efab7b-55a2-4c10-ac7f-d399c5cdc19f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.000906', 1, 'fdc20e4e-fa79-4f4e-9fe8-35328ff5c63d', 'caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('367d6225-ca26-41dd-9ae7-34b31ce9db33', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:15.00055', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '9332c544-50e8-4704-9224-999ce112e534', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('e91a46b0-c329-4e05-876d-059ae0799273', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:15.000556', 1, 'e8326386-8d8d-43e8-89c4-9060cc36570c', '9332c544-50e8-4704-9224-999ce112e534', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('d7d0f4e4-1e8d-465f-a81e-e465504badf3', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:28.000316', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', 'd5801199-29ae-4de0-958e-31416b00cbd9', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('0b4f4ded-4b2d-4326-a35e-043121f2e522', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:28.000321', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', 'd5801199-29ae-4de0-958e-31416b00cbd9', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('05e9f1e5-971b-4ec5-8a07-63ce94ee4df6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:28.000325', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', 'd5801199-29ae-4de0-958e-31416b00cbd9', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('78924572-9381-4c8d-be98-9a6fc9a02718', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000783', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('c9b9ddd1-6039-422b-bc1c-2e0cbefc7147', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000793', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('400eb207-5a45-4d00-b6ff-1b29b8280a19', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.0008', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('e5cf492c-4b7b-407c-a2a7-b90f40479ebf', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000807', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('64c331e5-e6e5-4e33-8974-8ef519ada579', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000812', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('6e0f2846-d2d6-4f64-95cb-4d9003fa1d93', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000817', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('39821c59-a54c-402e-9023-fcb26fced8b0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000822', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('d9007f23-f7fb-4f9a-9853-5ff770992565', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000827', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('5e90c7cb-7dc1-46d8-91fb-a96a2a68fc8b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000833', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('0b8b0585-72dd-4c96-872d-5d025c47881c', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000838', 1, 'd7438f56-ece4-4f22-81cd-415d09e94dfe', '52045121-3f63-4d4a-ad27-268d80d4cf23', 'Entradas para Guabira vs Blooming en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('d1622eb1-f60b-46b8-a7cb-4ff17577141d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:16:33.000465', 1, 'fa2ce8fb-7c82-43c8-9b3b-f1797a965d0b', 'cecddda1-470f-4563-b98e-8a37c75c91e6', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('0308aa9c-1a2d-4562-a03e-264fce77397d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:19:38.000673', 1, 'ecc91506-6b7a-4094-98cb-ebdac32b71b2', 'b491c0dd-85a1-4ddb-a0e2-3c44e6f2fd24', 'Entradas para Guabira vs Oriente P. en el sector GENERAL Y CURVA MENOR');
INSERT INTO public.ticket VALUES ('f7b505bf-8e1d-4477-9e26-63f916470ca4', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:42:41.000245', 1, 'a34fa73c-ae9e-469a-9f71-0f5500844dad', '64bb4add-f006-4042-8fd9-80ab16566d61', 'Entradas para Guabira vs Oriente P. en el sector PALCO');
INSERT INTO public.ticket VALUES ('5f0d774e-cdf3-4db1-b9f7-65d906bd0e3d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:45:21.000998', 1, 'c6570e66-2f9d-4ce2-8de5-d2f307f15af6', '2019c7e2-54f3-4437-a32c-e6d5e8a037aa', 'Entradas para Guabira vs Bolivar en el sector PREFERENCIA ');
INSERT INTO public.ticket VALUES ('364db495-45c9-48fc-9e1f-f1595d510a12', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:46:56.000732', 1, '463ea920-9f3b-40bc-8ceb-1f4aff43da80', 'b9b6019b-33db-4329-ba42-20d60eb44f4b', 'Entradas para Guabira vs Oriente P. en el sector PREFERENCIA MENOR');
INSERT INTO public.ticket VALUES ('0f78da85-4079-4160-96ce-873d757281eb', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000328', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('e7daf6d2-60ea-4ae6-ae18-731acb29b375', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000366', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('ffe227e0-ec51-4e7e-b033-5bbb5d98e375', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000418', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('2cc7ad5e-eb2d-497f-b3ab-3a83ff9dfbb9', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000446', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('1548dc03-a0d6-4135-8c6d-09869c27d899', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000475', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('52986ea8-5d3c-4612-b9c3-c63119185d9e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000527', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('583d1d21-c577-43ae-9acc-f3eb1be0c31e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000552', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('cd35e129-9674-40ca-a7db-02bffabafafc', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000581', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('98d36ebe-a047-48ba-a1c3-8fe268c6547b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000622', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');
INSERT INTO public.ticket VALUES ('d74a6f88-1912-4fac-ba87-a150f71f5c01', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000643', 1, 'a6514ff3-5e0a-40d6-b2c1-8cd8a25c064f', 'aee8322f-e288-48d1-bb85-2b3a936022d1', 'Entradas para Guabira vs Blooming en el sector GENEREAL Y CURVA ');


--
-- TOC entry 3055 (class 0 OID 16410)
-- Dependencies: 204
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario VALUES ('94138b3f-4778-4b82-93fd-92d92358ef3d', NULL, '2022-08-18 02:37:20.000858', 1, NULL, 'alfredo', 'alfredo', '2525', '2525', '2525', NULL);
INSERT INTO public.usuario VALUES ('3a4f30ff-2bd5-490d-8d31-d419ab44f64f', NULL, '2022-09-13 23:32:53.0001', 1, NULL, 'wilson', 'paz', 'wilson@gmail,com', '555555', '123', NULL);
INSERT INTO public.usuario VALUES ('f78406cf-c386-4832-a46e-ac979574582b', NULL, '2022-09-13 23:34:12.0003', 1, NULL, 'nicolas', 'n', 'pas12@gmail.com', '454545', '123', NULL);
INSERT INTO public.usuario VALUES ('a6f432b0-5e80-4c23-8fdb-d9833ce4aeb4', NULL, '2022-09-14 15:59:11.000118', 1, NULL, 'Alberto ', 'Iriarte ', '123@gmail.com', '12334488', '123', NULL);
INSERT INTO public.usuario VALUES ('33f74fe3-c666-49a6-a646-25f3bff7feda', NULL, '2022-09-14 21:41:59.000884', 1, NULL, 'edwin', 'aguilar', 'edwin@gmail.com', '78585852', '123', NULL);
INSERT INTO public.usuario VALUES ('a5f85db5-d006-4eaf-ac4b-bfcc11229416', NULL, '2022-07-19 03:10:09.000254', 1, NULL, 'Admin', 'Admin', 'admin@gmail.com', 'rickypazd@icloud.com', '123', true);
INSERT INTO public.usuario VALUES ('637a70ce-98a4-4060-820d-b7bf567cb04c', NULL, '2022-09-16 20:11:38.000876', 1, NULL, 'micky', 'paz', 'micky@gmail.com', '77585852', '123', NULL);
INSERT INTO public.usuario VALUES ('cfd50919-1381-4b93-adbf-b443e7307461', NULL, '2022-07-21 02:44:39.000019', 1, NULL, '123', '123', '123', '123', '123', true);
INSERT INTO public.usuario VALUES ('c700c390-94b9-41f1-b07d-b3f74525a09c', NULL, '2022-07-21 04:33:20.00007', 1, NULL, 'mario', 'perez', 'peres@gmail.com', '77695852', '123456', NULL);
INSERT INTO public.usuario VALUES ('900acbc5-2345-4f88-af35-ec9d407cb492', NULL, '2022-08-01 19:56:03.000276', 1, NULL, 'pedro', 'nieme', 'pas@gmail.com', '77694945', '123', NULL);
INSERT INTO public.usuario VALUES ('dea8a6b5-3d4c-407c-bf10-14d3348e11f3', NULL, '2022-08-10 20:07:00.000605', 1, NULL, 'alberto', 'chavez', '156', '775855', '156', NULL);
INSERT INTO public.usuario VALUES ('f2726451-5bdd-443a-8c88-c2461ed8b1d3', NULL, '2022-09-16 22:18:14.000386', 1, NULL, 'grasiela', 'balcazar', 'grasiela@gmail.com', '7558952', '123', NULL);
INSERT INTO public.usuario VALUES ('006349fa-ff10-4783-97b4-eb8fffb92d65', NULL, '2022-07-19 03:07:41.000509', 0, NULL, '', 'nieme', 'nnieme641@icloud.com', '77694941', '2525', true);
INSERT INTO public.usuario VALUES ('75fc67bc-3033-42b4-8ee8-c81d341497de', NULL, '2022-08-16 13:34:11.000715', 0, NULL, 'fernando ', 'mansilla', 'mansilla@gmail.com', '856252', '123', NULL);
INSERT INTO public.usuario VALUES ('8ffbfddc-6f1c-4500-92bb-a7abc2de7b63', NULL, '2022-08-16 05:51:07.000182', 0, NULL, 'mateo', 'nieme', 'mateo12', '525', '123', NULL);
INSERT INTO public.usuario VALUES ('060866de-b3e1-4685-9f9f-2044f525ebc0', NULL, '2022-08-12 22:48:41.000296', 0, NULL, 'viÃÂÃÂ±ola', 'viÃÂÃÂ±ola', 'viÃÂÃÂ±ola', '455', '12345', NULL);
INSERT INTO public.usuario VALUES ('12167035-d049-44db-b9cf-d5397244b723', NULL, '2022-07-21 03:41:46.000919', 1, NULL, '1234', '1234', '1234', '1234', '1234', true);


--
-- TOC entry 3056 (class 0 OID 16416)
-- Dependencies: 205
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta VALUES ('06027f97-b9e9-46da-bb6a-3822468a516f', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-16 04:25:08.000041', 1, '--', '', '');
INSERT INTO public.venta VALUES ('d0c2748a-7ebe-4715-abbf-2d19f5d4b82b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 04:35:28.000981', 1, '--', '', '');
INSERT INTO public.venta VALUES ('ebe03c6c-226d-407c-95a4-7e64295b8ce6', '8ffbfddc-6f1c-4500-92bb-a7abc2de7b63', '2022-08-16 05:51:56.000706', 1, '--', '8136201', 'fanatico');
INSERT INTO public.venta VALUES ('5ca1bd83-3d7f-406d-a435-1ece0602ebb5', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:01:37.000412', 1, '--', '', '');
INSERT INTO public.venta VALUES ('d0571b02-ece2-4394-9c4c-3052d1617e73', '8ffbfddc-6f1c-4500-92bb-a7abc2de7b63', '2022-08-16 06:03:55.000908', 1, '--', '', '');
INSERT INTO public.venta VALUES ('c8ba33ae-52f2-4f23-bcfb-0ecf13c9c105', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:10.000829', 1, '--', '', '');
INSERT INTO public.venta VALUES ('4321574e-c172-405d-9fde-c4b83915954b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:05:37.000892', 1, '--', '', '');
INSERT INTO public.venta VALUES ('46e29179-3861-4d95-b551-a4bf1030b3fc', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:15.000349', 1, '--', '', '');
INSERT INTO public.venta VALUES ('6ae39af9-0e2a-4bf9-8c68-29542a0d1abd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:36.00098', 1, '--', '', '');
INSERT INTO public.venta VALUES ('56d21d25-3cac-479e-901f-6354d0e5359f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:35:29.000277', 1, '--', '', '');
INSERT INTO public.venta VALUES ('128b1904-cdf4-486b-bdd1-e969a59484a1', '75fc67bc-3033-42b4-8ee8-c81d341497de', '2022-08-16 13:35:01.000999', 1, '--', '', '');
INSERT INTO public.venta VALUES ('825b1257-70d8-45ab-9d91-eb0377f88f0a', '75fc67bc-3033-42b4-8ee8-c81d341497de', '2022-08-16 13:45:14.000532', 1, '--', '', '');
INSERT INTO public.venta VALUES ('7b226360-2047-4f94-a699-98459dab2777', '75fc67bc-3033-42b4-8ee8-c81d341497de', '2022-08-16 13:45:21.000085', 1, '--', '', '');
INSERT INTO public.venta VALUES ('691be3d3-21ea-4a57-ba12-d8eaac7451f1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:22:46.000321', 1, '--', '', '');
INSERT INTO public.venta VALUES ('e2c5a6d8-123b-498c-9927-fa4e891e9fa5', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:28:01.000281', 1, '--', '', '');
INSERT INTO public.venta VALUES ('5840ae07-9c06-4d65-8dea-217488938513', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:28:35.000505', 1, '--', '', '');
INSERT INTO public.venta VALUES ('5f6a34cd-5d55-4b76-af25-0c7c474930e0', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:34:04.000235', 1, '--', '', '');
INSERT INTO public.venta VALUES ('39f106c9-882e-471e-a48d-d3d21f915c09', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:44:23.000293', 1, '--', '', '');
INSERT INTO public.venta VALUES ('2b861fc9-3d66-4f33-a06a-02ca7b13d8e4', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:44:23.000325', 1, '--', '', '');
INSERT INTO public.venta VALUES ('e64ab286-931a-4d18-b872-43cb8a22dd31', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:50:45.000255', 1, '--', '', '');
INSERT INTO public.venta VALUES ('7f8e57fd-1f55-4a86-b8e0-0e19c0f8d325', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 10:50:52.000332', 1, '--', '', '');
INSERT INTO public.venta VALUES ('58f374de-aced-4119-92d0-9cc65c2accad', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-17 23:41:48.00098', 1, '--', '', '');
INSERT INTO public.venta VALUES ('b21f11c6-3105-40cf-a854-e0584a193fda', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-17 23:44:06.00023', 1, '--', '', '');
INSERT INTO public.venta VALUES ('7cfb4424-5d1d-4648-b941-5289c1ea4a99', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 00:06:05.000825', 1, '--', '', '');
INSERT INTO public.venta VALUES ('a133324c-9e8a-4aca-af52-0a61036414c6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 00:33:39.000396', 1, '--', '', '');
INSERT INTO public.venta VALUES ('e9d4011a-5cf2-4725-8d68-fd52d21c3090', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000441', 1, '--', '25452525', 'fanatico');
INSERT INTO public.venta VALUES ('ccae2721-7713-476c-90eb-26a189e452d8', '94138b3f-4778-4b82-93fd-92d92358ef3d', '2022-08-18 02:37:57.000485', 1, '--', '25452525', 'fanatico');
INSERT INTO public.venta VALUES ('df674c6a-4ca0-4d25-9a70-6e2535e6f07d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:39:28.000191', 1, '--', '', '');
INSERT INTO public.venta VALUES ('70c2b318-5fc3-4566-8a5d-78e96fd2432a', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:17.000648', 1, '--', '', '');
INSERT INTO public.venta VALUES ('6a36518b-b14e-4887-993f-3b4e10a3dafa', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:07:28.000158', 2, '--', '', '');
INSERT INTO public.venta VALUES ('5f2a0d2a-2caa-47ae-82a1-89e4216daf8c', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 04:50:31.000175', 2, '--', '', '');
INSERT INTO public.venta VALUES ('286cdf1b-a2ee-4bf4-89c4-8451d1fb1663', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-16 04:10:08.000473', 2, '--', '', '');
INSERT INTO public.venta VALUES ('e27488ca-4dc1-44f5-898e-c0b62d43f47a', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 05:53:04.000347', 2, '--', '', '');
INSERT INTO public.venta VALUES ('5b3fd17b-c708-4df3-b671-d2aadc474e84', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:27:33.000954', 1, '--', '', '');
INSERT INTO public.venta VALUES ('864559d2-046e-421a-a120-ee9e9d4071ce', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:27:45.000005', 1, '--', '', '');
INSERT INTO public.venta VALUES ('fd697ebb-0f64-436e-9bd2-e2bd6c705e84', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:01:01.000501', 1, '--', '', '');
INSERT INTO public.venta VALUES ('ea8b2f92-99f3-4c18-a942-bca6c85b477f', 'a5f85db5-d006-4eaf-ac4b-bfcc11229416', '2022-08-18 06:59:46.000215', 2, '--', '4737437', 'roeroes');
INSERT INTO public.venta VALUES ('9174dd98-3629-4ad9-bad0-d7b9229e7e8e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 07:19:23.000202', 2, '--', '', '');
INSERT INTO public.venta VALUES ('5deca414-bcf9-45c0-b08e-436419c20bcf', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:20:51.000045', 1, '--', '', '');
INSERT INTO public.venta VALUES ('df42391b-5f64-4083-8dd2-a6e60ac3770c', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 07:24:25.000584', 2, '--', '', '');
INSERT INTO public.venta VALUES ('907cfefe-f43a-422f-9d4b-f8eb6d7971e3', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:12:19.000985', 2, '--', '', '');
INSERT INTO public.venta VALUES ('0c23ce19-b870-4ea7-96d5-6b2557b4e27f', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-18 19:13:12.000376', 2, '--', '', '');
INSERT INTO public.venta VALUES ('f4f57dc8-7606-4c78-aad7-f813977de4d9', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:10:03.000466', 1, '--', '', '');
INSERT INTO public.venta VALUES ('997415ac-2de2-4cba-9b13-108e98f65197', '12167035-d049-44db-b9cf-d5397244b723', '2022-08-23 03:10:46.000856', 1, '--', '', '');
INSERT INTO public.venta VALUES ('78130354-8043-4e1c-8016-bf53015356ed', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:15:24.00012', 1, '--', '', '');
INSERT INTO public.venta VALUES ('c25c3cfe-1e69-4380-82c9-de1009003f25', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:15:27.000604', 1, '--', '', '');
INSERT INTO public.venta VALUES ('125c5ff7-b2db-4ab4-ae0f-b45dee791c20', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:15:44.00025', 1, '--', '', '');
INSERT INTO public.venta VALUES ('7b980509-b5d3-4330-8968-9ae828d06109', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:17:24.000118', 1, '--', '', '');
INSERT INTO public.venta VALUES ('35fd27ca-9c37-4db2-84a7-91a0ac0a9041', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 03:17:38.000134', 1, '--', '', '');
INSERT INTO public.venta VALUES ('7441f75a-6a34-466b-88f5-4cee31466d68', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-23 04:25:09.000325', 2, '--', '', '');
INSERT INTO public.venta VALUES ('230c90f0-55cf-466d-8ce2-e4cc072520cf', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-24 20:03:06.000651', 2, '--', '856522', 'fanatico');
INSERT INTO public.venta VALUES ('b89cb4ba-a61e-4abe-aaa6-53e0e95300bd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-24 23:40:12.000277', 2, '--', '', '');
INSERT INTO public.venta VALUES ('f258b5e2-29f9-48ec-a98f-945a4642a1e3', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-13 23:34:45.000359', 1, '--', '253352', 'hincha');
INSERT INTO public.venta VALUES ('3c4019a5-d822-4818-8f8b-a9a902a49b9b', 'f78406cf-c386-4832-a46e-ac979574582b', '2022-09-14 00:04:58.000077', 1, '--', '', '');
INSERT INTO public.venta VALUES ('54c87618-c370-4a0a-a570-43550ebba8fd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 00:59:08.00096', 1, '--', '', '');
INSERT INTO public.venta VALUES ('96c0a9f0-6fab-41ab-9c58-6939bfa9ad00', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:06:55.000396', 2, '--', '', '');
INSERT INTO public.venta VALUES ('8c1abfa3-a863-4424-a013-de3b4c1adccf', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 06:04:25.000021', 2, '--', '', '');
INSERT INTO public.venta VALUES ('c0e65171-277c-4b4a-9939-9df9e37bf9b7', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-18 02:56:29.000224', 2, '--', '', '');
INSERT INTO public.venta VALUES ('1fbfa0aa-35a8-4598-88c8-cbba602aa21f', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-16 18:21:43.000111', 2, '--', '', '');
INSERT INTO public.venta VALUES ('e2fbc860-57e1-4f1f-9c8d-b348673f5930', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 02:14:48.000684', 2, '--', '', '');
INSERT INTO public.venta VALUES ('deb00d61-7282-4f8a-aaeb-74e25ede1a10', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 01:00:39.000915', 2, '--', '', '');
INSERT INTO public.venta VALUES ('b64695b9-b47d-4984-ae6e-b5c6d330a771', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-08-17 23:20:17.000466', 2, '--', '', '');
INSERT INTO public.venta VALUES ('146e0032-e144-4717-8571-381db2a1b9fa', 'a6f432b0-5e80-4c23-8fdb-d9833ce4aeb4', '2022-09-14 16:00:01.0008', 1, '--', '1234557', 'Hincha');
INSERT INTO public.venta VALUES ('4f6194b7-550e-4d23-bfaa-1fad235ee8b7', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 16:00:53.000877', 2, '--', '1525225', 'jhincha');
INSERT INTO public.venta VALUES ('77c663d4-7dbb-46e0-b188-fdcd97b6a5bb', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:05:43.000023', 1, '--', '255582', 'hincha');
INSERT INTO public.venta VALUES ('049e0e51-6161-447a-a693-88c2d7b0100d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-14 20:08:40.000782', 1, '--', '255652', 'hincha');
INSERT INTO public.venta VALUES ('59693d5a-347d-40b7-8a22-5ab295ad4933', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000637', 1, '--', '25625632', 'hincha oriente');
INSERT INTO public.venta VALUES ('282e00a9-da49-46db-9f53-9655ca1ab347', '33f74fe3-c666-49a6-a646-25f3bff7feda', '2022-09-14 21:43:17.000695', 2, '--', '25625632', 'hincha oriente');
INSERT INTO public.venta VALUES ('1ecba9f1-1a36-4841-9c80-2fd9cf74c64c', '637a70ce-98a4-4060-820d-b7bf567cb04c', '2022-09-16 20:12:14.000704', 2, '--', '25365', 'hincha');
INSERT INTO public.venta VALUES ('8a866c5d-c75f-4d6d-9528-78450ce14dab', 'f2726451-5bdd-443a-8c88-c2461ed8b1d3', '2022-09-16 22:19:09.000235', 2, '--', '25336223', 'hincha a  muerte');
INSERT INTO public.venta VALUES ('1760ea8e-4b1a-4b59-b3e5-a640b9b98a5a', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 03:24:34.000079', 1, '--', '', 'feedgfdx');
INSERT INTO public.venta VALUES ('7c7b65e5-ef3b-4cef-935d-760650dc4105', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 03:30:52.00069', 2, '--', '', '');
INSERT INTO public.venta VALUES ('e3d4df43-7d61-45ee-abc9-73f032a96341', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:31:14.000003', 2, '--', '34234', '2sdfsfsd  sf ds');
INSERT INTO public.venta VALUES ('d40e5306-6a92-42bf-afe6-fa68a19ec4fd', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:36:22.000282', 2, '--', '324234', 'sdfs fsd fs');
INSERT INTO public.venta VALUES ('319c2af5-1bf3-4656-b144-41ce7f43eb5e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 04:54:46.000836', 2, '--', '32423423', 'sdfsdf dsf sdf');
INSERT INTO public.venta VALUES ('c8213451-e478-4d1a-b056-947f9113e611', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:00:22.000334', 1, '--', '2555252', 'hincha');
INSERT INTO public.venta VALUES ('2fe724df-9549-4cf0-8bb3-388400773da7', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:01:03.000671', 2, '--', '2522552', 'incha');
INSERT INTO public.venta VALUES ('bc5a977c-0802-4bc8-8c75-dc353375b8c5', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-20 05:03:55.000014', 2, '--', '', '');
INSERT INTO public.venta VALUES ('67509e02-f921-4ced-a687-a53acd5a7163', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:05:42.000862', 2, '--', '', '');
INSERT INTO public.venta VALUES ('e5cea307-d6c5-4e0b-bfcf-d26b3329b00c', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:09:34.000237', 2, '--', '', '');
INSERT INTO public.venta VALUES ('e2b7b24c-bb85-45c8-bfe9-abe1382833d5', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:11:19.000021', 2, '--', '', '');
INSERT INTO public.venta VALUES ('10875ac4-9a09-40cc-8ec1-23f8d0426cc5', '3a4f30ff-2bd5-490d-8d31-d419ab44f64f', '2022-09-20 05:22:06.000309', 2, '--', '25856', '63265');
INSERT INTO public.venta VALUES ('3cc10cfb-7efa-40ff-bfad-7a93386d703e', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:35:26.000404', 2, '--', '', '');
INSERT INTO public.venta VALUES ('6741fcdf-d2d9-41a1-add5-a557d4ae6ea1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:37:05.000364', 1, '--', '', '');
INSERT INTO public.venta VALUES ('99beddff-e788-4b45-b28a-cf29ee34420d', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:38:47.000065', 1, '--', '', '');
INSERT INTO public.venta VALUES ('c8e3eb41-14d8-41ac-b640-473c203982ce', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:39:23.000433', 1, '--', '', '');
INSERT INTO public.venta VALUES ('91fd6d78-cece-45cc-a3ee-83f6d524f164', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:40:20.000745', 1, '--', '', '');
INSERT INTO public.venta VALUES ('c4728bcc-885c-4f2e-b44a-b82acd026fa1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:41:44.000808', 1, '--', '', '');
INSERT INTO public.venta VALUES ('716878db-d007-4ded-acd0-3caa0692c753', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:42:48.000088', 1, '--', '', '');
INSERT INTO public.venta VALUES ('caa9cfd2-ffe4-4824-8020-8cb899646ea8', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:06.000872', 1, '--', '', '');
INSERT INTO public.venta VALUES ('9332c544-50e8-4704-9224-999ce112e534', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:15.000543', 1, '--', '', '');
INSERT INTO public.venta VALUES ('d5801199-29ae-4de0-958e-31416b00cbd9', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:43:28.000311', 1, '--', '', '');
INSERT INTO public.venta VALUES ('52045121-3f63-4d4a-ad27-268d80d4cf23', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-22 23:44:00.000774', 2, '--', '', '');
INSERT INTO public.venta VALUES ('cecddda1-470f-4563-b98e-8a37c75c91e6', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:16:33.00035', 2, '--', '', '');
INSERT INTO public.venta VALUES ('b491c0dd-85a1-4ddb-a0e2-3c44e6f2fd24', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:19:38.000665', 2, '--', '', '');
INSERT INTO public.venta VALUES ('64bb4add-f006-4042-8fd9-80ab16566d61', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:42:41.000211', 2, '--', 'sadd3', 'dd w w wd');
INSERT INTO public.venta VALUES ('2019c7e2-54f3-4437-a32c-e6d5e8a037aa', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:45:21.000963', 2, '--', '6757657', 'hiuh hu hiu i');
INSERT INTO public.venta VALUES ('b9b6019b-33db-4329-ba42-20d60eb44f4b', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:46:56.000722', 2, '--', '564765', 'jdsbkj k sdsf');
INSERT INTO public.venta VALUES ('aee8322f-e288-48d1-bb85-2b3a936022d1', 'cfd50919-1381-4b93-adbf-b443e7307461', '2022-09-23 00:53:54.000281', 2, '--', '324324', 'asd das dasd');


--
-- TOC entry 2896 (class 2606 OID 16423)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (key);


--
-- TOC entry 2899 (class 2606 OID 16425)
-- Name: orden_pago orden_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_pago
    ADD CONSTRAINT orden_pago_pkey PRIMARY KEY (key);


--
-- TOC entry 2902 (class 2606 OID 16427)
-- Name: sector sector_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT sector_pkey PRIMARY KEY (key);


--
-- TOC entry 2906 (class 2606 OID 16429)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (key);


--
-- TOC entry 2908 (class 2606 OID 16467)
-- Name: usuario uniq_correo_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT uniq_correo_usuario UNIQUE (correo);


--
-- TOC entry 2910 (class 2606 OID 16431)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (key);


--
-- TOC entry 2912 (class 2606 OID 16433)
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (key);


--
-- TOC entry 2900 (class 1259 OID 16434)
-- Name: fki_fk_key_evento_sector; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_key_evento_sector ON public.sector USING btree (key_evento);


--
-- TOC entry 2903 (class 1259 OID 16435)
-- Name: fki_fk_key_sector_ticket; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_key_sector_ticket ON public.ticket USING btree (key_sector);


--
-- TOC entry 2897 (class 1259 OID 16437)
-- Name: fki_fk_key_venta_orden_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_key_venta_orden_pago ON public.orden_pago USING btree (key_venta);


--
-- TOC entry 2904 (class 1259 OID 16438)
-- Name: fki_fk_key_venta_ticket; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_key_venta_ticket ON public.ticket USING btree (key_venta);


--
-- TOC entry 3047 (class 2618 OID 16556)
-- Name: view_venta_detalle _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.view_venta_detalle AS
 SELECT venta.key,
    venta.key_usuario,
    venta.fecha_on,
    venta.estado,
    venta.codigo,
    venta.nit,
    venta.razon_social,
    sum(sq_ticket.precio) AS total,
    count(sq_ticket.key) AS cantidad,
    array_to_json(array_agg(sq_ticket.*)) AS detalle
   FROM public.venta,
    ( SELECT ticket.key,
            ticket.key_usuario,
            ticket.fecha_on,
            ticket.estado,
            ticket.key_sector,
            ticket.key_venta,
            ticket.descripcion,
            sector.precio
           FROM public.ticket,
            public.sector
          WHERE ((ticket.key_sector)::text = (sector.key)::text)) sq_ticket
  WHERE ((venta.key)::text = (sq_ticket.key_venta)::text)
  GROUP BY venta.key;


--
-- TOC entry 3049 (class 2618 OID 41085)
-- Name: ventas_por_sector _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.ventas_por_sector AS
 SELECT sector.key,
    evento.descripcion AS nombre_evento,
    sector.nombre AS nombre_sector,
    sector.precio,
    sector.capacidad,
    sum(sector.precio) AS total_pagado,
    count(sector.precio) AS cantidad_entradas
   FROM public.venta,
    public.ticket,
    public.sector,
    public.evento
  WHERE ((venta.estado = 2) AND ((venta.key)::text = (ticket.key_venta)::text) AND ((sector.key)::text = (ticket.key_sector)::text) AND ((evento.key)::text = (sector.key_evento)::text))
  GROUP BY evento.key, sector.key;


--
-- TOC entry 3050 (class 2618 OID 41095)
-- Name: view_sector _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.view_sector AS
 SELECT sector.key,
    sector.key_usuario,
    sector.fecha_on,
    sector.estado,
    sector.key_evento,
    sector.nombre,
    sector.precio,
    sector.capacidad,
    count(venta.key) AS vendidas
   FROM ((public.sector
     LEFT JOIN public.ticket ON (((sector.key)::text = (ticket.key_sector)::text)))
     LEFT JOIN ( SELECT venta_1.key,
            venta_1.key_usuario,
            venta_1.fecha_on,
            venta_1.estado,
            venta_1.codigo,
            venta_1.nit,
            venta_1.razon_social
           FROM public.venta venta_1
          WHERE (venta_1.estado = 2)) venta ON (((venta.key)::text = (ticket.key_venta)::text)))
  GROUP BY sector.key;


--
-- TOC entry 2914 (class 2606 OID 16439)
-- Name: sector fk_key_evento_sector; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector
    ADD CONSTRAINT fk_key_evento_sector FOREIGN KEY (key_evento) REFERENCES public.evento(key) NOT VALID;


--
-- TOC entry 2915 (class 2606 OID 16444)
-- Name: ticket fk_key_sector_ticket; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_key_sector_ticket FOREIGN KEY (key_sector) REFERENCES public.sector(key) NOT VALID;


--
-- TOC entry 2913 (class 2606 OID 16454)
-- Name: orden_pago fk_key_venta_orden_pago; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orden_pago
    ADD CONSTRAINT fk_key_venta_orden_pago FOREIGN KEY (key_venta) REFERENCES public.venta(key) NOT VALID;


--
-- TOC entry 2916 (class 2606 OID 16459)
-- Name: ticket fk_key_venta_ticket; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_key_venta_ticket FOREIGN KEY (key_venta) REFERENCES public.venta(key) NOT VALID;


-- Completed on 2022-09-23 01:31:06 -04

--
-- PostgreSQL database dump complete
--

