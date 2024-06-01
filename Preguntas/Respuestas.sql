-- ¿Cual es el nombre y el pais de las competiciones que se dieron en una temporada especıfica?
    SELECT GP.nombre as "Gran Premio", PS.nombre as "Pais" from public.grandespremios as GP
    JOIN circuitos as CT on CT.idcircuito = GP.idcircuito
    JOIN ciudades as CD on CD.idciudad = CT.idciudad
    JOIN public.paises as PS on CD.idpais = PS.idpais;

-- ¿Cual es el nombre y la longitud del circuito mas extenso que se utilizo la temporada 2?
SELECT CIRCUITOS.NOMBRE, CIRCUITOS.LONGITUD
FROM GRANDESPREMIOS 
JOIN CIRCUITOS ON CIRCUITOS.IDCIRCUITO = GRANDESPREMIOS.IDCIRCUITO
WHERE GRANDESPREMIOS.IDTEMPORADA = 2 ORDER BY CIRCUITOS.LONGITUD DESC LIMIT 1;

-- ¿Cuales son los circuitos que no son aptos para realizar carreras formula 1?
SELECT * FROM CIRCUITOS WHERE LONGITUD < 3;

-- ¿Cual es la marca, el tipo de neumaticos y el peso del vehıculo del competidor X?


-- ¿Cual es la posicion, nombre del piloto, nacionalidad , el modelo de vehıculo y los puntos que
-- tienen los pilotos que participan en una temporada? Ordenelos por posicion.


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