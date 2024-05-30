-- insercion en la tabla paises

INSERT INTO paises (idpais, nombre) VALUES
(1, 'Argentina'),
(2, 'Brasil'),
(3, 'Chile'),
(4, 'Colombia'),
(5, 'Mexico'),
(6, 'Peru'),
(7, 'Uruguay'),
(8, 'Venezuela'),
(9, 'Espana'),
(10, 'Francia');

-- insercion en la tabla ciudades

INSERT INTO public.ciudades (idciudad, idpais, nombre) VALUES
(1, 1, 'Buenos Aires'),
(2, 1, 'Cordoba'),
(3, 2, 'Sao Paulo'),
(4, 2, 'Rio de Janeiro'),
(5, 3, 'Santiago'),
(6, 3, 'Valparaiso'),
(7, 4, 'Bogota'),
(8, 4, 'Medellin'),
(9, 5, 'Ciudad de Mexico'),
(10, 5, 'Guadalajara'),
(11, 6, 'Lima'),
(12, 6, 'Cusco'),
(13, 7, 'Montevideo'),
(14, 7, 'Punta del Este'),
(15, 8, 'Caracas'),
(16, 8, 'Maracaibo'),
(17, 9, 'Madrid'),
(18, 9, 'Barcelona'),
(19, 10, 'Paris'),
(20, 10, 'Lyon');

-- insercion en la tabla circuitos

INSERT INTO public.circuitos (idcircuito, idciudad, nombre, longitud) VALUES
(1, 1, 'Circuito de Buenos Aires', 4.3),
(2, 2, 'Circuito de Cordoba', 3.8),
(3, 3, 'Autodromo de Interlagos', 4.3),
(4, 4, 'Circuito de Rio de Janeiro', 4.0),
(5, 5, 'Circuito de Santiago', 3.2),
(6, 6, 'Circuito de Valparaiso', 3.7),
(7, 7, 'Autodromo de Tocancipa', 2.7),
(8, 8, 'Circuito de Medellin', 3.5),
(9, 9, 'Autodromo Hermanos Rodriguez', 4.3),
(10, 10, 'Circuito de Guadalajara', 3.8),
(11, 11, 'Autodromo de La Chutana', 2.4),
(12, 12, 'Circuito de Cusco', 3.6),
(13, 13, 'Autodromo de El Pinar', 3.1),
(14, 14, 'Circuito de Punta del Este', 3.4),
(15, 15, 'Autodromo de Caracas', 3.2),
(16, 16, 'Circuito de Maracaibo', 3.9),
(17, 17, 'Circuito del Jarama', 3.9),
(18, 18, 'Circuito de Montmelo', 4.7),
(19, 19, 'Circuito de Nevers Magny-Cours', 4.4),
(20, 20, 'Circuito de Paul Ricard', 5.8);

-- insercion en la tabla temporadas

INSERT INTO public.temporadas (idtemporada, fechadeinicio, fechadefin) VALUES
(1, '2020-03-15', '2020-11-29'),
(2, '2021-03-28', '2021-12-12'),
(3, '2022-03-20', '2022-11-27'),
(4, '2023-03-26', '2023-12-10'),
(5, '2024-03-24', '2024-11-24');

-- insercion en la tabla equipos

INSERT INTO equipos(idequipo, nombre, paisdeorigen)
VALUES 
(1, 'Equipo Gauchos Racing', 1), 
(2, 'Equipo Samba Racing', 2), 
(3, 'Equipo Andes F1', 3), 
(4, 'Equipo Cafe Colombiano F1', 4), 
(5, 'Equipo Tequila Sunrise F1', 5), 
(6, 'Equipo Inca F1', 6), 
(7, 'Equipo Charrua F1', 7), 
(8, 'Equipo Bolivar F1', 8), 
(9, 'Equipo Toro Espanol F1', 9), 
(10, 'Equipo Baguette Racing', 10), 
(11, 'Equipo Tango F1', 1), 
(12, 'Equipo Bossa Nova F1', 2), 
(13, 'Equipo Pisco F1', 6); 

-- insercion en la tabla patrocinadores

INSERT INTO patrocinadores(idpatrocinador, nombre)
VALUES 
(1, 'Red Bull'),
(2, 'Shell'),
(3, 'Petrobras'),
(4, 'Telefonica'),
(5, 'Santander'),
(6, 'Infiniti'),
(7, 'Rolex'),
(8, 'Heineken'),
(9, 'Puma'),
(10, 'Hugo Boss'),
(11, 'Gulf Oil'),
(12, 'Monster Energy'),
(13, 'FedEx');

