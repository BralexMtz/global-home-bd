--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 2/02/2021
--@Descripción: Creación de las tablas temporales


set serveroutput on
create global temporary table vivienda_cercana(
      vivienda_id number(10,0),
      capacidad_personas number(3,0),
      direccion varchar(50),
      descripcion varchar(2000),
      is_renta number(1,0),
      is_vacaciones number(1,0),
      is_venta number(1,0)
) on commit preserve rows;

create or replace procedure creacion_tabla_vivienda_cercana(
  p_longitud in varchar2, p_latitud in varchar2
) is

--Declaracion de variables
v_vivienda_id vivienda.vivienda_id%type;
v_capacidad_personas vivienda.capacidad_personas%type;
v_direccion vivienda.direccion%type;
v_ir_renta vivienda.is_renta%type;
v_is_vacaciones vivienda.is_vacaciones%type;
v_is_venta vivienda.is_venta%type;

cursor cur_viviendas is
  select v.vivienda_id, v.capacidad_personas, v.direccion, v.is_renta,
    v.is_vacaciones, v.is_venta, v.descripcion
  from vivienda v 
  where (v.latitud between (p_latitud - 1) and (p_latitud + 1)) and
    (v.longitud between (p_longitud - 1) and (p_longitud + 1)) and 
    v.estado_id = 1;

begin    
  for i in cur_viviendas loop
    insert into vivienda_cercana values(i.vivienda_id,i.capacidad_personas,i.direccion,
      i.descripcion,i.is_renta,i.is_vacaciones,i.is_venta);
  end loop;
end;
/
show errors


declare
  cursor cur_tabla_viviendas_cercanas is
    select * from vivienda_cercana;
  
begin

  creacion_tabla_vivienda_cercana(40.02202012121,0.00021218931);
  dbms_output.put_line(
      'vivienda_id'||','||
      'capacidad_personas'||','||
      'direccion'||','||
      'descripcion'||','||
      'is_renta'||','||
      'is_vacaciones'||','||
      'is_venta'
    );
  for v in cur_tabla_viviendas_cercanas loop
    dbms_output.put_line(
      v.vivienda_id||','||
      v.capacidad_personas||','||
      v.direccion||','||
      v.descripcion||','||
      v.is_renta||','||
      v.is_vacaciones||','||
      v.is_venta
    );
  end loop;

end;
/
