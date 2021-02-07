--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Main del hilo del programa

whenever sqlerror exit rollback

prompt creando usuarios
@s-01-usuarios.sql

prompt conectando al usuario PM_PROY_ADMIN
connect PM_PROY_ADMIN

prompt creando tabla externa
@s-04-tablas-externas.sql

prompt creando entidades
@s-02-entidades.sql

prompt creando tablas temporales
@s-03-tablas-temporales.sql

prompt creando secuencias
@s-05-secuencias.sql

prompt creando indices
@s-06-indices.sql

prompt creando sinonimos
@s-07-sinonimos.sql

promp creando vistas
@s-08-vistas.sql

prompt creando funciones
@s-15-fx-get-texto-notificacion.sql
@s-15-fx-get-blob-img.sql
@s-15-fx-comisiones-totales.sql

prompt creando triggers
@s-11-tr-actualiza-estado-historico.sql
@s-11-tr-validar-tarjeta.sql
@s-11-tr-actualiza-estado-alquiler.sql
@s-11-tr-actualiza-estado-renta.sql
@s-11-tr-borrar-mensajes.sql

prompt insertando dummy data xd
@s-09-carga-inicial.sql

prompt Realizando prueba triggers
@s-12-tr-actualiza-estado-alquiler-prueba.sql
@s-12-tr-actualiza-estado-renta-prueba.sql
@s-12-tr-validar-tarjeta-prueba.sql
@s-12-tr-borrar-mensajes-prueba.sql

prompt Creando procedures
@s-13-p-info-usuario.sql
@s-13-p-insertar-vivienda.sql

prompt Ejecutando pruebas de procedures
@s-14-p-info-usuario-prueba.sql
@s-14-p-insertar-vivienda-prueba.sql

prompt pruebas funciones
@s-16-fx-get-blob-img-prueba.sql
@s-16-fx-get-texto-notificacion-prueba.sql
@s-16-fx-comisiones-totales-prueba.sql

commit;
whenever sqlerror continue none
prompt listo!
