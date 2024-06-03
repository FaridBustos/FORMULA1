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



-- ¿Cual es el nombre del piloto, y los puntos que
-- tienen los pilotos que participan en la temporada 2? Ordenelos por puntos.
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

SELECT 
PERSONAS.NOMBRE,
SUM(PUNTAJES.PUNTAJE) AS PUNTAJETOTAL
FROM PARTICIPACIONES
JOIN PILOTOS ON PILOTOS.IDPERSONA = PARTICIPACIONES.IDPERSONA
JOIN PERSONAS ON PERSONAS.IDPERSONA = PILOTOS.IDPERSONA
JOIN CARRERAS ON CARRERAS.IDCARRERA = PARTICIPACIONES.IDCARRERA
JOIN GRANDESPREMIOS ON GRANDESPREMIOS.IDGRANPREMIO = CARRERAS.IDGRANPREMIO
JOIN TEMPORADAS ON TEMPORADAS.IDTEMPORADA = GRANDESPREMIOS.IDTEMPORADA
JOIN ObtenerRankingDeCarrera(CARRERAS.IDCARRERA) AS RANKINGS ON RANKINGS.ID_PARTICIPACION = PARTICIPACIONES.IDPARTICIPACION
LEFT JOIN PUNTAJES ON PUNTAJES.POSICION = RANKINGS.RANKING
WHERE CARRERAS.IDTIPODECARRERA = 1 AND TEMPORADAS.IDTEMPORADA = 2
GROUP BY PERSONAS.NOMBRE
ORDER BY PUNTAJETOTAL desc;



-- ¿Cual es el nombre del equipo y el nombre del patrocinador de los equipos que
-- participan en una temporada?
SELECT EQUIPOS.NOMBRE AS EQUIPO, PATROCINADORES.NOMBRE AS PATROCINADOR
FROM PATROCINADORESEQUIPOS
JOIN EQUIPOS ON EQUIPOS.IDEQUIPO = PATROCINADORESEQUIPOS.IDEQUIPO
JOIN PATROCINADORES ON PATROCINADORES.IDPATROCINADOR = PATROCINADORESEQUIPOS.IDPATROCINADOR
WHERE PATROCINADORESEQUIPOS.IDTEMPORADA = 2;

-- ¿Cual es el nombre del piloto y estados (si existe) que un piloto ha tenido en toda su
-- trayectoria en la Formula 1?
SELECT 
PERSONAS.NOMBRE AS PILOTO, 
tiposestadospiloto.NOMBRE AS ESTADO, 
pilotosestadopilotos.FECHADEINICIO, 
pilotosestadopilotos.FECHADEFIN
FROM pilotosestadopilotos
JOIN tiposestadospiloto ON tiposestadospiloto.IDTIPOESTADOPILOTO = pilotosestadopilotos.IDTIPOESTADOPILOTO
JOIN PERSONAS ON PERSONAS.IDPERSONA = pilotosestadopilotos.IDPERSONA;


-- ¿Cuál es el nombre del piloto, la fecha, la hora y descripción de las sanciones 
-- que hubo en una carrera de la formula 1?
-- ¿Cuál es el nombre del piloto, la fecha, la hora y descripción de las sanciones que un piloto tuvo en una carrera determinada?

SELECT 
PERSONAS.NOMBRE,
SANCIONES.DESCRIPCION,
CARRERAS.FECHA,
CARRERAS.HORA
FROM SANCIONESVUELTAS
JOIN SANCIONES ON SANCIONES.IDSANCION = SANCIONESVUELTAS.IDSANCION
JOIN VUELTAS ON VUELTAS.IDVUELTA = SANCIONESVUELTAS.IDVUELTA
JOIN PARTICIPACIONES ON PARTICIPACIONES.IDPARTICIPACION = VUELTAS.IDPARTICIPACION
JOIN CARRERAS ON CARRERAS.IDCARRERA = PARTICIPACIONES.IDCARRERA
JOIN PERSONAS ON PERSONAS.IDPERSONA = PARTICIPACIONES.IDPERSONA
where CARRERAS.idcarrera = 1
ORDER BY PERSONAS.NOMBRE;

