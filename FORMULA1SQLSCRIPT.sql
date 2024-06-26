--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-02 23:15:44

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
-- TOC entry 260 (class 1255 OID 99404)
-- Name: agregarequipo(integer, character varying, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregarequipo(IN p_idequipo integer, IN p_nombre character varying, IN p_paisdeorigen integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Equipos (idEquipo, nombre, paisDeOrigen)
    VALUES (p_idEquipo, p_nombre, p_paisDeOrigen);
END;
$$;


ALTER PROCEDURE public.agregarequipo(IN p_idequipo integer, IN p_nombre character varying, IN p_paisdeorigen integer) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 99403)
-- Name: agregarpiloto(integer, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.agregarpiloto(IN p_idpersona integer, IN p_nombre character varying, IN p_correoelectronico character varying, IN p_telefono character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

    INSERT INTO Personas (idPersona, nombre, correoElectronico, teléfono)
    VALUES (p_idPersona, p_nombre, p_correoElectronico, p_telefono);

    INSERT INTO Pilotos (idPersona)
    VALUES (p_idPersona);
END;
$$;


ALTER PROCEDURE public.agregarpiloto(IN p_idpersona integer, IN p_nombre character varying, IN p_correoelectronico character varying, IN p_telefono character varying) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 99429)
-- Name: carrodepiloto(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.carrodepiloto(id_piloto integer, id_carrera integer) RETURNS TABLE(nombre_equipo character varying, peso_vehiculo double precision, dureza_neumatico character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    SELECT EQUIPOS.NOMBRE, VEHICULOS.PESO, TIPOSDENEUMATICOS.DUREZA
    FROM PARTICIPACIONES
    JOIN VEHICULOS ON VEHICULOS.IDVEHICULO = PARTICIPACIONES.IDVEHICULO
    JOIN TIPOSDENEUMATICOS ON TIPOSDENEUMATICOS.IDTIPODENEUMATICO = VEHICULOS.IDTIPODENEUMATICO
    JOIN EQUIPOS ON EQUIPOS.IDEQUIPO = VEHICULOS.IDEQUIPO
    WHERE PARTICIPACIONES.idpersona = id_Piloto AND PARTICIPACIONES.idcarrera = id_carrera;
end;
$$;


ALTER FUNCTION public.carrodepiloto(id_piloto integer, id_carrera integer) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 99399)
-- Name: numsanciones(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numsanciones(idpiloto integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
    countSanciones int;
begin
    select count(public.sanciones.idsancion) into countSanciones
    from personas
    join participaciones on participaciones.idpersona = personas.idpersona
    join vueltas on vueltas.idparticipacion = participaciones.idparticipacion
    join sancionesvueltas on sancionesvueltas.idvuelta = vueltas.idvuelta
    join sanciones on sancionesvueltas.idsancion = sanciones.idsancion
    where personas.idpersona = idPiloto;

    return countSanciones;

end;
$$;


ALTER FUNCTION public.numsanciones(idpiloto integer) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 99402)
-- Name: obtenerequiposporpais(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtenerequiposporpais(countryname character varying) RETURNS TABLE(idequipo integer, nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT e.idEquipo, e.nombre
    FROM Equipos e
    JOIN Paises p ON e.paisDeOrigen = p.idPais
    WHERE p.nombre = countryName;
END;
$$;


ALTER FUNCTION public.obtenerequiposporpais(countryname character varying) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 99433)
-- Name: obtenerrankingdecarrera(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtenerrankingdecarrera(id_carrera integer) RETURNS TABLE(id_participacion integer, tiempo_total interval, ranking integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        PARTICIPACIONES.IDPARTICIPACION, 
        TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) AS tiempo_total,
        CAST(DENSE_RANK() OVER (ORDER BY TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) ASC) AS INT) AS ranking
    FROM PARTICIPACIONES 
    JOIN CARRERAS ON CARRERAS.IDCARRERA = PARTICIPACIONES.IDCARRERA
    WHERE CARRERAS.IDCARRERA = id_carrera
    ORDER BY TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) ASC;
END;
$$;


ALTER FUNCTION public.obtenerrankingdecarrera(id_carrera integer) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 99432)
-- Name: tiempodetodaslasvueltas(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tiempodetodaslasvueltas(id_participacion integer) RETURNS interval
    LANGUAGE plpgsql
    AS $$
DECLARE
    tiempototalV INTERVAL;
BEGIN
    SELECT SUM(COALESCE(VUELTAS.tiempo, '00:00:00'::INTERVAL) + COALESCE(SANCIONES.penalizacion, '00:00:00'::INTERVAL)) AS TiempoTotal
    INTO tiempototalV
    FROM PARTICIPACIONES 
    LEFT JOIN VUELTAS ON VUELTAS.IDPARTICIPACION = PARTICIPACIONES.IDPARTICIPACION
    LEFT JOIN SANCIONESVUELTAS ON SANCIONESVUELTAS.IDVUELTA = VUELTAS.IDVUELTA
    LEFT JOIN SANCIONES ON SANCIONES.IDSANCION = SANCIONESVUELTAS.IDSANCION
    WHERE PARTICIPACIONES.IDPARTICIPACION = id_participacion;
    
    RETURN tiempototalV;
END;
$$;


ALTER FUNCTION public.tiempodetodaslasvueltas(id_participacion integer) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 99400)
-- Name: totaltiempopenalizado(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.totaltiempopenalizado(idpilotop integer, idtemporadap integer) RETURNS time without time zone
    LANGUAGE plpgsql
    AS $$
declare
    tiempo_penalizado time;
begin
        select sum(public.sanciones.penalizacion) into tiempo_penalizado
        from personas
        join participaciones on participaciones.idpersona = personas.idpersona
        join carreras on carreras.idcarrera = participaciones.idcarrera
        join grandespremios on grandespremios.idgranpremio = carreras.idgranpremio
        join temporadas on temporadas.idtemporada = grandespremios.idtemporada
        join vueltas on vueltas.idparticipacion = participaciones.idparticipacion
        join sancionesvueltas on sancionesvueltas.idvuelta = vueltas.idvuelta
        join sanciones on sancionesvueltas.idsancion = sanciones.idsancion
        where personas.idpersona = idPilotop and temporadas.idtemporada=idTemporadap;

        return tiempo_penalizado;
end;
$$;


ALTER FUNCTION public.totaltiempopenalizado(idpilotop integer, idtemporadap integer) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 99401)
-- Name: verificarvehiculoequipo(double precision, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verificarvehiculoequipo(peso double precision, numerovalvulas integer, neumatico character varying, ciguenal character varying, arbollevas character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
    if peso >= 798 and numeroValvulas = 24 and ciguenal in ('Acero', 'Aluminio') and arbollevas in ('Acero', 'Aluminio')  and neumatico in ('DURO', 'MEDIO', 'SUAVE') then
        return 'Vehiculo permitido por la FIA';
    else
        return 'Vehículo no permitido por la FIA';
    end if;
end;
$$;


ALTER FUNCTION public.verificarvehiculoequipo(peso double precision, numerovalvulas integer, neumatico character varying, ciguenal character varying, arbollevas character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 241 (class 1259 OID 99334)
-- Name: accidentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accidentes (
    idaccidente integer NOT NULL,
    idvuelta integer NOT NULL,
    causa character varying(100),
    consecuencias character varying(255)
);


ALTER TABLE public.accidentes OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 99121)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    idcargo integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 99242)
-- Name: carreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carreras (
    idcarrera integer NOT NULL,
    idgranpremio integer NOT NULL,
    idtipodecarrera integer,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);


ALTER TABLE public.carreras OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 99282)
-- Name: carrerasclasificatorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrerasclasificatorias (
    idcarrera integer NOT NULL,
    idtipodeclasificacion integer NOT NULL
);


ALTER TABLE public.carrerasclasificatorias OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 99257)
-- Name: carreraslibres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carreraslibres (
    idcarrera integer NOT NULL
);


ALTER TABLE public.carreraslibres OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 99267)
-- Name: carrerasprincipales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrerasprincipales (
    idcarrera integer NOT NULL
);


ALTER TABLE public.carrerasprincipales OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 99212)
-- Name: circuitos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.circuitos (
    idcircuito integer NOT NULL,
    idciudad integer NOT NULL,
    nombre character varying(100),
    longitud double precision NOT NULL
);


ALTER TABLE public.circuitos OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 99071)
-- Name: ciudades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudades (
    idciudad integer NOT NULL,
    idpais integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.ciudades OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 99081)
-- Name: equipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipos (
    idequipo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    paisdeorigen integer NOT NULL
);


ALTER TABLE public.equipos OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 99141)
-- Name: haceparte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.haceparte (
    idhaceparte integer NOT NULL,
    idequipo integer NOT NULL,
    idpersona integer NOT NULL,
    idcargo integer NOT NULL,
    fechaingreso date NOT NULL,
    fechasalida date
);


ALTER TABLE public.haceparte OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 99091)
-- Name: patrocinadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patrocinadores (
    idpatrocinador integer NOT NULL,
    nombre character varying(55) NOT NULL
);


ALTER TABLE public.patrocinadores OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 99101)
-- Name: patrocinadoresequipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patrocinadoresequipos (
    idequipo integer NOT NULL,
    idpatrocinador integer NOT NULL,
    idtemporada integer NOT NULL,
    montopatrocinio double precision,
    tipodepatrocinio character varying(55)
);


ALTER TABLE public.patrocinadoresequipos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 99096)
-- Name: temporadas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temporadas (
    idtemporada integer NOT NULL,
    fechadeinicio date NOT NULL,
    fechadefin date NOT NULL
);


ALTER TABLE public.temporadas OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 99418)
-- Name: equipostemporada; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.equipostemporada AS
 SELECT e.nombre AS equiponombre,
    count(hp.idpersona) AS numerointegrantes,
    p.nombre AS patrocinadornombre,
    t.idtemporada AS temporadaid
   FROM ((((public.equipos e
     JOIN public.haceparte hp ON ((e.idequipo = hp.idequipo)))
     JOIN public.patrocinadoresequipos pe ON ((e.idequipo = pe.idequipo)))
     JOIN public.patrocinadores p ON ((pe.idpatrocinador = p.idpatrocinador)))
     JOIN public.temporadas t ON ((pe.idtemporada = t.idtemporada)))
  GROUP BY e.nombre, p.nombre, t.idtemporada;


ALTER VIEW public.equipostemporada OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 99126)
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personas (
    idpersona integer NOT NULL,
    nombre character varying(150) NOT NULL,
    correoelectronico character varying(255) NOT NULL,
    "teléfono" character varying(15)
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 99166)
-- Name: pilotosestadopilotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pilotosestadopilotos (
    idestadopiloto integer NOT NULL,
    idpersona integer NOT NULL,
    idtipoestadopiloto integer NOT NULL,
    fechadeinicio date,
    fechadefin date
);


ALTER TABLE public.pilotosestadopilotos OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 99161)
-- Name: tiposestadospiloto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiposestadospiloto (
    idtipoestadopiloto integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tiposestadospiloto OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 99438)
-- Name: estadosdepilotos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.estadosdepilotos AS
 SELECT personas.nombre AS piloto,
    tiposestadospiloto.nombre AS estado,
    pilotosestadopilotos.fechadeinicio,
    pilotosestadopilotos.fechadefin
   FROM ((public.pilotosestadopilotos
     JOIN public.tiposestadospiloto ON ((tiposestadospiloto.idtipoestadopiloto = pilotosestadopilotos.idtipoestadopiloto)))
     JOIN public.personas ON ((personas.idpersona = pilotosestadopilotos.idpersona)));


ALTER VIEW public.estadosdepilotos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 99222)
-- Name: grandespremios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grandespremios (
    idgranpremio integer NOT NULL,
    idtemporada integer NOT NULL,
    idcircuito integer NOT NULL,
    nombre character varying(100) NOT NULL,
    fechainicio date NOT NULL,
    fechafinalizacion date NOT NULL
);


ALTER TABLE public.grandespremios OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 99409)
-- Name: infoequipos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.infoequipos AS
 SELECT p.nombre AS "Nombre",
    c.nombre AS "Cargo",
    eq.nombre AS "Equipo"
   FROM (((public.haceparte hc
     JOIN public.personas p ON ((hc.idpersona = p.idpersona)))
     JOIN public.equipos eq ON ((hc.idequipo = eq.idequipo)))
     JOIN public.cargos c ON ((hc.idcargo = c.idcargo)));


ALTER VIEW public.infoequipos OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 99434)
-- Name: lesionesdepilotos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.lesionesdepilotos AS
 SELECT personas.nombre AS piloto,
    tiposestadospiloto.nombre AS estado,
    pilotosestadopilotos.fechadeinicio,
    pilotosestadopilotos.fechadefin
   FROM ((public.pilotosestadopilotos
     JOIN public.tiposestadospiloto ON ((tiposestadospiloto.idtipoestadopiloto = pilotosestadopilotos.idtipoestadopiloto)))
     JOIN public.personas ON ((personas.idpersona = pilotosestadopilotos.idpersona)));


ALTER VIEW public.lesionesdepilotos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 99181)
-- Name: motores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motores (
    idmotor integer NOT NULL,
    marca character varying(55) NOT NULL,
    numerodevalvulas integer NOT NULL,
    modelo character varying(55) NOT NULL,
    materialdelciguenal character varying(55) NOT NULL,
    materialarbollevas character varying(55) NOT NULL
);


ALTER TABLE public.motores OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 99066)
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paises (
    idpais integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 99405)
-- Name: nombrepaiscompeticion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.nombrepaiscompeticion AS
 SELECT gp.nombre AS "Gran Premio",
    ps.nombre AS "Pais"
   FROM (((public.grandespremios gp
     JOIN public.circuitos ct ON ((ct.idcircuito = gp.idcircuito)))
     JOIN public.ciudades cd ON ((cd.idciudad = ct.idciudad)))
     JOIN public.paises ps ON ((cd.idpais = ps.idpais)));


ALTER VIEW public.nombrepaiscompeticion OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 99374)
-- Name: noticias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.noticias (
    idnoticia integer NOT NULL,
    autor character varying(100) NOT NULL,
    titulo character varying(100) NOT NULL,
    noticia character varying(255) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);


ALTER TABLE public.noticias OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 99344)
-- Name: paradaenboxes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paradaenboxes (
    idparadaenbox integer NOT NULL,
    idvuelta integer NOT NULL,
    duracion interval,
    serviciosrealizados character varying(255)
);


ALTER TABLE public.paradaenboxes OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 99302)
-- Name: participaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participaciones (
    idparticipacion integer NOT NULL,
    idvehiculo integer NOT NULL,
    idcarrera integer NOT NULL,
    idpersona integer NOT NULL,
    posiciondesalida integer NOT NULL,
    posiciondellegada integer NOT NULL
);


ALTER TABLE public.participaciones OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 99131)
-- Name: pilotos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pilotos (
    idpersona integer NOT NULL
);


ALTER TABLE public.pilotos OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 99192)
-- Name: vehiculos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehiculos (
    idvehiculo integer NOT NULL,
    idtipodemotor integer NOT NULL,
    idtipodeneumatico integer NOT NULL,
    idequipo integer NOT NULL,
    peso double precision NOT NULL,
    modelo character varying(100) NOT NULL,
    marca character varying(100) NOT NULL
);


ALTER TABLE public.vehiculos OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 99413)
-- Name: pilotocarreralibre; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.pilotocarreralibre AS
 SELECT p.nombre AS pilotonombre,
    e.nombre AS equiponombre,
    c.hora AS tiempo
   FROM ((((((public.personas p
     JOIN public.pilotos pi ON ((p.idpersona = pi.idpersona)))
     JOIN public.participaciones pa ON ((pi.idpersona = pa.idpersona)))
     JOIN public.vehiculos v ON ((pa.idvehiculo = v.idvehiculo)))
     JOIN public.equipos e ON ((v.idequipo = e.idequipo)))
     JOIN public.carreras c ON ((pa.idcarrera = c.idcarrera)))
     JOIN public.carreraslibres cl ON ((c.idcarrera = cl.idcarrera)));


ALTER VIEW public.pilotocarreralibre OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 99379)
-- Name: plataformas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataformas (
    idplataforma integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.plataformas OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 99384)
-- Name: plataformascarreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataformascarreras (
    idplataformascarreras integer NOT NULL,
    audencia bigint NOT NULL,
    idplataforma integer NOT NULL,
    idcarrera integer NOT NULL
);


ALTER TABLE public.plataformascarreras OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 99297)
-- Name: puntajes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.puntajes (
    idpuntaje integer NOT NULL,
    posicion integer,
    puntaje integer
);


ALTER TABLE public.puntajes OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 99354)
-- Name: sanciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sanciones (
    idsancion integer NOT NULL,
    descripcion character varying(255),
    penalizacion interval NOT NULL
);


ALTER TABLE public.sanciones OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 99359)
-- Name: sancionesvueltas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sancionesvueltas (
    idsancionvuelta integer NOT NULL,
    idvuelta integer NOT NULL,
    idsancion integer NOT NULL
);


ALTER TABLE public.sancionesvueltas OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 99324)
-- Name: vueltas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vueltas (
    idvuelta integer NOT NULL,
    idparticipacion integer NOT NULL,
    tiempo interval NOT NULL
);


ALTER TABLE public.vueltas OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 99423)
-- Name: sancionespilotoscarrera; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sancionespilotoscarrera AS
 SELECT p.nombre AS pilotonombre,
    c.fecha AS carrerafecha,
    s.descripcion AS sanciondescripcion
   FROM ((((((public.pilotos pi
     JOIN public.personas p ON ((pi.idpersona = p.idpersona)))
     JOIN public.participaciones pa ON ((pi.idpersona = pa.idpersona)))
     JOIN public.vueltas v ON ((pa.idparticipacion = v.idparticipacion)))
     JOIN public.sancionesvueltas sv ON ((v.idvuelta = sv.idvuelta)))
     JOIN public.sanciones s ON ((sv.idsancion = s.idsancion)))
     JOIN public.carreras c ON ((pa.idcarrera = c.idcarrera)));


ALTER VIEW public.sancionespilotoscarrera OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 99237)
-- Name: tiposdecarreras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiposdecarreras (
    idtipodecarrera integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.tiposdecarreras OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 99277)
-- Name: tiposdeclasificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiposdeclasificacion (
    idtipodeclasificacion integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.tiposdeclasificacion OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 99186)
-- Name: tiposdeneumaticos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiposdeneumaticos (
    idtipodeneumatico integer NOT NULL,
    dureza character varying(20),
    CONSTRAINT tiposdeneumaticos_dureza_check CHECK (((dureza)::text = ANY ((ARRAY['DURO'::character varying, 'MEDIO'::character varying, 'SUAVE'::character varying])::text[])))
);


