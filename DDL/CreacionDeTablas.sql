CREATE TABLE Paises (
    idPais INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Ciudades (
    idCiudad INT PRIMARY KEY,
    idPais INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (idPais) REFERENCES Paises(idPais)
);

CREATE TABLE Equipos (
    idEquipo INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    paisDeOrigen INT NOT NULL,
    FOREIGN KEY (paisDeOrigen) REFERENCES Paises(idPais)
);

CREATE TABLE Patrocinadores (
    idPatrocinador INT PRIMARY KEY,
    nombre VARCHAR(55) NOT NULL
);

CREATE TABLE Temporadas (
    idTemporada INT PRIMARY KEY,
    fechaDeInicio DATE NOT NULL,
    fechaDeFin DATE NOT NULL
);

CREATE TABLE PatrocinadoresEquipos (
    idEquipo INT NOT NULL,
    idPatrocinador INT NOT NULL,
    idTemporada INT NOT NULL,
    montoPatrocinio FLOAT,
    tipoDePatrocinio CHARACTER VARYING(10),
    FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo),
    FOREIGN KEY (idPatrocinador) REFERENCES Patrocinadores(idPatrocinador),
    FOREIGN KEY (idTemporada) REFERENCES Temporadas(idTemporada),
    PRIMARY KEY (idEquipo, idPatrocinador, idTemporada)
);

CREATE TABLE Cargos (
    idCargo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Personas (
    idPersona INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correoElectronico VARCHAR(255) NOT NULL,
    telefono VARCHAR(15)
);

CREATE TABLE Pilotos (
    idPersona INT PRIMARY KEY,
    FOREIGN KEY (idPersona) REFERENCES Personas(idPersona)
);

CREATE TABLE HaceParte (
    idHaceParte INT PRIMARY KEY,
    idEquipo INT NOT NULL,
    idPersona INT NOT NULL,
    idCargo INT NOT NULL,
    fechaIngreso DATE NOT NULL,
    fechaSalida DATE,
    FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo),
    FOREIGN KEY (idPersona) REFERENCES Personas(idPersona),
    FOREIGN KEY (idCargo) REFERENCES Cargos(idCargo)
);

CREATE TABLE TiposEstadosPiloto (
    idTipoEstadoPiloto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE PilotosEstadoPilotos (
    idEstadoPiloto INT PRIMARY KEY,
    idPersona INT NOT NULL,
    idTipoEstadoPiloto INT NOT NULL,
    fechaDeInicio DATE,
    fechaDeFin DATE,
    FOREIGN KEY (idPersona) REFERENCES Pilotos(idPersona),
    FOREIGN KEY (idTipoEstadoPiloto) REFERENCES TiposEstadosPiloto(idTipoEstadoPiloto)
);

CREATE TABLE Motores (
    idMotor INT PRIMARY KEY,
    marca VARCHAR(55) NOT NULL,
    numeroDeValvulas INT NOT NULL,
    modelo VARCHAR(55) NOT NULL,
    materialDelCiguenal VARCHAR(55) NOT NULL,
    materialArbolLevas VARCHAR(55) NOT NULL
);

CREATE TABLE TiposDeNeumaticos (
    idTipoDeNeumatico INT PRIMARY KEY,
    dureza VARCHAR(20) CHECK (dureza IN ('DURO', 'MEDIO', 'SUAVE'))
);

CREATE TABLE Vehiculos (
    idVehiculo INT PRIMARY KEY,
    idTipoDeMotor INT NOT NULL,
    idTipoDeNeumatico INT NOT NULL,
    idEquipo INT NOT NULL,
    peso FLOAT NOT NULL,
    FOREIGN KEY (idTipoDeMotor) REFERENCES Motores(idMotor),
    FOREIGN KEY (idTipoDeNeumatico) REFERENCES TiposDeNeumaticos(idTipoDeNeumatico),
    FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo)
);

CREATE TABLE Circuitos (
    idCircuito INT PRIMARY KEY,
    idCiudad INT NOT NULL,
    nombre VARCHAR(100),
    longitud FLOAT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad)
);