-- ¿Cual es la fecha, la hora, el paıs, la ciudad y el circuito de las carreras que ocurriran despues del 2022-01-01?
-- ordenadas por fecha
SELECT CARRERAS.fecha, CARRERAS.hora, CIUDADES.NOMBRE, PAISES.NOMBRE, CIRCUITOS.NOMBRE
FROM CARRERAS
JOIN GRANDESPREMIOS ON GRANDESPREMIOS.IDGRANPREMIO = CARRERAS.IDGRANPREMIO
JOIN CIRCUITOS ON CIRCUITOS.IDCIRCUITO = GRANDESPREMIOS.IDCIRCUITO
JOIN CIUDADES ON CIUDADES.IDCIUDAD = CIRCUITOS.IDCIUDAD
JOIN PAISES ON PAISES.IDPAIS = CIUDADES.IDPAIS
WHERE CARRERAS.FECHA > '2022-01-01'
ORDER BY CARRERAS.FECHA ASC;


-- ¿Cual es el nombre del piloto, la carrera y la posicion de ranking de un piloto determinado que ha participado en una carrera
-- libre?
SELECT PERSONAS.NOMBRE, RANKINGS.RANKING, PARTICIPACIONES.idcarrera
FROM PARTICIPACIONES 
JOIN ObtenerRankingDeCarrera(PARTICIPACIONES.IDCARRERA) AS RANKINGS ON RANKINGS.ID_PARTICIPACION = PARTICIPACIONES.IDPARTICIPACION
JOIN PERSONAS ON PERSONAS.IDPERSONA = PARTICIPACIONES.IDPERSONA
JOIN CARRERAS ON CARRERAS.IDCARRERA = PARTICIPACIONES.IDCARRERA
WHERE PARTICIPACIONES.IDPERSONA = 1 AND CARRERAS.IDTIPODECARRERA = 2
ORDER BY RANKING;

-- ¿Cuál es el nombre del piloto, el número, la posición, el modelo del vehículo, el tiempo total en
-- vueltas y el número de vueltas que hizo un piloto en una carrera?

SELECT Personas.nombre AS Nombre_Piloto, Equipos.idEquipo AS Numero_Equipo, Participaciones.posicionDeLlegada AS Posicion, Vehiculos.modelo AS Modelo_Vehiculo, SUM(Vueltas.tiempo) AS Tiempo_Total_Vueltas, COUNT(Vueltas.idVuelta) AS Numero_Vueltas
FROM Personas
JOIN Pilotos ON Personas.idPersona = Pilotos.idPersona
JOIN Participaciones ON Pilotos.idPersona = Participaciones.idPersona
JOIN Vehiculos ON Participaciones.idVehiculo = Vehiculos.idVehiculo
JOIN Equipos ON Vehiculos.idEquipo = Equipos.idEquipo
JOIN Vueltas ON Participaciones.idParticipacion = Vueltas.idParticipacion
WHERE Participaciones.idCarrera = 3
GROUP BY Personas.nombre, Equipos.idEquipo, Participaciones.posicionDeLlegada, Vehiculos.modelo;



-- ¿Cuál es el nombre, apellido y cargo de los integrantes de un equipo determinado?

SELECT Personas.nombre AS Nombre, Cargos.nombre AS Cargo
FROM HaceParte
JOIN Personas ON HaceParte.idPersona = Personas.idPersona
JOIN Cargos ON HaceParte.idCargo = Cargos.idCargo
WHERE HaceParte.idEquipo = 2;


-- ¿Cuál es el número de accidentes ocurridos en una temporada específica?