ALTER TABLE public.tiposdeneumaticos OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 99334)
-- Dependencies: 241
-- Data for Name: accidentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accidentes (idaccidente, idvuelta, causa, consecuencias) FROM stdin;
1	765	Fallo mecánico	Daños leves en el vehículo
2	432	Condiciones climáticas adversas	Ninguna
3	217	Error humano	Lesiones leves en el conductor
4	891	Fallo mecánico	Daños moderados en el vehículo
5	589	Error humano	Ninguna
6	312	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
7	479	Fallo mecánico	Ninguna
8	723	Error humano	Daños leves en el vehículo
9	145	Condiciones climáticas adversas	Daños leves en el vehículo
10	689	Error humano	Ninguna
11	531	Fallo mecánico	Daños graves en el vehículo
12	819	Condiciones de la carretera	Lesiones graves en el conductor
13	276	Fallo mecánico	Daños leves en el vehículo
14	647	Error humano	Ninguna
15	982	Condiciones climáticas adversas	Ninguna
16	124	Fallo mecánico	Daños moderados en el vehículo
17	764	Error humano	Lesiones graves en el conductor
18	382	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
19	591	Fallo mecánico	Daños leves en el vehículo
20	845	Error humano	Ninguna
21	217	Condiciones climáticas adversas	Daños leves en el vehículo
22	738	Error humano	Daños leves en el vehículo
23	432	Condiciones de la carretera	Daños moderados en el vehículo
24	965	Fallo mecánico	Ninguna
25	308	Error humano	Daños leves en el vehículo
26	621	Condiciones climáticas adversas	Ninguna
27	154	Fallo mecánico	Daños leves en el vehículo
28	799	Error humano	Ninguna
29	432	Condiciones de la carretera	Daños moderados en el vehículo
30	589	Fallo mecánico	Daños graves en el vehículo
31	871	Error humano	Lesiones leves en el conductor
32	267	Condiciones climáticas adversas	Ninguna
33	423	Fallo mecánico	Daños moderados en el vehículo
34	748	Error humano	Ninguna
35	124	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
36	512	Fallo mecánico	Daños leves en el vehículo
37	936	Error humano	Daños leves en el vehículo
38	198	Condiciones climáticas adversas	Daños leves en el vehículo
39	603	Fallo mecánico	Ninguna
40	895	Error humano	Ninguna
41	329	Condiciones de la carretera	Daños graves en el vehículo
42	726	Fallo mecánico	Daños leves en el vehículo
43	569	Error humano	Daños leves en el vehículo
44	133	Condiciones climáticas adversas	Ninguna
45	812	Fallo mecánico	Daños moderados en el vehículo
46	417	Error humano	Lesiones graves en el conductor
47	689	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
48	942	Fallo mecánico	Daños leves en el vehículo
49	238	Error humano	Daños leves en el vehículo
50	539	Condiciones climáticas adversas	Daños leves en el vehículo
51	691	Fallo mecánico	Daños graves en el vehículo
52	843	Error humano	Ninguna
53	327	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
54	579	Fallo mecánico	Ninguna
55	721	Error humano	Daños leves en el vehículo
56	157	Condiciones climáticas adversas	Ninguna
57	896	Fallo mecánico	Daños leves en el vehículo
58	429	Error humano	Daños leves en el vehículo
59	672	Condiciones de la carretera	Ninguna
60	942	Fallo mecánico	Daños moderados en el vehículo
61	587	Error humano	Lesiones graves en el conductor
62	376	Condiciones climáticas adversas	Daños leves en el vehículo
63	762	Fallo mecánico	Daños leves en el vehículo
64	189	Error humano	Ninguna
65	572	Condiciones de la carretera	Daños moderados en el vehículo
66	834	Fallo mecánico	Daños graves en el vehículo y lesiones en el conductor
67	251	Error humano	Daños leves en el vehículo
68	459	Condiciones climáticas adversas	Daños leves en el vehículo
69	699	Fallo mecánico	Ninguna
70	913	Error humano	Daños leves en el vehículo
71	357	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
72	623	Fallo mecánico	Daños moderados en el vehículo
73	189	Error humano	Ninguna
74	479	Condiciones climáticas adversas	Ninguna
75	872	Fallo mecánico	Daños leves en el vehículo
76	238	Error humano	Daños leves en el vehículo
77	617	Condiciones de la carretera	Daños moderados en el vehículo
78	791	Fallo mecánico	Daños graves en el vehículo y lesiones en el conductor
79	156	Error humano	Ninguna
80	449	Condiciones climáticas adversas	Daños leves en el vehículo
81	712	Fallo mecánico	Ninguna
82	298	Error humano	Daños leves en el vehículo
83	537	Condiciones de la carretera	Daños moderados en el vehículo
84	684	Fallo mecánico	Daños graves en el vehículo y lesiones en el conductor
85	179	Error humano	Ninguna
86	629	Condiciones climáticas adversas	Ninguna
87	751	Fallo mecánico	Daños leves en el vehículo
88	392	Error humano	Daños leves en el vehículo
89	548	Condiciones de la carretera	Daños moderados en el vehículo
90	783	Fallo mecánico	Ninguna
91	287	Error humano	Daños leves en el vehículo
92	639	Condiciones climáticas adversas	Daños leves en el vehículo
93	854	Fallo mecánico	Daños moderados en el vehículo
94	176	Error humano	Ninguna
95	542	Condiciones de la carretera	Daños graves en el vehículo y lesiones en el conductor
96	791	Fallo mecánico	Daños leves en el vehículo
97	269	Error humano	Ninguna
98	632	Condiciones climáticas adversas	Daños leves en el vehículo
99	926	Fallo mecánico	Daños moderados en el vehículo
100	317	Error humano	Daños leves en el vehículo
\.


--
-- TOC entry 5056 (class 0 OID 99121)
-- Dependencies: 221
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (idcargo, nombre) FROM stdin;
1	Piloto
2	Ingeniero de pista
3	Ingeniero de aerodinámica
4	Mecánico
5	Director técnico
6	Director de equipo
\.


--
-- TOC entry 5068 (class 0 OID 99242)
-- Dependencies: 233
-- Data for Name: carreras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carreras (idcarrera, idgranpremio, idtipodecarrera, fecha, hora) FROM stdin;
30	1	1	2020-03-23	14:00:00
35	2	1	2020-03-26	14:00:00
40	3	1	2020-03-29	14:00:00
45	4	1	2020-03-29	14:00:00
50	5	1	2020-04-04	14:00:00
55	6	1	2021-03-31	14:00:00
60	7	1	2021-04-03	14:00:00
5	8	1	2021-04-06	14:00:00
65	9	1	2021-04-09	14:00:00
10	10	1	2021-04-12	14:00:00
15	11	1	2022-03-29	14:00:00
70	12	1	2022-03-01	14:00:00
20	13	1	2022-04-04	14:00:00
80	15	1	2022-04-10	14:00:00
85	16	1	2023-03-29	14:00:00
25	17	1	2023-04-01	14:00:00
90	18	1	2023-04-04	14:00:00
95	19	1	2023-04-07	14:00:00
100	20	1	2023-04-10	14:00:00
105	21	1	2024-03-27	14:00:00
110	22	1	2024-03-30	14:00:00
115	23	1	2024-03-30	14:00:00
120	24	1	2024-04-05	14:00:00
125	25	1	2024-04-08	14:00:00
26	1	2	2020-03-20	10:00:00
31	2	2	2020-03-23	10:00:00
36	3	2	2020-03-26	10:00:00
41	4	2	2020-03-26	10:00:00
46	5	2	2020-04-01	10:00:00
51	6	2	2021-03-28	10:00:00
56	7	2	2021-03-31	10:00:00
1	8	2	2021-04-03	14:00:00
61	9	2	2021-04-06	10:00:00
6	10	2	2021-04-09	14:00:00
11	11	2	2022-03-26	14:00:00
66	12	2	2022-03-29	10:00:00
16	13	2	2022-04-01	14:00:00
76	15	2	2022-04-07	10:00:00
81	16	2	2023-03-26	10:00:00
21	17	2	2023-03-29	14:00:00
86	18	2	2023-04-01	10:00:00
91	19	2	2023-04-04	10:00:00
96	20	2	2023-04-07	10:00:00
101	21	2	2024-03-24	10:00:00
106	22	2	2024-03-27	10:00:00
111	23	2	2024-03-27	10:00:00
116	24	2	2024-04-02	10:00:00
121	25	2	2024-04-05	10:00:00
27	1	3	2020-03-21	14:00:00
28	1	3	2020-03-22	10:00:00
29	1	3	2020-03-22	14:00:00
32	2	3	2020-03-24	14:00:00
33	2	3	2020-03-25	10:00:00
34	2	3	2020-03-25	14:00:00
37	3	3	2020-03-27	14:00:00
38	3	3	2020-03-28	10:00:00
39	3	3	2020-03-28	14:00:00
42	4	3	2020-03-27	14:00:00
43	4	3	2020-03-28	10:00:00
44	4	3	2020-03-28	14:00:00
47	5	3	2020-04-02	14:00:00
48	5	3	2020-04-03	10:00:00
49	5	3	2020-04-03	14:00:00
52	6	3	2021-03-29	14:00:00
53	6	3	2021-03-30	10:00:00
54	6	3	2021-03-30	14:00:00
57	7	3	2021-04-01	14:00:00
58	7	3	2021-04-02	10:00:00
59	7	3	2021-04-02	14:00:00
2	8	3	2021-04-03	10:00:00
3	8	3	2021-04-04	10:00:00
4	8	3	2021-04-05	10:00:00
62	9	3	2021-04-07	14:00:00
63	9	3	2021-04-08	10:00:00
64	9	3	2021-04-08	14:00:00
7	10	3	2021-04-09	10:00:00
8	10	3	2021-04-10	10:00:00
9	10	3	2021-04-11	10:00:00
12	11	3	2022-03-26	10:00:00
13	11	3	2022-03-27	10:00:00
14	11	3	2022-03-28	10:00:00
67	12	3	2022-03-30	14:00:00
68	12	3	2022-03-31	10:00:00
69	12	3	2022-03-31	14:00:00
17	13	3	2022-04-01	10:00:00
18	13	3	2022-04-02	10:00:00
19	13	3	2022-04-03	10:00:00
77	15	3	2022-04-08	14:00:00
78	15	3	2022-04-09	10:00:00
79	15	3	2022-04-09	14:00:00
82	16	3	2023-03-27	14:00:00
83	16	3	2023-03-28	10:00:00
84	16	3	2023-03-28	14:00:00
22	17	3	2023-03-29	10:00:00
23	17	3	2023-03-30	10:00:00
24	17	3	2023-03-31	10:00:00
87	18	3	2023-04-02	14:00:00
88	18	3	2023-04-03	10:00:00
89	18	3	2023-04-03	14:00:00
92	19	3	2023-04-05	14:00:00
93	19	3	2023-04-06	10:00:00
94	19	3	2023-04-06	14:00:00
97	20	3	2023-04-08	14:00:00
98	20	3	2023-04-09	10:00:00
99	20	3	2023-04-09	14:00:00
102	21	3	2024-03-25	14:00:00
103	21	3	2024-03-26	10:00:00
104	21	3	2024-03-26	14:00:00
107	22	3	2024-03-28	14:00:00
108	22	3	2024-03-29	10:00:00
109	22	3	2024-03-29	14:00:00
112	23	3	2024-03-28	14:00:00
113	23	3	2024-03-29	10:00:00
114	23	3	2024-03-29	14:00:00
117	24	3	2024-04-03	14:00:00
118	24	3	2024-04-04	10:00:00
119	24	3	2024-04-04	14:00:00
122	25	3	2024-04-06	14:00:00
123	25	3	2024-04-07	10:00:00
124	25	3	2024-04-07	14:00:00
\.


--
-- TOC entry 5072 (class 0 OID 99282)
-- Dependencies: 237
-- Data for Name: carrerasclasificatorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrerasclasificatorias (idcarrera, idtipodeclasificacion) FROM stdin;
27	1
28	2
29	3
32	1
33	2
34	3
37	1
38	2
39	3
42	1
43	2
44	3
47	1
48	2
49	3
52	1
53	2
54	3
57	1
58	2
59	3
2	1
3	2
4	3
62	1
63	2
64	3
7	1
8	2
9	3
12	1
13	2
14	3
67	1
68	2
69	3
17	1
18	2
19	3
77	1
78	2
79	3
82	1
83	2
84	3
22	1
23	2
24	3
87	1
88	2
89	3
92	1
93	2
94	3
97	1
98	2
99	3
102	1
103	2
104	3
107	1
108	2
109	3
112	1
113	2
114	3
117	1
118	2
119	3
122	1
123	2
124	3
\.


--
-- TOC entry 5069 (class 0 OID 99257)
-- Dependencies: 234
-- Data for Name: carreraslibres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carreraslibres (idcarrera) FROM stdin;
26
31
36
41
46
51
56
1
61
6
11
66
16
76
81
21
86
91
96
101
106
111
116
121
\.


--
-- TOC entry 5070 (class 0 OID 99267)
-- Dependencies: 235
-- Data for Name: carrerasprincipales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrerasprincipales (idcarrera) FROM stdin;
30
35
40
45
50
55
60
5
65
10
15
70
20
80
85
25
90
95
100
105
110
115
120
125
\.


--
-- TOC entry 5065 (class 0 OID 99212)
-- Dependencies: 230
-- Data for Name: circuitos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.circuitos (idcircuito, idciudad, nombre, longitud) FROM stdin;
1	1	Circuito de Buenos Aires	4.3
2	2	Circuito de Cordoba	3.8
3	3	Autodromo de Interlagos	4.3
4	4	Circuito de Rio de Janeiro	4
5	5	Circuito de Santiago	3.2
6	6	Circuito de Valparaiso	3.7
8	8	Circuito de Medellin	3.5
9	9	Autodromo Hermanos Rodriguez	4.3
10	10	Circuito de Guadalajara	3.8
12	12	Circuito de Cusco	3.6
13	13	Autodromo de El Pinar	3.1
14	14	Circuito de Punta del Este	3.4
15	15	Autodromo de Caracas	3.2
16	16	Circuito de Maracaibo	3.9
17	17	Circuito del Jarama	3.9
18	18	Circuito de Montmelo	4.7
19	19	Circuito de Nevers Magny-Cours	4.4
20	20	Circuito de Paul Ricard	5.8
7	7	Autodromo de Tocancipa	3.2
11	11	Autodromo de La Chutana	3.2
21	7	Circuito de lenis	2
22	4	Circuito de simon bolivar	2.5
\.


--
-- TOC entry 5051 (class 0 OID 99071)
-- Dependencies: 216
-- Data for Name: ciudades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudades (idciudad, idpais, nombre) FROM stdin;
1	1	Buenos Aires
2	1	Cordoba
3	2	Sao Paulo
4	2	Rio de Janeiro
5	3	Santiago
6	3	Valparaiso
7	4	Bogota
8	4	Medellin
9	5	Ciudad de Mexico
10	5	Guadalajara
11	6	Lima
12	6	Cusco
13	7	Montevideo
14	7	Punta del Este
15	8	Caracas
16	8	Maracaibo
17	9	Madrid
18	9	Barcelona
19	10	Paris
20	10	Lyon
\.


--
-- TOC entry 5052 (class 0 OID 99081)
-- Dependencies: 217
-- Data for Name: equipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipos (idequipo, nombre, paisdeorigen) FROM stdin;
1	Equipo Gauchos Racing	1
2	Equipo Samba Racing	2
3	Equipo Andes F1	3
4	Equipo Cafe Colombiano F1	4
5	Equipo Tequila Sunrise F1	5
6	Equipo Inca F1	6
7	Equipo Charrua F1	7
8	Equipo Bolivar F1	8
9	Equipo Toro Espanol F1	9
10	Equipo Baguette Racing	10
11	Equipo Tango F1	1
12	Equipo Bossa Nova F1	2
13	Equipo Pisco F1	6
\.


--
-- TOC entry 5066 (class 0 OID 99222)
-- Dependencies: 231
-- Data for Name: grandespremios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grandespremios (idgranpremio, idtemporada, idcircuito, nombre, fechainicio, fechafinalizacion) FROM stdin;
1	1	9	Gran Premio de Mexico	2020-03-20	2020-03-23
2	1	8	Gran Premio de Colombia	2020-03-23	2020-03-26
3	1	7	Gran Premio de Colombia	2020-03-26	2020-03-29
4	1	6	Gran Premio de Chile	2020-03-29	2020-04-01
5	1	5	Gran Premio de Chile	2020-04-01	2020-04-04
6	2	11	Gran Premio de Peru	2021-03-28	2021-03-31
7	2	12	Gran Premio de Peru	2021-03-31	2021-04-03
8	2	13	Gran Premio de Uruguay	2021-04-03	2021-04-06
9	2	14	Gran Premio de Uruguay	2021-04-06	2021-04-09
10	2	15	Gran Premio de Venezuela	2021-04-09	2021-04-12
11	3	20	Gran Premio de Francia	2022-03-26	2022-03-29
12	3	19	Gran Premio de Francia	2022-03-29	2022-04-01
13	3	18	Gran Premio de Espana	2022-04-01	2022-04-04
14	3	17	Gran Premio de Espana	2022-04-04	2022-04-07
15	3	16	Gran Premio de Venezuela	2022-04-07	2022-04-10
16	4	15	Gran Premio de Venezuela	2023-03-26	2023-03-29
17	4	5	Gran Premio de Chile	2023-03-29	2023-04-01
18	4	4	Gran Premio de Brasil	2023-04-01	2023-04-04
19	4	3	Gran Premio de Brasil	2023-04-04	2023-04-07
20	4	2	Gran Premio de Argentina	2023-04-07	2023-04-10
21	5	1	Gran Premio de Argentina	2024-03-24	2024-03-27
22	5	3	Gran Premio de Brasil	2024-03-27	2024-03-30
23	5	6	Gran Premio de Chile	2024-03-30	2024-04-02
24	5	8	Gran Premio de Colombia	2024-04-02	2024-04-05
25	5	10	Gran Premio de Mexico	2024-04-05	2024-04-08
\.


--
-- TOC entry 5059 (class 0 OID 99141)
-- Dependencies: 224
-- Data for Name: haceparte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.haceparte (idhaceparte, idequipo, idpersona, idcargo, fechaingreso, fechasalida) FROM stdin;
1	1	1	1	2019-01-01	\N
2	1	2	1	2019-01-01	\N
3	1	3	4	2019-01-01	\N
4	1	4	4	2019-01-01	\N
5	1	5	5	2019-01-01	\N
6	2	6	1	2019-01-01	\N
7	2	7	1	2019-01-01	\N
8	2	8	4	2019-01-01	\N
9	2	9	4	2019-01-01	\N
10	2	10	5	2019-01-01	\N
11	3	11	1	2019-01-01	\N
12	3	12	1	2019-01-01	\N
13	3	13	4	2019-01-01	\N
14	3	14	4	2019-01-01	\N
15	3	15	5	2019-01-01	\N
16	4	16	1	2019-01-01	\N
17	4	17	1	2019-01-01	\N
18	4	18	4	2019-01-01	\N
19	4	19	4	2019-01-01	\N
20	4	20	5	2019-01-01	\N
21	5	21	1	2019-01-01	\N
22	5	22	1	2019-01-01	\N
23	5	23	4	2019-01-01	\N
24	5	24	4	2019-01-01	\N
25	5	25	5	2019-01-01	\N
26	6	26	1	2019-01-01	\N
27	6	27	1	2019-01-01	\N
28	6	28	4	2019-01-01	\N
29	6	29	4	2019-01-01	\N
30	6	30	5	2019-01-01	\N
31	7	31	1	2019-01-01	\N
32	7	32	1	2019-01-01	\N
33	7	33	4	2019-01-01	\N
34	7	34	4	2019-01-01	\N
35	7	35	5	2019-01-01	\N
36	8	36	1	2019-01-01	\N
37	8	37	1	2019-01-01	\N
38	8	38	4	2019-01-01	\N
39	8	39	4	2019-01-01	\N
40	8	40	5	2019-01-01	\N
41	9	41	1	2019-01-01	\N
42	9	42	1	2019-01-01	\N
43	9	43	4	2019-01-01	\N
44	9	44	4	2019-01-01	\N
45	9	45	5	2019-01-01	\N
46	10	46	1	2019-01-01	\N
47	10	47	1	2019-01-01	\N
48	10	48	4	2019-01-01	\N
49	10	49	4	2019-01-01	\N
50	10	50	5	2019-01-01	\N
51	11	51	1	2019-01-01	\N
52	11	52	1	2019-01-01	\N
53	11	53	4	2019-01-01	\N
54	11	54	4	2019-01-01	\N
55	11	55	5	2019-01-01	\N
56	12	56	1	2019-01-01	\N
57	12	57	1	2019-01-01	\N
58	12	58	4	2019-01-01	\N
59	12	59	4	2019-01-01	\N
60	12	60	5	2019-01-01	\N
61	13	61	1	2019-01-01	\N
62	13	62	1	2019-01-01	\N
63	13	63	4	2019-01-01	\N
64	13	64	4	2019-01-01	\N
65	13	65	5	2019-01-01	\N
\.


--
-- TOC entry 5062 (class 0 OID 99181)
-- Dependencies: 227
-- Data for Name: motores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motores (idmotor, marca, numerodevalvulas, modelo, materialdelciguenal, materialarbollevas) FROM stdin;
1	Mercedes	24	AMG F1 M12	Acero	Titanio
2	Honda	24	RA620H	Acero	Titanio
3	Ferrari	24	065/6	Acero	Titanio
4	Renault	24	E-Tech 20B	Acero	Titanio
5	Mercedes	24	AMG F1 M12	Acero	Titanio
6	Honda	24	RA620H	Acero	Titanio
7	Mercedes	24	AMG F1 M12	Acero	Titanio
8	Mercedes	24	AMG F1 M12	Acero	Titanio
9	Ferrari	24	065/6	Acero	Titanio
10	Ferrari	24	065/6	Acero	Titanio
\.