-- insercion en la tabla patrocinadores equipos

INSERT INTO public.patrocinadoresequipos(
idequipo, idpatrocinador, idtemporada, montopatrocinio, "tipoDePatrocinio")
VALUES 
(7, 9, 1, 5000000, 'exclusivo'),
(11, 2, 1, 3000000, 'no exclusivo'),
(9, 5, 1, 4500000, 'exclusivo'),
(6, 6, 1, 2000000, 'no exclusivo'),
(3, 3, 1, 4000000, 'exclusivo'),
(8, 10, 1, 6000000, 'no exclusivo'),
(13, 12, 1, 2500000, 'exclusivo'),
(2, 3, 1, 3500000, 'no exclusivo'),
(8, 7, 1, 2800000, 'exclusivo'),
(5, 4, 1, 3200000, 'no exclusivo'),
(4, 11, 2, 5000000, 'exclusivo'),
(13, 5, 2, 3000000, 'no exclusivo'),
(2, 8, 2, 4500000, 'exclusivo'),
(6, 1, 2, 2000000, 'no exclusivo'),
(10, 3, 2, 4000000, 'exclusivo'),
(1, 6, 2, 6000000, 'no exclusivo'),
(11, 9, 2, 2500000, 'exclusivo'),
(9, 7, 2, 3500000, 'no exclusivo'),
(5, 10, 2, 2800000, 'exclusivo'),
(7, 12, 2, 3200000, 'no exclusivo'),
(8, 7, 3, 5000000, 'exclusivo'),
(12, 9, 3, 3000000, 'no exclusivo'),
(6, 3, 3, 4500000, 'exclusivo'),
(5, 10, 3, 2000000, 'no exclusivo'),
(2, 2, 3, 4000000, 'exclusivo'),
(3, 8, 3, 6000000, 'no exclusivo'),
(10, 4, 3, 2500000, 'exclusivo'),
(1, 5, 3, 3500000, 'no exclusivo'),
(7, 11, 3, 2800000, 'exclusivo'),
(9, 1, 3, 3200000, 'no exclusivo'),
(9, 12, 4, 5000000, 'exclusivo'),
(4, 6, 4, 3000000, 'no exclusivo'),
(7, 2, 4, 4500000, 'exclusivo'),
(1, 10, 4, 2000000, 'no exclusivo'),
(11, 3, 4, 4000000, 'exclusivo'),
(5, 5, 4, 6000000, 'no exclusivo'),
(3, 8, 4, 2500000, 'exclusivo'),
(10, 7, 4, 3500000, 'no exclusivo'),
(6, 11, 4, 2800000, 'exclusivo'),
(2, 1, 4, 3200000, 'no exclusivo'),
(5, 8, 5, 5000000, 'exclusivo'),
(12, 3, 5, 3000000, 'no exclusivo'),
(1, 10, 5, 4500000, 'exclusivo'),
(8, 4, 5, 2000000, 'no exclusivo'),
(10, 6, 5, 4000000, 'exclusivo'),
(2, 1, 5, 6000000, 'no exclusivo'),
(11, 9, 5, 2500000, 'exclusivo'),
(6, 11, 5, 3500000, 'no exclusivo'),
(4, 7, 5, 2800000, 'exclusivo'),
(7, 12, 5, 3200000, 'no exclusivo');

-- insercion en la tabla grandes premios

INSERT INTO public.grandespremios(
	idgranpremio, idtemporada, idcircuito, nombre, fechainicio, fechafinalizacion)