SELECT COUNT(Accidentes.idAccidente) AS Numero_Accidentes
FROM GrandesPremios
JOIN Carreras ON GrandesPremios.idGranPremio = Carreras.idGranPremio
JOIN Participaciones ON Carreras.idCarrera = Participaciones.idCarrera
JOIN Vueltas ON Participaciones.idParticipacion = Vueltas.idParticipacion
JOIN Accidentes ON Vueltas.idVuelta = Accidentes.idVuelta
WHERE GrandesPremios.idTemporada = 2;


-- ¿Cuál es el nombre del gran premio, la fecha, el modelo de vehículo, la posición y los puntos que
-- hizo un piloto en una temporada?


SELECT GrandesPremios.nombre AS Nombre_GranPremio, GrandesPremios.fechaInicio AS Fecha, Vehiculos.modelo AS Modelo_Vehiculo, Participaciones.posicionDeLlegada AS Posicion, Puntajes.puntaje AS Puntos
FROM GrandesPremios
JOIN Carreras ON GrandesPremios.idGranPremio = Carreras.idGranPremio
JOIN Participaciones ON Carreras.idCarrera = Participaciones.idCarrera
JOIN Vehiculos ON Participaciones.idVehiculo = Vehiculos.idVehiculo
JOIN Pilotos ON Participaciones.idPersona = Pilotos.idPersona
JOIN Puntajes ON Participaciones.posicionDeLlegada = Puntajes.posicion
WHERE Pilotos.idPersona = 1 AND GrandesPremios.idTemporada = 2;




-- ¿Cuál es el fabricante y tipo de llanta más utilizado en una carrera determinada?

SELECT TiposDeNeumaticos.dureza AS Tipo_Llanta, COUNT(Vehiculos.idTipoDeNeumatico) AS Cantidad
FROM Carreras
JOIN Participaciones ON Carreras.idCarrera = Participaciones.idCarrera
JOIN Vehiculos ON Participaciones.idVehiculo = Vehiculos.idVehiculo
JOIN TiposDeNeumaticos ON Vehiculos.idTipoDeNeumatico = TiposDeNeumaticos.idTipoDeNeumatico
WHERE Carreras.idCarrera = 2
GROUP BY TiposDeNeumaticos.dureza
ORDER BY Cantidad DESC
LIMIT 1;

-- ¿Cual es la posición, el nombre del equipo y los puntos que posee un equipo en una temporada
-- en especifico? Ordenados por puntos
WITH PuntosPorEquipo AS (
    SELECT
        EQUIPOS.nombre AS NombreEquipo,
        SUM(PUNTAJES.puntaje) AS PuntosTotales
    FROM
        EQUIPOS
        JOIN VEHICULOS ON EQUIPOS.idEquipo = VEHICULOS.idEquipo
        JOIN PARTICIPACIONES ON VEHICULOS.idVehiculo = PARTICIPACIONES.idVehiculo
        JOIN PUNTAJES ON PUNTAJES.posicion = PARTICIPACIONES.posicionDeLlegada
        JOIN CARRERAS ON PARTICIPACIONES.idCarrera = CARRERAS.idCarrera
        JOIN GRANDESPREMIOS ON CARRERAS.idGranPremio = GRANDESPREMIOS.idGranPremio
        JOIN TEMPORADAS ON GRANDESPREMIOS.idTemporada = TEMPORADAS.idTemporada
    WHERE
        TEMPORADAS.idTemporada = 2
    GROUP BY
        EQUIPOS.nombre
)
SELECT
    ROW_NUMBER() OVER (ORDER BY PuntosTotales DESC) AS Posicion,
    NombreEquipo,
    PuntosTotales
FROM
    PuntosPorEquipo
ORDER BY
    PuntosTotales DESC;


