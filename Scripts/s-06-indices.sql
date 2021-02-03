--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 28/01/2021
--@Descripción: Creación secuencias para el proyecto de bases de datos

prompt creando indice historico_estado_vivienda_iuk
create unique index historico_estado_vivienda_iuk 
  on historico_estado_vivienda(estado_id,vivienda_id);

prompt creando indice vivienda_direccion_iuk
create unique index vivienda_direccion_iuk
  on vivienda(direccion);

prompt creando indice idx_nombre_usuario
create unique index idx_nombre_usuario 
  on usuario(upper(nombre_usuario));