--
-- TOC entry 5080 (class 0 OID 99374)
-- Dependencies: 245
-- Data for Name: noticias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.noticias (idnoticia, autor, titulo, noticia, fecha, hora) FROM stdin;
1	Juan Pérez	Lewis Hamilton gana el Gran Premio de Mónaco	El piloto británico Lewis Hamilton, de la escudería Mercedes, logra una emocionante victoria en el circuito urbano de Mónaco.	2024-05-20	15:30:00
2	María Gómez	Red Bull presenta mejoras en su chasis	La escudería Red Bull Racing presenta mejoras en su chasis en un intento por aumentar su competitividad en el Campeonato Mundial de Fórmula 1.	2024-05-21	10:45:00
3	Carlos López	Ferrari anuncia cambios en su alineación de pilotos	La escudería Ferrari anuncia cambios en su alineación de pilotos para la próxima temporada, con el objetivo de mejorar sus resultados en pista.	2024-05-22	09:15:00
4	Ana Rodríguez	McLaren revela diseño de su nuevo monoplaza	La escudería McLaren muestra el diseño de su nuevo monoplaza para la temporada 2025 de Fórmula 1, con un enfoque en la aerodinámica y la eficiencia.	2024-05-23	11:00:00
5	Pedro Martínez	Sebastian Vettel anuncia su retirada de la Fórmula 1	El piloto alemán Sebastian Vettel anuncia su retirada de la Fórmula 1 al final de la presente temporada, tras una exitosa carrera de más de 15 años en la categoría.	2024-05-24	14:20:00
6	Laura Fernández	AlphaTauri firma contrato con joven promesa	El equipo AlphaTauri anuncia la firma de un contrato con una joven promesa del automovilismo, quien debutará en la Fórmula 1 en la próxima temporada.	2024-05-25	08:55:00
7	David Gutiérrez	Mercedes domina los primeros entrenamientos libres en Silverstone	El equipo Mercedes AMG Petronas Formula One Team muestra su superioridad al liderar los tiempos en los primeros entrenamientos libres del Gran Premio de Gran Bretaña.	2024-05-26	10:30:00
8	Elena Ramírez	Renault anuncia asociación estratégica con fabricante de motores	La escudería Renault anuncia una asociación estratégica con un destacado fabricante de motores para mejorar el rendimiento de sus unidades de potencia en la Fórmula 1.	2024-05-27	13:45:00
9	Javier González	FIA introduce nuevas regulaciones de seguridad	La Federación Internacional del Automóvil (FIA) anuncia la introducción de nuevas regulaciones de seguridad en la Fórmula 1, enfocadas en la protección de los pilotos y la mejora de la seguridad en pista.	2024-05-28	09:00:00
10	Sofía Pérez	Alpine revela detalles de su programa de desarrollo de jóvenes pilotos	El equipo Alpine F1 Team detalla su programa de desarrollo de jóvenes pilotos, con el objetivo de identificar y cultivar el talento de las futuras estrellas de la Fórmula 1.	2024-05-29	12:10:00
\.


--
-- TOC entry 5050 (class 0 OID 99066)
-- Dependencies: 215
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paises (idpais, nombre) FROM stdin;
1	Argentina
2	Brasil
3	Chile
4	Colombia
5	Mexico
6	Peru
7	Uruguay
8	Venezuela
9	Espana
10	Francia
\.


