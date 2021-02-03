--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 2/02/2021
--@Descripción: Creación de sinonimos

prompt creando sinonimos publicos
create or replace public synonym CLIENTE for USUARIO;
create or replace public synonym CASA for VIVIENDA;
create or replace public synonym STATUS for ESTADO;

prompt dando pemisos al invitado de lectura
grant select on usuario to PM_PROY_INVITADO;
grant select on vivienda to PM_PROY_INVITADO;
grant select on estado to PM_PROY_INVITADO;

prompt conectando con el usuario invitado PM_PROY_INVITADO
connect PM_PROY_INVITADO

prompt creando sinonimos privados para el invitado
create or replace synonym usuario for PM_PROY_ADMIN.usuario;
create or replace synonym vivienda for PM_PROY_ADMIN.vivienda;
create or replace synonym estado for PM_PROY_ADMIN.estado;

prompt conectando con el usuario invitado PM_PROY_ADMIN
connect PM_PROY_ADMIN

prompt creando sinonimos de software externo con prefijo
declare

cursor cur_nombre_tablas is
  select table_name
  from user_tables;
  

begin 
  for i in cur_nombre_tablas loop
    execute immediate 
    'create or replace synonym CX_'||i.table_name||' for '||i.table_name;
  end loop;
end;
/
