-- ¿Cual es el nombre y el pais de las competiciones que se dieron en una temporada especifica?
SELECT GP.nombre as "Gran Premio", PS.nombre as "Pais" from public.grandespremios as GP
JOIN circuitos as CT on CT.idcircuito = GP.idcircuito
JOIN ciudades as CD on CD.idciudad = CT.idciudad
JOIN public.paises as PS on CD.idpais = PS.idpais;

-- ¿Cual es el nombre y la longitud del circuito mas extenso que se utilizo en una temporada en especifico?
SELECT CIRCUITOS.NOMBRE, CIRCUITOS.LONGITUD
FROM GRANDESPREMIOS 
JOIN CIRCUITOS ON CIRCUITOS.IDCIRCUITO = GRANDESPREMIOS.IDCIRCUITO
WHERE GRANDESPREMIOS.IDTEMPORADA = 2 ORDER BY CIRCUITOS.LONGITUD DESC LIMIT 1;

-- ¿Cuales son los circuitos que no son aptos para realizar carreras formula 1?
SELECT * FROM CIRCUITOS WHERE CIRCUITOS.LONGITUD < 3;

-- ¿Cual es el nombre del equipo, el tipo de neumaticos y el peso del vehıculo del competidor X en una carrera en especifico?
create or replace function carroDePiloto(id_Piloto int, id_carrera int)
returns table (
    nombre_equipo varchar(50),
    peso_vehiculo double precision,
    dureza_neumatico varchar(20)
) as
$$
begin
    return query
    SELECT EQUIPOS.NOMBRE, VEHICULOS.PESO, TIPOSDENEUMATICOS.DUREZA
    FROM PARTICIPACIONES
    JOIN VEHICULOS ON VEHICULOS.IDVEHICULO = PARTICIPACIONES.IDVEHICULO
    JOIN TIPOSDENEUMATICOS ON TIPOSDENEUMATICOS.IDTIPODENEUMATICO = VEHICULOS.IDTIPODENEUMATICO
    JOIN EQUIPOS ON EQUIPOS.IDEQUIPO = VEHICULOS.IDEQUIPO
    WHERE PARTICIPACIONES.idpersona = id_Piloto AND PARTICIPACIONES.idcarrera = id_carrera;
end;
$$
language plpgsql;


SELECT * FROM carroDePiloto(1, 1);



-- ¿Cual es la posicion, nombre del piloto, el peso del vehiculo y los puntos que
-- tienen los pilotos que participan en la temporada 2? Ordenelos por posicion.
CREATE OR REPLACE FUNCTION TiempoDeTodasLasVueltas(id_participacion INT)
RETURNS INTERVAL AS $$
DECLARE
    tiempototalV INTERVAL;
BEGIN
    SELECT SUM(COALESCE(VUELTAS.tiempo, '00:00:00'::INTERVAL) + COALESCE(SANCIONES.penalizacion, '00:00:00'::INTERVAL)) AS TiempoTotal INTO tiempototalV
    FROM PARTICIPACIONES 
    LEFT JOIN VUELTAS ON VUELTAS.IDPARTICIPACION = PARTICIPACIONES.IDPARTICIPACION
    LEFT JOIN SANCIONESVUELTAS ON SANCIONESVUELTAS.IDVUELTA = VUELTAS.IDVUELTA
    LEFT JOIN SANCIONES ON SANCIONES.IDSANCION = SANCIONESVUELTAS.IDSANCION
    WHERE VUELTAS.IDPARTICIPACION = id_participacion;
    
    RETURN tiempototalV;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ObtenerRankingDeCarrera(id_carrera INT)
RETURNS TABLE (
    id_participacion INT,
    tiempo_total INTERVAL,
    ranking INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        PARTICIPACIONES.IDPARTICIPACION, 
        TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) AS tiempo_total,
        DENSE_RANK() OVER (ORDER BY TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) ASC) AS ranking
    FROM PARTICIPACIONES 
    JOIN CARRERAS ON CARRERAS.IDCARRERA = PARTICIPACIONES.IDCARRERA
    WHERE CARRERAS.IDCARRERA = id_carrera
    ORDER BY TiempoDeTodasLasVueltas(PARTICIPACIONES.IDPARTICIPACION) ASC;
END;
$$ LANGUAGE plpgsql;



-- ¿Cual es el nombre, numero de integrantes y el nombre del patrocinador de los equipos que
-- participan en una temporada?


-- ¿Cual es el nombre, carrera y fecha de lesiones (si existe) que un piloto ha tenido en toda su
-- trayectoria en la Formula 1?


-- ¿Cual es el nombre, la fecha y descripcion de las sanciones que un piloto tuvo en una carrera
-- determinada?


-- ¿Cual es la fecha, el paıs, la ciudad y el circuito de las carreras que ocurriran proximamente?
-- ordenadas por fecha


-- ¿Cual es el nombre, equipo y tiempo de un piloto determinado que ha participado en una carrera
-- libre?


-- ¿Cual es el nombre del piloto, el numero, la posicion, el modelo del vehıculo, el tiempo total en
-- vueltas y el numero de vueltas que hizo un piloto en una carrera?


-- ¿Cual es el nombre, apellido y cargo de los integrantes de un equipo determinado?


-- ¿Cual es el numero de accidentes ocurridos en una temporada especıfica?


-- ¿Cual es el nombre del gran premio, la fecha, el modelo de vehıculo, la posicion y los puntos que
-- hizo un piloto en una temporada?


-- ¿Cual es el fabricante y tipo de llanta mas utilizado en una carrera determinada?


-- ¿Cual es la posicion, el nombre del equipo y los puntos que posee un equipo en una temporada
-- en especifico? Ordenados por puntos.


-- ¿Cual es el nombre del gran premio, la fecha de fin y los puntos que ha tenido un equipo en una
-- temporada?


-- ¿Cual es el nombre del equipo con mas puntos en toda la historia de la Formula 1?
SELECT EQ.idEquipo, EQ.nombre as nombreEquipo, sum(p.puntaje) as totalPuntos
    FROM participaciones PA
    JOIN puntajes P on PA.idpuntaje = P.idpuntaje
    JOIN vehiculos VH on PA.idvehiculo = VH.idvehiculo
    JOIN equipos EQ on EQ.idequipo = VH.idequipo
    GROUP BY EQ.idEquipo, EQ.nombre
    ORDER BY EQ.idequipo,EQ.nombre
    LIMIT 1;


-- ¿Cual es el gran premio, el nombre del conductor, el vehıculo y el tiempo de las vueltas mas
-- rapidas que se han hecho en cada gran premio de una temporada?


-- ¿Cual es el circuito que mas se ha utilizado en toda la historia de la Formula 1?