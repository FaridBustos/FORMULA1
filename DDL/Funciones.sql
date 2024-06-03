-- Numero de sanciones por piloto

create or replace function numSanciones(idPiloto int)
returns int as
$$
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
$$
language plpgsql;


-- Total de tiempo de penalizacion de un piloto en una temporada en especifico.

create or replace function totalTiempoPenalizado(idPilotop int, idTemporadap int)
returns time as
$$
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
$$
language plpgsql;


-- Funcion que determina si el auto de un equipo es apto para competir

create or replace function verificarVehiculoEquipo(peso double precision, numeroValvulas int, neumatico varchar, ciguenal varchar, arbollevas varchar)
returns varchar as
$$
begin
    if peso >= 798 and numeroValvulas = 24 and ciguenal in ('Acero', 'Aluminio') and arbollevas in ('Acero', 'Aluminio')  and neumatico in ('DURO', 'MEDIO', 'SUAVE') then
        return 'Vehiculo permitido por la FIA';
    else
        return 'Vehículo no permitido por la FIA';
    end if;
end;
$$
language plpgsql;


-- Equipos dado un país

CREATE OR REPLACE FUNCTION obtenerEquiposPorPais(countryName VARCHAR)
RETURNS TABLE(idEquipo INT, nombre VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT e.idEquipo, e.nombre
    FROM Equipos e
    JOIN Paises p ON e.paisDeOrigen = p.idPais
    WHERE p.nombre = countryName;
END;
$$ LANGUAGE plpgsql;


-- Procedimientos

-- Añadir piloto

CREATE OR REPLACE PROCEDURE agregarPiloto(p_idPersona INT, p_nombre VARCHAR(150), p_correoElectronico VARCHAR(255), p_telefono VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO Personas (idPersona, nombre, correoElectronico, teléfono)
    VALUES (p_idPersona, p_nombre, p_correoElectronico, p_telefono);

    INSERT INTO Pilotos (idPersona)
    VALUES (p_idPersona);
END;
$$;


-- Añadir Equipos.

CREATE OR REPLACE PROCEDURE agregarEquipo(p_idEquipo INT, p_nombre VARCHAR(50), p_paisDeOrigen INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Equipos (idEquipo, nombre, paisDeOrigen)
    VALUES (p_idEquipo, p_nombre, p_paisDeOrigen);
END;
$$;

--- CARRO de pilotos
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

--tiempo total de una vuelta
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



-- ranking de una carrera
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