--
-- TOC entry 5077 (class 0 OID 99344)
-- Dependencies: 242
-- Data for Name: paradaenboxes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paradaenboxes (idparadaenbox, idvuelta, duracion, serviciosrealizados) FROM stdin;
1	1	00:00:13	Cambio de neumáticos
2	2	00:00:08	Repostaje de combustible
3	3	00:00:16	Ajuste de alerones
4	4	00:00:09	Revisión general
5	5	00:00:11	Cambio de frenos
6	6	00:00:07	Limpieza de parabrisas
7	7	00:00:14	Cambio de neumáticos
8	8	00:00:05	Repostaje de combustible
9	9	00:00:19	Ajuste de alerones
10	10	00:00:06	Revisión general
11	11	00:00:11	Cambio de neumáticos
12	12	00:00:05	Repostaje de combustible
13	13	00:00:10	Ajuste de alerones
14	14	00:00:03	Revisión general
15	15	00:00:18	Cambio de frenos
16	16	00:00:07	Limpieza de parabrisas
17	17	00:00:12	Cambio de neumáticos
18	18	00:00:15	Repostaje de combustible
19	19	00:00:09	Ajuste de alerones
20	20	00:00:14	Revisión general
21	21	00:00:06	Cambio de frenos
22	22	00:00:13	Limpieza de parabrisas
23	23	00:00:08	Cambio de neumáticos
24	24	00:00:16	Repostaje de combustible
25	25	00:00:04	Ajuste de alerones
26	26	00:00:17	Revisión general
27	27	00:00:02	Cambio de frenos
28	28	00:00:11	Limpieza de parabrisas
29	29	00:00:19	Cambio de neumáticos
30	30	00:00:01	Repostaje de combustible
31	31	00:00:05	Ajuste de alerones
32	32	00:00:12	Revisión general
33	33	00:00:03	Cambio de frenos
34	34	00:00:15	Limpieza de parabrisas
35	35	00:00:10	Cambio de neumáticos
36	36	00:00:07	Repostaje de combustible
37	37	00:00:09	Ajuste de alerones
38	38	00:00:14	Revisión general
39	39	00:00:06	Cambio de frenos
40	40	00:00:13	Limpieza de parabrisas
41	41	00:00:08	Cambio de neumáticos
42	42	00:00:16	Repostaje de combustible
43	43	00:00:04	Ajuste de alerones
44	44	00:00:17	Revisión general
45	45	00:00:02	Cambio de frenos
46	46	00:00:11	Limpieza de parabrisas
47	47	00:00:19	Cambio de neumáticos
48	48	00:00:01	Repostaje de combustible
49	49	00:00:05	Ajuste de alerones
50	50	00:00:12	Revisión general
51	51	00:00:03	Cambio de frenos
52	52	00:00:15	Limpieza de parabrisas
53	53	00:00:10	Cambio de neumáticos
54	54	00:00:07	Repostaje de combustible
55	55	00:00:09	Ajuste de alerones
56	56	00:00:14	Revisión general
57	57	00:00:06	Cambio de frenos
58	58	00:00:13	Limpieza de parabrisas
59	59	00:00:08	Cambio de neumáticos
60	60	00:00:16	Repostaje de combustible
61	61	00:00:04	Ajuste de alerones
62	62	00:00:17	Revisión general
63	63	00:00:02	Cambio de frenos
64	64	00:00:11	Limpieza de parabrisas
65	65	00:00:19	Cambio de neumáticos
66	66	00:00:01	Repostaje de combustible
67	67	00:00:05	Ajuste de alerones
68	68	00:00:12	Revisión general
69	69	00:00:03	Cambio de frenos
70	70	00:00:15	Limpieza de parabrisas
71	71	00:00:10	Cambio de neumáticos
72	72	00:00:07	Repostaje de combustible
73	73	00:00:09	Ajuste de alerones
74	74	00:00:14	Revisión general
75	75	00:00:06	Cambio de frenos
76	76	00:00:13	Limpieza de parabrisas
77	77	00:00:08	Cambio de neumáticos
78	78	00:00:16	Repostaje de combustible
79	79	00:00:04	Ajuste de alerones
80	80	00:00:17	Revisión general
81	81	00:00:02	Cambio de frenos
82	82	00:00:11	Limpieza de parabrisas
83	83	00:00:19	Cambio de neumáticos
84	84	00:00:01	Repostaje de combustible
85	85	00:00:05	Ajuste de alerones
86	86	00:00:12	Revisión general
87	87	00:00:03	Cambio de frenos
88	88	00:00:15	Limpieza de parabrisas
89	89	00:00:10	Cambio de neumáticos
90	90	00:00:07	Repostaje de combustible
91	91	00:00:09	Ajuste de alerones
92	92	00:00:14	Revisión general
93	93	00:00:06	Cambio de frenos
94	94	00:00:13	Limpieza de parabrisas
95	95	00:00:08	Cambio de neumáticos
96	96	00:00:16	Repostaje de combustible
97	97	00:00:04	Ajuste de alerones
98	98	00:00:17	Revisión general
99	99	00:00:02	Cambio de frenos
100	100	00:00:11	Limpieza de parabrisas
101	101	00:00:13	Cambio de neumáticos
102	102	00:00:08	Repostaje de combustible
103	103	00:00:16	Ajuste de alerones
104	104	00:00:09	Revisión general
105	105	00:00:11	Cambio de frenos
106	106	00:00:07	Limpieza de parabrisas
107	107	00:00:14	Cambio de neumáticos
108	108	00:00:05	Repostaje de combustible
109	109	00:00:19	Ajuste de alerones
110	110	00:00:06	Revisióngeneral
111	111	00:00:13	Cambio de frenos
112	112	00:00:08	Limpieza de parabrisas
113	113	00:00:16	Cambio de neumáticos
114	114	00:00:09	Repostaje de combustible
115	115	00:00:11	Ajuste de alerones
116	116	00:00:07	Revisión general
117	117	00:00:14	Cambio de frenos
118	118	00:00:05	Limpieza de parabrisas
119	119	00:00:19	Cambio de neumáticos
120	120	00:00:06	Repostaje de combustible
121	121	00:00:13	Ajuste de alerones
122	122	00:00:08	Revisión general
123	123	00:00:16	Cambio de frenos
124	124	00:00:09	Limpieza de parabrisas
125	125	00:00:11	Cambio de neumáticos
126	126	00:00:07	Repostaje de combustible
127	127	00:00:14	Ajuste de alerones
128	128	00:00:05	Revisión general
129	129	00:00:19	Cambio de frenos
130	130	00:00:06	Limpieza de parabrisas
131	131	00:00:13	Cambio de neumáticos
132	132	00:00:08	Repostaje de combustible
133	133	00:00:16	Ajuste de alerones
134	134	00:00:09	Revisión general
135	135	00:00:11	Cambio de frenos
136	136	00:00:07	Limpieza de parabrisas
137	137	00:00:14	Cambio de neumáticos
138	138	00:00:05	Repostaje de combustible
139	139	00:00:19	Ajuste de alerones
140	140	00:00:06	Revisión general
141	141	00:00:13	Cambio de frenos
142	142	00:00:08	Limpieza de parabrisas
143	143	00:00:16	Cambio de neumáticos
144	144	00:00:09	Repostaje de combustible
145	145	00:00:11	Ajuste de alerones
146	146	00:00:07	Revisión general
147	147	00:00:14	Cambio de frenos
148	148	00:00:05	Limpieza de parabrisas
149	149	00:00:19	Cambio de neumáticos
150	150	00:00:06	Repostaje de combustible
151	151	00:00:13	Ajuste de alerones
152	152	00:00:08	Revisión general
153	153	00:00:16	Cambio de frenos
154	154	00:00:09	Limpieza de parabrisas
155	155	00:00:11	Cambio de neumáticos
156	156	00:00:07	Repostaje de combustible
157	157	00:00:14	Ajuste de alerones
158	158	00:00:05	Revisión general
159	159	00:00:19	Cambio de frenos
160	160	00:00:06	Limpieza de parabrisas
161	161	00:00:13	Cambio de neumáticos
162	162	00:00:08	Repostaje de combustible
163	163	00:00:16	Ajuste de alerones
164	164	00:00:09	Revisión general
165	165	00:00:11	Cambio de frenos
166	166	00:00:07	Limpieza de parabrisas
167	167	00:00:14	Cambio de neumáticos
168	168	00:00:05	Repostaje de combustible
169	169	00:00:19	Ajuste de alerones
170	170	00:00:06	Revisión general
171	171	00:00:13	Cambio de frenos
172	172	00:00:08	Limpieza de parabrisas
173	173	00:00:16	Cambio de neumáticos
174	174	00:00:09	Repostaje de combustible
175	175	00:00:11	Ajuste de alerones
176	176	00:00:07	Revisión general
177	177	00:00:14	Cambio de frenos
178	178	00:00:05	Limpieza de parabrisas
179	179	00:00:19	Cambio de neumáticos
180	180	00:00:06	Repostaje de combustible
181	181	00:00:13	Ajuste de alerones
182	182	00:00:08	Revisión general
183	183	00:00:16	Cambio de frenos
184	184	00:00:09	Limpieza de parabrisas
185	185	00:00:11	Cambio de neumáticos
186	186	00:00:07	Repostaje de combustible
187	187	00:00:14	Ajuste de alerones
188	188	00:00:05	Revisión general
189	189	00:00:19	Cambio de frenos
190	190	00:00:06	Limpieza de parabrisas
191	191	00:00:13	Cambio de neumáticos
192	192	00:00:08	Repostaje de combustible
193	193	00:00:16	Ajuste de alerones
194	194	00:00:09	Revisión general
195	195	00:00:11	Cambio de frenos
196	196	00:00:07	Limpieza de parabrisas
197	197	00:00:14	Cambio de neumáticos
198	198	00:00:05	Repostaje de combustible
199	199	00:00:19	Ajuste de alerones
200	200	00:00:06	Revisión general
201	201	00:00:13	Cambio de frenos
202	202	00:00:08	Limpieza de parabrisas
203	203	00:00:16	Cambio de neumáticos
204	204	00:00:09	Repostaje de combustible
205	205	00:00:11	Ajuste de alerones
206	206	00:00:07	Revisión general
207	207	00:00:14	Cambio de frenos
208	208	00:00:05	Limpieza de parabrisas
209	209	00:00:19	Cambio de neumáticos
210	210	00:00:06	Repostaje de combustible
211	211	00:00:13	Ajuste de alerones
212	212	00:00:08	Revisión general
213	213	00:00:16	Cambio de frenos
214	214	00:00:09	Limpieza de parabrisas
215	215	00:00:11	Cambio de neumáticos
216	216	00:00:07	Repostaje de combustible
217	217	00:00:14	Ajuste de alerones
218	218	00:00:05	Revisión general
219	219	00:00:19	Cambio de frenos
220	220	00:00:06	Limpieza de parabrisas
221	221	00:00:13	Cambio de neumáticos
222	222	00:00:08	Repostaje de combustible
223	223	00:00:16	Ajuste de alerones
224	224	00:00:09	Revisión general
225	225	00:00:11	Cambio de frenos
226	226	00:00:07	Limpieza de parabrisas
227	227	00:00:14	Cambio de neumáticos
228	228	00:00:05	Repostaje de combustible
229	229	00:00:19	Ajuste de alerones
230	230	00:00:06	Revisión general
231	231	00:00:13	Cambio de frenos
232	232	00:00:08	Limpieza de parabrisas
233	233	00:00:16	Cambio de neumáticos
234	234	00:00:09	Repostaje de combustible
235	235	00:00:11	Ajuste de alerones
236	236	00:00:07	Revisión general
237	237	00:00:14	Cambio de frenos
238	238	00:00:05	Limpieza de parabrisas
239	239	00:00:19	Cambio de neumáticos
240	240	00:00:06	Repostaje de combustible
241	241	00:00:13	Ajuste de alerones
242	242	00:00:08	Revisión general
243	243	00:00:16	Cambio de frenos
244	244	00:00:09	Limpieza de parabrisas
245	245	00:00:11	Cambio de neumáticos
246	246	00:00:07	Repostaje de combustible
247	247	00:00:14	Ajuste de alerones
248	248	00:00:05	Revisión general
249	249	00:00:19	Cambio de frenos
250	250	00:00:06	Limpieza de parabrisas
251	251	00:00:13	Cambio de neumáticos
252	252	00:00:08	Repostaje de combustible
253	253	00:00:16	Ajuste de alerones
254	254	00:00:09	Revisión general
255	255	00:00:11	Cambio de frenos
256	256	00:00:07	Limpieza de parabrisas
257	257	00:00:14	Cambio de neumáticos
258	258	00:00:05	Repostaje de combustible
259	259	00:00:19	Ajuste de alerones
260	260	00:00:06	Revisión general
261	261	00:00:13	Cambio de frenos
262	262	00:00:08	Limpieza de parabrisas
263	263	00:00:16	Cambio de neumáticos
264	264	00:00:09	Repostaje de combustible
265	265	00:00:11	Ajuste de alerones
266	266	00:00:07	Revisión general
267	267	00:00:14	Cambio de frenos
268	268	00:00:05	Limpieza de parabrisas
269	269	00:00:19	Cambio de neumáticos
270	270	00:00:06	Repostaje de combustible
271	271	00:00:13	Ajuste de alerones
272	272	00:00:08	Revisión general
273	273	00:00:16	Cambio de frenos
274	274	00:00:09	Limpieza de parabrisas
275	275	00:00:11	Cambio de neumáticos
276	276	00:00:07	Repostaje de combustible
277	277	00:00:14	Ajuste de alerones
278	278	00:00:05	Revisión general
279	279	00:00:19	Cambio de frenos
280	280	00:00:06	Limpieza de parabrisas
281	281	00:00:13	Cambio de neumáticos
282	282	00:00:08	Repostaje de combustible
283	283	00:00:16	Ajuste de alerones
284	284	00:00:09	Revisión general
285	285	00:00:11	Cambio de frenos
286	286	00:00:07	Limpieza de parabrisas
287	287	00:00:14	Cambio de neumáticos
288	288	00:00:05	Repostaje de combustible
289	289	00:00:19	Ajuste de alerones
290	290	00:00:06	Revisión general
291	291	00:00:13	Cambio de frenos
292	292	00:00:08	Limpieza de parabrisas
293	293	00:00:16	Cambio de neumáticos
294	294	00:00:09	Repostaje de combustible
295	295	00:00:11	Ajuste de alerones
296	296	00:00:07	Revisión general
297	297	00:00:14	Cambio de frenos
298	298	00:00:05	Limpieza de parabrisas
299	299	00:00:19	Cambio de neumáticos
300	300	00:00:06	Repostaje de combustible
301	301	00:00:13	Ajuste de alerones
302	302	00:00:08	Revisión general
303	303	00:00:16	Cambio de frenos
304	304	00:00:09	Limpieza de parabrisas
305	305	00:00:11	Cambio de neumáticos
306	306	00:00:07	Repostaje de combustible
307	307	00:00:14	Ajuste de alerones
308	308	00:00:05	Revisión general
309	309	00:00:19	Cambio de frenos
310	310	00:00:06	Limpieza de parabrisas
311	311	00:00:13	Cambio de neumáticos
312	312	00:00:08	Repostaje de combustible
313	313	00:00:16	Ajuste de alerones
314	314	00:00:09	Revisión general
315	315	00:00:11	Cambio de frenos
316	316	00:00:07	Limpieza de parabrisas
317	317	00:00:14	Cambio de neumáticos
318	318	00:00:05	Repostaje de combustible
319	319	00:00:19	Ajuste de alerones
320	320	00:00:06	Revisión general
321	321	00:00:13	Cambio de frenos
322	322	00:00:08	Limpieza de parabrisas
323	323	00:00:16	Cambio de neumáticos
324	324	00:00:09	Repostaje de combustible
325	325	00:00:11	Ajuste de alerones
326	326	00:00:07	Revisión general
327	327	00:00:14	Cambio de frenos
328	328	00:00:05	Limpieza de parabrisas
329	329	00:00:19	Cambio de neumáticos
330	330	00:00:06	Repostaje de combustible
331	331	00:00:13	Ajuste de alerones
332	332	00:00:08	Revisión general
333	333	00:00:16	Cambio de frenos
334	334	00:00:09	Limpieza de parabrisas
335	335	00:00:11	Cambio de neumáticos
336	336	00:00:07	Repostaje de combustible
337	337	00:00:14	Ajuste de alerones
338	338	00:00:05	Revisión general
339	339	00:00:19	Cambio de frenos
340	340	00:00:06	Limpieza de parabrisas
341	341	00:00:13	Cambio de neumáticos
342	342	00:00:08	Repostaje de combustible
343	343	00:00:16	Ajuste de alerones
344	344	00:00:09	Revisión general
345	345	00:00:11	Cambio de frenos
346	346	00:00:07	Limpieza de parabrisas
347	347	00:00:14	Cambio de neumáticos
348	348	00:00:05	Repostaje de combustible
349	349	00:00:19	Ajuste de alerones
350	350	00:00:06	Revisión general
351	351	00:00:13	Cambio de frenos
352	352	00:00:08	Limpieza de parabrisas
353	353	00:00:16	Cambio de neumáticos
354	354	00:00:09	Repostaje de combustible
355	355	00:00:11	Ajuste de alerones
356	356	00:00:07	Revisión general
357	357	00:00:14	Cambio de frenos
358	358	00:00:05	Limpieza de parabrisas
359	359	00:00:19	Cambio de neumáticos
360	360	00:00:06	Repostaje de combustible
361	361	00:00:13	Ajuste de alerones
362	362	00:00:08	Revisión general
363	363	00:00:16	Cambio de frenos
364	364	00:00:09	Limpieza de parabrisas
365	365	00:00:11	Cambio de neumáticos
366	366	00:00:07	Repostaje de combustible
367	367	00:00:14	Ajuste de alerones
368	368	00:00:05	Revisión general
369	369	00:00:19	Cambio de frenos
370	370	00:00:06	Limpieza de parabrisas
371	371	00:00:13	Cambio de neumáticos
372	372	00:00:08	Repostaje de combustible
373	373	00:00:16	Ajuste de alerones
374	374	00:00:09	Revisión general
375	375	00:00:11	Cambio de frenos
376	376	00:00:07	Limpieza de parabrisas
377	377	00:00:14	Cambio de neumáticos
378	378	00:00:05	Repostaje de combustible
379	379	00:00:19	Ajuste de alerones
380	380	00:00:06	Revisión general
381	381	00:00:13	Cambio de frenos
382	382	00:00:08	Limpieza de parabrisas
383	383	00:00:16	Cambio de neumáticos
384	384	00:00:09	Repostaje de combustible
385	385	00:00:11	Ajuste de alerones
386	386	00:00:07	Revisión general
387	387	00:00:14	Cambio de frenos
388	388	00:00:05	Limpieza de parabrisas
389	389	00:00:19	Cambio de neumáticos
390	390	00:00:06	Repostaje de combustible
391	391	00:00:13	Ajuste de alerones
392	392	00:00:08	Revisión general
393	393	00:00:16	Cambio de frenos
394	394	00:00:09	Limpieza de parabrisas
395	395	00:00:11	Cambio de neumáticos
396	396	00:00:07	Repostaje de combustible
397	397	00:00:14	Ajuste de alerones
398	398	00:00:05	Revisión general
399	399	00:00:19	Cambio de frenos
400	400	00:00:06	Limpieza de parabrisas
401	401	00:00:13	Cambio de neumáticos
402	402	00:00:08	Repostaje de combustible
403	403	00:00:16	Ajuste de alerones
404	404	00:00:09	Revisión general
405	405	00:00:11	Cambio de frenos
406	406	00:00:07	Limpieza de parabrisas
407	407	00:00:14	Cambio de neumáticos
408	408	00:00:05	Repostaje de combustible
409	409	00:00:19	Ajuste de alerones
410	410	00:00:06	Revisión general
411	411	00:00:13	Cambio de frenos
412	412	00:00:08	Limpieza de parabrisas
413	413	00:00:16	Cambio de neumáticos
414	414	00:00:09	Repostaje de combustible
415	415	00:00:11	Ajuste de alerones
416	416	00:00:07	Revisión general
417	417	00:00:14	Cambio de frenos
418	418	00:00:05	Limpieza de parabrisas
419	419	00:00:19	Cambio de neumáticos
420	420	00:00:06	Repostaje de combustible
421	421	00:00:13	Ajuste de alerones
422	422	00:00:08	Revisión general
423	423	00:00:16	Cambio de frenos
424	424	00:00:09	Limpieza de parabrisas
425	425	00:00:11	Cambio de neumáticos
426	426	00:00:07	Repostaje de combustible
427	427	00:00:14	Ajuste de alerones
428	428	00:00:05	Revisión general
429	429	00:00:19	Cambio de frenos
430	430	00:00:06	Limpieza de parabrisas
431	431	00:00:13	Cambio de neumáticos
432	432	00:00:08	Repostaje de combustible
433	433	00:00:16	Ajuste de alerones
434	434	00:00:09	Revisión general
435	435	00:00:11	Cambio de frenos
436	436	00:00:07	Limpieza de parabrisas
437	437	00:00:14	Cambio de neumáticos
438	438	00:00:05	Repostaje de combustible
439	439	00:00:19	Ajuste de alerones
440	440	00:00:06	Revisión general
441	441	00:00:13	Cambio de frenos
442	442	00:00:08	Limpieza de parabrisas
443	443	00:00:16	Cambio de neumáticos
444	444	00:00:09	Repostaje de combustible
445	445	00:00:11	Ajuste de alerones
446	446	00:00:07	Revisión general
447	447	00:00:14	Cambio de frenos
448	448	00:00:05	Limpieza de parabrisas
449	449	00:00:19	Cambio de neumáticos
450	450	00:00:06	Repostaje de combustible
451	451	00:00:13	Ajuste de alerones
452	452	00:00:08	Revisión general
453	453	00:00:16	Cambio de frenos
454	454	00:00:09	Limpieza de parabrisas
455	455	00:00:11	Cambio de neumáticos
456	456	00:00:07	Repostaje de combustible
457	457	00:00:14	Ajuste de alerones
458	458	00:00:05	Revisión general
459	459	00:00:19	Cambio de frenos
460	460	00:00:06	Limpieza de parabrisas
461	461	00:00:13	Cambio de neumáticos
462	462	00:00:08	Repostaje de combustible
463	463	00:00:16	Ajuste de alerones
464	464	00:00:09	Revisión general
465	465	00:00:11	Cambio de frenos
466	466	00:00:07	Limpieza de parabrisas
467	467	00:00:14	Cambio de neumáticos
468	468	00:00:05	Repostaje de combustible
469	469	00:00:19	Ajuste de alerones
470	470	00:00:06	Revisión general
471	471	00:00:13	Cambio de frenos
472	472	00:00:08	Limpieza de parabrisas
473	473	00:00:16	Cambio de neumáticos
474	474	00:00:09	Repostaje de combustible
475	475	00:00:11	Ajuste de alerones
476	476	00:00:07	Revisión general
477	477	00:00:14	Cambio de frenos
478	478	00:00:05	Limpieza de parabrisas
479	479	00:00:19	Cambio de neumáticos
480	480	00:00:06	Repostaje de combustible
481	481	00:00:13	Ajuste de alerones
482	482	00:00:08	Revisión general
483	483	00:00:16	Cambio de frenos
484	484	00:00:09	Limpieza de parabrisas
485	485	00:00:11	Cambio de neumáticos
486	486	00:00:07	Repostaje de combustible
487	487	00:00:14	Ajuste de alerones
488	488	00:00:05	Revisión general
489	489	00:00:19	Cambio de frenos
490	490	00:00:06	Limpieza de parabrisas
491	491	00:00:13	Cambio de neumáticos
492	492	00:00:08	Repostaje de combustible
493	493	00:00:16	Ajuste de alerones
494	494	00:00:09	Revisión general
495	495	00:00:11	Cambio de frenos
496	496	00:00:07	Limpieza de parabrisas
497	497	00:00:14	Cambio de neumáticos
498	498	00:00:05	Repostaje de combustible
499	499	00:00:19	Ajuste de alerones
500	500	00:00:06	Revisión general
501	501	00:00:13	Cambio de frenos
502	502	00:00:08	Limpieza de parabrisas
503	503	00:00:16	Cambio de neumáticos
504	504	00:00:09	Repostaje de combustible
505	505	00:00:11	Ajuste de alerones
506	506	00:00:07	Revisión general
507	507	00:00:14	Cambio de frenos
508	508	00:00:05	Limpieza de parabrisas
509	509	00:00:19	Cambio de neumáticos
510	510	00:00:06	Repostaje de combustible
511	511	00:00:13	Ajuste de alerones
512	512	00:00:08	Revisión general
513	513	00:00:16	Cambio de frenos
514	514	00:00:09	Limpieza de parabrisas
515	515	00:00:11	Cambio de neumáticos
516	516	00:00:07	Repostaje de combustible
517	517	00:00:14	Ajuste de alerones
518	518	00:00:05	Revisión general
519	519	00:00:19	Cambio de frenos
520	520	00:00:06	Limpieza de parabrisas
521	521	00:00:13	Cambio de neumáticos
522	522	00:00:08	Repostaje de combustible
523	523	00:00:16	Ajuste de alerones
524	524	00:00:09	Revisión general
525	525	00:00:11	Cambio de frenos
526	526	00:00:07	Limpieza de parabrisas
527	527	00:00:14	Cambio de neumáticos
528	528	00:00:05	Repostaje de combustible
529	529	00:00:19	Ajuste de alerones
530	530	00:00:06	Revisión general
531	531	00:00:13	Cambio de frenos
532	532	00:00:08	Limpieza de parabrisas
533	533	00:00:16	Cambio de neumáticos
534	534	00:00:09	Repostaje de combustible
535	535	00:00:11	Ajuste de alerones
536	536	00:00:07	Revisión general
537	537	00:00:14	Cambio de frenos
538	538	00:00:05	Limpieza de parabrisas
539	539	00:00:19	Cambio de neumáticos
540	540	00:00:06	Repostaje de combustible
541	541	00:00:13	Ajuste de alerones
542	542	00:00:08	Revisión general
543	543	00:00:16	Cambio de frenos
544	544	00:00:09	Limpieza de parabrisas
545	545	00:00:11	Cambio de neumáticos
546	546	00:00:07	Repostaje de combustible
547	547	00:00:14	Ajuste de alerones
548	548	00:00:05	Revisión general
549	549	00:00:19	Cambio de frenos
550	550	00:00:06	Limpieza de parabrisas
551	551	00:00:13	Cambio de neumáticos
552	552	00:00:08	Repostaje de combustible
553	553	00:00:16	Ajuste de alerones
554	554	00:00:09	Revisión general
555	555	00:00:11	Cambio de frenos
556	556	00:00:07	Limpieza de parabrisas
557	557	00:00:14	Cambio de neumáticos
558	558	00:00:05	Repostaje de combustible
559	559	00:00:19	Ajuste de alerones
560	560	00:00:06	Revisión general
561	561	00:00:13	Cambio de frenos
562	562	00:00:08	Limpieza de parabrisas
563	563	00:00:16	Cambio de neumáticos
564	564	00:00:09	Repostaje de combustible
565	565	00:00:11	Ajuste de alerones
566	566	00:00:07	Revisión general
567	567	00:00:14	Cambio de frenos
568	568	00:00:05	Limpieza de parabrisas
569	569	00:00:19	Cambio de neumáticos
570	570	00:00:06	Repostaje de combustible
571	571	00:00:13	Ajuste de alerones
572	572	00:00:08	Revisión general
573	573	00:00:16	Cambio de frenos
574	574	00:00:09	Limpieza de parabrisas
575	575	00:00:11	Cambio de neumáticos
576	576	00:00:07	Repostaje de combustible
577	577	00:00:14	Ajuste de alerones
578	578	00:00:05	Revisión general
579	579	00:00:19	Cambio de frenos
580	580	00:00:06	Limpieza de parabrisas
581	581	00:00:13	Cambio de neumáticos
582	582	00:00:08	Repostaje de combustible
583	583	00:00:16	Ajuste de alerones
584	584	00:00:09	Revisión general
585	585	00:00:11	Cambio de frenos
586	586	00:00:07	Limpieza de parabrisas
587	587	00:00:14	Cambio de neumáticos
588	588	00:00:05	Repostaje de combustible
589	589	00:00:19	Ajuste de alerones
590	590	00:00:06	Revisión general
591	591	00:00:13	Cambio de frenos
592	592	00:00:08	Limpieza de parabrisas
593	593	00:00:16	Cambio de neumáticos
594	594	00:00:09	Repostaje de combustible
595	595	00:00:11	Ajuste de alerones
596	596	00:00:07	Revisión general
597	597	00:00:14	Cambio de frenos
598	598	00:00:05	Limpieza de parabrisas
599	599	00:00:19	Cambio de neumáticos
600	600	00:00:06	Repostaje de combustible
601	601	00:00:13	Ajuste de alerones
602	602	00:00:08	Revisión general
603	603	00:00:16	Cambio de frenos
604	604	00:00:09	Limpieza de parabrisas
605	605	00:00:11	Cambio de neumáticos
606	606	00:00:07	Repostaje de combustible
607	607	00:00:14	Ajuste de alerones
608	608	00:00:05	Revisión general
609	609	00:00:19	Cambio de frenos
610	610	00:00:06	Limpieza de parabrisas
611	611	00:00:13	Cambio de neumáticos
612	612	00:00:08	Repostaje de combustible
613	613	00:00:16	Ajuste de alerones
614	614	00:00:09	Revisión general
615	615	00:00:11	Cambio de frenos
616	616	00:00:07	Limpieza de parabrisas
617	617	00:00:14	Cambio de neumáticos
618	618	00:00:05	Repostaje de combustible
619	619	00:00:19	Ajuste de alerones
620	620	00:00:06	Revisión general
621	621	00:00:13	Cambio de frenos
622	622	00:00:08	Limpieza de parabrisas
623	623	00:00:16	Cambio de neumáticos
624	624	00:00:09	Repostaje de combustible
625	625	00:00:11	Ajuste de alerones
626	626	00:00:07	Revisión general
627	627	00:00:14	Cambio de frenos
628	628	00:00:05	Limpieza de parabrisas
629	629	00:00:19	Cambio de neumáticos
630	630	00:00:06	Repostaje de combustible
631	631	00:00:13	Ajuste de alerones
632	632	00:00:08	Revisión general
633	633	00:00:16	Cambio de frenos
634	634	00:00:09	Limpieza de parabrisas
635	635	00:00:11	Cambio de neumáticos
636	636	00:00:07	Repostaje de combustible
637	637	00:00:14	Ajuste de alerones
638	638	00:00:05	Revisión general
639	639	00:00:19	Cambio de frenos
640	640	00:00:06	Limpieza de parabrisas
641	641	00:00:13	Cambio de neumáticos
642	642	00:00:08	Repostaje de combustible
643	643	00:00:16	Ajuste de alerones
644	644	00:00:09	Revisión general
645	645	00:00:11	Cambio de frenos
646	646	00:00:07	Limpieza de parabrisas
647	647	00:00:14	Cambio de neumáticos
648	648	00:00:05	Repostaje de combustible
649	649	00:00:19	Ajuste de alerones
650	650	00:00:06	Revisión general
651	651	00:00:13	Cambio de frenos
652	652	00:00:08	Limpieza de parabrisas
653	653	00:00:16	Cambio de neumáticos
654	654	00:00:09	Repostaje de combustible
655	655	00:00:11	Ajuste de alerones
656	656	00:00:07	Revisión general
657	657	00:00:14	Cambio de frenos
658	658	00:00:05	Limpieza de parabrisas
659	659	00:00:19	Cambio de neumáticos
660	660	00:00:06	Repostaje de combustible
661	661	00:00:13	Ajuste de alerones
662	662	00:00:08	Revisión general
663	663	00:00:16	Cambio de frenos
664	664	00:00:09	Limpieza de parabrisas
665	665	00:00:11	Cambio de neumáticos
666	666	00:00:07	Reposter de combustible
667	667	00:00:14	Ajuste de alerones
668	668	00:00:05	Revisión general
669	669	00:00:19	Cambio de frenos
670	670	00:00:06	Limpieza de parabrisas
671	671	00:00:13	Cambio de neumáticos
672	672	00:00:08	Repostaje de combustible
673	673	00:00:16	Ajuste de alerones
674	674	00:00:09	Revisión general
675	675	00:00:11	Cambio de frenos
676	676	00:00:07	Limpieza de parabrisas
677	677	00:00:14	Cambio de neumáticos
678	678	00:00:05	Repostaje de combustible
679	679	00:00:19	Ajuste de alerones
680	680	00:00:06	Revisión general
681	681	00:00:13	Cambio de frenos
682	682	00:00:08	Limpieza de parabrisas
683	683	00:00:16	Cambio de neumáticos
684	684	00:00:09	Repostaje de combustible
685	685	00:00:11	Ajuste de alerones
686	686	00:00:07	Revisión general
687	687	00:00:14	Cambio de frenos
688	688	00:00:05	Limpieza de parabrisas
689	689	00:00:19	Cambio de neumáticos
690	690	00:00:06	Repostaje de combustible
691	691	00:00:13	Ajuste de alerones
692	692	00:00:08	Revisión general
693	693	00:00:16	Cambio de frenos
694	694	00:00:09	Limpieza de parabrisas
695	695	00:00:11	Cambio de neumáticos
696	696	00:00:07	Repostaje de combustible
697	697	00:00:14	Ajuste de alerones
698	698	00:00:05	Revisión general
699	699	00:00:19	Cambio de frenos
700	700	00:00:06	Limpieza de parabrisas
701	701	00:00:13	Cambio de neumáticos
702	702	00:00:08	Repostaje de combustible
703	703	00:00:16	Ajuste de alerones
704	704	00:00:09	Revisión general
705	705	00:00:11	Cambio de frenos
706	706	00:00:07	Limpieza de parabrisas
707	707	00:00:14	Cambio de neumáticos
708	708	00:00:05	Repostaje de combustible
709	709	00:00:19	Ajuste de alerones
710	710	00:00:06	Revisión general
711	711	00:00:13	Cambio de frenos
712	712	00:00:08	Limpieza de parabrisas
713	713	00:00:16	Cambio de neumáticos
714	714	00:00:09	Repostaje de combustible
715	715	00:00:11	Ajuste de alerones
716	716	00:00:07	Revisión general
717	717	00:00:14	Cambio de frenos
718	718	00:00:05	Limpieza de parabrisas
719	719	00:00:19	Cambio de neumáticos
720	720	00:00:06	Repostaje de combustible
721	721	00:00:13	Ajuste de alerones
722	722	00:00:08	Revisión general
723	723	00:00:16	Cambio de frenos
724	724	00:00:09	Limpieza de parabrisas
725	725	00:00:11	Cambio de neumáticos
726	726	00:00:07	Repostaje de combustible
727	727	00:00:14	Ajuste de alerones
728	728	00:00:05	Revisión general
729	729	00:00:19	Cambio de frenos
730	730	00:00:06	Limpieza de parabrisas
731	731	00:00:13	Cambio de neumáticos
732	732	00:00:08	Repostaje de combustible
733	733	00:00:16	Ajuste de alerones
734	734	00:00:09	Revisión general
735	735	00:00:11	Cambio de frenos
736	736	00:00:07	Limpieza de parabrisas
737	737	00:00:14	Cambio de neumáticos
738	738	00:00:05	Repostaje de combustible
739	739	00:00:19	Ajuste de alerones
740	740	00:00:06	Revisión general
741	741	00:00:13	Cambio de frenos
742	742	00:00:08	Limpieza de parabrisas
743	743	00:00:16	Cambio de neumáticos
744	744	00:00:09	Repostaje de combustible
745	745	00:00:11	Ajuste de alerones
746	746	00:00:07	Revisión general
747	747	00:00:14	Cambio de frenos
748	748	00:00:05	Limpieza de parabrisas
749	749	00:00:19	Cambio de neumáticos
750	750	00:00:06	Repostaje de combustible
751	751	00:00:13	Ajuste de alerones
752	752	00:00:08	Revisión general
753	753	00:00:16	Cambio de frenos
754	754	00:00:09	Limpieza de parabrisas
755	755	00:00:11	Cambio de neumáticos
756	756	00:00:07	Repostaje de combustible
757	757	00:00:14	Ajuste de alerones
758	758	00:00:05	Revisión general
759	759	00:00:19	Cambio de frenos
760	760	00:00:06	Limpieza de parabrisas
761	761	00:00:13	Cambio de neumáticos
762	762	00:00:08	Repostaje de combustible
763	763	00:00:16	Ajuste de alerones
764	764	00:00:09	Revisión general
765	765	00:00:11	Cambio de frenos
766	766	00:00:07	Limpieza de parabrisas
767	767	00:00:14	Cambio de neumáticos
768	768	00:00:05	Repostaje de combustible
769	769	00:00:19	Ajuste de alerones
770	770	00:00:06	Revisión general
771	771	00:00:13	Cambio de frenos
772	772	00:00:08	Limpieza de parabrisas
773	773	00:00:16	Cambio de neumáticos
774	774	00:00:09	Repostaje de combustible
775	775	00:00:11	Ajuste de alerones
776	776	00:00:07	Revisión general
777	777	00:00:14	Cambio de frenos
778	778	00:00:05	Limpieza de parabrisas
779	779	00:00:19	Cambio de neumáticos
780	780	00:00:06	Repostaje de combustible
781	781	00:00:13	Ajuste de alerones
782	782	00:00:08	Revisión general
783	783	00:00:16	Cambio de frenos
784	784	00:00:09	Limpieza de parabrisas
785	785	00:00:11	Cambio de neumáticos
786	786	00:00:07	Repostaje de combustible
787	787	00:00:14	Ajuste de alerones
788	788	00:00:05	Revisión general
789	789	00:00:19	Cambio de frenos
790	790	00:00:06	Limpieza de parabrisas
791	791	00:00:13	Cambio de neumáticos
792	792	00:00:08	Repostaje de combustible
793	793	00:00:16	Ajuste de alerones
794	794	00:00:09	Revisión general
795	795	00:00:11	Cambio de frenos
796	796	00:00:07	Limpieza de parabrisas
797	797	00:00:14	Cambio de neumáticos
798	798	00:00:05	Repostaje de combustible
799	799	00:00:19	Ajuste de alerones
800	800	00:00:06	Revisión general
801	801	00:00:13	Cambio de frenos
802	802	00:00:08	Limpieza de parabrisas
803	803	00:00:16	Cambio de neumáticos
804	804	00:00:09	Repostaje de combustible
805	805	00:00:11	Ajuste de alerones
806	806	00:00:07	Revisión general
807	807	00:00:14	Cambio de frenos
808	808	00:00:05	Limpieza de parabrisas
809	809	00:00:19	Cambio de neumáticos
810	810	00:00:06	Repostaje de combustible
811	811	00:00:13	Ajuste de alerones
812	812	00:00:08	Revisión general
813	813	00:00:16	Cambio de frenos
814	814	00:00:09	Limpieza de parabrisas
815	815	00:00:11	Cambio de neumáticos
816	816	00:00:07	Repostaje de combustible
817	817	00:00:14	Ajuste de alerones
818	818	00:00:05	Revisión general
819	819	00:00:19	Cambio de frenos
820	820	00:00:06	Limpieza de parabrisas
821	821	00:00:13	Cambio de neumáticos
822	822	00:00:08	Repostaje de combustible
823	823	00:00:16	Ajuste de alerones
824	824	00:00:09	Revisión general
825	825	00:00:11	Cambio de frenos
826	826	00:00:07	Limpieza de parabrisas
827	827	00:00:14	Cambio de neumáticos
828	828	00:00:05	Repostaje de combustible
829	829	00:00:19	Ajuste de alerones
830	830	00:00:06	Revisión general
831	831	00:00:13	Cambio de frenos
832	832	00:00:08	Limpieza de parabrisas
833	833	00:00:16	Cambio de neumáticos
834	834	00:00:09	Repostaje de combustible
835	835	00:00:11	Ajuste de alerones
836	836	00:00:07	Revisión general
837	837	00:00:14	Cambio de frenos
838	838	00:00:05	Limpieza de parabrisas
839	839	00:00:19	Cambio de neumáticos
840	840	00:00:06	Repostaje de combustible
841	841	00:00:13	Ajuste de alerones
842	842	00:00:08	Revisión general
843	843	00:00:16	Cambio de frenos
844	844	00:00:09	Limpieza de parabrisas
845	845	00:00:11	Cambio de neumáticos
846	846	00:00:07	Repostaje de combustible
847	847	00:00:14	Ajuste de alerones
848	848	00:00:05	Revisión general
849	849	00:00:19	Cambio de frenos
850	850	00:00:06	Limpieza de parabrisas
851	851	00:00:13	Cambio de neumáticos
852	852	00:00:08	Repostaje de combustible
853	853	00:00:16	Ajuste de alerones
854	854	00:00:09	Revisión general
855	855	00:00:11	Cambio de frenos
856	856	00:00:07	Limpieza de parabrisas
857	857	00:00:14	Cambio de neumáticos
858	858	00:00:05	Repostaje de combustible
859	859	00:00:19	Ajuste de alerones
860	860	00:00:06	Revisión general
861	861	00:00:13	Cambio de frenos
862	862	00:00:08	Limpieza de parabrisas
863	863	00:00:16	Cambio de neumáticos
864	864	00:00:09	Repostaje de combustible
865	865	00:00:11	Ajuste de alerones
866	866	00:00:07	Revisión general
867	867	00:00:14	Cambio de frenos
868	868	00:00:05	Limpieza de parabrisas
869	869	00:00:19	Cambio de neumáticos
870	870	00:00:06	Repostaje de combustible
871	871	00:00:13	Ajuste de alerones
872	872	00:00:08	Revisión general
873	873	00:00:16	Cambio de frenos
874	874	00:00:09	Limpieza de parabrisas
875	875	00:00:11	Cambio de neumáticos
876	876	00:00:07	Repostaje de combustible
877	877	00:00:14	Ajuste de alerones
878	878	00:00:05	Revisión general
879	879	00:00:19	Cambio de frenos
880	880	00:00:06	Limpieza de parabrisas
881	881	00:00:13	Cambio de neumáticos
882	882	00:00:08	Repostaje de combustible
883	883	00:00:16	Ajuste de alerones
884	884	00:00:09	Revisión general
885	885	00:00:11	Cambio de frenos
886	886	00:00:07	Limpieza de parabrisas
887	887	00:00:14	Cambio de neumáticos
888	888	00:00:05	Repostaje de combustible
889	889	00:00:19	Ajuste de alerones
890	890	00:00:06	Revisión general
891	891	00:00:13	Cambio de frenos
892	892	00:00:08	Limpieza de parabrisas
893	893	00:00:16	Cambio de neumáticos
894	894	00:00:09	Repostaje de combustible
895	895	00:00:11	Ajuste de alerones
896	896	00:00:07	Revisión general
897	897	00:00:14	Cambio de frenos
898	898	00:00:05	Limpieza de parabrisas
899	899	00:00:19	Cambio de neumáticos
900	900	00:00:06	Repostaje de combustible
901	901	00:00:13	Ajuste de alerones
902	902	00:00:08	Revisión general
903	903	00:00:16	Cambio de frenos
904	904	00:00:09	Limpieza de parabrisas
905	905	00:00:11	Cambio de neumáticos
906	906	00:00:07	Repostaje de combustible
907	907	00:00:14	Ajuste de alerones
908	908	00:00:05	Revisión general
909	909	00:00:19	Cambio de frenos
910	910	00:00:06	Limpieza de parabrisas
911	911	00:00:13	Cambio de neumáticos
912	912	00:00:08	Repostaje de combustible
913	913	00:00:16	Ajuste de alerones
914	914	00:00:09	Revisión general
915	915	00:00:11	Cambio de frenos
916	916	00:00:07	Limpieza de parabrisas
917	917	00:00:14	Cambio de neumáticos
918	918	00:00:05	Repostaje de combustible
919	919	00:00:19	Ajuste de alerones
920	920	00:00:06	Revisión general
921	921	00:00:13	Cambio de frenos
922	922	00:00:08	Limpieza de parabrisas
923	923	00:00:16	Cambio de neumáticos
924	924	00:00:09	Repostaje de combustible
925	925	00:00:11	Ajuste de alerones
926	926	00:00:07	Revisión general
927	927	00:00:14	Cambio de frenos
928	928	00:00:05	Limpieza de parabrisas
929	929	00:00:19	Cambio de neumáticos
930	930	00:00:06	Repostaje de combustible
931	931	00:00:13	Ajuste de alerones
932	932	00:00:08	Revisión general
933	933	00:00:16	Cambio de frenos
934	934	00:00:09	Limpieza de parabrisas
935	935	00:00:11	Cambio de neumáticos
936	936	00:00:07	Repostaje de combustible
937	937	00:00:14	Ajuste de alerones
938	938	00:00:05	Revisión general
939	939	00:00:19	Cambio de frenos
940	940	00:00:06	Limpieza de parabrisas
941	941	00:00:13	Cambio de neumáticos
942	942	00:00:08	Repostaje de combustible
943	943	00:00:16	Ajuste de alerones
944	944	00:00:09	Revisión general
945	945	00:00:11	Cambio de frenos
946	946	00:00:07	Limpieza de parabrisas
947	947	00:00:14	Cambio de neumáticos
948	948	00:00:05	Repostaje de combustible
949	949	00:00:19	Ajuste de alerones
950	950	00:00:06	Revisión general
951	951	00:00:13	Cambio de frenos
952	952	00:00:08	Limpieza de parabrisas
953	953	00:00:16	Cambio de neumáticos
954	954	00:00:09	Repostaje de combustible
955	955	00:00:11	Ajuste de alerones
956	956	00:00:07	Revisión general
957	957	00:00:14	Cambio de frenos
958	958	00:00:05	Limpieza de parabrisas
959	959	00:00:19	Cambio de neumáticos
960	960	00:00:06	Repostaje de combustible
961	961	00:00:13	Ajuste de alerones
962	962	00:00:08	Revisión general
963	963	00:00:16	Cambio de frenos
964	964	00:00:09	Limpieza de parabrisas
965	965	00:00:11	Cambio de neumáticos
966	966	00:00:07	Repostaje de combustible
967	967	00:00:14	Ajuste de alerones
968	968	00:00:05	Revisión general
969	969	00:00:19	Cambio de frenos
970	970	00:00:06	Limpieza de parabrisas
971	971	00:00:13	Cambio de neumáticos
972	972	00:00:08	Repostaje de combustible
973	973	00:00:16	Ajuste de alerones
974	974	00:00:09	Revisión general
975	975	00:00:11	Cambio de frenos
976	976	00:00:07	Limpieza de parabrisas
977	977	00:00:14	Cambio de neumáticos
978	978	00:00:05	Repostaje de combustible
979	979	00:00:19	Ajuste de alerones
980	980	00:00:06	Revisión general
981	981	00:00:13	Cambio de frenos
982	982	00:00:08	Limpieza de parabrisas
983	983	00:00:16	Cambio de neumáticos
984	984	00:00:09	Repostaje de combustible
985	985	00:00:11	Ajuste de alerones
986	986	00:00:07	Revisión general
987	987	00:00:14	Cambio de frenos
988	988	00:00:05	Limpieza de parabrisas
989	989	00:00:19	Cambio de neumáticos
990	990	00:00:06	Repostaje de combustible
991	991	00:00:08	Cambio de frenos
992	992	00:00:14	Limpieza de parabrisas
993	993	00:00:17	Cambio de neumáticos
994	994	00:00:06	Repostaje de combustible
995	995	00:00:19	Ajuste de alerones
996	996	00:00:04	Revisión general
997	997	00:00:13	Cambio de frenos
998	998	00:00:02	Limpieza de parabrisas
999	999	00:00:20	Cambio de neumáticos
1000	1000	00:00:01	Repostaje de combustible
\.