VALUES 
	(1, 1, 9, 'Gran Premio de Mexico', '2020-03-20', '2020-03-23'),
	(2, 1, 8, 'Gran Premio de Colombia', '2020-03-23', '2020-03-26'),
	(3, 1, 7, 'Gran Premio de Colombia', '2020-03-26', '2020-03-29'),
	(4, 1, 6, 'Gran Premio de Chile', '2020-03-29', '2020-04-01'),
	(5, 1, 5, 'Gran Premio de Chile', '2020-04-01', '2020-04-04'),
	(6, 2, 11, 'Gran Premio de Peru', '2021-03-28', '2021-03-31'),
	(7, 2, 12, 'Gran Premio de Peru', '2021-03-31', '2021-04-03'),
	(8, 2, 13, 'Gran Premio de Uruguay', '2021-04-03', '2021-04-06'),
	(9, 2, 14, 'Gran Premio de Uruguay', '2021-04-06', '2021-04-09'),
	(10, 2, 15, 'Gran Premio de Venezuela', '2021-04-09', '2021-04-12'),
	(11, 3, 20, 'Gran Premio de Francia', '2022-03-26', '2022-03-29'),
	(12, 3, 19, 'Gran Premio de Francia', '2022-03-29', '2022-04-01'),
	(13, 3, 18, 'Gran Premio de Espana', '2022-04-01', '2022-04-04'),
	(14, 3, 17, 'Gran Premio de Espana', '2022-04-04', '2022-04-07'),
	(15, 3, 16, 'Gran Premio de Venezuela', '2022-04-07', '2022-04-10'),
	(16, 4, 15, 'Gran Premio de Venezuela', '2023-03-26', '2023-03-29'),
	(17, 4, 5, 'Gran Premio de Chile', '2023-03-29', '2023-04-01'),
	(18, 4, 4, 'Gran Premio de Brasil', '2023-04-01', '2023-04-04'),
	(19, 4, 3, 'Gran Premio de Brasil', '2023-04-04', '2023-04-07'),
	(20, 4, 2, 'Gran Premio de Argentina', '2023-04-07', '2023-04-10'),
	(21, 5, 1, 'Gran Premio de Argentina', '2024-03-24', '2024-03-27'),
	(22, 5, 3, 'Gran Premio de Brasil', '2024-03-27', '2024-03-30'),
	(23, 5, 6, 'Gran Premio de Chile', '2024-03-30', '2024-04-02'),
	(24, 5, 8, 'Gran Premio de Colombia', '2024-04-02', '2024-04-05'),
	(25, 5, 10, 'Gran Premio de Mexico', '2024-04-05', '2024-04-08');

-- Insercion en la tabla puntajes
INSERT INTO Puntajes (idPuntaje, posicion, puntaje) VALUES
(1, 1, 25),
(2, 2, 18),
(3, 3, 15),
(4, 4, 12),
(5, 5, 10),
(6, 6, 8),
(7, 7, 6),
(8, 8, 4),
(9, 9, 2),
(10, 10, 1);

-- Insercion en la tabla motores

INSERT INTO Motores (idMotor, marca, numeroDeValvulas, modelo, materialDelCiguenal, materialArbolLevas) VALUES
(1, 'Mercedes', 24, 'AMG F1 M12', 'Acero', 'Titanio'),
(2, 'Honda', 24, 'RA620H', 'Acero', 'Titanio'),
(3, 'Ferrari', 24, '065/6', 'Acero', 'Titanio'),
(4, 'Renault', 24, 'E-Tech 20B', 'Acero', 'Titanio'),
(5, 'Mercedes', 24, 'AMG F1 M12', 'Acero', 'Titanio'),
(6, 'Honda', 24, 'RA620H', 'Acero', 'Titanio'),
(7, 'Mercedes', 24, 'AMG F1 M12', 'Acero', 'Titanio'),
(8, 'Mercedes', 24, 'AMG F1 M12', 'Acero', 'Titanio'),
(9, 'Ferrari', 24, '065/6', 'Acero', 'Titanio'),
(10, 'Ferrari', 24, '065/6', 'Acero', 'Titanio');

-- Insercion en la tabla Tipos De Neumaticos

INSERT INTO TiposDeNeumaticos (idTipoDeNeumatico, dureza) VALUES
(1, 'DURO'),
(2, 'MEDIO'),
(3, 'SUAVE');

-- Insercion en la tabla vehiculos
INSERT INTO Vehiculos (idVehiculo, idTipoDeMotor, idTipoDeNeumatico, idEquipo, peso) VALUES
(1, 1, 1, 1, 752.5),
(2, 2, 2, 2, 751.0),
(3, 3, 3, 3, 753.0),
(4, 4, 1, 4, 750.5),
(5, 5, 2, 5, 752.0),
(6, 6, 3, 6, 751.5),
(7, 7, 1, 7, 752.3),
(8, 8, 2, 8, 751.8),
(9, 9, 3, 9, 753.1),
(10, 10, 1, 10, 750.9),
(11, 4, 2, 11, 752.7),
(12, 3, 3, 12, 750.4),
(13, 2, 1, 13, 753.6);

-- Insercion en la tabla noticias