-- ¿Cuál es el promedio de duración de las paradas en boxes en un gran premio particular?
SELECT AVG(EXTRACT(EPOCH FROM duracion)) AS promedio_duracion
FROM ParadaEnBoxes
JOIN Vueltas ON ParadaEnBoxes.idVuelta = Vueltas.idVuelta
JOIN Participaciones ON Vueltas.idParticipacion = Participaciones.idParticipacion
JOIN Carreras ON Participaciones.idCarrera = Carreras.idCarrera
JOIN GrandesPremios ON Carreras.idGranPremio = GrandesPremios.idGranPremio
WHERE GrandesPremios.idgranpremio = 8;

-- Comprobar la duracion de paradas en boxes teniendo en cuenta el gran premio
select v.idvuelta, par.idparticipacion, p.duracion, g.idgranpremio from paradaenboxes
join public.vueltas v on v.idvuelta = paradaenboxes.idvuelta
join participaciones par on par.idparticipacion = v.idparticipacion
join carreras c on par.idcarrera = c.idcarrera
join grandespremios g on g.idgranpremio = c.idgranpremio
join paradaenboxes p on p.idvuelta = v.idvuelta;




-- ¿Cuál es el nombre del equipo con más puntos en toda la historia de la Fórmula 1?

WITH PuntosPorEquipo AS (
    SELECT
        EQUIPOS.nombre AS NombreEquipo,
        SUM(PUNTAJES.puntaje) AS PuntosTotales
    FROM
        EQUIPOS
        JOIN VEHICULOS ON EQUIPOS.idEquipo = VEHICULOS.idEquipo
        JOIN PARTICIPACIONES ON VEHICULOS.idVehiculo = PARTICIPACIONES.idVehiculo
        JOIN PUNTAJES ON PUNTAJES.posicion = PARTICIPACIONES.posicionDeLlegada
    GROUP BY
        EQUIPOS.nombre
)
SELECT
    NombreEquipo
FROM
    PuntosPorEquipo
ORDER BY
    PuntosTotales DESC
LIMIT 1;



-- ¿Cuál es el gran premio, el nombre del conductor, el vehículo y el tiempo de las vueltas más
-- rápidas que se han hecho en cada gran premio de una temporada?
WITH VueltasMasRapidas AS (
    SELECT
        GRANDESPREMIOS.nombre AS GranPremio,
        PERSONAS.nombre AS NombreConductor,
        VEHICULOS.modelo AS ModeloVehiculo,
        MIN(VUELTAS.tiempo) AS TiempoMasRapido
    FROM
        VUELTAS
        JOIN PARTICIPACIONES ON VUELTAS.idParticipacion = PARTICIPACIONES.idParticipacion
        JOIN PILOTOS ON PARTICIPACIONES.idPersona = PILOTOS.idPersona
        JOIN PERSONAS ON PILOTOS.idPersona = PERSONAS.idPersona
        JOIN VEHICULOS ON PARTICIPACIONES.idVehiculo = VEHICULOS.idVehiculo
        JOIN CARRERAS ON PARTICIPACIONES.idCarrera = CARRERAS.idCarrera
        JOIN GRANDESPREMIOS ON CARRERAS.idGranPremio = GRANDESPREMIOS.idGranPremio
        JOIN TEMPORADAS ON GRANDESPREMIOS.idTemporada = TEMPORADAS.idTemporada
    WHERE
        TEMPORADAS.idTemporada = 2
    GROUP BY
        GRANDESPREMIOS.nombre, PERSONAS.nombre, VEHICULOS.modelo
)
SELECT
    GranPremio,
    NombreConductor,
    ModeloVehiculo,
    TiempoMasRapido
FROM
    VueltasMasRapidas;


-- ¿Cuál es el circuito que más se ha utilizado en toda la historia de la Fórmula 1?

SELECT C.idCircuito, C.nombre, COUNT(GP.idgranpremio) AS cantidadVecesUtilizado
FROM Circuitos as C
JOIN GrandesPremios GP ON C.idCircuito = GP.idCircuito
GROUP BY c.idCircuito, C.nombre
ORDER BY cantidadVecesUtilizado DESC
LIMIT 1;



