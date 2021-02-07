--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 28/01/2021
--@Descripción: Creación secuencias para el proyecto de bases de datos

prompt creando indice historico_estado_vivienda_iuk
create unique index historico_estado_vivienda_iuk 
  on historico_estado_vivienda(estado_id,vivienda_id);

prompt creando indice vivienda_direccion_iuk
create unique index vivienda_direccion_iuk
  on vivienda(direccion);

prompt creando indice usuario_nombre_usuario_iuk
create unique index usuario_nombre_usuario_iuk
  on usuario(upper(nombre_usuario));

prompt creando indice mensaje_titulo_ix
create index mensaje_titulo_ix
  on mensaje(upper(titulo));

prompt creando indice usuario_celular_ix
create index usuario_celular_ix
  on usuario(celular);