INSERT INTO Noticias (idNoticia, autor, titulo, noticia, fecha, hora) VALUES
(1, 'Juan Pérez', 'Lewis Hamilton gana el Gran Premio de Mónaco', 'El piloto británico Lewis Hamilton, de la escudería Mercedes, logra una emocionante victoria en el circuito urbano de Mónaco.', '2024-05-20', '15:30:00'),
(2, 'María Gómez', 'Red Bull presenta mejoras en su chasis', 'La escudería Red Bull Racing presenta mejoras en su chasis en un intento por aumentar su competitividad en el Campeonato Mundial de Fórmula 1.', '2024-05-21', '10:45:00'),
(3, 'Carlos López', 'Ferrari anuncia cambios en su alineación de pilotos', 'La escudería Ferrari anuncia cambios en su alineación de pilotos para la próxima temporada, con el objetivo de mejorar sus resultados en pista.', '2024-05-22', '09:15:00'),
(4, 'Ana Rodríguez', 'McLaren revela diseño de su nuevo monoplaza', 'La escudería McLaren muestra el diseño de su nuevo monoplaza para la temporada 2025 de Fórmula 1, con un enfoque en la aerodinámica y la eficiencia.', '2024-05-23', '11:00:00'),
(5, 'Pedro Martínez', 'Sebastian Vettel anuncia su retirada de la Fórmula 1', 'El piloto alemán Sebastian Vettel anuncia su retirada de la Fórmula 1 al final de la presente temporada, tras una exitosa carrera de más de 15 años en la categoría.', '2024-05-24', '14:20:00'),
(6, 'Laura Fernández', 'AlphaTauri firma contrato con joven promesa', 'El equipo AlphaTauri anuncia la firma de un contrato con una joven promesa del automovilismo, quien debutará en la Fórmula 1 en la próxima temporada.', '2024-05-25', '08:55:00'),
(7, 'David Gutiérrez', 'Mercedes domina los primeros entrenamientos libres en Silverstone', 'El equipo Mercedes AMG Petronas Formula One Team muestra su superioridad al liderar los tiempos en los primeros entrenamientos libres del Gran Premio de Gran Bretaña.', '2024-05-26', '10:30:00'),
(8, 'Elena Ramírez', 'Renault anuncia asociación estratégica con fabricante de motores', 'La escudería Renault anuncia una asociación estratégica con un destacado fabricante de motores para mejorar el rendimiento de sus unidades de potencia en la Fórmula 1.', '2024-05-27', '13:45:00'),
(9, 'Javier González', 'FIA introduce nuevas regulaciones de seguridad', 'La Federación Internacional del Automóvil (FIA) anuncia la introducción de nuevas regulaciones de seguridad en la Fórmula 1, enfocadas en la protección de los pilotos y la mejora de la seguridad en pista.', '2024-05-28', '09:00:00'),
(10, 'Sofía Pérez', 'Alpine revela detalles de su programa de desarrollo de jóvenes pilotos', 'El equipo Alpine F1 Team detalla su programa de desarrollo de jóvenes pilotos, con el objetivo de identificar y cultivar el talento de las futuras estrellas de la Fórmula 1.', '2024-05-29', '12:10:00');


