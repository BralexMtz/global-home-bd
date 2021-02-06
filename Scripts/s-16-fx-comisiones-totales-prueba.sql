--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Prueba de la funcion para obtener las comisiones 

declare
v_comisiones number(11,2);
v_resultado_esperado number(11,2) default 4505491.18;
begin
  dbms_output.put_line('
  --------------------------------------------------------------------------------
  # PRUEBA - FUNCION COMISION - ESCENARIO 1 
  --------------------------------------------------------------------------------');
  v_comisiones := comisiones();
  
  if v_comisiones = v_resultado_esperado then
    dbms_output.put_line('PRUEBA EXITOSA
    RESULTADO ESPERADO: '||v_resultado_esperado||'
    RESULTADO OBTENIDO: '||v_comisiones);
  else 
  dbms_output.put_line('PRUEBA FALLIDA =(
    RESULTADO ESPERADO: '||v_resultado_esperado||'
    RESULTADO OBTENIDO: '||v_comisiones);
  end if;
  
end;
/
show errors