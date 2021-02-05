--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Validador para probar la inserción de un objeto

set serveroutput on
declare 
  v_vivienda_id imagen.vivienda_id%type;
  v_num_img imagen.imagen_numero%type;
  v_estado_id_despues vivienda.estado_id%type;
  v_longitud_foto number(9,0);
begin
  -- random index vivienda disponible
  select * into v_vivienda_id
  from (
    select v.vivienda_id
    from vivienda v
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;
  -- random index usuario
  select count(*) into v_num_img
  from imagen i
  where i.vivienda_id=v_vivienda_id;

  v_num_img := v_num_img+1;

  dbms_output.put_line('
  -------------------------------------------------------------------------------
  #       PRUEBA - FUNCION GENERA BLOB - ESCENARIO 1
  -------------------------------------------------------------------------------
  Insertando ...

  Vivienda_id: '||v_vivienda_id||'
  imagen_numero: '||v_num_img||'
  ');
  insert into imagen(imagen_numero,vivienda_id,archivo) values(v_num_img,v_vivienda_id,get_blob_img('img-0.jpg'));
    
  select dbms_lob.getlength(i.archivo) into v_longitud_foto 
  from imagen i
  where i.vivienda_id = v_vivienda_id
  and i.imagen_numero = v_num_img;

  if v_longitud_foto <> 0 then

      dbms_output.put_line('
      >>>>>>>>>>     PRUEBA FUNCION GENERA BLOB EXITOSA OK :)
      ');
  end if;
end;
/
rollback;