-- Insercion en la tabla carreras
INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(26, 1, '2020-03-20', '10:00:00'),
(27, 1, '2020-03-21', '14:00:00'), 
(28, 1, '2020-03-22', '10:00:00'), 
(29, 1, '2020-03-22', '14:00:00'), 
(30, 1, '2020-03-23', '14:00:00'), 
(31, 2, '2020-03-23', '10:00:00'), 
(32, 2, '2020-03-24', '14:00:00'), 
(33, 2, '2020-03-25', '10:00:00'), 
(34, 2, '2020-03-25', '14:00:00'), 
(35, 2, '2020-03-26', '14:00:00'), 
(36, 3, '2020-03-26', '10:00:00'), 
(37, 3, '2020-03-27', '14:00:00'), 
(38, 3, '2020-03-28', '10:00:00'), 
(39, 3, '2020-03-28', '14:00:00'), 
(40, 3, '2020-03-29', '14:00:00'), 
(41, 4, '2020-03-26', '10:00:00'), 
(42, 4, '2020-03-27', '14:00:00'), 
(43, 4, '2020-03-28', '10:00:00'), 
(44, 4, '2020-03-28', '14:00:00'), 
(45, 4, '2020-03-29', '14:00:00'), 
(46, 5, '2020-04-01', '10:00:00'), 
(47, 5, '2020-04-02', '14:00:00'), 
(48, 5, '2020-04-03', '10:00:00'), 
(49, 5, '2020-04-03', '14:00:00'), 
(50, 5, '2020-04-04', '14:00:00'), 
(51, 6, '2021-03-28', '10:00:00'), 
(52, 6, '2021-03-29', '14:00:00'), 
(53, 6, '2021-03-30', '10:00:00'), 
(54, 6, '2021-03-30', '14:00:00'), 
(55, 6, '2021-03-31', '14:00:00'), 
(56, 7, '2021-03-31', '10:00:00'), 
(57, 7, '2021-04-01', '14:00:00'), 
(58, 7, '2021-04-02', '10:00:00'), 
(59, 7, '2021-04-02', '14:00:00'), 
(60, 7, '2021-04-03', '14:00:00'), 
(1, 8, '2021-04-03', '14:00:00'), 
(2, 8, '2021-04-03', '10:00:00'), 
(3, 8, '2021-04-04', '10:00:00'), 
(4, 8, '2021-04-05', '10:00:00'), 
(5, 8, '2021-04-06', '14:00:00'), 
(61, 9, '2021-04-06', '10:00:00'), 
(62, 9, '2021-04-07', '14:00:00'), 
(63, 9, '2021-04-08', '10:00:00'), 
(64, 9, '2021-04-08', '14:00:00'), 
(65, 9, '2021-04-09', '14:00:00'), 
(6, 10, '2021-04-09', '14:00:00'), 
(7, 10, '2021-04-09', '10:00:00'), 
(8, 10, '2021-04-10', '10:00:00'), 
(9, 10, '2021-04-11', '10:00:00'), 
(10, 10, '2021-04-12', '14:00:00'), 
(12, 11, '2022-03-26', '10:00:00'), 
(11, 11, '2022-03-26', '14:00:00'), 
(13, 11, '2022-03-27', '10:00:00'), 
(14, 11, '2022-03-28', '10:00:00'), 
(15, 11, '2022-03-29', '14:00:00'), 
(66, 12, '2022-03-29', '10:00:00'), 
(67, 12, '2022-03-30', '14:00:00'), 
(68, 12, '2022-03-31', '10:00:00'), 
(69, 12, '2022-03-31', '14:00:00'), 
(70, 12, '2022-03-01', '14:00:00'), 
(17, 13, '2022-04-01', '10:00:00'), 
(16, 13, '2022-04-01', '14:00:00'), 
(18, 13, '2022-04-02', '10:00:00'), 
(19, 13, '2022-04-03', '10:00:00'), 
(20, 13, '2022-04-04', '14:00:00'), 
(76, 15, '2022-04-07', '10:00:00'), 
(77, 15, '2022-04-08', '14:00:00'), 
(78, 15, '2022-04-09', '10:00:00'), 
(79, 15, '2022-04-09', '14:00:00'), 
(80, 15, '2022-04-10', '14:00:00'), 
(81, 16, '2023-03-26', '10:00:00'), 
(82, 16, '2023-03-27', '14:00:00'), 
(83, 16, '2023-03-28', '10:00:00'), 
(84, 16, '2023-03-28', '14:00:00'), 
(85, 16, '2023-03-29', '14:00:00'), 
(22, 17, '2023-03-29', '10:00:00'), 
(21, 17, '2023-03-29', '14:00:00'), 
(23, 17, '2023-03-30', '10:00:00'), 
(24, 17, '2023-03-31', '10:00:00'), 
(25, 17, '2023-04-01', '14:00:00'), 
(86, 18, '2023-04-01', '10:00:00'), 
(87, 18, '2023-04-02', '14:00:00'), 
(88, 18, '2023-04-03', '10:00:00'), 
(89, 18, '2023-04-03', '14:00:00'), 
(90, 18, '2023-04-04', '14:00:00'), 
(91, 19, '2023-04-04', '10:00:00'), 
(92, 19, '2023-04-05', '14:00:00'), 
(93, 19, '2023-04-06', '10:00:00'), 
(94, 19, '2023-04-06', '14:00:00'), 
(95, 19, '2023-04-07', '14:00:00'), 
(96, 20, '2023-04-07', '10:00:00'), 
(97, 20, '2023-04-08', '14:00:00'), 
(98, 20, '2023-04-09', '10:00:00'), 
(99, 20, '2023-04-09', '14:00:00'), 
(100, 20, '2023-04-10', '14:00:00'), 
(101, 21, '2024-03-24', '10:00:00'), 
(102, 21, '2024-03-25', '14:00:00'), 
(103, 21, '2024-03-26', '10:00:00'), 
(104, 21, '2024-03-26', '14:00:00'), 
(105, 21, '2024-03-27', '14:00:00'), 
(106, 22, '2024-03-27', '10:00:00'), 
(107, 22, '2024-03-28', '14:00:00'), 
(108, 22, '2024-03-29', '10:00:00'), 
(109, 22, '2024-03-29', '14:00:00'), 
(110, 22, '2024-03-30', '14:00:00'), 
(111, 23, '2024-03-27', '10:00:00'), 
(112, 23, '2024-03-28', '14:00:00'), 
(113, 23, '2024-03-29', '10:00:00'), 
(114, 23, '2024-03-29', '14:00:00'), 
(115, 23, '2024-03-30', '14:00:00'), 
(116, 24, '2024-04-02', '10:00:00'), 
(117, 24, '2024-04-03', '14:00:00'), 
(118, 24, '2024-04-04', '10:00:00'), 
(119, 24, '2024-04-04', '14:00:00'), 
(120, 24, '2024-04-05', '14:00:00'), 
(121, 25, '2024-04-05', '10:00:00'), 
(122, 25, '2024-04-06', '14:00:00'), 
(123, 25, '2024-04-07', '10:00:00'), 
(124, 25, '2024-04-07', '14:00:00'), 
(125, 25, '2024-04-08', '14:00:00');

