-- Gran Premio Mexico

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(26, 1, '2020-03-20', '10:00:00'), -- Libre
(27, 1, '2020-03-21', '14:00:00'), -- Q1
(28, 1, '2020-03-22', '10:00:00'), -- Q2
(29, 1, '2020-03-22', '14:00:00'), -- Q3
(30, 1, '2020-03-23', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(26);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (27, 1), (28, 2), (29, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(27);

INSERT INTO public.q2(idcarrera)
VALUES
(28);
INSERT INTO public.q3(idcarrera)
VALUES
(29);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(30);

-- Gran Premio Colombia

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(31, 2, '2020-03-23', '10:00:00'), -- Libre
(32, 2, '2020-03-24', '14:00:00'), -- Q1
(33, 2, '2020-03-25', '10:00:00'), -- Q2
(34, 2, '2020-03-25', '14:00:00'), -- Q3
(35, 2, '2020-03-26', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(31);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (32, 1), (33, 2), (34, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(32);

INSERT INTO public.q2(idcarrera)
VALUES
(33);
INSERT INTO public.q3(idcarrera)
VALUES
(34);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(35);

-- Gran Premio Colombia

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(36, 3, '2020-03-26', '10:00:00'), -- Libre
(37, 3, '2020-03-27', '14:00:00'), -- Q1
(38, 3, '2020-03-28', '10:00:00'), -- Q2
(39, 3, '2020-03-28', '14:00:00'), -- Q3
(40, 3, '2020-03-29', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(36);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (37, 1), (38, 2), (39, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(37);

INSERT INTO public.q2(idcarrera)
VALUES
(38);
INSERT INTO public.q3(idcarrera)
VALUES
(39);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(40);

-- Gran Premio chile

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(41, 4, '2020-03-26', '10:00:00'), -- Libre
(42, 4, '2020-03-27', '14:00:00'), -- Q1
(43, 4, '2020-03-28', '10:00:00'), -- Q2
(44, 4, '2020-03-28', '14:00:00'), -- Q3
(45, 4, '2020-03-29', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(41);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (42, 1), (43, 2), (44, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(42);

INSERT INTO public.q2(idcarrera)
VALUES
(43);
INSERT INTO public.q3(idcarrera)
VALUES
(44);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(45);

-- Gran Premio chile

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(46, 5, '2020-04-01', '10:00:00'), -- Libre
(47, 5, '2020-04-02', '14:00:00'), -- Q1
(48, 5, '2020-04-03', '10:00:00'), -- Q2
(49, 5, '2020-04-03', '14:00:00'), -- Q3
(50, 5, '2020-04-04', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(46);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (47, 1), (48, 2), (49, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(47);

INSERT INTO public.q2(idcarrera)
VALUES
(48);
INSERT INTO public.q3(idcarrera)
VALUES
(49);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(50);

-- Gran Premio peru

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(51, 6, '2021-03-28', '10:00:00'), -- Libre
(52, 6, '2021-03-29', '14:00:00'), -- Q1
(53, 6, '2021-03-30', '10:00:00'), -- Q2
(54, 6, '2021-03-30', '14:00:00'), -- Q3
(55, 6, '2021-03-31', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(51);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (52, 1), (53, 2), (54, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(52);

INSERT INTO public.q2(idcarrera)
VALUES
(53);
INSERT INTO public.q3(idcarrera)
VALUES
(54);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(55);


-- Gran Premio peru

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(56, 7, '2021-03-31', '10:00:00'), -- Libre
(57, 7, '2021-04-01', '14:00:00'), -- Q1
(58, 7, '2021-04-02', '10:00:00'), -- Q2
(59, 7, '2021-04-02', '14:00:00'), -- Q3
(60, 7, '2021-04-03', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(56);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (57, 1), (58, 2), (59, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(57);

INSERT INTO public.q2(idcarrera)
VALUES
(58);
INSERT INTO public.q3(idcarrera)
VALUES
(59);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(60);


-- Gran Premio Uruguay

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(1, 8, '2021-04-03', '14:00:00'), -- Libre
(2, 8, '2021-04-03', '10:00:00'), -- Q1
(3, 8, '2021-04-04', '10:00:00'), -- Q2
(4, 8, '2021-04-05', '10:00:00'), -- Q3
(5, 8, '2021-04-06', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(1);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (2, 1), (3, 2), (4, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(2);

INSERT INTO public.q2(idcarrera)
VALUES
(3);
INSERT INTO public.q3(idcarrera)
VALUES
(4);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(5);

-- Gran Premio uruguay

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(61, 9, '2021-04-06', '10:00:00'), -- Libre
(62, 9, '2021-04-07', '14:00:00'), -- Q1
(63, 9, '2021-04-08', '10:00:00'), -- Q2
(64, 9, '2021-04-08', '14:00:00'), -- Q3
(65, 9, '2021-04-09', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(61);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (62, 1), (63, 2), (64, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(62);

INSERT INTO public.q2(idcarrera)
VALUES
(63);
INSERT INTO public.q3(idcarrera)
VALUES
(64);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(65);


-- Gran Premio Venezuela

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(6, 10, '2021-04-09', '14:00:00'), -- Libre
(7, 10, '2021-04-09', '10:00:00'), -- Q1
(8, 10, '2021-04-10', '10:00:00'), -- Q2
(9, 10, '2021-04-11', '10:00:00'), -- Q3
(10, 10, '2021-04-12', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(6);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (7, 1), (8, 2), (9, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(7);
INSERT INTO public.q2(idcarrera)
VALUES
(8);
INSERT INTO public.q3(idcarrera)
VALUES
(9);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(10);

-- Gran Premio De Francia

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(11, 11, '2022-03-26', '14:00:00'), -- Libre
(12, 11, '2022-03-26', '10:00:00'), -- Q1
(13, 11, '2022-03-27', '10:00:00'), -- Q2
(14, 11, '2022-03-28', '10:00:00'), -- Q3
(15, 11, '2022-03-29', '14:00:00'); -- Principal


INSERT INTO public.carreraslibres(idcarrera)
VALUES
(11);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (12, 1), (13, 2), (14, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(12);
INSERT INTO public.q2(idcarrera)
VALUES
(13);
INSERT INTO public.q3(idcarrera)
VALUES
(14);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(15);

-- Gran Premio francia

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(66, 12, '2022-03-29', '10:00:00'), -- Libre
(67, 12, '2022-03-30', '14:00:00'), -- Q1
(68, 12, '2022-03-31', '10:00:00'), -- Q2
(69, 12, '2022-03-31', '14:00:00'), -- Q3
(70, 12, '2022-03-01', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(66);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (67, 1), (68, 2), (69, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(67);

INSERT INTO public.q2(idcarrera)
VALUES
(68);
INSERT INTO public.q3(idcarrera)
VALUES
(69);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(70);


-- Gran Premio De España
INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(16, 13, '2022-04-01', '14:00:00'), -- Libre
(17, 13, '2022-04-01', '10:00:00'), -- Q1
(18, 13, '2022-04-02', '10:00:00'), -- Q2
(19, 13, '2022-04-03', '10:00:00'), -- Q3
(20, 13, '2022-04-04', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(16);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (17, 1), (18, 2), (19, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(17);
INSERT INTO public.q2(idcarrera)
VALUES
(18);
INSERT INTO public.q3(idcarrera)
VALUES
(19);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(20);

-- Gran Premio venezuela

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(76, 15, '2022-04-07', '10:00:00'), -- Libre
(77, 15, '2022-04-08', '14:00:00'), -- Q1
(78, 15, '2022-04-09', '10:00:00'), -- Q2
(79, 15, '2022-04-09', '14:00:00'), -- Q3
(80, 15, '2022-04-10', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(76);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (77, 1), (78, 2), (79, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(77);

INSERT INTO public.q2(idcarrera)
VALUES
(78);
INSERT INTO public.q3(idcarrera)
VALUES
(79);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(80);

-- Gran Premio venezuela

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(81, 16, '2023-03-26', '10:00:00'), -- Libre
(82, 16, '2023-03-27', '14:00:00'), -- Q1
(83, 16, '2023-03-28', '10:00:00'), -- Q2
(84, 16, '2023-03-28', '14:00:00'), -- Q3
(85, 16, '2023-03-29', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(81);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (82, 1), (83, 2), (84, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(82);

INSERT INTO public.q2(idcarrera)
VALUES
(83);
INSERT INTO public.q3(idcarrera)
VALUES
(84);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(85);



-- Gran Premio De Chile

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(21, 17, '2023-03-29', '14:00:00'), -- Libre
(22, 17, '2023-03-29', '10:00:00'), -- Q1
(23, 17, '2023-03-30', '10:00:00'), -- Q2
(24, 17, '2023-03-31', '10:00:00'), -- Q3
(25, 17, '2023-04-01', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(21);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (22, 1), (23, 2), (24, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(22);
INSERT INTO public.q2(idcarrera)
VALUES
(23);
INSERT INTO public.q3(idcarrera)
VALUES
(24);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(25);

-- Gran Premio brasil

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(86, 18, '2023-04-01', '10:00:00'), -- Libre
(87, 18, '2023-04-02', '14:00:00'), -- Q1
(88, 18, '2023-04-03', '10:00:00'), -- Q2
(89, 18, '2023-04-03', '14:00:00'), -- Q3
(90, 18, '2023-04-04', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(86);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (87, 1), (88, 2), (89, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(87);

INSERT INTO public.q2(idcarrera)
VALUES
(88);
INSERT INTO public.q3(idcarrera)
VALUES
(89);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(90);

-- Gran Premio brasil

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(91, 19, '2023-04-04', '10:00:00'), -- Libre
(92, 19, '2023-04-05', '14:00:00'), -- Q1
(93, 19, '2023-04-06', '10:00:00'), -- Q2
(94, 19, '2023-04-06', '14:00:00'), -- Q3
(95, 19, '2023-04-07', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(91);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (92, 1), (93, 2), (94, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(92);

INSERT INTO public.q2(idcarrera)
VALUES
(93);
INSERT INTO public.q3(idcarrera)
VALUES
(94);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(95);

-- Gran Premio argentina

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(96, 20, '2023-04-07', '10:00:00'), -- Libre
(97, 20, '2023-04-08', '14:00:00'), -- Q1
(98, 20, '2023-04-09', '10:00:00'), -- Q2
(99, 20, '2023-04-09', '14:00:00'), -- Q3
(100, 20, '2023-04-10', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(96);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (97, 1), (98, 2), (99, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(97);

INSERT INTO public.q2(idcarrera)
VALUES
(98);
INSERT INTO public.q3(idcarrera)
VALUES
(99);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(100);

-- Gran Premio argentina

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(101, 21, '2024-03-24', '10:00:00'), -- Libre
(102, 21, '2024-03-25', '14:00:00'), -- Q1
(103, 21, '2024-03-26', '10:00:00'), -- Q2
(104, 21, '2024-03-26', '14:00:00'), -- Q3
(105, 21, '2024-03-27', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(101);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (102, 1), (103, 2), (104, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(102);

INSERT INTO public.q2(idcarrera)
VALUES
(103);
INSERT INTO public.q3(idcarrera)
VALUES
(104);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(105);

-- Gran Premio brasil

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(106, 22, '2024-03-27', '10:00:00'), -- Libre
(107, 22, '2024-03-28', '14:00:00'), -- Q1
(108, 22, '2024-03-29', '10:00:00'), -- Q2
(109, 22, '2024-03-29', '14:00:00'), -- Q3
(110, 22, '2024-03-30', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(106);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (107, 1), (108, 2), (109, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(107);

INSERT INTO public.q2(idcarrera)
VALUES
(108);
INSERT INTO public.q3(idcarrera)
VALUES
(109);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(110);

-- Gran Premio brasil

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(111, 23, '2024-03-27', '10:00:00'), -- Libre
(112, 23, '2024-03-28', '14:00:00'), -- Q1
(113, 23, '2024-03-29', '10:00:00'), -- Q2
(114, 23, '2024-03-29', '14:00:00'), -- Q3
(115, 23, '2024-03-30', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(111);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (112, 1), (113, 2), (114, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(112);

INSERT INTO public.q2(idcarrera)
VALUES
(113);
INSERT INTO public.q3(idcarrera)
VALUES
(114);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(115);

-- Gran Premio colombia

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(116, 24, '2024-04-02', '10:00:00'), -- Libre
(117, 24, '2024-04-03', '14:00:00'), -- Q1
(118, 24, '2024-04-04', '10:00:00'), -- Q2
(119, 24, '2024-04-04', '14:00:00'), -- Q3
(120, 24, '2024-04-05', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(116);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (117, 1), (118, 2), (119, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(117);

INSERT INTO public.q2(idcarrera)
VALUES
(118);
INSERT INTO public.q3(idcarrera)
VALUES
(119);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(120);

-- Gran Premio mexico

INSERT INTO public.carreras (idcarrera, idgranpremio, fecha, hora)
VALUES
(121, 25, '2024-04-05', '10:00:00'), -- Libre
(122, 25, '2024-04-06', '14:00:00'), -- Q1
(123, 25, '2024-04-07', '10:00:00'), -- Q2
(124, 25, '2024-04-07', '14:00:00'), -- Q3
(125, 25, '2024-04-08', '14:00:00'); -- Principal

INSERT INTO public.carreraslibres(idcarrera)
VALUES
(121);

INSERT INTO public.carrerasclasificatorias(
	idcarrera, idtipodeclasificacion)
	VALUES (122, 1), (123, 2), (124, 3);

INSERT INTO public.q1(idcarrera)
VALUES
(122);

INSERT INTO public.q2(idcarrera)
VALUES
(123);
INSERT INTO public.q3(idcarrera)
VALUES
(124);
INSERT INTO public.carrerasprincipales(idcarrera)
VALUES
(125);

-- Insertamos valores en la tabla puntajes
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

-- Insertamos algunos ejemplos en la tabla motores

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

-- Insertamos tipos de neumaticos

INSERT INTO TiposDeNeumaticos (idTipoDeNeumatico, dureza) VALUES
(1, 'DURO'),
(2, 'MEDIO'),
(3, 'SUAVE');

-- Se inserta a cada Equipo un Vehículo.
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

-- Tabla Noticias

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