--
-- TOC entry 5074 (class 0 OID 99302)
-- Dependencies: 239
-- Data for Name: participaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participaciones (idparticipacion, idvehiculo, idcarrera, idpersona, posiciondesalida, posiciondellegada) FROM stdin;
1	1	1	1	1	10
2	1	1	2	3	2
3	2	1	6	5	3
4	2	1	7	7	4
5	3	1	11	9	5
6	3	1	12	11	6
7	4	1	16	13	7
8	4	1	17	15	8
9	5	1	21	17	9
10	5	1	22	19	1
11	6	1	26	2	11
12	6	1	27	4	12
13	7	1	31	6	13
14	7	1	32	8	14
15	8	1	36	10	15
16	8	1	37	12	16
17	9	1	41	14	17
18	9	1	42	16	18
19	10	1	46	18	19
20	10	1	47	20	20
21	1	2	1	1	10
22	1	2	2	3	2
23	2	2	6	5	3
24	2	2	7	7	4
25	3	2	11	9	5
26	3	2	12	11	6
27	4	2	16	13	7
28	4	2	17	15	8
29	5	2	21	17	9
30	5	2	22	19	1
31	6	2	26	2	11
32	6	2	27	4	12
33	7	2	31	6	13
34	7	2	32	8	14
35	8	2	36	10	15
36	8	2	37	12	16
37	9	2	41	14	17
38	9	2	42	16	18
39	10	2	46	18	19
40	10	2	47	20	20
41	1	3	1	1	10
42	1	3	2	3	2
43	2	3	6	5	3
44	2	3	7	7	4
45	3	3	11	9	5
46	3	3	12	11	6
47	4	3	16	13	7
48	4	3	17	15	8
49	5	3	21	17	9
50	5	3	22	19	1
51	6	3	26	2	11
52	6	3	27	4	12
53	7	3	31	6	13
54	7	3	32	8	14
55	8	3	36	10	15
56	8	3	37	12	16
57	9	3	41	14	17
58	9	3	42	16	18
59	10	3	46	18	19
60	10	3	47	20	20
61	1	4	1	1	10
62	1	4	2	3	2
63	2	4	6	5	3
64	2	4	7	7	4
65	3	4	11	9	5
66	3	4	12	11	6
67	4	4	16	13	7
68	4	4	17	15	8
69	5	4	21	17	9
70	5	4	22	19	1
71	6	4	26	2	11
72	6	4	27	4	12
73	7	4	31	6	13
74	7	4	32	8	14
75	8	4	36	10	15
76	8	4	37	12	16
77	9	4	41	14	17
78	9	4	42	16	18
79	10	4	46	18	19
80	10	4	47	20	20
81	1	5	1	1	10
82	1	5	2	3	2
83	2	5	6	5	3
84	2	5	7	7	4
85	3	5	11	9	5
86	3	5	12	11	6
87	4	5	16	13	7
88	4	5	17	15	8
89	5	5	21	17	9
90	5	5	22	19	1
91	6	5	26	2	11
92	6	5	27	4	12
93	7	5	31	6	13
94	7	5	32	8	14
95	8	5	36	10	15
96	8	5	37	12	16
97	9	5	41	14	17
98	9	5	42	16	18
99	10	5	46	18	19
100	10	5	47	20	20
101	1	6	1	1	10
102	1	6	2	3	2
103	2	6	6	5	3
104	2	6	7	7	4
105	3	6	11	9	5
106	3	6	12	11	6
107	4	6	16	13	7
108	4	6	17	15	8
109	5	6	21	17	9
110	5	6	22	19	1
111	6	6	26	2	11
112	6	6	27	4	12
113	7	6	31	6	13
114	7	6	32	8	14
115	8	6	36	10	15
116	8	6	37	12	16
117	9	6	41	14	17
118	9	6	42	16	18
119	10	6	46	18	19
120	10	6	47	20	20
121	1	7	1	1	10
122	1	7	2	3	2
123	2	7	6	5	3
124	2	7	7	7	4
125	3	7	11	9	5
126	3	7	12	11	6
127	4	7	16	13	7
128	4	7	17	15	8
129	5	7	21	17	9
130	5	7	22	19	1
131	6	7	26	2	11
132	6	7	27	4	12
133	7	7	31	6	13
134	7	7	32	8	14
135	8	7	36	10	15
136	8	7	37	12	16
137	9	7	41	14	17
138	9	7	42	16	18
139	10	7	46	18	19
140	10	7	47	20	20
141	1	8	1	1	10
142	1	8	2	3	2
143	2	8	6	5	3
144	2	8	7	7	4
145	3	8	11	9	5
146	3	8	12	11	6
147	4	8	16	13	7
148	4	8	17	15	8
149	5	8	21	17	9
150	5	8	22	19	1
151	6	8	26	2	11
152	6	8	27	4	12
153	7	8	31	6	13
154	7	8	32	8	14
155	8	8	36	10	15
156	8	8	37	12	16
157	9	8	41	14	17
158	9	8	42	16	18
159	10	8	46	18	19
160	10	8	47	20	20
161	1	9	1	1	10
162	1	9	2	3	2
163	2	9	6	5	3
164	2	9	7	7	4
165	3	9	11	9	5
166	3	9	12	11	6
167	4	9	16	13	7
168	4	9	17	15	8
169	5	9	21	17	9
170	5	9	22	19	1
171	6	9	26	2	11
172	6	9	27	4	12
173	7	9	31	6	13
174	7	9	32	8	14
175	8	9	36	10	15
176	8	9	37	12	16
177	9	9	41	14	17
178	9	9	42	16	18
179	10	9	46	18	19
180	10	9	47	20	20
181	1	10	1	1	10
182	1	10	2	3	2
183	2	10	6	5	3
184	2	10	7	7	4
185	3	10	11	9	5
186	3	10	12	11	6
187	4	10	16	13	7
188	4	10	17	15	8
189	5	10	21	17	9
190	5	10	22	19	1
191	6	10	26	2	11
192	6	10	27	4	12
193	7	10	31	6	13
194	7	10	32	8	14
195	8	10	36	10	15
196	8	10	37	12	16
197	9	10	41	14	17
198	9	10	42	16	18
199	10	10	46	18	19
200	10	10	47	20	20
201	1	51	1	1	10
202	1	51	2	3	2
203	2	51	6	5	3
204	2	51	7	7	4
205	3	51	11	9	5
206	3	51	12	11	6
207	4	51	16	13	7
208	4	51	17	15	8
209	5	51	21	17	9
210	5	51	22	19	1
211	6	51	26	2	11
212	6	51	27	4	12
213	7	51	31	6	13
214	7	51	32	8	14
215	8	51	36	10	15
216	8	51	37	12	16
217	9	51	41	14	17
218	9	51	42	16	18
219	10	51	46	18	19
220	10	51	47	20	20
221	1	52	1	1	10
222	1	52	2	3	2
223	2	52	6	5	3
224	2	52	7	7	4
225	3	52	11	9	5
226	3	52	12	11	6
227	4	52	16	13	7
228	4	52	17	15	8
229	5	52	21	17	9
230	5	52	22	19	1
231	6	52	26	2	11
232	6	52	27	4	12
233	7	52	31	6	13
234	7	52	32	8	14
235	8	52	36	10	15
236	8	52	37	12	16
237	9	52	41	14	17
238	9	52	42	16	18
239	10	52	46	18	19
240	10	52	47	20	20
241	1	53	1	1	10
242	1	53	2	3	2
243	2	53	6	5	3
244	2	53	7	7	4
245	3	53	11	9	5
246	3	53	12	11	6
247	4	53	16	13	7
248	4	53	17	15	8
249	5	53	21	17	9
250	5	53	22	19	1
251	6	53	26	2	11
252	6	53	27	4	12
253	7	53	31	6	13
254	7	53	32	8	14
255	8	53	36	10	15
256	8	53	37	12	16
257	9	53	41	14	17
258	9	53	42	16	18
259	10	53	46	18	19
260	10	53	47	20	20
261	1	54	1	1	10
262	1	54	2	3	2
263	2	54	6	5	3
264	2	54	7	7	4
265	3	54	11	9	5
266	3	54	12	11	6
267	4	54	16	13	7
268	4	54	17	15	8
269	5	54	21	17	9
270	5	54	22	19	1
271	6	54	26	2	11
272	6	54	27	4	12
273	7	54	31	6	13
274	7	54	32	8	14
275	8	54	36	10	15
276	8	54	37	12	16
277	9	54	41	14	17
278	9	54	42	16	18
279	10	54	46	18	19
280	10	54	47	20	20
281	1	55	1	1	10
282	1	55	2	3	2
283	2	55	6	5	3
284	2	55	7	7	4
285	3	55	11	9	5
286	3	55	12	11	6
287	4	55	16	13	7
288	4	55	17	15	8
289	5	55	21	17	9
290	5	55	22	19	1
291	6	55	26	2	11
292	6	55	27	4	12
293	7	55	31	6	13
294	7	55	32	8	14
295	8	55	36	10	15
296	8	55	37	12	16
297	9	55	41	14	17
298	9	55	42	16	18
299	10	55	46	18	19
300	10	55	47	20	20
301	1	56	1	1	10
302	1	56	2	3	2
303	2	56	6	5	3
304	2	56	7	7	4
305	3	56	11	9	5
306	3	56	12	11	6
307	4	56	16	13	7
308	4	56	17	15	8
309	5	56	21	17	9
310	5	56	22	19	1
311	6	56	26	2	11
312	6	56	27	4	12
313	7	56	31	6	13
314	7	56	32	8	14
315	8	56	36	10	15
316	8	56	37	12	16
317	9	56	41	14	17
318	9	56	42	16	18
319	10	56	46	18	19
320	10	56	47	20	20
321	1	57	1	1	10
322	1	57	2	3	2
323	2	57	6	5	3
324	2	57	7	7	4
325	3	57	11	9	5
326	3	57	12	11	6
327	4	57	16	13	7
328	4	57	17	15	8
329	5	57	21	17	9
330	5	57	22	19	1
331	6	57	26	2	11
332	6	57	27	4	12
333	7	57	31	6	13
334	7	57	32	8	14
335	8	57	36	10	15
336	8	57	37	12	16
337	9	57	41	14	17
338	9	57	42	16	18
339	10	57	46	18	19
340	10	57	47	20	20
341	1	58	1	1	10
342	1	58	2	3	2
343	2	58	6	5	3
344	2	58	7	7	4
345	3	58	11	9	5
346	3	58	12	11	6
347	4	58	16	13	7
348	4	58	17	15	8
349	5	58	21	17	9
350	5	58	22	19	1
351	6	58	26	2	11
352	6	58	27	4	12
353	7	58	31	6	13
354	7	58	32	8	14
355	8	58	36	10	15
356	8	58	37	12	16
357	9	58	41	14	17
358	9	58	42	16	18
359	10	58	46	18	19
360	10	58	47	20	20
361	1	59	1	1	10
362	1	59	2	3	2
363	2	59	6	5	3
364	2	59	7	7	4
365	3	59	11	9	5
366	3	59	12	11	6
367	4	59	16	13	7
368	4	59	17	15	8
369	5	59	21	17	9
370	5	59	22	19	1
371	6	59	26	2	11
372	6	59	27	4	12
373	7	59	31	6	13
374	7	59	32	8	14
375	8	59	36	10	15
376	8	59	37	12	16
377	9	59	41	14	17
378	9	59	42	16	18
379	10	59	46	18	19
380	10	59	47	20	20
381	1	60	1	1	10
382	1	60	2	3	2
383	2	60	6	5	3
384	2	60	7	7	4
385	3	60	11	9	5
386	3	60	12	11	6
387	4	60	16	13	7
388	4	60	17	15	8
389	5	60	21	17	9
390	5	60	22	19	1
391	6	60	26	2	11
392	6	60	27	4	12
393	7	60	31	6	13
394	7	60	32	8	14
395	8	60	36	10	15
396	8	60	37	12	16
397	9	60	41	14	17
398	9	60	42	16	18
399	10	60	46	18	19
400	10	60	47	20	20
401	1	61	1	1	10
402	1	61	2	3	2
403	2	61	6	5	3
404	2	61	7	7	4
405	3	61	11	9	5
406	3	61	12	11	6
407	4	61	16	13	7
408	4	61	17	15	8
409	5	61	21	17	9
410	5	61	22	19	1
411	6	61	26	2	11
412	6	61	27	4	12
413	7	61	31	6	13
414	7	61	32	8	14
415	8	61	36	10	15
416	8	61	37	12	16
417	9	61	41	14	17
418	9	61	42	16	18
419	10	61	46	18	19
420	10	61	47	20	20
421	1	62	1	1	10
422	1	62	2	3	2
423	2	62	6	5	3
424	2	62	7	7	4
425	3	62	11	9	5
426	3	62	12	11	6
427	4	62	16	13	7
428	4	62	17	15	8
429	5	62	21	17	9
430	5	62	22	19	1
431	6	62	26	2	11
432	6	62	27	4	12
433	7	62	31	6	13
434	7	62	32	8	14
435	8	62	36	10	15
436	8	62	37	12	16
437	9	62	41	14	17
438	9	62	42	16	18
439	10	62	46	18	19
440	10	62	47	20	20
441	1	63	1	1	10
442	1	63	2	3	2
443	2	63	6	5	3
444	2	63	7	7	4
445	3	63	11	9	5
446	3	63	12	11	6
447	4	63	16	13	7
448	4	63	17	15	8
449	5	63	21	17	9
450	5	63	22	19	1
451	6	63	26	2	11
452	6	63	27	4	12
453	7	63	31	6	13
454	7	63	32	8	14
455	8	63	36	10	15
456	8	63	37	12	16
457	9	63	41	14	17
458	9	63	42	16	18
459	10	63	46	18	19
460	10	63	47	20	20
461	1	64	1	1	10
462	1	64	2	3	2
463	2	64	6	5	3
464	2	64	7	7	4
465	3	64	11	9	5
466	3	64	12	11	6
467	4	64	16	13	7
468	4	64	17	15	8
469	5	64	21	17	9
470	5	64	22	19	1
471	6	64	26	2	11
472	6	64	27	4	12
473	7	64	31	6	13
474	7	64	32	8	14
475	8	64	36	10	15
476	8	64	37	12	16
477	9	64	41	14	17
478	9	64	42	16	18
479	10	64	46	18	19
480	10	64	47	20	20
481	1	65	1	1	10
482	1	65	2	3	2
483	2	65	6	5	3
484	2	65	7	7	4
485	3	65	11	9	5
486	3	65	12	11	6
487	4	65	16	13	7
488	4	65	17	15	8
489	5	65	21	17	9
490	5	65	22	19	1
491	6	65	26	2	11
492	6	65	27	4	12
493	7	65	31	6	13
494	7	65	32	8	14
495	8	65	36	10	15
496	8	65	37	12	16
497	9	65	41	14	17
498	9	65	42	16	18
499	10	65	46	18	19
500	10	65	47	20	20
\.