CREATE TABLE GrandesPremios (
    idGranPremio INT PRIMARY KEY,
    idTemporada INT NOT NULL,
    idCircuito INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFinalizacion DATE NOT NULL,
    FOREIGN KEY (idTemporada) REFERENCES Temporadas(idTemporada),
    FOREIGN KEY (idCircuito) REFERENCES Circuitos(idCircuito)
);

CREATE TABLE Carreras (
    idCarrera INT PRIMARY KEY,
    idGranPremio INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    FOREIGN KEY (idGranPremio) REFERENCES GrandesPremios(idGranPremio)
);

CREATE TABLE CarrerasLibres (
    idCarrera INT PRIMARY KEY,
    FOREIGN KEY (idCarrera) REFERENCES Carreras(idCarrera)
);

CREATE TABLE CarrerasPrincipales (
    idCarrera INT PRIMARY KEY,
    FOREIGN KEY (idCarrera) REFERENCES Carreras(idCarrera)
);

CREATE TABLE TiposDeClasificacion (
    idTipoDeClasificacion INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE CarrerasClasificatorias (
    idCarrera INT PRIMARY KEY,
    idTipoDeClasificacion INT NOT NULL,
    FOREIGN KEY (idCarrera) REFERENCES Carreras(idCarrera),
    FOREIGN KEY (idTipoDeClasificacion) REFERENCES TiposDeClasificacion(idTipoDeClasificacion)
);

CREATE TABLE Q1 (
    idCarrera INT PRIMARY KEY,
    FOREIGN KEY (idCarrera) REFERENCES CarrerasClasificatorias(idCarrera)
);

CREATE TABLE Q2 (
    idCarrera INT PRIMARY KEY,
    FOREIGN KEY (idCarrera) REFERENCES CarrerasClasificatorias(idCarrera)
);

CREATE TABLE Q3 (
    idCarrera INT PRIMARY KEY,
    FOREIGN KEY (idCarrera) REFERENCES CarrerasClasificatorias(idCarrera)
);

CREATE TABLE Puntajes (
    idPuntaje INT PRIMARY KEY,
    posicion INT,
    puntaje INT
);

CREATE TABLE Participaciones (
    idParticipacion INT PRIMARY KEY,
    idVehiculo INT NOT NULL,
    idCarrera INT NOT NULL,
    idPuntaje INT,
    idPersona INT NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES Vehiculos(idVehiculo),
    FOREIGN KEY (idCarrera) REFERENCES Carreras(idCarrera),
    FOREIGN KEY (idPuntaje) REFERENCES Puntajes(idPuntaje),
    FOREIGN KEY (idPersona) REFERENCES Pilotos(idPersona),
    UNIQUE (idVehiculo, idCarrera, idPuntaje, idPersona)
);

CREATE TABLE Vueltas (
    idVuelta INT PRIMARY KEY,
    idParticipacion INT NOT NULL,
    FOREIGN KEY (idParticipacion) REFERENCES Participaciones(idParticipacion)
);

CREATE TABLE Accidentes (
    idAccidente INT PRIMARY KEY,
    idVuelta INT NOT NULL,
    causa VARCHAR(100),
    consecuencias VARCHAR(255),
    FOREIGN KEY (idVuelta) REFERENCES Vueltas(idVuelta)
);

CREATE TABLE ParadaEnBoxes (
    idParadaEnBox INT PRIMARY KEY,
    idVuelta INT NOT NULL,
    duracion TIME,
    serviciosRealizados VARCHAR(255),
    FOREIGN KEY (idVuelta) REFERENCES Vueltas(idVuelta)
);

CREATE TABLE Sanciones (
    idSancion INT PRIMARY KEY,
    descripcion VARCHAR(255),
    penalizacion TIME NOT NULL
);

CREATE TABLE SancionesVueltas (
    idSancionVuelta INT PRIMARY KEY,
    idVuelta INT NOT NULL,
    idSancion INT NOT NULL,
    FOREIGN KEY (idVuelta) REFERENCES Vueltas(idVuelta),
    FOREIGN KEY (idSancion) REFERENCES Sanciones(idSancion)
);

CREATE TABLE Noticias (
    idNoticia INT PRIMARY KEY,
    autor VARCHAR(100) NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    noticia VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL
);
