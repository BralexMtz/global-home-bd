--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Creación de las tablas externas

prompt creando directorio archivo_externo
create or replace directory tmp_dir as '/media/bralex/Data/Repositorios/global-home-bd';

create table usuarios_vetados(
  usuario_id number(10,0),
  correo varchar2(40),
  nombre_usuario varchar2(10),
  nombre varchar2(40),
  ap_paterno varchar2(40),
  ap_materno varchar2(40),
  contrasenia varchar2(10),
  celular number(10,0)
)organization external(
  type oracle_loader
  default directory tmp_dir
  access parameters(
      records delimited by newline
      badfile tmp_dir:'usuarios_vetados_ext_bad.log'
      logfile tmp_dir:'usuarios_vetados_ext.log'
      fields terminated by ','
      lrtrim
      missing field values are null
      (
        usuario_id, correo, nombre_usuario, nombre,
        ap_paterno, ap_materno, contrasenia, celular
      )
  )
  location ('tabla_externa.csv')
)reject limit unlimited;
