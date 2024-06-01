PGDMP      *                |            Formula1    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    83187    Formula1    DATABASE     }   CREATE DATABASE "Formula1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "Formula1";
                postgres    false            �            1259    83481 
   accidentes    TABLE     �   CREATE TABLE public.accidentes (
    idaccidente integer NOT NULL,
    idvuelta integer NOT NULL,
    causa character varying(100),
    consecuencias character varying(255)
);
    DROP TABLE public.accidentes;
       public         heap    postgres    false            �            1259    83243    cargos    TABLE     i   CREATE TABLE public.cargos (
    idcargo integer NOT NULL,
    nombre character varying(100) NOT NULL
);
    DROP TABLE public.cargos;
       public         heap    postgres    false            �            1259    83359    carreras    TABLE     �   CREATE TABLE public.carreras (
    idcarrera integer NOT NULL,
    idgranpremio integer NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);
    DROP TABLE public.carreras;
       public         heap    postgres    false            �            1259    83394    carrerasclasificatorias    TABLE     |   CREATE TABLE public.carrerasclasificatorias (
    idcarrera integer NOT NULL,
    idtipodeclasificacion integer NOT NULL
);
 +   DROP TABLE public.carrerasclasificatorias;
       public         heap    postgres    false            �            1259    83369    carreraslibres    TABLE     G   CREATE TABLE public.carreraslibres (
    idcarrera integer NOT NULL
);
 "   DROP TABLE public.carreraslibres;
       public         heap    postgres    false            �            1259    83379    carrerasprincipales    TABLE     L   CREATE TABLE public.carrerasprincipales (
    idcarrera integer NOT NULL
);
 '   DROP TABLE public.carrerasprincipales;
       public         heap    postgres    false            �            1259    83334 	   circuitos    TABLE     �   CREATE TABLE public.circuitos (
    idcircuito integer NOT NULL,
    idciudad integer NOT NULL,
    nombre character varying(100),
    longitud double precision NOT NULL
);
    DROP TABLE public.circuitos;
       public         heap    postgres    false            �            1259    83193    ciudades    TABLE     �   CREATE TABLE public.ciudades (
    idciudad integer NOT NULL,
    idpais integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.ciudades;
       public         heap    postgres    false            �            1259    83203    equipos    TABLE     �   CREATE TABLE public.equipos (
    idequipo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    paisdeorigen integer NOT NULL
);
    DROP TABLE public.equipos;
       public         heap    postgres    false            �            1259    83344    grandespremios    TABLE     �   CREATE TABLE public.grandespremios (
    idgranpremio integer NOT NULL,
    idtemporada integer NOT NULL,
    idcircuito integer NOT NULL,
    nombre character varying(100) NOT NULL,
    fechainicio date NOT NULL,
    fechafinalizacion date NOT NULL
);
 "   DROP TABLE public.grandespremios;
       public         heap    postgres    false            �            1259    83263 	   haceparte    TABLE     �   CREATE TABLE public.haceparte (
    idhaceparte integer NOT NULL,
    idequipo integer NOT NULL,
    idpersona integer NOT NULL,
    idcargo integer NOT NULL,
    fechaingreso date NOT NULL,
    fechasalida date
);
    DROP TABLE public.haceparte;
       public         heap    postgres    false            �            1259    83303    motores    TABLE     )  CREATE TABLE public.motores (
    idmotor integer NOT NULL,
    marca character varying(55) NOT NULL,
    numerodevalvulas integer NOT NULL,
    modelo character varying(55) NOT NULL,
    materialdelciguenal character varying(55) NOT NULL,
    materialarbollevas character varying(55) NOT NULL
);
    DROP TABLE public.motores;
       public         heap    postgres    false            �            1259    83521    noticias    TABLE       CREATE TABLE public.noticias (
    idnoticia integer NOT NULL,
    autor character varying(100) NOT NULL,
    titulo character varying(100) NOT NULL,
    noticia character varying(255) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);
    DROP TABLE public.noticias;
       public         heap    postgres    false            �            1259    83188    paises    TABLE     g   CREATE TABLE public.paises (
    idpais integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE public.paises;
       public         heap    postgres    false            �            1259    83491    paradaenboxes    TABLE     �   CREATE TABLE public.paradaenboxes (
    idparadaenbox integer NOT NULL,
    idvuelta integer NOT NULL,
    duracion time without time zone,
    serviciosrealizados character varying(255)
);
 !   DROP TABLE public.paradaenboxes;
       public         heap    postgres    false            �            1259    83444    participaciones    TABLE     �   CREATE TABLE public.participaciones (
    idparticipacion integer NOT NULL,
    idvehiculo integer NOT NULL,
    idcarrera integer NOT NULL,
    idpersona integer NOT NULL
);
 #   DROP TABLE public.participaciones;
       public         heap    postgres    false            �            1259    83213    patrocinadores    TABLE     w   CREATE TABLE public.patrocinadores (
    idpatrocinador integer NOT NULL,
    nombre character varying(55) NOT NULL
);
 "   DROP TABLE public.patrocinadores;
       public         heap    postgres    false            �            1259    83223    patrocinadoresequipos    TABLE     �   CREATE TABLE public.patrocinadoresequipos (
    idequipo integer NOT NULL,
    idpatrocinador integer NOT NULL,
    idtemporada integer NOT NULL,
    montopatrocinio double precision,
    "tipoDePatrocinio" character varying(20)
);
 )   DROP TABLE public.patrocinadoresequipos;
       public         heap    postgres    false            �            1259    83248    personas    TABLE     �   CREATE TABLE public.personas (
    idpersona integer NOT NULL,
    nombre character varying(150) NOT NULL,
    correoelectronico character varying(255) NOT NULL,
    "teléfono" character varying(15)
);
    DROP TABLE public.personas;
       public         heap    postgres    false            �            1259    83253    pilotos    TABLE     @   CREATE TABLE public.pilotos (
    idpersona integer NOT NULL
);
    DROP TABLE public.pilotos;
       public         heap    postgres    false            �            1259    83288    pilotosestadopilotos    TABLE     �   CREATE TABLE public.pilotosestadopilotos (
    idestadopiloto integer NOT NULL,
    idpersona integer NOT NULL,
    idtipoestadopiloto integer NOT NULL,
    fechadeinicio date,
    fechadefin date
);
 (   DROP TABLE public.pilotosestadopilotos;
       public         heap    postgres    false            �            1259    83439    puntajes    TABLE     l   CREATE TABLE public.puntajes (
    idpuntaje integer NOT NULL,
    posicion integer,
    puntaje integer
);
    DROP TABLE public.puntajes;
       public         heap    postgres    false            �            1259    83409    q1    TABLE     ;   CREATE TABLE public.q1 (
    idcarrera integer NOT NULL
);
    DROP TABLE public.q1;
       public         heap    postgres    false            �            1259    83419    q2    TABLE     ;   CREATE TABLE public.q2 (
    idcarrera integer NOT NULL
);
    DROP TABLE public.q2;
       public         heap    postgres    false            �            1259    83429    q3    TABLE     ;   CREATE TABLE public.q3 (
    idcarrera integer NOT NULL
);
    DROP TABLE public.q3;
       public         heap    postgres    false            �            1259    83501 	   sanciones    TABLE     �   CREATE TABLE public.sanciones (
    idsancion integer NOT NULL,
    descripcion character varying(255),
    penalizacion time without time zone NOT NULL
);
    DROP TABLE public.sanciones;
       public         heap    postgres    false            �            1259    83506    sancionesvueltas    TABLE     �   CREATE TABLE public.sancionesvueltas (
    idsancionvuelta integer NOT NULL,
    idvuelta integer NOT NULL,
    idsancion integer NOT NULL
);
 $   DROP TABLE public.sancionesvueltas;
       public         heap    postgres    false            �            1259    83218 
   temporadas    TABLE     �   CREATE TABLE public.temporadas (
    idtemporada integer NOT NULL,
    fechadeinicio date NOT NULL,
    fechadefin date NOT NULL
);
    DROP TABLE public.temporadas;
       public         heap    postgres    false            �            1259    83389    tiposdeclasificacion    TABLE     |   CREATE TABLE public.tiposdeclasificacion (
    idtipodeclasificacion integer NOT NULL,
    nombre character varying(100)
);
 (   DROP TABLE public.tiposdeclasificacion;
       public         heap    postgres    false            �            1259    83308    tiposdeneumaticos    TABLE     '  CREATE TABLE public.tiposdeneumaticos (
    idtipodeneumatico integer NOT NULL,
    dureza character varying(20),
    CONSTRAINT tiposdeneumaticos_dureza_check CHECK (((dureza)::text = ANY ((ARRAY['DURO'::character varying, 'MEDIO'::character varying, 'SUAVE'::character varying])::text[])))
);
 %   DROP TABLE public.tiposdeneumaticos;
       public         heap    postgres    false            �            1259    83283    tiposestadospiloto    TABLE     �   CREATE TABLE public.tiposestadospiloto (
    idtipoestadopiloto integer NOT NULL,
    nombre character varying(100) NOT NULL
);
 &   DROP TABLE public.tiposestadospiloto;
       public         heap    postgres    false            �            1259    83314 	   vehiculos    TABLE     �   CREATE TABLE public.vehiculos (
    idvehiculo integer NOT NULL,
    idtipodemotor integer NOT NULL,
    idtipodeneumatico integer NOT NULL,
    idequipo integer NOT NULL,
    peso double precision NOT NULL
);
    DROP TABLE public.vehiculos;
       public         heap    postgres    false            �            1259    83471    vueltas    TABLE     �   CREATE TABLE public.vueltas (
    idvuelta integer NOT NULL,
    idparticipacion integer NOT NULL,
    tiempo time without time zone
);
    DROP TABLE public.vueltas;
       public         heap    postgres    false            �          0    83481 
   accidentes 
   TABLE DATA           Q   COPY public.accidentes (idaccidente, idvuelta, causa, consecuencias) FROM stdin;
    public          postgres    false    243   9�       �          0    83243    cargos 
   TABLE DATA           1   COPY public.cargos (idcargo, nombre) FROM stdin;
    public          postgres    false    221   o�       �          0    83359    carreras 
   TABLE DATA           H   COPY public.carreras (idcarrera, idgranpremio, fecha, hora) FROM stdin;
    public          postgres    false    232   �       �          0    83394    carrerasclasificatorias 
   TABLE DATA           S   COPY public.carrerasclasificatorias (idcarrera, idtipodeclasificacion) FROM stdin;
    public          postgres    false    236   i�       �          0    83369    carreraslibres 
   TABLE DATA           3   COPY public.carreraslibres (idcarrera) FROM stdin;
    public          postgres    false    233   �       �          0    83379    carrerasprincipales 
   TABLE DATA           8   COPY public.carrerasprincipales (idcarrera) FROM stdin;
    public          postgres    false    234   _�       �          0    83334 	   circuitos 
   TABLE DATA           K   COPY public.circuitos (idcircuito, idciudad, nombre, longitud) FROM stdin;
    public          postgres    false    230   ��       �          0    83193    ciudades 
   TABLE DATA           <   COPY public.ciudades (idciudad, idpais, nombre) FROM stdin;
    public          postgres    false    216   !�       �          0    83203    equipos 
   TABLE DATA           A   COPY public.equipos (idequipo, nombre, paisdeorigen) FROM stdin;
    public          postgres    false    217   �       �          0    83344    grandespremios 
   TABLE DATA           w   COPY public.grandespremios (idgranpremio, idtemporada, idcircuito, nombre, fechainicio, fechafinalizacion) FROM stdin;
    public          postgres    false    231   ��       �          0    83263 	   haceparte 
   TABLE DATA           i   COPY public.haceparte (idhaceparte, idequipo, idpersona, idcargo, fechaingreso, fechasalida) FROM stdin;
    public          postgres    false    224   ��       �          0    83303    motores 
   TABLE DATA           t   COPY public.motores (idmotor, marca, numerodevalvulas, modelo, materialdelciguenal, materialarbollevas) FROM stdin;
    public          postgres    false    227   ˹       �          0    83521    noticias 
   TABLE DATA           R   COPY public.noticias (idnoticia, autor, titulo, noticia, fecha, hora) FROM stdin;
    public          postgres    false    247   ^�       �          0    83188    paises 
   TABLE DATA           0   COPY public.paises (idpais, nombre) FROM stdin;
    public          postgres    false    215   Ӿ       �          0    83491    paradaenboxes 
   TABLE DATA           _   COPY public.paradaenboxes (idparadaenbox, idvuelta, duracion, serviciosrealizados) FROM stdin;
    public          postgres    false    244   T�       �          0    83444    participaciones 
   TABLE DATA           \   COPY public.participaciones (idparticipacion, idvehiculo, idcarrera, idpersona) FROM stdin;
    public          postgres    false    241   E�       �          0    83213    patrocinadores 
   TABLE DATA           @   COPY public.patrocinadores (idpatrocinador, nombre) FROM stdin;
    public          postgres    false    218   ��       �          0    83223    patrocinadoresequipos 
   TABLE DATA           {   COPY public.patrocinadoresequipos (idequipo, idpatrocinador, idtemporada, montopatrocinio, "tipoDePatrocinio") FROM stdin;
    public          postgres    false    220   %�       �          0    83248    personas 
   TABLE DATA           U   COPY public.personas (idpersona, nombre, correoelectronico, "teléfono") FROM stdin;
    public          postgres    false    222   X�       �          0    83253    pilotos 
   TABLE DATA           ,   COPY public.pilotos (idpersona) FROM stdin;
    public          postgres    false    223   <�       �          0    83288    pilotosestadopilotos 
   TABLE DATA           x   COPY public.pilotosestadopilotos (idestadopiloto, idpersona, idtipoestadopiloto, fechadeinicio, fechadefin) FROM stdin;
    public          postgres    false    226   ��       �          0    83439    puntajes 
   TABLE DATA           @   COPY public.puntajes (idpuntaje, posicion, puntaje) FROM stdin;
    public          postgres    false    240   ��       �          0    83409    q1 
   TABLE DATA           '   COPY public.q1 (idcarrera) FROM stdin;
    public          postgres    false    237   ��       �          0    83419    q2 
   TABLE DATA           '   COPY public.q2 (idcarrera) FROM stdin;
    public          postgres    false    238   (�       �          0    83429    q3 
   TABLE DATA           '   COPY public.q3 (idcarrera) FROM stdin;
    public          postgres    false    239   v�       �          0    83501 	   sanciones 
   TABLE DATA           I   COPY public.sanciones (idsancion, descripcion, penalizacion) FROM stdin;
    public          postgres    false    245   ��       �          0    83506    sancionesvueltas 
   TABLE DATA           P   COPY public.sancionesvueltas (idsancionvuelta, idvuelta, idsancion) FROM stdin;
    public          postgres    false    246   x�       �          0    83218 
   temporadas 
   TABLE DATA           L   COPY public.temporadas (idtemporada, fechadeinicio, fechadefin) FROM stdin;
    public          postgres    false    219   ��       �          0    83389    tiposdeclasificacion 
   TABLE DATA           M   COPY public.tiposdeclasificacion (idtipodeclasificacion, nombre) FROM stdin;
    public          postgres    false    235   .�       �          0    83308    tiposdeneumaticos 
   TABLE DATA           F   COPY public.tiposdeneumaticos (idtipodeneumatico, dureza) FROM stdin;
    public          postgres    false    228   Z�       �          0    83283    tiposestadospiloto 
   TABLE DATA           H   COPY public.tiposestadospiloto (idtipoestadopiloto, nombre) FROM stdin;
    public          postgres    false    225   ��       �          0    83314 	   vehiculos 
   TABLE DATA           a   COPY public.vehiculos (idvehiculo, idtipodemotor, idtipodeneumatico, idequipo, peso) FROM stdin;
    public          postgres    false    229   /�       �          0    83471    vueltas 
   TABLE DATA           D   COPY public.vueltas (idvuelta, idparticipacion, tiempo) FROM stdin;
    public          postgres    false    242   ��       �           2606    83485    accidentes accidentes_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.accidentes
    ADD CONSTRAINT accidentes_pkey PRIMARY KEY (idaccidente);
 D   ALTER TABLE ONLY public.accidentes DROP CONSTRAINT accidentes_pkey;
       public            postgres    false    243            �           2606    83247    cargos cargos_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (idcargo);
 <   ALTER TABLE ONLY public.cargos DROP CONSTRAINT cargos_pkey;
       public            postgres    false    221            �           2606    83363    carreras carreras_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT carreras_pkey PRIMARY KEY (idcarrera);
 @   ALTER TABLE ONLY public.carreras DROP CONSTRAINT carreras_pkey;
       public            postgres    false    232            �           2606    83398 4   carrerasclasificatorias carrerasclasificatorias_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_pkey PRIMARY KEY (idcarrera);
 ^   ALTER TABLE ONLY public.carrerasclasificatorias DROP CONSTRAINT carrerasclasificatorias_pkey;
       public            postgres    false    236            �           2606    83373 "   carreraslibres carreraslibres_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.carreraslibres
    ADD CONSTRAINT carreraslibres_pkey PRIMARY KEY (idcarrera);
 L   ALTER TABLE ONLY public.carreraslibres DROP CONSTRAINT carreraslibres_pkey;
       public            postgres    false    233            �           2606    83383 ,   carrerasprincipales carrerasprincipales_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.carrerasprincipales
    ADD CONSTRAINT carrerasprincipales_pkey PRIMARY KEY (idcarrera);
 V   ALTER TABLE ONLY public.carrerasprincipales DROP CONSTRAINT carrerasprincipales_pkey;
       public            postgres    false    234            �           2606    83338    circuitos circuitos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.circuitos
    ADD CONSTRAINT circuitos_pkey PRIMARY KEY (idcircuito);
 B   ALTER TABLE ONLY public.circuitos DROP CONSTRAINT circuitos_pkey;
       public            postgres    false    230            �           2606    83197    ciudades ciudades_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY (idciudad);
 @   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT ciudades_pkey;
       public            postgres    false    216            �           2606    83207    equipos equipos_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (idequipo);
 >   ALTER TABLE ONLY public.equipos DROP CONSTRAINT equipos_pkey;
       public            postgres    false    217            �           2606    83348 "   grandespremios grandespremios_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_pkey PRIMARY KEY (idgranpremio);
 L   ALTER TABLE ONLY public.grandespremios DROP CONSTRAINT grandespremios_pkey;
       public            postgres    false    231            �           2606    83267    haceparte haceparte_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_pkey PRIMARY KEY (idhaceparte);
 B   ALTER TABLE ONLY public.haceparte DROP CONSTRAINT haceparte_pkey;
       public            postgres    false    224            �           2606    83307    motores motores_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.motores
    ADD CONSTRAINT motores_pkey PRIMARY KEY (idmotor);
 >   ALTER TABLE ONLY public.motores DROP CONSTRAINT motores_pkey;
       public            postgres    false    227            �           2606    83525    noticias noticias_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.noticias
    ADD CONSTRAINT noticias_pkey PRIMARY KEY (idnoticia);
 @   ALTER TABLE ONLY public.noticias DROP CONSTRAINT noticias_pkey;
       public            postgres    false    247            �           2606    83192    paises paises_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (idpais);
 <   ALTER TABLE ONLY public.paises DROP CONSTRAINT paises_pkey;
       public            postgres    false    215            �           2606    83495     paradaenboxes paradaenboxes_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.paradaenboxes
    ADD CONSTRAINT paradaenboxes_pkey PRIMARY KEY (idparadaenbox);
 J   ALTER TABLE ONLY public.paradaenboxes DROP CONSTRAINT paradaenboxes_pkey;
       public            postgres    false    244            �           2606    83448 $   participaciones participaciones_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_pkey PRIMARY KEY (idparticipacion);
 N   ALTER TABLE ONLY public.participaciones DROP CONSTRAINT participaciones_pkey;
       public            postgres    false    241            �           2606    83217 "   patrocinadores patrocinadores_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.patrocinadores
    ADD CONSTRAINT patrocinadores_pkey PRIMARY KEY (idpatrocinador);
 L   ALTER TABLE ONLY public.patrocinadores DROP CONSTRAINT patrocinadores_pkey;
       public            postgres    false    218            �           2606    83227 0   patrocinadoresequipos patrocinadoresequipos_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_pkey PRIMARY KEY (idequipo, idpatrocinador, idtemporada);
 Z   ALTER TABLE ONLY public.patrocinadoresequipos DROP CONSTRAINT patrocinadoresequipos_pkey;
       public            postgres    false    220    220    220            �           2606    83252    personas personas_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (idpersona);
 @   ALTER TABLE ONLY public.personas DROP CONSTRAINT personas_pkey;
       public            postgres    false    222            �           2606    83257    pilotos pilotos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.pilotos
    ADD CONSTRAINT pilotos_pkey PRIMARY KEY (idpersona);
 >   ALTER TABLE ONLY public.pilotos DROP CONSTRAINT pilotos_pkey;
       public            postgres    false    223            �           2606    83292 .   pilotosestadopilotos pilotosestadopilotos_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_pkey PRIMARY KEY (idestadopiloto);
 X   ALTER TABLE ONLY public.pilotosestadopilotos DROP CONSTRAINT pilotosestadopilotos_pkey;
       public            postgres    false    226            �           2606    83443    puntajes puntajes_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.puntajes
    ADD CONSTRAINT puntajes_pkey PRIMARY KEY (idpuntaje);
 @   ALTER TABLE ONLY public.puntajes DROP CONSTRAINT puntajes_pkey;
       public            postgres    false    240            �           2606    83413 
   q1 q1_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.q1
    ADD CONSTRAINT q1_pkey PRIMARY KEY (idcarrera);
 4   ALTER TABLE ONLY public.q1 DROP CONSTRAINT q1_pkey;
       public            postgres    false    237            �           2606    83423 
   q2 q2_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.q2
    ADD CONSTRAINT q2_pkey PRIMARY KEY (idcarrera);
 4   ALTER TABLE ONLY public.q2 DROP CONSTRAINT q2_pkey;
       public            postgres    false    238            �           2606    83433 
   q3 q3_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.q3
    ADD CONSTRAINT q3_pkey PRIMARY KEY (idcarrera);
 4   ALTER TABLE ONLY public.q3 DROP CONSTRAINT q3_pkey;
       public            postgres    false    239            �           2606    83505    sanciones sanciones_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sanciones
    ADD CONSTRAINT sanciones_pkey PRIMARY KEY (idsancion);
 B   ALTER TABLE ONLY public.sanciones DROP CONSTRAINT sanciones_pkey;
       public            postgres    false    245            �           2606    83510 &   sancionesvueltas sancionesvueltas_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_pkey PRIMARY KEY (idsancionvuelta);
 P   ALTER TABLE ONLY public.sancionesvueltas DROP CONSTRAINT sancionesvueltas_pkey;
       public            postgres    false    246            �           2606    83222    temporadas temporadas_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.temporadas
    ADD CONSTRAINT temporadas_pkey PRIMARY KEY (idtemporada);
 D   ALTER TABLE ONLY public.temporadas DROP CONSTRAINT temporadas_pkey;
       public            postgres    false    219            �           2606    83393 .   tiposdeclasificacion tiposdeclasificacion_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.tiposdeclasificacion
    ADD CONSTRAINT tiposdeclasificacion_pkey PRIMARY KEY (idtipodeclasificacion);
 X   ALTER TABLE ONLY public.tiposdeclasificacion DROP CONSTRAINT tiposdeclasificacion_pkey;
       public            postgres    false    235            �           2606    83313 (   tiposdeneumaticos tiposdeneumaticos_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.tiposdeneumaticos
    ADD CONSTRAINT tiposdeneumaticos_pkey PRIMARY KEY (idtipodeneumatico);
 R   ALTER TABLE ONLY public.tiposdeneumaticos DROP CONSTRAINT tiposdeneumaticos_pkey;
       public            postgres    false    228            �           2606    83287 *   tiposestadospiloto tiposestadospiloto_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.tiposestadospiloto
    ADD CONSTRAINT tiposestadospiloto_pkey PRIMARY KEY (idtipoestadopiloto);
 T   ALTER TABLE ONLY public.tiposestadospiloto DROP CONSTRAINT tiposestadospiloto_pkey;
       public            postgres    false    225            �           2606    83318    vehiculos vehiculos_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_pkey PRIMARY KEY (idvehiculo);
 B   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_pkey;
       public            postgres    false    229            �           2606    83475    vueltas vueltas_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.vueltas
    ADD CONSTRAINT vueltas_pkey PRIMARY KEY (idvuelta);
 >   ALTER TABLE ONLY public.vueltas DROP CONSTRAINT vueltas_pkey;
       public            postgres    false    242            �           2606    83486 #   accidentes accidentes_idvuelta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.accidentes
    ADD CONSTRAINT accidentes_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);
 M   ALTER TABLE ONLY public.accidentes DROP CONSTRAINT accidentes_idvuelta_fkey;
       public          postgres    false    242    4817    243            �           2606    83364 #   carreras carreras_idgranpremio_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carreras
    ADD CONSTRAINT carreras_idgranpremio_fkey FOREIGN KEY (idgranpremio) REFERENCES public.grandespremios(idgranpremio);
 M   ALTER TABLE ONLY public.carreras DROP CONSTRAINT carreras_idgranpremio_fkey;
       public          postgres    false    231    232    4795            �           2606    83399 >   carrerasclasificatorias carrerasclasificatorias_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);
 h   ALTER TABLE ONLY public.carrerasclasificatorias DROP CONSTRAINT carrerasclasificatorias_idcarrera_fkey;
       public          postgres    false    232    4797    236            �           2606    83404 J   carrerasclasificatorias carrerasclasificatorias_idtipodeclasificacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carrerasclasificatorias
    ADD CONSTRAINT carrerasclasificatorias_idtipodeclasificacion_fkey FOREIGN KEY (idtipodeclasificacion) REFERENCES public.tiposdeclasificacion(idtipodeclasificacion);
 t   ALTER TABLE ONLY public.carrerasclasificatorias DROP CONSTRAINT carrerasclasificatorias_idtipodeclasificacion_fkey;
       public          postgres    false    4803    236    235            �           2606    83374 ,   carreraslibres carreraslibres_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carreraslibres
    ADD CONSTRAINT carreraslibres_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);
 V   ALTER TABLE ONLY public.carreraslibres DROP CONSTRAINT carreraslibres_idcarrera_fkey;
       public          postgres    false    232    233    4797            �           2606    83384 6   carrerasprincipales carrerasprincipales_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.carrerasprincipales
    ADD CONSTRAINT carrerasprincipales_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);
 `   ALTER TABLE ONLY public.carrerasprincipales DROP CONSTRAINT carrerasprincipales_idcarrera_fkey;
       public          postgres    false    232    234    4797            �           2606    83339 !   circuitos circuitos_idciudad_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.circuitos
    ADD CONSTRAINT circuitos_idciudad_fkey FOREIGN KEY (idciudad) REFERENCES public.ciudades(idciudad);
 K   ALTER TABLE ONLY public.circuitos DROP CONSTRAINT circuitos_idciudad_fkey;
       public          postgres    false    216    230    4765            �           2606    83198    ciudades ciudades_idpais_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_idpais_fkey FOREIGN KEY (idpais) REFERENCES public.paises(idpais);
 G   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT ciudades_idpais_fkey;
       public          postgres    false    216    4763    215            �           2606    83208 !   equipos equipos_paisdeorigen_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_paisdeorigen_fkey FOREIGN KEY (paisdeorigen) REFERENCES public.paises(idpais);
 K   ALTER TABLE ONLY public.equipos DROP CONSTRAINT equipos_paisdeorigen_fkey;
       public          postgres    false    215    4763    217            �           2606    83354 -   grandespremios grandespremios_idcircuito_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_idcircuito_fkey FOREIGN KEY (idcircuito) REFERENCES public.circuitos(idcircuito);
 W   ALTER TABLE ONLY public.grandespremios DROP CONSTRAINT grandespremios_idcircuito_fkey;
       public          postgres    false    230    231    4793            �           2606    83349 .   grandespremios grandespremios_idtemporada_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.grandespremios
    ADD CONSTRAINT grandespremios_idtemporada_fkey FOREIGN KEY (idtemporada) REFERENCES public.temporadas(idtemporada);
 X   ALTER TABLE ONLY public.grandespremios DROP CONSTRAINT grandespremios_idtemporada_fkey;
       public          postgres    false    219    231    4771            �           2606    83278     haceparte haceparte_idcargo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idcargo_fkey FOREIGN KEY (idcargo) REFERENCES public.cargos(idcargo);
 J   ALTER TABLE ONLY public.haceparte DROP CONSTRAINT haceparte_idcargo_fkey;
       public          postgres    false    4775    224    221            �           2606    83268 !   haceparte haceparte_idequipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);
 K   ALTER TABLE ONLY public.haceparte DROP CONSTRAINT haceparte_idequipo_fkey;
       public          postgres    false    224    4767    217            �           2606    83273 "   haceparte haceparte_idpersona_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.haceparte
    ADD CONSTRAINT haceparte_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.personas(idpersona);
 L   ALTER TABLE ONLY public.haceparte DROP CONSTRAINT haceparte_idpersona_fkey;
       public          postgres    false    224    222    4777            �           2606    83496 )   paradaenboxes paradaenboxes_idvuelta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paradaenboxes
    ADD CONSTRAINT paradaenboxes_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);
 S   ALTER TABLE ONLY public.paradaenboxes DROP CONSTRAINT paradaenboxes_idvuelta_fkey;
       public          postgres    false    4817    244    242            �           2606    83456 .   participaciones participaciones_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carreras(idcarrera);
 X   ALTER TABLE ONLY public.participaciones DROP CONSTRAINT participaciones_idcarrera_fkey;
       public          postgres    false    232    241    4797            �           2606    83466 .   participaciones participaciones_idpersona_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.pilotos(idpersona);
 X   ALTER TABLE ONLY public.participaciones DROP CONSTRAINT participaciones_idpersona_fkey;
       public          postgres    false    223    4779    241            �           2606    83451 /   participaciones participaciones_idvehiculo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_idvehiculo_fkey FOREIGN KEY (idvehiculo) REFERENCES public.vehiculos(idvehiculo);
 Y   ALTER TABLE ONLY public.participaciones DROP CONSTRAINT participaciones_idvehiculo_fkey;
       public          postgres    false    229    241    4791            �           2606    83228 9   patrocinadoresequipos patrocinadoresequipos_idequipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);
 c   ALTER TABLE ONLY public.patrocinadoresequipos DROP CONSTRAINT patrocinadoresequipos_idequipo_fkey;
       public          postgres    false    4767    220    217            �           2606    83233 ?   patrocinadoresequipos patrocinadoresequipos_idpatrocinador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idpatrocinador_fkey FOREIGN KEY (idpatrocinador) REFERENCES public.patrocinadores(idpatrocinador);
 i   ALTER TABLE ONLY public.patrocinadoresequipos DROP CONSTRAINT patrocinadoresequipos_idpatrocinador_fkey;
       public          postgres    false    220    4769    218            �           2606    83238 <   patrocinadoresequipos patrocinadoresequipos_idtemporada_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patrocinadoresequipos
    ADD CONSTRAINT patrocinadoresequipos_idtemporada_fkey FOREIGN KEY (idtemporada) REFERENCES public.temporadas(idtemporada);
 f   ALTER TABLE ONLY public.patrocinadoresequipos DROP CONSTRAINT patrocinadoresequipos_idtemporada_fkey;
       public          postgres    false    219    4771    220            �           2606    83258    pilotos pilotos_idpersona_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pilotos
    ADD CONSTRAINT pilotos_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.personas(idpersona);
 H   ALTER TABLE ONLY public.pilotos DROP CONSTRAINT pilotos_idpersona_fkey;
       public          postgres    false    222    4777    223            �           2606    83293 8   pilotosestadopilotos pilotosestadopilotos_idpersona_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_idpersona_fkey FOREIGN KEY (idpersona) REFERENCES public.pilotos(idpersona);
 b   ALTER TABLE ONLY public.pilotosestadopilotos DROP CONSTRAINT pilotosestadopilotos_idpersona_fkey;
       public          postgres    false    4779    226    223            �           2606    83298 A   pilotosestadopilotos pilotosestadopilotos_idtipoestadopiloto_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pilotosestadopilotos
    ADD CONSTRAINT pilotosestadopilotos_idtipoestadopiloto_fkey FOREIGN KEY (idtipoestadopiloto) REFERENCES public.tiposestadospiloto(idtipoestadopiloto);
 k   ALTER TABLE ONLY public.pilotosestadopilotos DROP CONSTRAINT pilotosestadopilotos_idtipoestadopiloto_fkey;
       public          postgres    false    4783    226    225            �           2606    83414    q1 q1_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.q1
    ADD CONSTRAINT q1_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carrerasclasificatorias(idcarrera);
 >   ALTER TABLE ONLY public.q1 DROP CONSTRAINT q1_idcarrera_fkey;
       public          postgres    false    236    237    4805            �           2606    83424    q2 q2_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.q2
    ADD CONSTRAINT q2_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carrerasclasificatorias(idcarrera);
 >   ALTER TABLE ONLY public.q2 DROP CONSTRAINT q2_idcarrera_fkey;
       public          postgres    false    238    4805    236            �           2606    83434    q3 q3_idcarrera_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.q3
    ADD CONSTRAINT q3_idcarrera_fkey FOREIGN KEY (idcarrera) REFERENCES public.carrerasclasificatorias(idcarrera);
 >   ALTER TABLE ONLY public.q3 DROP CONSTRAINT q3_idcarrera_fkey;
       public          postgres    false    4805    236    239            �           2606    83516 0   sancionesvueltas sancionesvueltas_idsancion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_idsancion_fkey FOREIGN KEY (idsancion) REFERENCES public.sanciones(idsancion);
 Z   ALTER TABLE ONLY public.sancionesvueltas DROP CONSTRAINT sancionesvueltas_idsancion_fkey;
       public          postgres    false    245    246    4823            �           2606    83511 /   sancionesvueltas sancionesvueltas_idvuelta_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sancionesvueltas
    ADD CONSTRAINT sancionesvueltas_idvuelta_fkey FOREIGN KEY (idvuelta) REFERENCES public.vueltas(idvuelta);
 Y   ALTER TABLE ONLY public.sancionesvueltas DROP CONSTRAINT sancionesvueltas_idvuelta_fkey;
       public          postgres    false    242    246    4817            �           2606    83329 !   vehiculos vehiculos_idequipo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idequipo_fkey FOREIGN KEY (idequipo) REFERENCES public.equipos(idequipo);
 K   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_idequipo_fkey;
       public          postgres    false    229    4767    217            �           2606    83319 &   vehiculos vehiculos_idtipodemotor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idtipodemotor_fkey FOREIGN KEY (idtipodemotor) REFERENCES public.motores(idmotor);
 P   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_idtipodemotor_fkey;
       public          postgres    false    227    4787    229            �           2606    83324 *   vehiculos vehiculos_idtipodeneumatico_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculos
    ADD CONSTRAINT vehiculos_idtipodeneumatico_fkey FOREIGN KEY (idtipodeneumatico) REFERENCES public.tiposdeneumaticos(idtipodeneumatico);
 T   ALTER TABLE ONLY public.vehiculos DROP CONSTRAINT vehiculos_idtipodeneumatico_fkey;
       public          postgres    false    228    4789    229            �           2606    83476 $   vueltas vueltas_idparticipacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vueltas
    ADD CONSTRAINT vueltas_idparticipacion_fkey FOREIGN KEY (idparticipacion) REFERENCES public.participaciones(idparticipacion);
 N   ALTER TABLE ONLY public.vueltas DROP CONSTRAINT vueltas_idparticipacion_fkey;
       public          postgres    false    241    4815    242            �   &  x��X[��@�n��'�<��<��� ?��v� KV�q� ���XjI �u��q������jJ1Чv��u��7�n���ǰ�W�S���Mݯ����ۯ�ʒw���Ų[��[-ׇ�ݲk�u�x��m��/���~�V��I�q��~ܯ��@����?�}A���n+O��T�zX�c�^�(p���TC$g.K^�����v��;��0�O�����%_�ȧ�����Lɺ˚��f2>��m��P��0����~}���"|�^�%����}�(���&��^�)07E/�Wz+��;�m�6�6� �$���9�p�Rr�`9$qm!Brg��<�\�r���Hh��(���Q���,(������h�:u�8�A�No`�y���Z}�S�<��GE�Ee.R��z�e��v�A1&�L�L�y��	$�gA�ސ�eW/�C�V���Q�Y���d@����c�u2�|$/���1�^�](�g����dU>�.Ϥ`0�$p' Rx7M��@�tX�ء�B ��A䊠pB���R3����B*��s0nJ4���#Y)�h�!�c[tdJ] �q3���Vo����$�h�A�����:�-�,K#�)F�� S�p'�c�_Er2�?nr7K9a�$%A�C'�s��G��N�A�ǒ�4�ܐ�s�Ȇ��?߁��5 2B��	"c���qF|M�eQ0F��r)d,��j@���y����rZI��P)-���/�ˋ\�1�*I�2w�w���P���FL���}����R�d��.P���4�sw�着�	��i+      �   d   x�3����/��2���KO��L-�WHIU(�,.I�2FL�)�y��f&'r�p��&^�����e��Y��\�_�Prxe2X�!ԛZX�Y������ [(\      �   v  x�u�Q�� F�gg/� B����������!�c	,�@��UR��T�ɮ\�4�r\O����u_���������Ͽi���Nx2u��0򆟛��=Ⱥ+/)����Zw�D6i�*�!.���3�}d>g��S"[)�!��U�H����;�V�)��(��P�f]|�>���3�5#:X�x"�7����@tx!�`f���v3�A|Q=��/�1h3k���;Mf�'�&�oV��B���Y 5_U�ŗ_ ��atD�D�h���r�H�x��z�8���D�{�|ݟUD����x= "��'��j��h�����8 ��D@I�|Y��Tw!�Io#�Vw= "��"�s�"kg�j���"(�=N�'QXɶ����dkE�|3Ԭ�S"�EP�6�r���DP��EP�6Nybz�dT���{/���"�YwA�zJĸ�6��D�&���]��<1#�`s�!G�"�>&���zJĸ*:ViD"[AEGA�qJl)��yV��Ϟ�oc���,=�;�0��Yȃv�5�,E�	�PgT�'�Sb"q���Xgߧ�V�>�u���X+��gN�i�jԽ��H�] cT�\��IH�9&�	Vc�(�(B���z�^ʊ'�      �   �   x�%��D!Eѵ3P�^~�u������f=��٢�������a�A�h���:ꨣ�h���D��D':щ.t�]�B�эnt��h����AM��B-]�zЃ��G1Tc(�P�� CE����d�ً���l��jG�L�_��5n      �   >   x�̹� ��\�x�zq�u�;R�����0d�)3,Y!��e�#'\��Z���jyk�>�9K      �   @   x�̻ !��\������ׁ/R�2%�4�L�1����,���q����A�p?��      �   b  x�]RKj�0]�N�4d��25����U7[�*�d��ަ�*G��:v7����̛'! T��^u6jdt륱m�VN��.C���{ H�H ����k��i�L'�����N!��j<�H�,�"�,����s�X���39�/����b6���dju�!fA	e�`+�u1\������ҝhX~o�_�^��;��6w����^��:y����b'��p�o�a�\`8�q���2�X�S�0ǝ7�EG���,�	0�.;����0�s;��0�X	,�1�5?����%�,Kk�����C*��1��t-9���z7��T�K��4w�5��\���B�m͈      �   �   x��MJ�@��U��	d:�Y� �L 8��MM�Z�.�N�G\���G�Yq�}�ǫR�`L�s,nm0K	��4�	+(ᔿ�X(9�Z��r�M�@����@'�c+�D��kd젆�/��/�g��s��q�&�4�}l�?veT��ir�"#��p��B�Д�ު����fޭ6����F�劻�T�0��JU+2��=K��AT�Q��#��8�re �a� �cy�����o��cWP      �   �   x�E�1�0E��9�-�e�!��bJ(�J	�N����(a��������ڨ�5剭�P�t!��tޓ�1$���AZ1�(��gS:�1��{E������ΚD�h��tv��K]�C)d�މ�i�� �x�u���q8�Q8φ��^�}q���v�j��&Ç}@����,��kI����ǀ����%���z �LGc�      �   }  x����N�0�g�����������b�U"�	J��#+k^���渱�H�H�'��9�`���3�j��]ծ^��~���6-�\�DrB�b�\�u�{�L$�@��/;a	�,r^��)�:�R�9��5�qL�������b�pD1��;C�Jx�3�PS�뷽�����ыNFX��N���h��������;z�����2�&#�d�h�6�Tz<LK@)Z����~L�$Ԁ-�mN$i�����9��gG��K**C��Q;�v��P�&
4��^uf_�A�{(�kbAф9�P�y�\v[ۼW�	�#b	ҽB�+qb�Í4!�%Y:��|nD�)Tο�>���y��㓄)���'���瓄<] �9�B�      �   7  x�m��q�@E�5�b��H�(�8<�w����
q���as���k�����UPc�8�_�]�v�}����ڸ��z�z�Ϯ�-=�����3W��B�FKu*����_5J�R��5jMT���$���O������z���N��^��Z�^����[�^�鍵{��N�ZP�C��Huz����K3�K�޸��G��\Z���i�ӛ�)��Pٳ�No�:���]Ip^3�8����h�5;��2mᢺ|d�l���r/�Ù�j�Ey]3���P^�(�ASަè)o��=�WS�9ʻf@���<�_���      �   �   x�3��M-JNMI-�42�t�uWp3T�54�tLN-���,I����2����KI�	r432�@�7�tK-*J,��003�7CS ԗ��X�SR�����`d���ʔ8טp�9q�X�̒�������� �Ee�      �   e  x��V�nG<��b�	 \J�%�d'Rl�� 9���m�#�ά����}�!�'쏥z����!#>�twUWWoY�Od�U���]q�����F��Z�%�F]x���Nլf��R�ߍj�qѩ�ױ���rj?ġ�7�T��H��W\s8T�-=�$9Wig�FV+]E�5�䮴��F���d��_�����h�b<*���h4��Ōr��n� �5��M2(�s`I5|�<���>RС�ܫq��*m�Ͽ�?�*��-�l�W����%״u�+]S�A��p��?K��d�y��M]� [Y����D�o��e�n�휽'��d+0VQ3�n[m��-	޷�1ҟ	�ZB�Pf��gݐ�� 6�t�����*��'M�
D&��S�:D`��i��gƵ�Q�2쬺$�7�W�ܵ����P��g]k���>m�賤�}��åP�d�E=T4���}J,xpN�]�mw��ԗ,���4��GEY�@�W\{(�|�,���BԘ��8F��mj��5��Oַ��H�̣��8x�����]���a��A��Ϙ� ��}��A~ˉ"P6�Ty����x:�,�BӒϊ{�g��Hp�Q����82�P�V"!�$��SҭS�W[�H�@Y��^A�
�@T��q+mthܡBd��'Luw��4�?x:��bt2�dq�.~#؁�HQ�y�z���j׀|%c�z�@N�`�~��0A=GO$�6+�N�v��fꊣ��u��b���>05�q�Bj�kخX:o4F#+UD-`�6�������@o�Ð�W�l�k��z�y��{�ٶ-�(v���q�\u�.e¤������aP�K�(m6h�~Þ*���3�6�u7�����EfD(ͼ`3��O�3��uQm���x��W��u�F�ݙ�8L�8���.E�g�&�n�0p����;��m���ۨ3Qy����/���p`�yv���tO`fkv�
�E�r���=����xS�Ȧ���7n!=�|�� ��v��3fSk����[��r��v݂P�M�g)���I�/�wW#��F�� }Q�W���a�#�)�������Ƕ= �(��2���˃��� �p��      �   q   x�3�t,JO�+��K�2�t*J,���2�t���I�2�t����M�L�2��=��"39�ˌ3 ���..s�Т����J.ΰԼԪ�ԜD.KN�����8݊󒁚c���� 2!i      �      x���AndIn�ׯN1'02"� ��W^{S=.eLw�g��m|a.�/
���$P�R�z����S|/b\�z<��c]���矾�����_������_�����?�k��K~��?���_>�ח�U������_����/�ֵ�/���/>��K>���o�����Or��U�W�ﯿ��������˗�>��^�|���:��/�p	���'��/_���/���<��Ͽ}�鷯����]�|�����2�q%q��⮒������7�P�w�|-c^c6���xu�q{=r�Wo����5^����l��v�W��GU�5�=YUq�x�����㚏��U�q���c�����η������������ ���M��UM�����j_��j�yS�]���Ǽ�ʯ�o��QUq��������k�G�=�5�&���5�5�F�Ǫ��F􇪖\K��惪�^K�~>�j_�a��*�����Z�M��kE2���QN��KF5�2/��	�u�J'Pb�&P�M&P�%��@�K��@�K�1��D:�����M��KG2�:/���tU�r�4&P�����ҝM�ڥ�L���^N�ƥQM�~\�ј�=�=�	���3������	�rm)'p뵵���;�ݘ�m׶t�_۳	�q�H&��=�	�q٨&��e�1��.[��\&��^��ھl�h�y�j�/��Z\����G6�>.���|����UM���Ҙ@��5�@ߗ�l�.�d���^N���QM`<�x4&0�#���W�lc]��	�B�	�B�	�}�nL`��N`��M`@!�L�x
y�38��������|���j���ܙ�����-!�$���3|>^�S!X�hp	��׈|T!h�����������������o�,� ����xp|��
<8�5����z[ ���H���4~�6�U!=����
��(�e �c�k�GB�c~���
�!�w#�C��ᘷ�V��]�?�.�v��WH�g_�8�wͿ����w#�c�t��c}��*�Ǫ�P�4����q�<h@ƱҠ��j�8V4@�X����*�����	|�&�8��4��:i��ũ�4��"i��!yҀ�CҤ�#�4��R'09��4P��"i ˡyҀ�CӤ�)�6�F�_��,����Z$�94Osh�4��؍��/Ǯ����4���E�@�c�In��&�>im$�9v�4 �ح��<�.���'�9,M�sX#i��au� ��ZI�+��'���r�I�k$:�N@tx+i ��E�@���I��I�o$<:�N�tx+i���E��Yaȓ<�&l:��4��:i ����TGI��ȓT�&�:��4p�:i��������'�|���4i&�:�����G�4V��2i&�:����?y�L���4i&������Я���fr��Q&�W��$�gi-O�	�Α&���[�R�u�L`u�2i&�c�N�L�u�<i&�:G�4�f�{n}-B��Y'�<���^�����I�y6g�4�k�4i�YҼ��W�4}�I3���,�f���I�y9g�4��\y����[���s5�f���:i�չZI��U$�:W�40���W�4}5�X��NxuJ+i��)E� �S�Y�=�>+����H`uJ�4��VҀ�S��\��I��{n}V�Nm$�:�Nxuj+i�֩E� �S��#O�I�Nm$�:�Nxuj+i�֩E� �s�I��{n}V���H`u�:i�չ[I��]$�>�J�40���W�4}7�X��NxuZ+i��iE� ���Y�=�>+W�5�X�V'�:��4vԡ"i �iy����[_
M�F� ��뤁W���l�^$�:=O�u�s�B�V��I�G�j%�:�H�uF�40���g���F� �3꤁Wg��l�Q$�:#O�u�s�B������5d�c�u�f���'�\�#M���{n}Js��z�I�(~�/���p_��R�xp=�Y�i�,.y�s�Bpu�:i�8�b�4^]�%3�k�I�(|�4i̺��U!MoȷX]�k��+�룓4�~��'�\�L�f���[��#��I���u����Bxu�N�,�u�<i�f�4f]�������:i��Z��rW+i�����9n�ʓ曝�&��sW#i��{����B�ޓt�����9��ʓ昺����i�4�X]�k��*�W���l]R$�=:O�u�s�B�.��V��Z��
麴�l]R$�4O�u�s�Bpui#i��u����Bxui+i��E� �K�Y�=��*���H`uݯ��W���n%غv�4���y����[���k7�X]�k��+<w��l]�H�u�<i`�uϭ�
��e��V��Z�
��e��[�I�.˓f]������[#i�܂Q'����4`�"i ��y����[����I�����w«�[I�./�p]�'̺��U����4��_k}W!����4`�"i �y����[���+I��������h%غ�H�uE�4q�>ʒF���:iX�ZxUZ����R(��J�uK�EIC�Z���",\��� ���(*����%����p��'K��K��U
GX�>�;��J��*GX�Ԏ����r�l���y�K�F`VIaW���*�#,�a[�p�p���URGX�Ui8��J��*-GXֹ߱H�UrGX`VIaW���*�#,�a[�p���h�;�r�2Ma9��6a9��֎�|�ϴ�4����s�i�˹�4u���n�p���nZ;��J��U
GX W�a�Y%u�\��#,z��^��#,`��� ��;��J��*GX�U�a�W���*�#,��䎰���:²��Ս�V�v�^��#,`��� ��;��J��*GX�U�a�W���*�#,��䎰ع�=MpU�� �R;��J��U
GX W�a�Y%u�\��#,��Ԏ����r�l��?�
�I�J��*GX�U�a�W���*�#,��䎰���:��J�`UjGX�Ui9�g?�<i�qvtH�FaVMaW��+���#��a�|-a�(�a峚:�JQ�p�����VxU[�����F�4
�j�+���V�ֆ#���֎��=��+ت�#���掰�lMaW��+���#��le�I[�p�p��V�USGX�Um8�
�j�+��-GX�V-a\5w�f��VpU�����L�4�a[�p�p��V�USGX�Um8�
�j�+��-GX�V-a\5w�f��V9�4�X��VxU[����Z8�
�j�+̪�#�g���#�g���ֳiR�ֳqR���7)w��ۖIiҜ-������jGX�J-GX�&J�#���掰¬�:�
�j�V`UkGX�Um9�
�j��>;V�I�j�+��GX�U�a�W��+ت�#���掰¬�:�
�j�V`UkGX�Um9�jgð"i W�a�Y5u�\Ն#���֎�«�r�l��V�UsGXaVMaW��+���#�~�jk%ت�#���掰¬�:�
�j�V`UkGX�Um9�
�j�+હ#�0�������p�5�ye����#��4l݅#�ם;�fݩ#����p�7�����[����]8�v�o.y���Ww���lLX&͆Ww�޼�.�M�;w�7̺SGx�ڻ�o`u׎��Ww���{��\w�o�u���gK�:i6��kGxë��o�u��\w�o�u���Ww�������#���]8�pݹ#��ٓ3Mpu7�������n9�l݅#�ם;�fݩ#����p�7��kGxë��o�u��)j�40�N���#���];�^�-Gx���p�7�sGxì;u�7����Vw�oxu��g;�"i ם;�fݩ#����p�7��kGx�}[��>;���>{���>�����>��6�}v ���m����o?H�Ex�m�sEx���SExC���oXu׊�WwK�P�.���\� �N���"���\��[���Zw�o�u��Yw�ohu7 �  ���Z���n)�j݅"��֝+�dݩ"���x�Xu׊�WwK�P�.���\� �N���"�a�]+�\�-ExC��P�7ܺsEx��r<K{�M��1X�jE��Uk)��Z��j�"l�m�"leE�x�jE�(�Z��q�V(��Z��8�gIcЪ5a��V+�F��R�j�B6��劰���*��ZC6�l�"lવa�Z�P�m���Ӥ1��REؠUk(��Z��j-EؠV+a�[-W�d�T6h�����V+��ZK�u9(�n�\6��REؠUk(��Z��j-EؠV+a�[-W�d�T6h�����V+�&�p�V�@�V(��Z��j�"lЪ5a�U�V�\��"lP������+��Z��jE���Q'�j-EؠV+a�[-W�d�T6h�����V+��ZK6��
E��V�aY-U�m�CUI�Z��j-E��V+a;��䊰�ClRE��	6E��	6�"l���"l�<�B�s�M�۷mҤ9��4a;��Ԋ����R�l�B6��rE�`VKaW���j�"l�a[�P���aBy����*��ZC6`�jE��Uk)��Z��j�"l0�������P�X�Z6x�Z���9�)O�c�Ҥq��SE��Uo(��z�;��-E�)�E�)�sE������S�7a�j�V�^��"�㜢�'���+��3=U�����;��"�|o)��z�;��"�4�SE��Uo(��z��<�u���V/a\=W�f�Tvp����^+��zKv��E�W�a�Y=U�\��"��W'��-E��V/a\=W�f�Tvp����^+��zKv��E�W�a�Y=U�]�i}��V�V�^��"�`�����+��z�;��E؁U�a�W��;��"쀫犰�9'1Mp����^+��zKv��E�W�a�Y=U�\��"���׊�ë�R�l�B�}��̓f�Tvp����^+��zKv��E�W�a�Y=U�\��"���׊�ë�R���)�E� ��+��z��9����9��V�����R����Z(�~�e�a?'�����Y����YkEؿ���J�sFk�;��"�0�������P�X�Zvx�[����^(��z�;��"��7a�s,n�4�8�v�&��(� \#W�f�Tp5�pP|ԊpPT����(ᠨ����#U�\��"�F\&M���R��׈B
�\�5RE8x�h(��F��-E8�w�p ��+��F��<�@�I�jԊp���R�l�B�5rE8`�H� W����"�j�� [�P�p�\�u�N�\��"�jԊp���R�l�B�5rE8`�H� W����"�j�� [�P�C�I�y����*��FC`5jE8��h)��F���"0k��p���P�X�Zx5Z�p�9��H�5rE8`�H� W����"�j�� [�P�p�\�5RE8��h(��F���m�l���5rG8`�H� W����#�j�� [�p�p���5RG8��h8��F��-G8��(� \#w�f��p5�p �Q;��F��5
G8 ���Y#u�\��#�jԎp���r�l����/l��r�]�o�j^�C���h��ޏ�o�*w�[�]��l�7t�WH�_����
�n�����������O�>�?�;�b      �   1  x�E�[n�8���,��"u���9����N�ew��
����c�c�Ҭ��^����o�C��W
���^�_�g��8���ߡ4�N{��oߔw���\��;7Nwn��7՝;Nw�~~g��Ž���w�X��_qE���8�)uu��t��"�"���P�P���R-B-���Z�Z�8�9����t�hjQ��*���UA�Uz���B�Z�Z�8�)�H���t��"բ�X��N�ߪ�]NwN-R-z��Z�Z�q�s�H���{�Z�bMb�Z�m1E�3zG��4NwJ-J-�8�9�(�؏ӽ�Ԣ�b��^[-J-v9�9�(���t�Ԣ�b�;G�R��|q���^'��Z�mq�pgԢ��ӝҫ7[q��Z�Z��S�W-Z-�p���o9�9�h�x��ΩE��{��-Z-~���B�zܽ��}�E~��̟&��9uu�=�I���=�Q�z�a�y����Ϊ�ή�β�ζ�κ�ξ�����y�f��V3�~�[�Ռ��j��o����fl����i��o����fl���1��M3 �i6�@���4�f����1�i����f��(8j̀��484�f��� �A�C3�ph�~@����C3�ph� á��phf4���Ẁëf��U3��|xi ^�A��f ��xi$^�A��f`��xi(^�A��f����G�~i,^��/͌��f�B����N�]�7��f��>ԃʚ��Pz(k���CE��[!��P�(�y8"k���y�E�����>T�(ʚ���������{��*�.���1\�%uc9jJ�Z{��D ��!�4���/�J�id" L�b��(E �F*�4Z`��0g�jaд�Ҵ�"�<�i�4�mښnڢoڪpڲq���G��F9�4�P�ю ;�x�i�# O#y���H�=�����HH@����i�H��N��5K[t$@P#$�%	 �HI@�FK5bp�Q� D��$jP����E��0j$%�Q�)�Q	�Q�0�Y	��ҕ I-a	��R� Jz�i[V����i��`j�% S�/��	��(L �Fb:5���O���jd& T�3��	3�Q�0��	[��&�5���Hm�n#�	�z�'l8mi>_�<mќ�� :a�Au®��m�	��6�'�<HO�zО�� >�ꓟ��>iJI~Ҕ���)%�ISJ�������
���������@[4(M)<(M)D(M)L(M)T(M)\(M)d(M)l(?J�C�Q
JSJB����(M))Q�Rr�4���4���4�Т4��4��4�0�4�P�4���F�E�ҔҔB�ҔҔB�Ҕ����p�4�$IiJɒҔ�&�)%OJS
QJS
SJS
UJS
WJS
YJS
[JS
]JS
_JS��֔:>�eJS
gJS
iJS
kʏRhS~�Ҕ�8�)%sJSJꔦ��)M)�)M)�)M)�)M)�)M)*M)*M)*M)*M)$*M),*M)4*M���_�"RiJaR�Q
�ʏR�TB)��1�<��TB��K%�\*���R	��J(5�TB���J.�Pjp��R�K%�\*���R	��J(5�TB���J���O1���Ͽ_܃�Ohr��M.U>�� Ƈ4�T���K��i�T���K�j�T���K��j�T���K�k�T���K��k�T���K�l�T�ĆK��l�T}g6\��C.UPJ����x��ȥ
J�\����R��*(5�TA���
J.UPjp��R�K�\����R��*(5�TA���
J.UPjp�2�ƏsL��(5<ҁR�C(5~�S�����@���(5~���x���R��*(5�TA���
J.UPjp��R�K�\����R��*Sjp�2��*(5r��R�ҍ��K��TA�)?Ț/k���TA���
J.UPjp��R�K�\����R��*(5�TA���
J.UPjp�2��*Sjp�2��ReJɥʔ�K�)%�*S
�*S
�*S����|Y�ťʔ¥ʔ¥ʔ¥ʔ¥ʔ¥ʔ¥ʔ¥ʔ¥ʔ¥�.��p�����?�<0�      �   �   x��9�0�z�)|��6R �(P�2	f,y�¹8��<M���Ρ�����r
�LĂ.�x�~���t6������Vl�XS�O�P�V�ɂ-��e����ѫ���i�ݠN�At�U��]Ҏ�z�u��-t      �   #  x�}�Kj�@�u�>���g$�%��E ���j0���tS���3�m֬�񳯿ϟ����:�f�B<��鿶Y�������HX0�;f�6��U�!�|w���E��j#�k�,qA��
�����V���%0i0�?n~`а�tMP4ua���5�B8m�Y����a����a�{����0�mM��'�Ab?�	���F����e��Ҁ<�f�-�A�A
>���sJ_>i0f-�����-tfv��z�J �AK#$|��-�F�8O�� m$Ji      �   �  x�}W�r�6<��_�2_zܢ�Y�]���N�)���ᐄJ���>= iYZbo�,��螞AF������ T�������Ѫ�-eyQV��b��fg8�eW�V��yp��\�gUY�YRЗ��S��M�% ��,K`!Y��U���:�; �;VnDg9�uHK*�f��>}�~FR���<�¾�;�1��>8N?i�q���	V�G|���Tsz�[g�[�"�Ub�����5d%z��qo7�ߨ�Pm��r�,�y��%K���.]5��-�x�أ�Ts�INvE4���uN�����WVcJF7F�l�x0o��P9��gI��N�򑝳�*Hu]
fL*h-�5�7~�W�l=T� /y�D[�9�7���� /i�*��n�q����I�#!�P'r�l&��_�kۘ�E5@��蒞��d`�7�M�t{�c���L�#:��j6�^s���1bU������dK����:&'H=4�������	?��R���d)�&yF��4ڵ6��5�7��n����钭1=�G[;T99C�O�O)[�!g�@? ��"�p�/�Ǽ�?s���i��z�E��+Z�<�rA���.N|�0�L-}���0-��I�+��;��ZoEH�G��(Ɨ���2�O�(C��8�גn�3������1.�G*�G���#}��H����kx� �֣)���)��F����;3E18�PI��~YIEI�Z�>t./�j%�0S��F����ƶ�=e����K<�a4�of�����v�9}�5�7}�?`��(' ��,Ucc=��F@���X�v{�6�#8`��r�����z�@<+'en<P���Oe6v$qKy-�0�U�ǅ���z!��� (�WY�L�s5[��x��!�TYU��}} W�n_��UV�%Й���hQK��F�W��:��N6CdPD�*��	eP�����[�>B�ƘZ5�h[�[_QN�O�D��l����;J��t�#LUW�d�Օ�>;�=T`��*��k)�a�/��P���t���P�>V5�;UAw�@wk��3����dvb�*ǎ����:�ѣ?U5t���BG���U��t`x,c��1m^����T�>44ʓ	M4��,論ah��:A���nާ�0�;9��̠���8����'�f�؏`�2K��dDx��~��b_���(�Ϭ�?��G�Ԝ:����HG��J��O��>v�aS�������w��*I��/zE      �   8   x��A A���9)i��Y�8�&	�c&LY�fÖg.\��y��mX      �   �   x�E�[��@C�o�^z��/{/��ut�#<�E!�`�!�G�����w&s��>o�ۙ�0Ѫ5�3�c�W�ng� �Qq8��~o��xf,p�g\�g�.�o�3え���xf����2������V�����s�>#�����T�uU��hJ'�W�ˁ6�V	o��R�6Vo�Τ��UȼѕV��J��L,�YŬ}���̣Ή�VIo�QEC���0�Ec%�:���h���������w���J�n��/"� �=�      �   ;   x����0��^1�ƽ��:��Ƙ(�G��KI�PQx�iF�CkR�Kȋ��G�TX	<      �   =   x�̹�  ��\�0 ��^��H�JB�C���0e�%+D��p�\U/����w�� ?�d      �   >   x�̹� ��\�x q<zq�u�;R��Х�!#(�)3,Ya�GN�$\��Z�V�y�^��>y}      �   >   x�̷�0���hh@s���:�-$t�a�SfPKVزÑ��I�V�U^���}��      �   �   x�U�;�0D��)|�$|�t�H����Y�Y)����F�!#�(��yo&���D��z7�Z0��Mi���\�Q�>�g).�&������m���'�H����-[�m�NhL�T4<�e��~˼4���ۣ7hM�>�''~�v���@�0��_VJ���Bh      �   M  x�5�ɕ�8C�r0}L����?���_�\�Dp @)Ɖ;�cF��̱���#�5�>c={�ܣ�3j�#�;���=��︧~�Mp��H�W1Q�����|b�~�&��{t����W��܊�1U[Z<9Ǻ	r�h�';�=���t��_�ӗ{���K�Ϥ�Tv���ܣ<o5��\�N��=�}drN�V�I�K��D1�(�~*�Ok��|7�%d���8�!?/eWs��j�0p����H�y5SJ<��ow/����ŜC��=��`]╚_�N�'�����lլ�M�-
h%O����)y�)��5pT�v��aNͩ!�w-��P��s$7�L�U���w~��Tˇi\%=�!E� Bj�ET(թ(zH�.�~��G�}>i�jY��d��K��$ZtK)�z��4���� ��O��O���Š(@ �c6I �rJ�)/������l���Fx��DC@O�.a0����X�=�3���m���C`�jǪ�WeGH��c��)�E�Ϥ��w@L�5
�U���3�G%m���\�܌��)yF��F���39�<�U�dSF����r�w ���	�K{,�8P0�y�m�.	"��L�ا�ì`O(Ǌ����6(��`�j��R�a��#M�Yi�1�6[LB
����E��6�\�U���j,m1/0�Z�P��LP�	��"����ywz�K9��ǞF��O9[��\p�6(�aM�SN���Ե3�3Ze�`���
�����ৼ^+k��B�R"(�<�5y>�i��)�r�
��۵���ra�z���2�����D@�2���^��ug��i�J!鎰�L.�-OW.IO{O0ǘo6P`��ɰe������m�1�Yv ������O/�Щő�\�q;��:�Q���:����4aei6|�:J;"���C�_��/8�0J{D��Վ�.���A[���.�����_,Y��/rL�9u��4�E9e<P�������������y���6
=i��NA�7���������E;��I&q�+�>J�'�^+'�R�(8����]�z�[p��}������g���[��K�>~��Q�lעE~�o	2-9*�v?"��,���Q��m��9sEo����~���%��#���o�z�#|�9*uI��K��Ba_�k|���5��a���������:_L�=���s�zp�|~���w�'��e���k�yy|�Z�3�=���*?k@���V����P^�0;*9�>���QI�����i�Z���T'��>|��]��zѫ�7v2��>��]��/�+�E3���ż�u��
�8��9ݑv���t������}����y�l��      �   I   x�%���P���.�"��v��s���cYpS(V��1H.=��uR�!=�>�_(�l���j_����KAM      �      x�3�4�2�4�2�4����� !�      �   $   x�3�t	��2��uu���2�us����� V��      �   �   x�U�=�0���>EN�(��H0 u��%u,d��Q��N��#��{h9���+��KLC��I���Β��t/����h��gN��\�|�u���w�=ka�תH���,+?�����LK����t���f	�!G� ��X ��":L      �   l   x�%�QD!��ØWѻ��ϱ��1&Fu�m8/���K���Jf��K���x�pc'�k"�@��m�'�����M�o��P���^���U���]���f�P/46���      �      x�e�[��:����H��2�_��:K��2.�2���R��s�g�<~>��?��ň��r~9���ը��o������c���g���7�=���/��9���7������������;���(���wL[È������v�ϰ�C�9|~�uNT�������0<���5�>_�ׇ�{����D����È9b~�.lQ���︁?���9"?��1��>��#�Z�AT� ��#�wܴ�D�>��U�H�J�e�F�w�\#��{$]�<#a<#����a����|���;��Q���𗜨j�Z�qk�"�:�a<��cͱ懱l,�0�����X1��Z9��[5Q-��#��Ǣ�E��3Q�96Qm����M[�clZ��c燱kl�7��؋�Q��W��MT���0�g~�Ʊ����N�CT'�!�S��Y������!���:�y�!�g����}������ć��xh�O}�]�g�g�q�x#*+�3:?��i�Y�ĔN�`lbL']3���I|61��mbR'1�ĨN���Y��i�:��7�V{'��G�hɬg���7G������72���������+���` �瀾b0�9�	�hto=1)<`Τ0�9���L
�3)|`� #�>,H�y��`�`��s8`�g��V)�v�����#�����G{�`	cS<a�
�)�map�%���L
_X��[�L
gX��ְ\|X�~� �ay��I��al�?�b0��E��#�b�����ҿ�]1���٤����F�M��b����(��N�Ť��-&�W��b0�}v�a�c���_�q�/�6s�t� ��4X�6���3�i��1���5��������t�6���ՏIa�L
���`c��c���`;��)�c���` ;��p��SX��)<d��������p�^~��^~��^~�^~8�^~X��L/��`&c;�d�'���eO�JM����ߪ�'���?��=u��'���O>iO~�I{��O�S��|��;���0~͞��?9ߕ�� -��OΎr���Q?9;��'gG9���(���h�~r;|X�-����Ӟzߪ8���7+��޷+N{�}�ⴧ޷,N��}���޷-N��}�"w.}���.?9;��'gG9���(���bR���Q?9��8���� Z~��<s�4��~�=u�ɓ���'O�S��<i�=�&����'OZ~��<i�~��w���Q?9;��'gG9���(�����߭�O^��^}�J������O��<?y� iў:�����'_��?���w��-��O�h�~�E��o��~rv��OΎr���Q?9;��'ߴ�?���w��7-��O�� �����'�;#�� `3H�a�nZ~�����;�䇖��'?��?9�'9���(����𓳣~rv��~h���^~��^~��^~���S���S���S���S���S��^~��^�������G,��?Ť��)�Q?;*�`G�쨀���SLZ���b>�3b���F{֏�hO~
�=�)��Y�Oa��?����F��S�s��������O��`G���~tŤ�S��~
vT�O��~
_|X�:-�O�9@괧�؂�4�[ОF?d��x���G?hZ��GmA���-h���-�7vT�#7vT�O��
�)�Q?;*�HZ��~$H��S�󷀟"iO~
~�S�a�&�i�OQ��?E���E��S�󸀟�h����%-�O��
�)�Q?;*�`G�쨀�b�����?�X��?Ţ=�)�i�~�J{�S�� ]�9@�h�~�M��SlZ���b�����.�`G�쨀���3)�쨀�b�����?�8��?��=�����OqxO�8���S�S�)-�~�}���~���~���~
vT�O��
�)�Q?;*�`G�/?�/�ӏ�i�s�w~�?�=M�)'�i�O9iO~�I{��SNZ���r��'����?᧜������?�dG���&�����S��~JvT�Oi��	?�->,H��?᧴� ��=	?�Ӟ&��N{��/2hO~J��O�)��?�tZ����i�~J��O�)�Q	?%;*�dG%��쨄����/]h�~ʠ�O�)��?��ӄ�26s�4s�4hO�_%�i������~9���ٯ���?�D��ٯ���?�%;*�5��'�E��WE쨄����S-�OY��	?e��'��E{��/�hO~ʢ=M�)k3H�0H��?�\��	?��O�)-�O�h�~JvT�OɎ��/ޘ~JvT�OɎJ�)-�O�i�~�M˟�Sn�ӄ�rӞ&����4�ܴ�	?�=��/	i�~�}���?�<��	?��O�)�Q	?%;*�dG%��쨄����SZ�<�B��h�Oyx��|xO�|xO�|xO�|xO�|xO�|x��|x��|x��|x��~�J�_�_�i����?J_PS
���L�jJgPSJ���Ԕڠ�ܠ�ޠ�࠮⠮䠮栮蠮꠮젮�������������������� ����������
���������������������� ��"��$��&��(��*���.��2���	W�p�	w�p�	W�PW�PW�PW�PW�PW�PW�PW�PW�PW�PW�PW�PW�PW�PW�P�+4�
�'��/��$Yhm����J��\�BI� ~N��ۅ�>�x��z��|��~�����`h>N��j�#�7���y$ch��ߒ�������a⃫cX�1>�������Jǰ�w]�H��`�1t��H�c �to�#�E;p��Ҏ'�Csp����14�tM���c �t�C�K�1 L;�����I�ch0�������14�v�Ў�"C��v �;�uw����1,�@*Csh� R�p��1��1�	�t@׎���ch��cXwǰ�ai�Щ��1,��T:�搎�I�ai� 0�L;�I���1�a�c ��1,�L:��;�uw����1��cXwǰ�a�ú;�uw����1��cXwǰ�aI�Ф�14��1,��ܐ;�ӎ���c �t}	�chR�L:�ӎ�"C�i��%$wM�H�c�R;���1x���1t3)CW��1t
yw���vH���@:��Ö���L� &��Jǀsюwǰ�c蓓��后��1�C;�J��`�14�v ӎ�KV�L:������1l�p��c �t͡8�c���Ö����cht��T:���厡9�chR���H�c賕���Хcht��;��;�}w���t}=�ch��c��1����t/w���c ��1l�pX�]:�&�����cx��c�wǰ�aK����14�t&C�I���"C�I����1��t ���I�ch0����1tI�C��Ö��I�ch0��;�ӎ�P;�j� 0� &C��v �����chR��T;��w�c�\^;���1tA/C7��1tw���t]�K�Э�t&C���1�T:��;�#C��v�����6��1��c8�14�v�Ў��14�t���ch0� �Csp�Ф�14�t}��chR���8�c�s����ʅt ӎ��14�t��4�ch��T;pH�Ф�1�l��H���w�p�cx��c �t���ch��c8�1�C:���*�1����t/w���ch0��C:�>�v@׎��1 L;���w/�t �����c��v Վ`�14�t}.�14�t���chR��T;�j� 0�pX���I� R��C;�J��`�1�`�1 L:����14�v ӎ`�1��h� 0�];��ڔt ����¤C���G;���c8�@:���1����cx+���18>��`�1���c �tvw�t}.�14�v��2���cx9��ᑎ�9�chR� &�� <  6�L;�I��`�1��14�t�W�c�,C�j� ��C;��v8�L:�F׎��1�T;pH�Ф�14�v ����V:�����14��1<�1�`�1�
�ch0�L;�I���C:��Ў��14�tM�C�q��`�14�v ӎw��h� t�@�C�R:�I���q��`�1 L:������I�ch0� ��E;�I����1��C�c�o�r�Ф�14�v8�tM�H�ch�@���ch0��/�JǀK�H�ch0�L;��v ӎ��14�tM�C}UC������~��HP@1     