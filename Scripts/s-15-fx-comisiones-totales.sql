--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Funcion para obtener las comisiones 

create or replace function comisiones return number is

v_comision_total number(11,2) default 0;
cursor cur_viviendas_comision is
  select distinct vv.precio_inicial
  from vivienda_venta vv
  join pago_vivienda pv on vv.vivienda_id = pv.vivienda_id;

begin
  for i in cur_viviendas_comision loop
    v_comision_total := v_comision_total + (i.precio_inicial * 0.122);
  end loop;
  return v_comision_total;
end;
/
show errors