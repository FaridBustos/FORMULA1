create table Paises(
  idPais int primary key,
  nombre varchar(50) not null
);


create table Ciudades(
    idCiudad int primary key,
    idPais int not null,
    nombre varchar(50) not null,
    foreign key (idPais) references Paises(idPais)
);


create table Equipos (
    idEquipo int primary key,
    nombre varchar(50) not null,
    paisDeOrigen int not null,
    foreign key (paisDeOrigen) references Paises(idPais)
);

create table Patrocinadores(
    idPatrocinador int primary key,
    nombre varchar(55) not null
);

create table Temporadas(
    idTemporada int primary key,
    fechaDeInicio date not null,
    fechaDeFin date not null
);

create table PatrocinadoresEquipos(
    idEquipo int not null,
    idPatrocinador int not null,
    idTemporada int not null,
    montoPatrocinio float,
    foreign key (idEquipo) references Equipos(idEquipo),
    foreign key (idPatrocinador) references  Patrocinadores(idPatrocinador),
    foreign key (idTemporada) references  Temporadas(idTemporada),
    primary key (idEquipo, idPatrocinador, idTemporada)
);


create table Cargos(
    idCargo int primary key,
    nombre varchar(100) not null
);

create table Personas(
    idPersona int primary key,
    nombre varchar(150) not null,
    correoElectronico varchar(255) not null,
    teléfono varchar(15)
);

create table Pilotos(
    idPersona int primary key ,
    foreign key (idPersona) references Personas(idPersona)
);

create table HaceParte(
    idHaceParte int primary key,
    idEquipo int not null,
    idPersona int not null,
    idCargo int not null,
    fechaIngreso date not null ,
    fechaSalida date,
    foreign key (idEquipo) references Equipos(idEquipo),
    foreign key (idPersona) references Personas(idPersona),
    foreign key (idCargo) references Cargos(idCargo)
);

create table TiposEstadosPiloto(
    idTipoEstadoPiloto int primary key,
    nombre varchar(100) not null
);

create table PilotosEstadoPilotos(
    idEstadoPiloto int primary key ,
    idPersona int not null,
    idTipoEstadoPiloto int not null,
    fechaDeInicio date,
    fechaDeFin date,
    foreign key (idPersona) references Pilotos(idPersona),
    foreign key (idTipoEstadoPiloto) references TiposEstadosPiloto(idTipoEstadoPiloto)
);



create table Motores(
    idMotor int primary key,
    marca varchar(55) not null,
    numeroDeValvulas int not null,
    modelo varchar(55) not null,
    materialDelCiguenal varchar(55) not null,
    materialArbolLevas varchar(55) not null
);

create table TiposDeNeumaticos(
    idTipoDeNeumatico int primary key,
    dureza varchar(20) check ( dureza in ('DURO', 'MEDIO', 'SUAVE') )
);


create table Vehiculos(
    idVehiculo int primary key,
    idTipoDeMotor int not null,
    idTipoDeNeumatico int not null,
    idEquipo int not null,
    peso float not null,
    foreign key (idTipoDeMotor) references Motores(idMotor),
    foreign key (idTipoDeNeumatico) references TiposDeNeumaticos(idTipoDeNeumatico),
    foreign key (idEquipo) references  Equipos(idEquipo)
);

create table Circuitos(
  idCircuito int primary key,
  idCiudad int not null,
  nombre varchar(100),
  longitud float not null,
  foreign key (idCiudad) references Ciudades(idCiudad)
);


create table GrandesPremios(
    idGranPremio int primary key,
    idTemporada int not null,
    idCircuito int not null,
    nombre varchar(100) not null,
    fechaInicio date not null,
    fechaFinalizacion date not null,
    foreign key (idTemporada) references Temporadas(idTemporada),
    foreign key (idCircuito) references Circuitos(idCircuito)
);

create table TiposDeCarreras(
    idTipoDeCarrera int primary key,
    nombre varchar(100) not null
);

create table Carreras(
    idCarrera int primary key,
    idGranPremio int not null,
    idTipoDeCarrera int,
    fecha date not null,
    hora time not null,
    foreign key (idGranpremio) references GrandesPremios(idGranPremio),
    foreign key (idTipoDeCarrera) references TiposDeCarreras(idTipoDeCarrera)
);


create table CarrerasLibres(
    idCarrera int primary key,
    foreign key (idCarrera) references Carreras(idCarrera)
);

create table CarrerasPrincipales(
    idCarrera int primary key,
    foreign key (idCarrera) references Carreras(idCarrera)
);

create table TiposDeClasificacion(
    idTipoDeClasificacion int primary key,
    nombre varchar(100)
);

create table CarrerasClasificatorias(
    idCarrera int primary key,
    idTipoDeClasificacion int not null,
    foreign key (idCarrera) references Carreras(idCarrera),
    foreign key (idTipoDeClasificacion) references TiposDeClasificacion(idTipoDeClasificacion)
);


create table Q1(
    idCarrera int primary key,
    foreign key (idCarrera) references CarrerasClasificatorias(idCarrera)
);

create table Q2(
    idCarrera int primary key,
    foreign key (idCarrera) references CarrerasClasificatorias(idCarrera)
);

create table Q3(
    idCarrera int primary key,
    foreign key (idCarrera) references CarrerasClasificatorias(idCarrera)
);


create table Puntajes(
    idPuntaje int primary key,
    posicion int,
    puntaje int
);

create table Participaciones (
    idParticipacion int primary key,
    idVehiculo int not null,
    idCarrera int not null,
    idPuntaje int,
    idPersona int not null,
    foreign key (idVehiculo) references Vehiculos(idVehiculo),
    foreign key (idCarrera) references Carreras(idCarrera),
    foreign key (idPersona) references Pilotos(idPersona),
    unique (idVehiculo,idCarrera, idPersona)
);

create table Vueltas(
    idVuelta int primary key,
    idParticipacion int not null,
    tiempo time not null,
    foreign key (idParticipacion) references Participaciones(idParticipacion)
);

create table Accidentes(
    idAccidente int primary key,
    idVuelta int not null,
    causa varchar(100),
    consecuencias varchar(255),
    foreign key (idVuelta) references Vueltas(idVuelta)
);


create table ParadaEnBoxes(
    idParadaEnBox int primary key,
    idVuelta int not null,
    duracion time,
    serviciosRealizados varchar(255),
    foreign key (idVuelta) references Vueltas(idVuelta)
);

create table Sanciones(
    idSancion int primary key,
    descripcion varchar(255),
    penalizacion time not null
);

create table SancionesVueltas(
    idSancionVuelta int primary key,
    idVuelta int not null,
    idSancion int not null,
    foreign key (idVuelta) references Vueltas(idVuelta),
    foreign key (idSancion) references Sanciones(idSancion)
);

create table Noticias(
    idNoticia int primary key,
    autor varchar(100) not null,
    titulo varchar(100) not null,
    noticia varchar(255) not null,
    fecha date not null,
    hora time not null
);


create table plataformas(
    idplataforma int primary key,
    nombre varchar(100) not null
);


create table PlataformasCarreras(
    idplataforma int primary key,
    nombre varchar(100) not null
);

create table PlataformasCarreras(
    idCarrera INT NOT NULL,
	idPlataforma INT NOT NULL,
	audiencia BIGINT NOT NULL,
	PRIMARY KEY (idCarrera, idPlataforma),
	foreign key (idCarrera) references carreras(idCarrera),
	foreign key (idPlataforma) references plataformas(idPlataforma)
);