--
-- TOC entry 5053 (class 0 OID 99091)
-- Dependencies: 218
-- Data for Name: patrocinadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patrocinadores (idpatrocinador, nombre) FROM stdin;
1	Red Bull
2	Shell
3	Petrobras
4	Telefonica
5	Santander
6	Infiniti
7	Rolex
8	Heineken
9	Puma
10	Hugo Boss
11	Gulf Oil
12	Monster Energy
13	FedEx
\.


--
-- TOC entry 5055 (class 0 OID 99101)
-- Dependencies: 220
-- Data for Name: patrocinadoresequipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patrocinadoresequipos (idequipo, idpatrocinador, idtemporada, montopatrocinio, tipodepatrocinio) FROM stdin;
7	9	1	5000000	exclusivo
11	2	1	3000000	no exclusivo
9	5	1	4500000	exclusivo
6	6	1	2000000	no exclusivo
3	3	1	4000000	exclusivo
8	10	1	6000000	no exclusivo
13	12	1	2500000	exclusivo
2	3	1	3500000	no exclusivo
8	7	1	2800000	exclusivo
5	4	1	3200000	no exclusivo
4	11	2	5000000	exclusivo
13	5	2	3000000	no exclusivo
2	8	2	4500000	exclusivo
6	1	2	2000000	no exclusivo
10	3	2	4000000	exclusivo
1	6	2	6000000	no exclusivo
11	9	2	2500000	exclusivo
9	7	2	3500000	no exclusivo
5	10	2	2800000	exclusivo
7	12	2	3200000	no exclusivo
8	7	3	5000000	exclusivo
12	9	3	3000000	no exclusivo
6	3	3	4500000	exclusivo
5	10	3	2000000	no exclusivo
2	2	3	4000000	exclusivo
3	8	3	6000000	no exclusivo
10	4	3	2500000	exclusivo
1	5	3	3500000	no exclusivo
7	11	3	2800000	exclusivo
9	1	3	3200000	no exclusivo
9	12	4	5000000	exclusivo
4	6	4	3000000	no exclusivo
7	2	4	4500000	exclusivo
1	10	4	2000000	no exclusivo
11	3	4	4000000	exclusivo
5	5	4	6000000	no exclusivo
3	8	4	2500000	exclusivo
10	7	4	3500000	no exclusivo
6	11	4	2800000	exclusivo
2	1	4	3200000	no exclusivo
5	8	5	5000000	exclusivo
12	3	5	3000000	no exclusivo
1	10	5	4500000	exclusivo
8	4	5	2000000	no exclusivo
10	6	5	4000000	exclusivo
2	1	5	6000000	no exclusivo
11	9	5	2500000	exclusivo
6	11	5	3500000	no exclusivo
4	7	5	2800000	exclusivo
7	12	5	3200000	no exclusivo
\.


--
-- TOC entry 5057 (class 0 OID 99126)
-- Dependencies: 222
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personas (idpersona, nombre, correoelectronico, "teléfono") FROM stdin;
1	Juan Perez	juan.perez@example.com	123456789
2	Maria Garcia	maria.garcia@example.com	987654321
3	Luis Martinez	luis.martinez@example.com	456123789
4	Ana Rodriguez	ana.rodriguez@example.com	789456123
5	Carlos Sanchez	carlos.sanchez@example.com	321654987
6	Laura Fernandez	laura.fernandez@example.com	654987321
7	Pedro Gomez	pedro.gomez@example.com	987123654
8	Sofia Diaz	sofia.diaz@example.com	159357486
9	Javier Alonso	javier.alonso@example.com	357159486
10	Elena Torres	elena.torres@example.com	753159486
11	Diego Ruiz	diego.ruiz@example.com	987753159
12	Paula Navarro	paula.navarro@example.com	123753159
13	Miguel Vazquez	miguel.vazquez@example.com	321753159
14	Andrea Jimenez	andrea.jimenez@example.com	654753159
15	Jorge Rubio	jorge.rubio@example.com	987654753
16	Carmen Molina	carmen.molina@example.com	159987654
17	Pablo Ortega	pablo.ortega@example.com	357159987
18	Alba Castro	alba.castro@example.com	753357159
19	Ruben Herrera	ruben.herrera@example.com	987753357
20	Natalia Serrano	natalia.serrano@example.com	123987753
21	Guillermo Iglesias	guillermo.iglesias@example.com	321987753
22	Rocio Martin	rocio.martin@example.com	654987753
23	Sergio Alvarez	sergio.alvarez@example.com	987654987
24	Olivia Moreno	olivia.moreno@example.com	159987654
25	Adrian Rubio	adrian.rubio@example.com	357159987
26	Lucia Ramos	lucia.ramos@example.com	753357159
27	Manuel Medina	manuel.medina@example.com	987753357
28	Alicia Guerrero	alicia.guerrero@example.com	123987753
29	Daniel Moya	daniel.moya@example.com	321987753
30	Eva Duran	eva.duran@example.com	654987753
31	Marcos Castro	marcos.castro@example.com	987654987
32	Elena Serrano	elena.serrano@example.com	159987654
33	Diego Ortega	diego.ortega@example.com	357159987
34	Celia Munoz	celia.munoz@example.com	753357159
35	Alejandro Dominguez	alejandro.dominguez@example.com	987753357
36	Clara Vidal	clara.vidal@example.com	123987753
37	Hector Reyes	hector.reyes@example.com	321987753
38	Sara Morales	sara.morales@example.com	654987753
39	Alberto Cabrera	alberto.cabrera@example.com	987654987
40	Isabel Arias	isabel.arias@example.com	159987654
41	Javier Carmona	javier.carmona@example.com	357159987
42	Marta Garrido	marta.garrido@example.com	753357159
43	Roberto Calderon	roberto.calderon@example.com	987753357
44	Lucia Pascual	lucia.pascual@example.com	123987753
45	David Bravo	david.bravo@example.com	321987753
46	Ines Cordero	ines.cordero@example.com	654987753
47	Francisco Soto	francisco.soto@example.com	987654987
48	Elena Roman	elena.roman@example.com	159987654
49	Antonio Gallego	antonio.gallego@example.com	357159987
50	Silvia Aguilar	silvia.aguilar@example.com	753357159
51	Carlos Cano	carlos.cano@example.com	987753357
52	Ainhoa Cruz	ainhoa.cruz@example.com	123987753
53	Iker Mendez	iker.mendez@example.com	321987753
54	Carmen Vargas	carmen.vargas@example.com	654987753
55	Pablo Castro	pablo.castro@example.com	987654987
56	Lorena Saez	lorena.saez@example.com	159987654
57	Alejandro Martin	alejandro.martin@example.com	357159987
58	Nerea Navarro	nerea.navarro@example.com	753357159
59	Javier Gomez	javier.gomez@example.com	987753357
60	Sonia Fernandez	sonia.fernandez@example.com	123987753
61	Daniel Ortiz	daniel.ortiz@example.com	321987753
62	Ana Lopez	ana.lopez@example.com	654987753
63	Juan Ruiz	juan.ruiz@example.com	987654987
64	Maria Jimenez	maria.jimenez@example.com	159987654
65	Alejandro Lopez	alejandro.lopez@example.com	456789123
\.


--
-- TOC entry 5058 (class 0 OID 99131)
-- Dependencies: 223
-- Data for Name: pilotos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pilotos (idpersona) FROM stdin;
1
2
6
7
11
12
16
17
21
22
26
27
31
32
36
37
41
42
46
47
51
52
56
57
61
62
\.


--
-- TOC entry 5061 (class 0 OID 99166)
-- Dependencies: 226
-- Data for Name: pilotosestadopilotos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pilotosestadopilotos (idestadopiloto, idpersona, idtipoestadopiloto, fechadeinicio, fechadefin) FROM stdin;
1	1	1	2020-01-01	2021-01-01
2	2	2	2020-02-01	2021-02-01
3	6	3	2020-03-01	2021-03-01
4	7	4	2020-04-01	2021-04-01
5	11	5	2020-05-01	2021-05-01
6	12	6	2020-06-01	2021-06-01
7	16	7	2020-07-01	2021-07-01
8	17	8	2020-08-01	2021-08-01
9	21	9	2020-09-01	2021-09-01
10	22	10	2020-10-01	2021-10-01
11	26	1	2020-11-01	2021-11-01
12	27	2	2020-12-01	2021-12-01
13	31	3	2021-01-01	2022-01-01
14	32	4	2021-02-01	2022-02-01
15	36	5	2021-03-01	2022-03-01
16	37	6	2021-04-01	2022-04-01
17	41	7	2021-05-01	2022-05-01
18	42	8	2021-06-01	2022-06-01
19	46	9	2021-07-01	2022-07-01
20	47	10	2021-08-01	2022-08-01
21	51	1	2021-09-01	2022-09-01
22	52	2	2021-10-01	2022-10-01
23	56	3	2021-11-01	2022-11-01
24	57	4	2021-12-01	2022-12-01
25	61	5	2022-01-01	2023-01-01
26	62	6	2022-02-01	2023-02-01
\.


--
-- TOC entry 5081 (class 0 OID 99379)
-- Dependencies: 246
-- Data for Name: plataformas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataformas (idplataforma, nombre) FROM stdin;
1	YouTube
2	ESPN
3	Sky Sports
4	Fox Sports
5	NBC Sports
6	F1 TV
7	BBC Sport
8	DAZN
9	Amazon Prime Video
10	CBS Sports
\.


--
-- TOC entry 5082 (class 0 OID 99384)
-- Dependencies: 247
-- Data for Name: plataformascarreras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataformascarreras (idplataformascarreras, audencia, idplataforma, idcarrera) FROM stdin;
1	500000	1	1
2	750000	2	1
3	200000	3	1
4	600000	4	1
5	450000	5	1
6	800000	6	2
7	300000	7	2
8	100000	8	2
9	650000	9	2
10	400000	10	2
11	550000	1	3
12	700000	2	3
13	250000	3	3
14	700000	4	3
15	470000	5	3
16	750000	6	4
17	350000	7	4
18	120000	8	4
19	670000	9	4
20	420000	10	4
21	600000	1	5
22	720000	2	5
23	270000	3	5
24	750000	4	5
25	490000	5	5
26	770000	6	6
27	370000	7	6
28	130000	8	6
29	680000	9	6
30	430000	10	6
\.


--
-- TOC entry 5073 (class 0 OID 99297)
-- Dependencies: 238
-- Data for Name: puntajes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.puntajes (idpuntaje, posicion, puntaje) FROM stdin;
1	1	25
2	2	18
3	3	15
4	4	12
5	5	10
6	6	8
7	7	6
8	8	4
9	9	2
10	10	1
\.


--
-- TOC entry 5078 (class 0 OID 99354)
-- Dependencies: 243
-- Data for Name: sanciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sanciones (idsancion, descripcion, penalizacion) FROM stdin;
1	Drive Through	00:20:00
2	Stop and Go	00:10:00
3	Penalización de Tiempo	00:30:00
4	Pérdida de Posición	00:01:00
5	Desqualificación	02:00:00
6	Pérdida de Puntos en el Campeonato	00:30:00
7	Advertencia	00:00:00
\.


--
-- TOC entry 5079 (class 0 OID 99359)
-- Dependencies: 244
-- Data for Name: sancionesvueltas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sancionesvueltas (idsancionvuelta, idvuelta, idsancion) FROM stdin;
1	718	3
2	312	6
3	653	7
4	119	2
5	567	5
6	826	4
7	450	1
8	241	6
9	802	4
10	874	7
11	689	5
12	901	6
13	180	1
14	432	4
15	532	3
16	715	2
17	287	6
18	496	5
19	650	3
20	892	4
21	133	7
22	347	2
23	582	1
24	911	5
25	278	6
26	708	3
27	422	4
28	590	7
29	219	2
30	984	1
31	627	6
32	148	5
33	709	4
34	581	3
35	830	7
36	297	6
37	478	1
38	691	5
39	559	2
40	963	3
41	144	4
42	879	7
43	386	6
44	580	1
45	745	2
46	658	5
47	226	4
48	527	3
49	812	6
50	317	7
51	636	1
52	458	5
53	865	3
54	231	6
55	512	4
56	979	7
57	394	2
58	604	1
59	719	5
60	873	6
61	142	4
62	660	3
63	272	7
64	381	5
65	547	2
66	898	6
67	120	1
68	735	4
69	823	3
70	486	7
71	659	2
72	316	5
73	542	6
74	805	1
75	237	3
76	682	7
77	401	2
78	573	4
79	729	1
80	981	6
81	306	5
82	648	3
83	573	7
84	128	2
85	860	4
86	509	1
87	726	6
88	364	5
89	591	3
90	738	7
91	145	2
92	687	4
93	511	6
94	843	1
95	267	5
96	655	3
97	772	7
98	293	2
99	809	4
100	526	1
101	854	7
102	312	2
103	643	6
104	419	3
105	578	4
106	926	1
107	137	5
108	789	7
109	562	1
110	499	3
111	607	4
112	871	2
113	315	5
114	701	6
115	982	7
116	248	1
117	544	2
118	673	3
119	846	4
120	357	5
121	664	6
122	927	7
123	188	1
124	515	2
125	739	3
126	894	4
127	469	5
128	617	6
129	874	7
130	278	1
131	586	2
132	707	3
133	943	4
134	329	5
135	832	6
136	991	7
137	142	1
138	526	2
139	658	3
140	892	4
141	450	5
142	703	6
143	954	7
144	201	1
145	592	2
146	726	3
147	813	4
148	389	5
149	897	6
150	953	7
151	134	1
152	557	2
153	689	3
154	771	4
155	453	5
156	624	6
157	811	7
158	163	1
159	612	2
160	737	3
161	865	4
162	536	5
163	604	6
164	873	7
165	297	1
166	525	2
167	641	3
168	748	4
169	411	5
170	708	6
171	926	7
172	186	1
173	573	2
174	621	3
175	748	4
176	366	5
177	815	6
178	947	7
179	299	1
180	573	2
181	654	3
182	725	4
183	469	5
184	911	6
185	932	7
186	227	1
187	509	2
188	649	3
189	721	4
190	382	5
191	826	6
192	946	7
193	241	1
194	547	2
195	666	3
196	756	4
197	445	5
198	703	6
199	928	7
200	156	1
201	474	2
202	693	6
203	827	1
204	576	3
205	349	4
206	615	5
207	842	7
208	121	2
209	469	3
210	599	4
211	783	1
212	512	5
213	647	6
214	987	7
215	158	1
216	633	2
217	752	3
218	864	4
219	430	5
220	971	6
221	978	7
222	223	1
223	583	2
224	722	3
225	811	4
226	375	5
227	692	6
228	987	7
229	174	1
230	649	2
231	744	3
232	848	4
233	394	5
234	711	6
235	949	7
236	132	1
237	557	2
238	676	3
239	776	4
240	423	5
241	691	6
242	977	7
243	181	1
244	552	2
245	678	3
246	794	4
247	456	5
248	745	6
249	915	7
250	168	1
251	615	2
252	724	3
253	852	4
254	334	5
255	708	6
256	998	7
257	111	1
258	588	2
259	699	3
260	827	4
261	393	5
262	736	6
263	914	7
264	192	1
265	587	2
266	714	3
267	821	4
268	381	5
269	646	6
270	968	7
271	179	1
272	596	2
273	738	3
274	879	4
275	462	5
276	725	6
277	921	7
278	141	1
279	521	2
280	666	3
281	797	4
282	341	5
283	671	6
284	933	7
285	103	1
286	569	2
287	691	3
288	818	4
289	478	5
290	769	6
291	929	7
292	197	1
293	595	2
294	709	3
295	852	4
296	332	5
297	625	6
298	993	7
299	135	1
300	547	2
\.


