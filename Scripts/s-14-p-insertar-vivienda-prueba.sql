--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Validación de insertar vivienda

declare

  v_vivienda_id  vivienda.vivienda_id%type;
  v_latitud  vivienda.latitud%type;
  v_longitud vivienda.longitud%type;
  v_direccion  vivienda.direccion%type;
  v_capacidad_personas vivienda.latitud%type;
  v_descripcion  vivienda.descripcion%type;
  v_fecha_estado  vivienda.fecha_estado%type;
  v_is_renta  vivienda.is_renta%type;
  v_is_vacaciones  vivienda.is_vacaciones%type;
  v_is_venta  vivienda.is_venta%type;
  v_duenio  vivienda.duenio%type;
  v_estado_id  vivienda.estado_id%type;
  v_costo_mensual  vivienda.costo_mensual%type;
  v_dia_pago  vivienda.dia_pago%type;
  v_costo_dia  vivienda.costo_dia%type;
  v_dias_max  vivienda.dias_max%type;
  v_importe  vivienda.importe%type;
  v_folio_vacas  vivienda.folio_vacas%type;
  v_pdf_validacion vivienda.pdf_validacion%type;
  v_num_mensualidades  vivienda.num_mensualidades%type;
  v_num_catastral  vivienda.num_catastral%type;
  v_folio_venta  vivienda.folio_venta%type;
  v_pdf_avaluo  vivienda.pdf_avaluo%type;
  v_precio_inicial  vivienda.precio_inicial%type;
  v_comision  vivienda.comision%type;
  v_clabe_interbancaria  vivienda.clabe_interbancaria%type;
  v_usuario_id vivienda.usuario_id%type;

  v_cuenta number(10,0);

begin

  select vivienda_seq.nextval into v_vivienda_id
  from dual;

  v_latitud := 22.0021;
  v_longitud := 42.3221;
  v_direccion := 'villa capitan esquina con niconi valle de méxico';
  v_capacidad_personas := 2;
  v_descripcion := 'casa habitación con todas las comodidades';
  v_fecha_estado := sysdate;
  v_is_renta := 1;
  v_is_vacaciones := 1;
  v_is_venta := 0;
  
  select * into v_duenio
  from (
    select u.usuario_id 
    from usuario u
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;

  v_estado_id := 1;
  v_costo_mensual := 2000;
  v_dia_pago := 3;
  v_costo_dia := 300;
  v_dias_max := 15;
  v_importe := 200;
  v_folio_vacas := 'KM31CLKS'; 
  v_pdf_validacion := empty_blob();
  v_num_mensualidades  := 18;

  v_num_catastral := null;
  v_folio_venta  := null;
  v_pdf_avaluo  := null;
  v_precio_inicial := null;
  v_comision  := null;
  v_clabe_interbancaria := null;
  v_usuario_id := null;

  dbms_output.put_line('
  ---------------------------------------------------------------------------------
  # PRUEBA - PROCEDURE INSERTAR VIVIENDA - ESCENARIO 1 
  ---------------------------------------------------------------------------------
  insertando... ');

  insertar_vivienda(vivienda_id, latitud, longitud,direccion, capacidad_personas, 
    descripcion, fecha_estado, is_renta, is_vacaciones, is_venta, duenio, estado_id, 
  costo_mensual, dia_pago, costo_dia, dias_max, importe, folio_vacas, pdf_validacion,
  num_mensualidades, num_catastral, folio_venta, pdf_avaluo, precio_inicial, comision, clabe_interbancaria, usuario_id);

  select count(*) into v_cuenta
  from vivienda v
  join vivienda_vacacional vv
  on v.vivienda_id=vv.vivienda_id
  join vivienda_renta vr
  on v.vivienda_id= vr.vivienda_id
  where vivienda_id=v_vivienda_id;


  if v_cuenta=1 then
    select count(*) into v_cuenta
    from vivienda v
    join vivienda_venta vv
    on v.vivienda_id=vv.vivienda_id
    where vivienda_id=v_vivienda_id;

    if v_cuenta=0 then
      dbms_output.put_line('>>>>>>>  Exito vivienda insertada')
    end if;
  end if;
  dbms_output.put_line('ERROR vivienda no insertada correctamente')

end;
/
show errors

rollback;