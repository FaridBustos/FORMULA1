-- Vistas

-- ¿Cual es el nombre y el pais de las competiciones que se dieron en una temporada especıfica?

CREATE VIEW nombrePaisCompeticion
as
    SELECT GP.nombre as "Gran Premio", PS.nombre as "Pais" from public.grandespremios as GP
    JOIN circuitos as CT on CT.idcircuito = GP.idcircuito
    JOIN ciudades as CD on CD.idciudad = CT.idciudad
    JOIN public.paises as PS on CD.idpais = PS.idpais;


-- ¿Cual es el nombre del equipo con mas puntos en toda la historia de la Formula 1?

CREATE VIEW equipoMaxPuntos
as
    SELECT EQ.idEquipo, EQ.nombre as nombreEquipo, sum(p.puntaje) as totalPuntos
    FROM participaciones PA
    JOIN puntajes P on PA.idpuntaje = P.idpuntaje
    JOIN vehiculos VH on PA.idvehiculo = VH.idvehiculo
    JOIN equipos EQ on EQ.idequipo = VH.idequipo
    GROUP BY EQ.idEquipo, EQ.nombre
    ORDER BY EQ.idequipo,EQ.nombre
    LIMIT 1;



-- Nombre Y Cargo de cada equipo
CREATE VIEW infoEquipos
as
    SELECT p.nombre as "Nombre", c.nombre as "Cargo", EQ.nombre "Equipo"
    FROM public.haceparte as HC
    JOIN personas p on HC.idpersona = p.idpersona
    JOIN equipos EQ on HC.idequipo = EQ.idequipo
    JOIN public.cargos c on HC.idcargo = c.idcargo;


-- Nombre Equipo Y tiempo de piloto en carrera libre

CREATE OR REPLACE VIEW PilotoCarreraLibre AS
SELECT
    p.nombre AS pilotoNombre,
    e.nombre AS equipoNombre,
    c.hora AS tiempo
FROM Personas p
    JOIN Pilotos pi ON p.idPersona = pi.idPersona
    JOIN Participaciones pa ON pi.idPersona = pa.idPersona
    JOIN Vehiculos v ON pa.idVehiculo = v.idVehiculo
    JOIN Equipos e ON v.idEquipo = e.idEquipo
    JOIN Carreras c ON pa.idCarrera = c.idCarrera
    JOIN CarrerasLibres cl ON c.idCarrera = cl.idCarrera;


-- Nombre numero de integrantes y el patrocinador de los equipos en una temporada

CREATE OR REPLACE VIEW EquiposTemporada AS
SELECT
    e.nombre AS equipoNombre,
    COUNT(hp.idPersona) AS numeroIntegrantes,
    p.nombre AS patrocinadorNombre,
    t.idTemporada AS temporadaID
FROM Equipos e
    JOIN HaceParte hp ON e.idEquipo = hp.idEquipo
    JOIN PatrocinadoresEquipos pe ON e.idEquipo = pe.idEquipo
    JOIN Patrocinadores p ON pe.idPatrocinador = p.idPatrocinador
    JOIN Temporadas t ON pe.idTemporada = t.idTemporada
GROUP BY
    e.nombre, p.nombre, t.idTemporada;


-- Sanciones de Pilotos en todas las carreras
    CREATE OR REPLACE VIEW SancionesPilotosCarrera AS
SELECT
    p.nombre AS pilotoNombre,
    c.fecha AS carreraFecha,
    s.descripcion AS sancionDescripcion
FROM Pilotos pi
    JOIN Personas p ON pi.idPersona = p.idPersona
    JOIN Participaciones pa ON pi.idPersona = pa.idPersona
    JOIN Vueltas v ON pa.idParticipacion = v.idParticipacion
    JOIN SancionesVueltas sv ON v.idVuelta = sv.idVuelta
    JOIN Sanciones s ON sv.idSancion = s.idSancion
    JOIN Carreras c ON pa.idCarrera = c.idCarrera;