--
-- TOC entry 5054 (class 0 OID 99096)
-- Dependencies: 219
-- Data for Name: temporadas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temporadas (idtemporada, fechadeinicio, fechadefin) FROM stdin;
1	2020-03-15	2020-11-29
2	2021-03-28	2021-12-12
3	2022-03-20	2022-11-27
4	2023-03-26	2023-12-10
5	2024-03-24	2024-11-24
\.


--
-- TOC entry 5067 (class 0 OID 99237)
-- Dependencies: 232
-- Data for Name: tiposdecarreras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiposdecarreras (idtipodecarrera, nombre) FROM stdin;
1	principal
2	libre
3	clasificatoria
\.


--
-- TOC entry 5071 (class 0 OID 99277)
-- Dependencies: 236
-- Data for Name: tiposdeclasificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiposdeclasificacion (idtipodeclasificacion, nombre) FROM stdin;
1	Q1
2	Q2
3	Q3
\.


--
-- TOC entry 5063 (class 0 OID 99186)
-- Dependencies: 228
-- Data for Name: tiposdeneumaticos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiposdeneumaticos (idtipodeneumatico, dureza) FROM stdin;
1	DURO
2	MEDIO
3	SUAVE
\.


--
-- TOC entry 5060 (class 0 OID 99161)
-- Dependencies: 225
-- Data for Name: tiposestadospiloto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiposestadospiloto (idtipoestadopiloto, nombre) FROM stdin;
1	Lesionado
2	En recuperación
3	Disponible
4	Activo
5	Reserva
6	Incapacitado médicamente
7	Retirado
8	En negociación de contrato
9	Libre de contrato
10	Suspendido
\.


--
-- TOC entry 5064 (class 0 OID 99192)
-- Dependencies: 229
-- Data for Name: vehiculos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehiculos (idvehiculo, idtipodemotor, idtipodeneumatico, idequipo, peso, modelo, marca) FROM stdin;
1	1	1	1	752.5	2020	Honda
2	2	2	2	751	2021	Tesla
3	3	3	3	753	2019	Toyota
4	4	1	4	750.5	2022	Ford
5	5	2	5	752	2018	Subaru
6	6	3	6	751.5	2021	Audi
7	7	1	7	752.3	2020	BMW
8	8	2	8	751.8	2019	Mazda
9	9	3	9	753.1	2022	Jeep
10	10	1	10	750.9	2020	Mercedes-Benz
11	4	2	11	752.7	2018	Nissan
12	3	3	12	750.4	2021	Hyundai
13	2	1	13	753.6	2019	Ford
\.


--
-- TOC entry 5075 (class 0 OID 99324)
-- Dependencies: 240
-- Data for Name: vueltas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vueltas (idvuelta, idparticipacion, tiempo) FROM stdin;
1	1	00:01:23
2	2	00:01:30
3	3	00:01:28
4	4	00:01:25
5	5	00:01:26
6	6	00:01:29
7	7	00:01:27
8	8	00:01:32
9	9	00:01:24
10	10	00:01:31
11	11	00:01:33
12	12	00:01:28
13	13	00:01:26
14	14	00:01:30
15	15	00:01:27
16	16	00:01:29
17	17	00:01:25
18	18	00:01:31
19	19	00:01:32
20	20	00:01:28
21	21	00:01:33
22	22	00:01:26
23	23	00:01:30
24	24	00:01:27
25	25	00:01:29
26	26	00:01:25
27	27	00:01:32
28	28	00:01:31
29	29	00:01:28
30	30	00:01:24
31	31	00:01:33
32	32	00:01:27
33	33	00:01:29
34	34	00:01:26
35	35	00:01:30
36	36	00:01:32
37	37	00:01:25
38	38	00:01:31
39	39	00:01:28
40	40	00:01:27
41	41	00:01:33
42	42	00:01:26
43	43	00:01:29
44	44	00:01:24
45	45	00:01:31
46	46	00:01:30
47	47	00:01:32
48	48	00:01:28
49	49	00:01:27
50	50	00:01:33
51	51	00:01:26
52	52	00:01:29
53	53	00:01:25
54	54	00:01:30
55	55	00:01:31
56	56	00:01:28
57	57	00:01:32
58	58	00:01:27
59	59	00:01:33
60	60	00:01:26
61	61	00:01:29
62	62	00:01:24
63	63	00:01:30
64	64	00:01:25
65	65	00:01:31
66	66	00:01:28
67	67	00:01:27
68	68	00:01:32
69	69	00:01:33
70	70	00:01:26
71	71	00:01:29
72	72	00:01:30
73	73	00:01:28
74	74	00:01:31
75	75	00:01:27
76	76	00:01:33
77	77	00:01:25
78	78	00:01:32
79	79	00:01:26
80	80	00:01:29
81	81	00:01:24
82	82	00:01:30
83	83	00:01:28
84	84	00:01:31
85	85	00:01:27
86	86	00:01:32
87	87	00:01:25
88	88	00:01:33
89	89	00:01:26
90	90	00:01:29
91	91	00:01:30
92	92	00:01:28
93	93	00:01:31
94	94	00:01:27
95	95	00:01:32
96	96	00:01:33
97	97	00:01:26
98	98	00:01:29
99	99	00:01:24
100	100	00:01:30
101	101	00:01:25
102	102	00:01:31
103	103	00:01:28
104	104	00:01:27
105	105	00:01:32
106	106	00:01:33
107	107	00:01:26
108	108	00:01:29
109	109	00:01:30
110	110	00:01:28
111	111	00:01:31
112	112	00:01:27
113	113	00:01:32
114	114	00:01:33
115	115	00:01:26
116	116	00:01:29
117	117	00:01:24
118	118	00:01:30
119	119	00:01:25
120	120	00:01:31
121	121	00:01:28
122	122	00:01:27
123	123	00:01:32
124	124	00:01:33
125	125	00:01:26
126	126	00:01:29
127	127	00:01:30
128	128	00:01:28
129	129	00:01:31
130	130	00:01:27
131	131	00:01:32
132	132	00:01:33
133	133	00:01:26
134	134	00:01:29
135	135	00:01:24
136	136	00:01:30
137	137	00:01:25
138	138	00:01:31
139	139	00:01:28
140	140	00:01:27
141	141	00:01:32
142	142	00:01:33
143	143	00:01:26
144	144	00:01:29
145	145	00:01:30
146	146	00:01:28
147	147	00:01:31
148	148	00:01:27
149	149	00:01:32
150	150	00:01:33
151	151	00:01:26
152	152	00:01:29
153	153	00:01:24
154	154	00:01:30
155	155	00:01:25
156	156	00:01:31
157	157	00:01:28
158	158	00:01:27
159	159	00:01:32
160	160	00:01:33
161	161	00:01:26
162	162	00:01:29
163	163	00:01:30
164	164	00:01:28
165	165	00:01:31
166	166	00:01:27
167	167	00:01:32
168	168	00:01:33
169	169	00:01:26
170	170	00:01:29
171	171	00:01:24
172	172	00:01:30
173	173	00:01:25
174	174	00:01:31
175	175	00:01:28
176	176	00:01:27
177	177	00:01:32
178	178	00:01:33
179	179	00:01:26
180	180	00:01:29
181	181	00:01:30
182	182	00:01:28
183	183	00:01:31
184	184	00:01:27
185	185	00:01:32
186	186	00:01:33
187	187	00:01:26
188	188	00:01:29
189	189	00:01:24
190	190	00:01:30
191	191	00:01:25
192	192	00:01:31
193	193	00:01:28
194	194	00:01:27
195	195	00:01:32
196	196	00:01:33
197	197	00:01:26
198	198	00:01:29
199	199	00:01:30
200	200	00:01:28
201	201	00:01:31
202	202	00:01:27
203	203	00:01:32
204	204	00:01:33
205	205	00:01:26
206	206	00:01:29
207	207	00:01:24
208	208	00:01:30
209	209	00:01:25
210	210	00:01:31
211	211	00:01:28
212	212	00:01:27
213	213	00:01:32
214	214	00:01:33
215	215	00:01:26
216	216	00:01:29
217	217	00:01:30
218	218	00:01:28
219	219	00:01:31
220	220	00:01:27
221	221	00:01:32
222	222	00:01:33
223	223	00:01:26
224	224	00:01:29
225	225	00:01:24
226	226	00:01:30
227	227	00:01:25
228	228	00:01:31
229	229	00:01:28
230	230	00:01:27
231	231	00:01:32
232	232	00:01:33
233	233	00:01:26
234	234	00:01:29
235	235	00:01:30
236	236	00:01:28
237	237	00:01:31
238	238	00:01:27
239	239	00:01:32
240	240	00:01:33
241	241	00:01:26
242	242	00:01:29
243	243	00:01:24
244	244	00:01:30
245	245	00:01:25
246	246	00:01:31
247	247	00:01:28
248	248	00:01:27
249	249	00:01:32
250	250	00:01:33
251	251	00:01:26
252	252	00:01:29
253	253	00:01:30
254	254	00:01:28
255	255	00:01:31
256	256	00:01:27
257	257	00:01:32
258	258	00:01:33
259	259	00:01:26
260	260	00:01:29
261	261	00:01:24
262	262	00:01:30
263	263	00:01:25
264	264	00:01:31
265	265	00:01:28
266	266	00:01:27
267	267	00:01:32
268	268	00:01:33
269	269	00:01:26
270	270	00:01:29
271	271	00:01:30
272	272	00:01:28
273	273	00:01:31
274	274	00:01:27
275	275	00:01:32
276	276	00:01:33
277	277	00:01:26
278	278	00:01:29
279	279	00:01:24
280	280	00:01:30
281	281	00:01:25
282	282	00:01:31
283	283	00:01:28
284	284	00:01:27
285	285	00:01:32
286	286	00:01:33
287	287	00:01:26
288	288	00:01:29
289	289	00:01:30
290	290	00:01:28
291	291	00:01:31
292	292	00:01:27
293	293	00:01:32
294	294	00:01:33
295	295	00:01:26
296	296	00:01:29
297	297	00:01:24
298	298	00:01:30
299	299	00:01:25
300	300	00:01:31
301	301	00:01:28
302	302	00:01:27
303	303	00:01:32
304	304	00:01:33
305	305	00:01:26
306	306	00:01:29
307	307	00:01:30
308	308	00:01:28
309	309	00:01:31
310	310	00:01:27
311	311	00:01:32
312	312	00:01:33
313	313	00:01:26
314	314	00:01:29
315	315	00:01:24
316	316	00:01:30
317	317	00:01:25
318	318	00:01:31
319	319	00:01:28
320	320	00:01:27
321	321	00:01:32
322	322	00:01:33
323	323	00:01:26
324	324	00:01:29
325	325	00:01:30
326	326	00:01:28
327	327	00:01:31
328	328	00:01:27
329	329	00:01:32
330	330	00:01:33
331	331	00:01:26
332	332	00:01:29
333	333	00:01:24
334	334	00:01:30
335	335	00:01:25
336	336	00:01:31
337	337	00:01:28
338	338	00:01:27
339	339	00:01:32
340	340	00:01:33
341	341	00:01:26
342	342	00:01:29
343	343	00:01:30
344	344	00:01:28
345	345	00:01:31
346	346	00:01:27
347	347	00:01:32
348	348	00:01:33
349	349	00:01:26
350	350	00:01:29
351	351	00:01:24
352	352	00:01:30
353	353	00:01:25
354	354	00:01:31
355	355	00:01:28
356	356	00:01:27
357	357	00:01:32
358	358	00:01:33
359	359	00:01:26
360	360	00:01:29
361	361	00:01:30
362	362	00:01:28
363	363	00:01:31
364	364	00:01:27
365	365	00:01:32
366	366	00:01:33
367	367	00:01:26
368	368	00:01:29
369	369	00:01:24
370	370	00:01:30
371	371	00:01:25
372	372	00:01:31
373	373	00:01:28
374	374	00:01:27
375	375	00:01:32
376	376	00:01:33
377	377	00:01:26
378	378	00:01:29
379	379	00:01:30
380	380	00:01:28
381	381	00:01:31
382	382	00:01:27
383	383	00:01:32
384	384	00:01:33
385	385	00:01:26
386	386	00:01:29
387	387	00:01:24
388	388	00:01:30
389	389	00:01:25
390	390	00:01:31
391	391	00:01:28
392	392	00:01:27
393	393	00:01:32
394	394	00:01:33
395	395	00:01:26
396	396	00:01:29
397	397	00:01:30
398	398	00:01:28
399	399	00:01:31
400	400	00:01:27
401	401	00:01:32
402	402	00:01:33
403	403	00:01:26
404	404	00:01:29
405	405	00:01:24
406	406	00:01:30
407	407	00:01:25
408	408	00:01:31
409	409	00:01:28
410	410	00:01:27
411	411	00:01:32
412	412	00:01:33
413	413	00:01:26
414	414	00:01:29
415	415	00:01:30
416	416	00:01:28
417	417	00:01:31
418	418	00:01:27
419	419	00:01:32
420	420	00:01:33
421	421	00:01:26
422	422	00:01:29
423	423	00:01:24
424	424	00:01:30
425	425	00:01:25
426	426	00:01:31
427	427	00:01:28
428	428	00:01:27
429	429	00:01:32
430	430	00:01:33
431	431	00:01:26
432	432	00:01:29
433	433	00:01:30
434	434	00:01:28
435	435	00:01:31
436	436	00:01:27
437	437	00:01:32
438	438	00:01:33
439	439	00:01:26
440	440	00:01:29
441	441	00:01:24
442	442	00:01:30
443	443	00:01:25
444	444	00:01:31
445	445	00:01:28
446	446	00:01:27
447	447	00:01:32
448	448	00:01:33
449	449	00:01:26
450	450	00:01:29
451	451	00:01:30
452	452	00:01:28
453	453	00:01:31
454	454	00:01:27
455	455	00:01:32
456	456	00:01:33
457	457	00:01:26
458	458	00:01:29
459	459	00:01:24
460	460	00:01:30
461	461	00:01:25
462	462	00:01:31
463	463	00:01:28
464	464	00:01:27
465	465	00:01:32
466	466	00:01:33
467	467	00:01:26
468	468	00:01:29
469	469	00:01:30
470	470	00:01:28
471	471	00:01:31
472	472	00:01:27
473	473	00:01:32
474	474	00:01:33
475	475	00:01:26
476	476	00:01:29
477	477	00:01:24
478	478	00:01:30
479	479	00:01:25
480	480	00:01:31
481	481	00:01:28
482	482	00:01:27
483	483	00:01:32
484	484	00:01:33
485	485	00:01:26
486	486	00:01:29
487	487	00:01:30
488	488	00:01:28
489	489	00:01:31
490	490	00:01:27
491	491	00:01:32
492	492	00:01:33
493	493	00:01:26
494	494	00:01:29
495	495	00:01:24
496	496	00:01:30
497	497	00:01:25
498	498	00:01:31
499	499	00:01:28
500	500	00:01:27
501	1	00:01:23
502	2	00:01:30
503	3	00:01:28
504	4	00:01:25
505	5	00:01:26
506	6	00:01:29
507	7	00:01:27
508	8	00:01:32
509	9	00:01:24
510	10	00:01:31
511	11	00:01:33
512	12	00:01:28
513	13	00:01:26
514	14	00:01:30
515	15	00:01:27
516	16	00:01:29
517	17	00:01:25
518	18	00:01:31
519	19	00:01:32
520	20	00:01:28
521	21	00:01:33
522	22	00:01:26
523	23	00:01:30
524	24	00:01:27
525	25	00:01:29
526	26	00:01:25
527	27	00:01:32
528	28	00:01:31
529	29	00:01:28
530	30	00:01:24
531	31	00:01:33
532	32	00:01:27
533	33	00:01:29
534	34	00:01:26
535	35	00:01:30
536	36	00:01:32
537	37	00:01:25
538	38	00:01:31
539	39	00:01:28
540	40	00:01:27
541	41	00:01:33
542	42	00:01:26
543	43	00:01:29
544	44	00:01:24
545	45	00:01:31
546	46	00:01:30
547	47	00:01:32
548	48	00:01:28
549	49	00:01:27
550	50	00:01:33
551	51	00:01:26
552	52	00:01:29
553	53	00:01:25
554	54	00:01:30
555	55	00:01:31
556	56	00:01:28
557	57	00:01:32
558	58	00:01:27
559	59	00:01:33
560	60	00:01:26
561	61	00:01:29
562	62	00:01:24
563	63	00:01:30
564	64	00:01:25
565	65	00:01:31
566	66	00:01:28
567	67	00:01:27
568	68	00:01:32
569	69	00:01:33
570	70	00:01:26
571	71	00:01:29
572	72	00:01:30
573	73	00:01:28
574	74	00:01:25
575	75	00:01:31
576	76	00:01:32
577	77	00:01:27
578	78	00:01:33
579	79	00:01:26
580	80	00:01:29
581	81	00:01:24
582	82	00:01:30
583	83	00:01:25
584	84	00:01:31
585	85	00:01:28
586	86	00:01:27
587	87	00:01:32
588	88	00:01:33
589	89	00:01:26
590	90	00:01:29
591	91	00:01:30
592	92	00:01:28
593	93	00:01:25
594	94	00:01:31
595	95	00:01:32
596	96	00:01:27
597	97	00:01:33
598	98	00:01:26
599	99	00:01:29
600	100	00:01:24
601	101	00:01:23
602	102	00:01:30
603	103	00:01:28
604	104	00:01:25
605	105	00:01:26
606	106	00:01:29
607	107	00:01:27
608	108	00:01:32
609	109	00:01:24
610	110	00:01:31
611	111	00:01:33
612	112	00:01:28
613	113	00:01:26
614	114	00:01:30
615	115	00:01:27
616	116	00:01:29
617	117	00:01:25
618	118	00:01:31
619	119	00:01:32
620	120	00:01:28
621	121	00:01:33
622	122	00:01:26
623	123	00:01:30
624	124	00:01:27
625	125	00:01:29
626	126	00:01:25
627	127	00:01:32
628	128	00:01:31
629	129	00:01:28
630	130	00:01:24
631	131	00:01:33
632	132	00:01:27
633	133	00:01:29
634	134	00:01:26
635	135	00:01:30
636	136	00:01:32
637	137	00:01:25
638	138	00:01:31
639	139	00:01:28
640	140	00:01:27
641	141	00:01:33
642	142	00:01:26
643	143	00:01:29
644	144	00:01:24
645	145	00:01:31
646	146	00:01:30
647	147	00:01:32
648	148	00:01:28
649	149	00:01:27
650	150	00:01:33
651	151	00:01:26
652	152	00:01:29
653	153	00:01:25
654	154	00:01:30
655	155	00:01:31
656	156	00:01:28
657	157	00:01:32
658	158	00:01:27
659	159	00:01:33
660	160	00:01:26
661	161	00:01:29
662	162	00:01:30
663	163	00:01:28
664	164	00:01:25
665	165	00:01:31
666	166	00:01:32
667	167	00:01:27
668	168	00:01:33
669	169	00:01:26
670	170	00:01:29
671	171	00:01:24
672	172	00:01:30
673	173	00:01:25
674	174	00:01:31
675	175	00:01:28
676	176	00:01:27
677	177	00:01:32
678	178	00:01:33
679	179	00:01:26
680	180	00:01:29
681	181	00:01:30
682	182	00:01:28
683	183	00:01:25
684	184	00:01:31
685	185	00:01:32
686	186	00:01:27
687	187	00:01:33
688	188	00:01:26
689	189	00:01:29
690	190	00:01:24
691	191	00:01:30
692	192	00:01:25
693	193	00:01:31
694	194	00:01:28
695	195	00:01:27
696	196	00:01:32
697	197	00:01:33
698	198	00:01:26
699	199	00:01:29
700	200	00:01:24
701	201	00:01:23
702	202	00:01:30
703	203	00:01:28
704	204	00:01:25
705	205	00:01:26
706	206	00:01:29
707	207	00:01:27
708	208	00:01:32
709	209	00:01:24
710	210	00:01:31
711	211	00:01:33
712	212	00:01:28
713	213	00:01:26
714	214	00:01:30
715	215	00:01:27
716	216	00:01:29
717	217	00:01:25
718	218	00:01:31
719	219	00:01:32
720	220	00:01:28
721	221	00:01:33
722	222	00:01:26
723	223	00:01:30
724	224	00:01:27
725	225	00:01:29
726	226	00:01:25
727	227	00:01:32
728	228	00:01:31
729	229	00:01:28
730	230	00:01:24
731	231	00:01:33
732	232	00:01:27
733	233	00:01:29
734	234	00:01:26
735	235	00:01:30
736	236	00:01:32
737	237	00:01:25
738	238	00:01:31
739	239	00:01:28
740	240	00:01:27
741	241	00:01:33
742	242	00:01:26
743	243	00:01:29
744	244	00:01:24
745	245	00:01:31
746	246	00:01:30
747	247	00:01:32
748	248	00:01:28
749	249	00:01:27
750	250	00:01:33
751	251	00:01:26
752	252	00:01:29
753	253	00:01:25
754	254	00:01:30
755	255	00:01:31
756	256	00:01:28
757	257	00:01:32
758	258	00:01:27
759	259	00:01:33
760	260	00:01:26
761	261	00:01:29
762	262	00:01:30
763	263	00:01:28
764	264	00:01:25
765	265	00:01:31
766	266	00:01:32
767	267	00:01:27
768	268	00:01:33
769	269	00:01:26
770	270	00:01:29
771	271	00:01:24
772	272	00:01:30
773	273	00:01:25
774	274	00:01:31
775	275	00:01:28
776	276	00:01:27
777	277	00:01:32
778	278	00:01:33
779	279	00:01:26
780	280	00:01:29
781	281	00:01:30
782	282	00:01:28
783	283	00:01:25
784	284	00:01:31
785	285	00:01:32
786	286	00:01:27
787	287	00:01:33
788	288	00:01:26
789	289	00:01:29
790	290	00:01:24
791	291	00:01:30
792	292	00:01:25
793	293	00:01:31
794	294	00:01:28
795	295	00:01:27
796	296	00:01:32
797	297	00:01:33
798	298	00:01:26
799	299	00:01:29
800	300	00:01:24
801	301	00:01:23
802	302	00:01:30
803	303	00:01:28
804	304	00:01:25
805	305	00:01:26
806	306	00:01:29
807	307	00:01:27
808	308	00:01:32
809	309	00:01:24
810	310	00:01:31
811	311	00:01:33
812	312	00:01:28
813	313	00:01:26
814	314	00:01:30
815	315	00:01:27
816	316	00:01:29
817	317	00:01:25
818	318	00:01:31
819	319	00:01:32
820	320	00:01:28
821	321	00:01:33
822	322	00:01:26
823	323	00:01:30
824	324	00:01:27
825	325	00:01:29
826	326	00:01:25
827	327	00:01:32
828	328	00:01:31
829	329	00:01:28
830	330	00:01:24
831	331	00:01:33
832	332	00:01:27
833	333	00:01:29
834	334	00:01:26
835	335	00:01:30
836	336	00:01:32
837	337	00:01:25
838	338	00:01:31
839	339	00:01:28
840	340	00:01:27
841	341	00:01:33
842	342	00:01:26
843	343	00:01:29
844	344	00:01:24
845	345	00:01:31
846	346	00:01:30
847	347	00:01:32
848	348	00:01:28
849	349	00:01:27
850	350	00:01:33
851	351	00:01:26
852	352	00:01:29
853	353	00:01:25
854	354	00:01:30
855	355	00:01:31
856	356	00:01:28
857	357	00:01:32
858	358	00:01:27
859	359	00:01:33
860	360	00:01:26
861	361	00:01:29
862	362	00:01:30
863	363	00:01:28
864	364	00:01:25
865	365	00:01:31
866	366	00:01:32
867	367	00:01:27
868	368	00:01:33
869	369	00:01:26
870	370	00:01:29
871	371	00:01:24
872	372	00:01:30
873	373	00:01:25
874	374	00:01:31
875	375	00:01:28
876	376	00:01:27
877	377	00:01:32
878	378	00:01:33
879	379	00:01:26
880	380	00:01:29
881	381	00:01:30
882	382	00:01:28
883	383	00:01:25
884	384	00:01:31
885	385	00:01:32
886	386	00:01:27
887	387	00:01:33
888	388	00:01:26
889	389	00:01:29
890	390	00:01:24
891	391	00:01:30
892	392	00:01:25
893	393	00:01:31
894	394	00:01:28
895	395	00:01:27
896	396	00:01:32
897	397	00:01:33
898	398	00:01:26
899	399	00:01:29
900	400	00:01:24
901	401	00:01:23
902	402	00:01:30
903	403	00:01:28
904	404	00:01:25
905	405	00:01:26
906	406	00:01:29
907	407	00:01:27
908	408	00:01:32
909	409	00:01:24
910	410	00:01:31
911	411	00:01:33
912	412	00:01:28
913	413	00:01:26
914	414	00:01:30
915	415	00:01:27
916	416	00:01:29
917	417	00:01:25
918	418	00:01:31
919	419	00:01:32
920	420	00:01:28
921	421	00:01:33
922	422	00:01:26
923	423	00:01:30
924	424	00:01:27
925	425	00:01:29
926	426	00:01:25
927	427	00:01:32
928	428	00:01:31
929	429	00:01:28
930	430	00:01:24
931	431	00:01:33
932	432	00:01:27
933	433	00:01:29
934	434	00:01:26
935	435	00:01:30
936	436	00:01:32
937	437	00:01:25
938	438	00:01:31
939	439	00:01:28
940	440	00:01:27
941	441	00:01:33
942	442	00:01:26
943	443	00:01:29
944	444	00:01:24
945	445	00:01:31
946	446	00:01:30
947	447	00:01:32
948	448	00:01:28
949	449	00:01:27
950	450	00:01:33
951	451	00:01:26
952	452	00:01:29
953	453	00:01:25
954	454	00:01:30
955	455	00:01:31
956	456	00:01:28
957	457	00:01:32
958	458	00:01:27
959	459	00:01:33
960	460	00:01:26
961	461	00:01:29
962	462	00:01:30
963	463	00:01:28
964	464	00:01:25
965	465	00:01:31
966	466	00:01:32
967	467	00:01:27
968	468	00:01:33
969	469	00:01:26
970	470	00:01:29
971	471	00:01:24
972	472	00:01:30
973	473	00:01:25
974	474	00:01:31
975	475	00:01:28
976	476	00:01:27
977	477	00:01:32
978	478	00:01:33
979	479	00:01:26
980	480	00:01:29
981	481	00:01:30
982	482	00:01:28
983	483	00:01:25
984	484	00:01:31
985	485	00:01:32
986	486	00:01:27
987	487	00:01:33
988	488	00:01:26
989	489	00:01:29
990	490	00:01:24
991	491	00:01:30
992	492	00:01:25
993	493	00:01:31
994	494	00:01:28
995	495	00:01:27
996	496	00:01:32
997	497	00:01:33
998	498	00:01:26
999	499	00:01:29
1000	500	00:01:24
\.


