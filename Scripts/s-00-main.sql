--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Main del hilo del programa

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

--promp creando vistas
--@s-08-vistas.sql

prompt creando funciones
@s-15-get-texto-notificacion.sql

prompt creando triggers
@s-11-tr-actualiza-estado-historico.sql
@s-11-tr-validar-tarjeta.sql
@s-11-tr-actualiza-estado-alquiler.sql
@s-11-tr-actualiza-estado-renta.sql

prompt insertando dummy data xd
@s-09-carga-inicial.sql
