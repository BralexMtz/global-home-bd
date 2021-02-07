--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Creacion de un procedure que inserte una vivienda de acuerdo a su subtipo

create or replace procedure insertar_vivienda(
  vivienda_id in number, latitud in varchar2, longitud in varchar2,
  direccion in varchar2, capacidad_personas in number, 
  descripcion in varchar2, fecha_estado in date, is_renta in number,
  is_vacaciones in number, is_venta in number, duenio in number,
  estado_id in number, costo_mensual in number, dia_pago in number,
  costo_dia in number, dias_max in number, importe in number,
  folio_vacas in varchar2, pdf_validacion blob, num_mensualidades in number,
  num_catastral in varchar2, folio_venta in varchar2, pdf_avaluo blob,
  precio_inicial in number, comision in number, 
  clabe_interbancaria in number, usuario_id in number
) is

begin
  insert into vivienda values(vivienda_id, latitud, longitud, direccion, capacidad_personas,descripcion, fecha_estado, is_renta, is_vacaciones, is_venta, duenio, estado_id);

  if is_renta = 1 then
    insert into vivienda_renta values(vivienda_id, costo_mensual, dia_pago);
  end if;

  if is_vacaciones = 1 then
    insert into vivienda_vacacional values(vivienda_id, costo_dia, dias_max, importe, folio_vacas,pdf_validacion);
  end if;

  if is_venta = 1 then
    insert into vivienda_venta values(vivienda_id, num_mensualidades, num_catastral, folio_venta, pdf_avaluo, precio_inicial, comision, clabe_interbancaria, usuario_id);
  end if;
end;
/
show errors