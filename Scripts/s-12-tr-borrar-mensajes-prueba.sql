--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de la prueba del trigger borrar mensajes
set serveroutput on
declare
v_mensajes_no_leidos number(5,0);
begin 
  dbms_output.put_line('
  -------------------------------------------------------------------------------
  # PRUEBA - TRIGGER ELIMINAR MENSAJES - ELIMINAR MENSAJES QUE NO HAYAN SIDO LEIDOS
  -------------------------------------------------------------------------------');
  
  select count(*) into v_mensajes_no_leidos
  from mensaje 
  where leido = 0;

  dbms_output.put_line('Numero de mensajes no leidos registrados: '||v_mensajes_no_leidos);
  delete from mensaje where leido = 0;

  select count(*) into v_mensajes_no_leidos
  from mensaje 
  where leido = 0;

  if v_mensajes_no_leidos = 0 then
    dbms_output.put_line('
    ');
    dbms_output.put_line('>>>>>>>>>>> PRUEBA EXITOSA!!!!');
    dbms_output.put_line('Numero de mensajes no leidos despues del delete: '||v_mensajes_no_leidos);
  end if;
end;
/
show errors
rollback;
