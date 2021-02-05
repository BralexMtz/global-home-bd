--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Prueba de la funcion para obtener las comisiones 

declare
v_comisiones number(11,2);
begin
  dbms_output.put_line('
  --------------------------------------------------------------------------------
  # PRUEBA - FUNCION COMISION - ESCENARIO 1 CON LOS INSERTS ACTUALES
  --------------------------------------------------------------------------------');
  v_comisiones := comisiones();
  dbms_output.put_line(v_comisiones);
end;
/
show errors