--
-- TOC entry 4854 (class 2606 OID 99338)
-- Name: accidentes accidentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accidentes
    ADD CONSTRAINT accidentes_pkey PRIMARY KEY (idaccidente);


--
-- TOC entry 4812 (class 2606 OID 99125)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (idcargo);


--
-- TOC entry 4836 (class 2606 OID 99246)
-- Name: carreras carreras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT carreras_pkey PRIMARY KEY (idcarrera);


--
-- TOC entry 4844 (class 2606 OID 99286)
-- Name: carrerasclasificatorias carrerasclasificatorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_pkey PRIMARY KEY (idcarrera);


--
-- TOC entry 4838 (class 2606 OID 99261)
-- Name: carreraslibres carreraslibres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreraslibres
    ADD CONSTRAINT carreraslibres_pkey PRIMARY KEY (idcarrera);


--
-- TOC entry 4840 (class 2606 OID 99271)
-- Name: carrerasprincipales carrerasprincipales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrerasprincipales
    ADD CONSTRAINT carrerasprincipales_pkey PRIMARY KEY (idcarrera);


--
-- TOC entry 4830 (class 2606 OID 99216)
-- Name: circuitos circuitos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.circuitos
    ADD CONSTRAINT circuitos_pkey PRIMARY KEY (idcircuito);


--
-- TOC entry 4802 (class 2606 OID 99075)
-- Name: ciudades ciudades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY (idciudad);


--
-- TOC entry 4804 (class 2606 OID 99085)
-- Name: equipos equipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (idequipo);


--
-- TOC entry 4832 (class 2606 OID 99226)
-- Name: grandespremios grandespremios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_pkey PRIMARY KEY (idgranpremio);


--
-- TOC entry 4818 (class 2606 OID 99145)
-- Name: haceparte haceparte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_pkey PRIMARY KEY (idhaceparte);


--
-- TOC entry 4824 (class 2606 OID 99185)
-- Name: motores motores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motores
    ADD CONSTRAINT motores_pkey PRIMARY KEY (idmotor);


--
-- TOC entry 4862 (class 2606 OID 99378)
-- Name: noticias noticias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.noticias
    ADD CONSTRAINT noticias_pkey PRIMARY KEY (idnoticia);


--
-- TOC entry 4800 (class 2606 OID 99070)
-- Name: paises paises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (idpais);


--
-- TOC entry 4856 (class 2606 OID 99348)
-- Name: paradaenboxes paradaenboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paradaenboxes
    ADD CONSTRAINT paradaenboxes_pkey PRIMARY KEY (idparadaenbox);


--
-- TOC entry 4848 (class 2606 OID 99308)
-- Name: participaciones participaciones_idparticipacion_idvehiculo_idcarrera_idpers_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idparticipacion_idvehiculo_idcarrera_idpers_key UNIQUE (idparticipacion, idvehiculo, idcarrera, idpersona);


--
-- TOC entry 4850 (class 2606 OID 99306)
-- Name: participaciones participaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_pkey PRIMARY KEY (idparticipacion);


--
-- TOC entry 4806 (class 2606 OID 99095)
-- Name: patrocinadores patrocinadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinadores
    ADD CONSTRAINT patrocinadores_pkey PRIMARY KEY (idpatrocinador);


--
-- TOC entry 4810 (class 2606 OID 99105)
-- Name: patrocinadoresequipos patrocinadoresequipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_pkey PRIMARY KEY (idequipo, idpatrocinador, idtemporada);


--
-- TOC entry 4814 (class 2606 OID 99130)
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (idpersona);


--
-- TOC entry 4816 (class 2606 OID 99135)
-- Name: pilotos pilotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotos
    ADD CONSTRAINT pilotos_pkey PRIMARY KEY (idpersona);


--
-- TOC entry 4822 (class 2606 OID 99170)
-- Name: pilotosestadopilotos pilotosestadopilotos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_pkey PRIMARY KEY (idestadopiloto);


--
-- TOC entry 4864 (class 2606 OID 99383)
-- Name: plataformas plataformas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataformas
    ADD CONSTRAINT plataformas_pkey PRIMARY KEY (idplataforma);


--
-- TOC entry 4866 (class 2606 OID 99388)
-- Name: plataformascarreras plataformascarreras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataformascarreras
    ADD CONSTRAINT plataformascarreras_pkey PRIMARY KEY (idplataformascarreras);


--
-- TOC entry 4846 (class 2606 OID 99301)
-- Name: puntajes puntajes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.puntajes
    ADD CONSTRAINT puntajes_pkey PRIMARY KEY (idpuntaje);


--
-- TOC entry 4858 (class 2606 OID 99358)
-- Name: sanciones sanciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanciones
    ADD CONSTRAINT sanciones_pkey PRIMARY KEY (idsancion);


--
-- TOC entry 4860 (class 2606 OID 99363)
-- Name: sancionesvueltas sancionesvueltas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_pkey PRIMARY KEY (idsancionvuelta);


--
-- TOC entry 4808 (class 2606 OID 99100)
-- Name: temporadas temporadas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporadas
    ADD CONSTRAINT temporadas_pkey PRIMARY KEY (idtemporada);


--
-- TOC entry 4834 (class 2606 OID 99241)
-- Name: tiposdecarreras tiposdecarreras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiposdecarreras
    ADD CONSTRAINT tiposdecarreras_pkey PRIMARY KEY (idtipodecarrera);


--
-- TOC entry 4842 (class 2606 OID 99281)
-- Name: tiposdeclasificacion tiposdeclasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiposdeclasificacion
    ADD CONSTRAINT tiposdeclasificacion_pkey PRIMARY KEY (idtipodeclasificacion);


--
-- TOC entry 4826 (class 2606 OID 99191)
-- Name: tiposdeneumaticos tiposdeneumaticos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiposdeneumaticos
    ADD CONSTRAINT tiposdeneumaticos_pkey PRIMARY KEY (idtipodeneumatico);


--
-- TOC entry 4820 (class 2606 OID 99165)
-- Name: tiposestadospiloto tiposestadospiloto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiposestadospiloto
    ADD CONSTRAINT tiposestadospiloto_pkey PRIMARY KEY (idtipoestadopiloto);


--
-- TOC entry 4828 (class 2606 OID 99196)
-- Name: vehiculos vehiculos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (idvehiculo);


--
-- TOC entry 4852 (class 2606 OID 99328)
-- Name: vueltas vueltas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vueltas
    ADD CONSTRAINT vueltas_pkey PRIMARY KEY (idvuelta);


--
-- TOC entry 4894 (class 2606 OID 99339)
-- Name: accidentes accidentes_idvuelta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accidentes
    ADD CONSTRAINT accidentes_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);


--
-- TOC entry 4884 (class 2606 OID 99247)
-- Name: carreras carreras_idgranpremio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT carreras_idgranpremio_fkey FOREIGN KEY (idgranpremio) REFERENCES public.grandespremios(idgranpremio);


--
-- TOC entry 4885 (class 2606 OID 99252)
-- Name: carreras carreras_idtipodecarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT carreras_idtipodecarrera_fkey FOREIGN KEY (idtipodecarrera) REFERENCES public.tiposdecarreras(idtipodecarrera);


--
-- TOC entry 4888 (class 2606 OID 99287)
-- Name: carrerasclasificatorias carrerasclasificatorias_idcarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);


--
-- TOC entry 4889 (class 2606 OID 99292)
-- Name: carrerasclasificatorias carrerasclasificatorias_idtipodeclasificacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_idtipodeclasificacion_fkey FOREIGN KEY (idtipodeclasificacion) REFERENCES public.tiposdeclasificacion(idtipodeclasificacion);


--
-- TOC entry 4886 (class 2606 OID 99262)
-- Name: carreraslibres carreraslibres_idcarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carreraslibres
    ADD CONSTRAINT carreraslibres_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);


--
-- TOC entry 4887 (class 2606 OID 99272)
-- Name: carrerasprincipales carrerasprincipales_idcarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrerasprincipales
    ADD CONSTRAINT carrerasprincipales_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);


--
-- TOC entry 4881 (class 2606 OID 99217)
-- Name: circuitos circuitos_idciudad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.circuitos
    ADD CONSTRAINT circuitos_idciudad_fkey FOREIGN KEY (idciudad) REFERENCES public.ciudades(idciudad);


--
-- TOC entry 4867 (class 2606 OID 99076)
-- Name: ciudades ciudades_idpais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_idpais_fkey FOREIGN KEY (idpais) REFERENCES public.paises(idpais);


--
-- TOC entry 4868 (class 2606 OID 99086)
-- Name: equipos equipos_paisdeorigen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_paisdeorigen_fkey FOREIGN KEY (paisdeorigen) REFERENCES public.paises(idpais);


--
-- TOC entry 4882 (class 2606 OID 99232)
-- Name: grandespremios grandespremios_idcircuito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_idcircuito_fkey FOREIGN KEY (idcircuito) REFERENCES public.circuitos(idcircuito);


--
-- TOC entry 4883 (class 2606 OID 99227)
-- Name: grandespremios grandespremios_idtemporada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_idtemporada_fkey FOREIGN KEY (idtemporada) REFERENCES public.temporadas(idtemporada);


--
-- TOC entry 4873 (class 2606 OID 99156)
-- Name: haceparte haceparte_idcargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idcargo_fkey FOREIGN KEY (idcargo) REFERENCES public.cargos(idcargo);


--
-- TOC entry 4874 (class 2606 OID 99146)
-- Name: haceparte haceparte_idequipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);


--
-- TOC entry 4875 (class 2606 OID 99151)
-- Name: haceparte haceparte_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.personas(idpersona);


--
-- TOC entry 4895 (class 2606 OID 99349)
-- Name: paradaenboxes paradaenboxes_idvuelta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paradaenboxes
    ADD CONSTRAINT paradaenboxes_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);


--
-- TOC entry 4890 (class 2606 OID 99314)
-- Name: participaciones participaciones_idcarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);


--
-- TOC entry 4891 (class 2606 OID 99319)
-- Name: participaciones participaciones_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.pilotos(idpersona);


--
-- TOC entry 4892 (class 2606 OID 99309)
-- Name: participaciones participaciones_idvehiculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idvehiculo_fkey FOREIGN KEY (idvehiculo) REFERENCES public.vehiculos(idvehiculo);


--
-- TOC entry 4869 (class 2606 OID 99106)
-- Name: patrocinadoresequipos patrocinadoresequipos_idequipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);


--
-- TOC entry 4870 (class 2606 OID 99111)
-- Name: patrocinadoresequipos patrocinadoresequipos_idpatrocinador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idpatrocinador_fkey FOREIGN KEY (idpatrocinador) REFERENCES public.patrocinadores(idpatrocinador);


--
-- TOC entry 4871 (class 2606 OID 99116)
-- Name: patrocinadoresequipos patrocinadoresequipos_idtemporada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idtemporada_fkey FOREIGN KEY (idtemporada) REFERENCES public.temporadas(idtemporada);


--
-- TOC entry 4872 (class 2606 OID 99136)
-- Name: pilotos pilotos_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotos
    ADD CONSTRAINT pilotos_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.personas(idpersona);


--
-- TOC entry 4876 (class 2606 OID 99171)
-- Name: pilotosestadopilotos pilotosestadopilotos_idpersona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.pilotos(idpersona);


--
-- TOC entry 4877 (class 2606 OID 99176)
-- Name: pilotosestadopilotos pilotosestadopilotos_idtipoestadopiloto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_idtipoestadopiloto_fkey FOREIGN KEY (idtipoestadopiloto) REFERENCES public.tiposestadospiloto(idtipoestadopiloto);


--
-- TOC entry 4898 (class 2606 OID 99394)
-- Name: plataformascarreras plataformascarreras_idcarrera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataformascarreras
    ADD CONSTRAINT plataformascarreras_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);


--
-- TOC entry 4899 (class 2606 OID 99389)
-- Name: plataformascarreras plataformascarreras_idplataforma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataformascarreras
    ADD CONSTRAINT plataformascarreras_idplataforma_fkey FOREIGN KEY (idplataforma) REFERENCES public.plataformas(idplataforma);


--
-- TOC entry 4896 (class 2606 OID 99369)
-- Name: sancionesvueltas sancionesvueltas_idsancion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_idsancion_fkey FOREIGN KEY (idsancion) REFERENCES public.sanciones(idsancion);


--
-- TOC entry 4897 (class 2606 OID 99364)
-- Name: sancionesvueltas sancionesvueltas_idvuelta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);


--
-- TOC entry 4878 (class 2606 OID 99207)
-- Name: vehiculos vehiculos_idequipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);


--
-- TOC entry 4879 (class 2606 OID 99197)
-- Name: vehiculos vehiculos_idtipodemotor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idtipodemotor_fkey FOREIGN KEY (idtipodemotor) REFERENCES public.motores(idmotor);


--
-- TOC entry 4880 (class 2606 OID 99202)
-- Name: vehiculos vehiculos_idtipodeneumatico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idtipodeneumatico_fkey FOREIGN KEY (idtipodeneumatico) REFERENCES public.tiposdeneumaticos(idtipodeneumatico);


--
-- TOC entry 4893 (class 2606 OID 99329)
-- Name: vueltas vueltas_idparticipacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vueltas
    ADD CONSTRAINT vueltas_idparticipacion_fkey FOREIGN KEY (idparticipacion) REFERENCES public.participaciones(idparticipacion);


-- Completed on 2024-06-02 23:15:45

--
-- PostgreSQL database dump complete
--

