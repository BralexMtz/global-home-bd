--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Creación de las tablas externas
prompt Conectando como SYSTEM
connect sys as sysdba 
--Un objeto tipo directory es un objeto que se crea y almacena en el
-- diccionario de datos y se emplea para mapear directorios
-- reales en el sistema de archivos. En este caso tmp_dir es un
-- objeto que apunta al directorio /media/bralex/Data/Repositorios/global-home-bd del servidor
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';
--se otorgan permisos para que el usuario PM_PROY_ADMIN de la BD pueda leer
--el contenido del directorio
grant read, write on directory tmp_dir to PM_PROY_ADMIN;
prompt Contectando con usuario PM_PROY_ADMIN para crear la tabla externa
connect PM_PROY_ADMIN

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
  location('tabla_externa.csv')
)reject limit unlimited;


prompt creando el directorio /tmp/bases en caso de no existir
!mkdir -p /tmp/bases

prompt copiando el archivo csv a /tmp/bases
!cp ../tabla_externa.csv /tmp/bases
prompt cambiando permisos
!chmod 777 /tmp/bases
