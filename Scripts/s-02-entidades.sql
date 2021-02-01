--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Creación de entidades para proyecto de bases de datos


--Creacion de la tabla servicio
create table servicio(
    servicio_id number(10,0) constraint servicio_id_pk primary key,
     nombre varchar2(40) not null,
     descripcion varchar2(50) not null,
     icono blob not null
);

--Creacion de la tabla estado
create table estado(
    estado_id number(10,0) constraint estado_id_pk primary key,
    clave varchar2(40) not null,
    descripcion varchar2(200) not null
);

-- Creacion de la Tabla usuario
create table usuario(
  usuario_id number(10,0) constraint usuario_id_pk primary key ,
  correo varchar2(40,0) not null,
  nombre_usuario varchar2(10) not null,
  nombre varchar2(40,0) not null,
  ap_paterno varchar2(40,0) not null,
  ap_materno varchar2(40,0) null,
  contrasenia varchar2(10) not null,
  celular number(10,0) not null
);


-- Creacion tabla tarjeta 
create table tarjeta_credito(
  tarjeta_credito_id number(10,0) constraint tarjeta_credito_id_pk primary key,
  num_tarjeta number(16,0) not null,
  mes_exp number(2,0) not null,
  anio_exp number(4,0) not null,
  num_seguridad number(4,0) not null,
  usuario_id constraint tarjeta_credito_usuario_id_fk references usuario(usuario_id)
);


--Creacion de la tabla vivienda
create table vivienda(
    vivienda_id number(10,0) constraint vivienda_id_pk primary key,
    latitud varchar2(20) not null,
    longitud varchar2(20) not null,
    direccion varchar(50) not null,
    capacidad_personas number(3,0) not null,
    descripcion varchar(2000) not null,
    fecha_estado date not null,
    is_renta number(1,0) not null,
    is_vacaciones number(1,0) not null,
    is_venta number(1,0) not null,
    duenio number(10,0) not null,
    estado_id number(10,0) not null,
    constraint vivienda_duenio_fk foreign key(duenio) 
    references usuario(usuario_id),
    constraint vivienda_estado_id_fk foreign key(estado_id) 
    references estado(estado_id)
);

--Creacion de a tabla imagen
create table imagen(
    imagen_numero number(2,0) not null,
    vivienda_id number(10,0) not null,
    archivo blob not null,
    constraint imagen_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint imagen_id_compuesta_pk primary key (imagen_numero,vivienda_id)
);

--Creacion de la tabla vivienda servicio
create table vivienda_servicio(
  servicio_id constraint vivienda_servicio_servicio_id_fk references servicio(servicio_id),
  vivienda_id constraint vivienda_servicio_vivienda_id_fk references vivienda(vivienda_id),
  constraint vivienda_servicio_pk primary key (servicio_id,vivienda_id)
);

--Creacion de la tabla historico_estado_vivienda
create table historico_estado_vivienda(
  historico_estado_vivienda_id number(10,0) 
    constraint historico_estado_vivienda_id_pk primary key,
  estado_id 
    constraint historico_estado_vivienda_estado_id_fk references estado(estado_id),
  vivienda_id 
    constraint historico_estado_vivienda_vivienda_id_fk references vivienda(vivienda_id),
  fecha_estado date not null,
  constraint historico_estado_vivienda_estado_id_vivienda_id_uk unique (estado_id,vivienda_id)
);

-- creacion de tabla mensaje
create table mensaje(
  mensaje_id number(10,0) constraint mensaje_id_pk primary key,
  respuesta constraint mensaje_respuesta_fk references mensaje(mensaje_id),
  titulo varchar2(40) not null,
  cuerpo varchar2(500) not null,
  leido number(1,0) not null,
  vivienda_id constraint mensaje_vivienda_id_fk references vivienda(vivienda_id),
  usuario_id constraint mensaje_usuario_id references usuario(usuario)
  
);

-- creacion de la tabla vivienda renta

create table vivienda_renta(
  vivienda_id constraint vivienda_renta_vivienda_id_fk references vivienda(vivienda_id),
  costo_mensual number(40,0) not null,
  dia_pago number(2,0) not null,
  constraint vivienda_renta_pk primary key (vivienda_id)
);
-- creacion de vivienda vacacional
create table vivienda_vacacional(
  vivienda_id constraint vivienda_vacacional_vivienda_id_fk references vivienda(vivienda_id),
  costo_dia number(6,0) not null,
  dias_max number(2,0) not null,
  importe number(6,2) not null,
  folio varchar2(18,0) not null,
  pdf_validacion blob not null,
  constraint vivienda_vacacional_pk primary key (vivienda_id)
);


--Creacion de la tabla vivienda venta
create table vivienda_venta(
    vivienda_id number(10,0) not null,
    num_catastral varchar2(40) not null,
    folio varchar2(18) not null,
    pdf_avaluo blob not null,
    precio_inicial number(10,2) not null,
    comision number(9,2) not null,
    clabe_interbancaria number(18,0) not null,
    usuario_id number(10,0) not null,
    constraint vivienda_venta_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vivienda_venta_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint vivienda_venta_vivienda_id_pk primary key(vivienda_id)
);

--Creacion de la tabla pago
create table pago(
    pago_id number(10,0) constraint pago_id_pk primary key,
    fecha_pago date not null,
    importe_pago number(9,2),
    pdf_evidencia blob not null,
    vivienda_id number(10,0) not null,
    constraint pago_vivienda_id_fk foreign key(vivienda_id)
    references vivienda_venta(vivienda_id)
);

--Creacion de la tabla clabe
create table clabe(
  clabe_id number(40,0) constraint clabe_pk primary key,
  clabe number(18,0) not null,
  vivienda_id constraint clabe_vivienda_id_fk references vivienda_renta(vivienda_id)
);

--Creacion de la tabla contrato renta
create table contrato_renta(
    contrato_renta_id number(10,0) constraint contrato_renta_id_pk primary key,
    folio varchar2(8) not null,
    fecha date not null,
    pdf blob not null,
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint contrato_renta_usuario_id_fk foreign key(usuario_id)
      references usuario(usuario_id),
    constraint contrato_renta_vivienda_id_fk foreign key(vivienda_id)
      references vivienda_renta(vivienda_id)
);

--Creacion de la tabla calificacion
create table calificacion(
  calificacion_id number(10,0) constraint calificacion_pk primary key,
  num_estrellas number(1,0) not null,
  fecha date not null,
  descripcion varchar(200,0) not null,
  vivienda_id 
    constraint calificacion_vivienda_id references vivienda_vacacional(vivienda_id),
  usuario_id 
    constraint calificacion_usuario_id references usuario(usuario_id),
  constraint calificacion_vivienda_id_usuario_id_uk unique(vivienda_id,usuario_id)    
);

--Creacion de la tbla notificacion
create table notificacion(
    notificacion_id number(10,0) constraint notificacion_id_pk primary key,
    enviado number(1,0) not null,
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint notificacion_usuario_id_fk foreign key(usuario_id)
      references usuario(usuari_id),
    constraint notificacion_vivivienda_id_fk foreign key(vivienda_id)
      references vivienda_vacacional(vivienda_id)
);

-- creacion de tabla alquiler
create table alquiler(
  alquiler_id number(10,0) constraint alquiler_pk primary key,
  folio varchar2(8,0) not null,
  periodo_ocupacion_inicio date not null,
  periodo_ocupacion_fin date not null,
  vivienda_id 
    constraint alquiler_viviendo_id_fk references vivienda_vacacional(vivienda_id),
  usuario_id 
    constraint alquiler_usuario_id_fk references usuario(usuario_id)
);