-- Insercion en la tabla carreras libres
INSERT INTO public.carreraslibres(idcarrera)
VALUES
(26), (31), (36), (41), (46), (51), (56), (1), (61),
(6), (11), (66), (16), (76), (81), (21), (86), (91), 
(96), (101), (106), (111), (116), (121);


-- Insercion en la tabla carrerasclasificatorias
INSERT INTO public.carrerasclasificatorias(idcarrera, idtipodeclasificacion)
VALUES
(27, 1), (28, 2), (29, 3),
(32, 1), (33, 2), (34, 3),
(37, 1), (38, 2), (39, 3),
(42, 1), (43, 2), (44, 3),
(47, 1), (48, 2), (49, 3),
(52, 1), (53, 2), (54, 3),
(57, 1), (58, 2), (59, 3),
(2, 1), (3, 2), (4, 3),
(62, 1), (63, 2), (64, 3),
(7, 1), (8, 2), (9, 3),
(12, 1), (13, 2), (14, 3),
(67, 1), (68, 2), (69, 3),
(17, 1), (18, 2), (19, 3),
(77, 1), (78, 2), (79, 3),
(82, 1), (83, 2), (84, 3),
(22, 1), (23, 2), (24, 3),
(87, 1), (88, 2), (89, 3),
(92, 1), (93, 2), (94, 3),
(97, 1), (98, 2), (99, 3),
(102, 1), (103, 2), (104, 3),
(107, 1), (108, 2), (109, 3),
(112, 1), (113, 2), (114, 3),
(117, 1), (118, 2), (119, 3),
(122, 1), (123, 2), (124, 3);


-- Insercion en la tabla q1
INSERT INTO public.q1(idcarrera)
VALUES
(27), (32), (37), (42), (47), (52), (57), (2), (62), 
(7), (12), (67), (17), (77), (82), (22), (87), (92), 
(97), (102), (107), (112), (117), (122);



-- Insercion en la tabla q2
INSERT INTO public.q2(idcarrera)
VALUES
(28), (33), (38), (43), (48), (53), (58), (3), (63), 
(8), (13), (68), (18), (78), (83), (23), (88), (93), 
(98), (103), (108), (113), (118), (123);



-- Insercion en la tabla q3
INSERT INTO public.q3(idcarrera)
VALUES
(29), (34), (39), (44), (49), (54), (59), (4), (64), 
(9), (14), (69), (19), (79), (84), (24), (89), (94), 
(99), (104), (109), (114), (119), (124);


-- Insercion en la tabla carreras principales
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(30), (35), (40), (45), (50), (55), (60), (5), (65), 
(10), (15), (70), (20), (80), (85), (25), (90), (95), 
(100), (105), (110), (115), (120), (125);

-- insercion en la tabla tipos de clasificacion

INSERT INTO public.tiposdeclasificacion(
	idtipodeclasificacion, nombre)
	VALUES 
    (1, 'Q1'),
    (2, 'Q2'),
    (3, 'Q3');
