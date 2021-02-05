--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Prueba de la actualizacion de estado al rentar una vivienda

set serveroutput on
declare 
  v_vivienda_id alquiler.vivienda_id%type;
  v_usuario_id alquiler.usuario_id%type;
  v_estado_id_despues vivienda.estado_id%type;
begin
  -- random index vivienda disponible
  select * into v_vivienda_id
  from (
    select vr.vivienda_id
    from vivienda_renta vr
    join vivienda v
    on vr.vivienda_id=v.vivienda_id
    where v.estado_id=1
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;
  -- random index usuario
  select * into v_usuario_id
  from (
    select u.usuario_id 
    from usuario u
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;

  dbms_output.put_line('
  ---------------------------------------------------------------------------------
  #       PRUEBA - TRIGGER ACTUALIZA ESTADO RENTA - ESCENARIO 1
  ---------------------------------------------------------------------------------
  Insertando ...

  Vivienda_id: '||v_vivienda_id||'
  Usuario_id: '||v_usuario_id||'
  ');
  INSERT INTO contrato_renta (contrato_renta_id,folio,fecha,pdf,usuario_id,vivienda_id) 
  VALUES (contrato_renta_seq.nextval,'AA2A8383',to_date('06/06/2020','dd/mm/yyyy'),
    empty_blob(),v_usuario_id,v_vivienda_id);



  select v.estado_id into v_estado_id_despues
  from vivienda v
  where v.vivienda_id=v_vivienda_id;

  if v_estado_id_despues = 2 
  then 
    dbms_output.put_line('
    
    >>>>>>>>>>     PRUEBA TRIGGER NUEVO ALQUILER EXITOSA OK :)
    ');
  else
    raise_application_error(-20051,'[[[ERROR]]] El estado de la vivienda esperado es: 2, el obtenido es: '||v_estado_id_despues);
  end if;

end;
/
rollback;