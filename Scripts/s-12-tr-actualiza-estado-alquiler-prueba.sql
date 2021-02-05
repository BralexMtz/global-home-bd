--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Prueba de la validación de un estado alquiler

set serveroutput on
declare 
  v_vivienda_id alquiler.vivienda_id%type;
  v_usuario_id alquiler.usuario_id%type;
  v_num_dias_max number(10,0);
  v_estado_id_despues vivienda.estado_id%type;
begin
  -- random index vivienda disponible
  select * into v_vivienda_id,v_num_dias_max
  from (
    select vv.vivienda_id, vv.dias_max
    from vivienda_vacacional vv
    join vivienda v
    on vv.vivienda_id=v.vivienda_id
    where v.estado_id=1
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;
  -- random index usuario
  select * into v_usuario_id
  from (
    select u.usuario_id 
    from usuario u
    join TARJETA_CREDITO tc
    on tc.usuario_id=u.usuario_id
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;

  dbms_output.put_line('
  ---------------------------------------------------------------------------------
  #       PRUEBA - TRIGGER ACTUALIZA ESTADO ALQUILER - ESCENARIO 1
  ---------------------------------------------------------------------------------
  Insertando ...

  Vivienda_id: '||v_vivienda_id||'
  Usuario_id: '||v_usuario_id||'
  ');


  INSERT INTO Alquiler (alquiler_id,folio,periodo_ocupacion_inicio,
    periodo_ocupacion_fin,vivienda_id,usuario_id) 
  VALUES (alquiler_seq.nextval,'OSA982L1',to_date('09/09/2020','dd/mm/yyyy'),
    to_date('09/09/2020','dd/mm/yyyy')+v_num_dias_max-2,v_vivienda_id,v_usuario_id);

  select v.estado_id into v_estado_id_despues
  from vivienda v
  where v.vivienda_id=v_vivienda_id;

  if v_estado_id_despues = 3 
  then 
    dbms_output.put_line('
    
    >>>>>>>>>>     PRUEBA TRIGGER NUEVO ALQUILER EXITOSA OK :)
    ');
  else
    raise_application_error(-20051,'[[[ERROR]]] El estado de la vivienda esperado es: 3, el obtenido es: '||v_estado_id_despues);
  end if;

end;
/
rollback;