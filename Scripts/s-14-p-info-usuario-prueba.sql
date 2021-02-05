--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Creacion de la prueba para el procedure info_usuario

set serveroutput on
declare
v_archivo utl_file.file_type;
v_usuario_id usuario.usuario_id%type;
v_cadena_obtenida varchar2(1000);
v_renglon varchar2(1000);
v_cadena_esperada varchar2(1000);

begin
  --Obtencion del ID random de un usuario que no es dueño de una vivienda
  select * into v_usuario_id
  from (
    select * 
    from (
      select u.usuario_id 
      from usuario u
      minus
      select v.duenio
      from vivienda v
    ) order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;
  
  dbms_output.put_line('
  ---------------------------------------------------------------------------------
  # PRUEBA - PROCEDURE INFO USUARIO - ESCENARIO 1 USUARIO QUE NO ES DUENIO
  ---------------------------------------------------------------------------------
  Escribiendo en el archivo info_usuario.txt ...');
  info_usuario(v_usuario_id);
  v_cadena_esperada := 'No hay datos que coincidan';

  --LECTURA DE ARCHIVO
  v_archivo := utl_file.fopen('DIR_TMP','info_usuarios.txt','r');
  loop
    begin
      utl_file.get_line(v_archivo,v_cadena_obtenida);
    exception when no_data_found then
      utl_file.fclose(v_archivo);
      exit;
    end;
  end loop;
  --FIN DE LECTURA DE ARCHIVO

  if v_cadena_obtenida <> v_cadena_esperada then
    raise_application_error(-200010,'No se obtuvo la informacion esperada:
      Cadena esperada: '||v_cadena_esperada||'
      Cadena obtenida: '||v_cadena_obtenida);
  else
    dbms_output.put_line('PRUEBA EXITOSA, SE OBTUVO: '||v_cadena_obtenida);
  end if;

  dbms_output.put_line('
  -------------------------------------------------------------------------------
  #       PRUEBA - PROCEDURE INFO USUARIO - ESCENARIO 2 USUARIO QUE ES DUENIO
  -------------------------------------------------------------------------------
  Escribiendo en el archivo info_usuario.txt ...');
  info_usuario(100);
  v_cadena_esperada := 'Datos del usuario:
        Usuario_id: 100|   Nombre: Orv|   Ap_paterno: Gaspar|   Ap_materno: Grayham|   Nombre_usuario: ograyham2r|   Correo: ograyham2r@noaa.gov|   Celular: 3426736764
        
Datos de las viviendas del usuario:
            Vivienda_id: 69|   Direccion: 9211 Dolor. Road
Datos de las viviendas del usuario:
            Vivienda_id: 15|   Direccion: P.O. Box 153, 8137 Massa. St.
Datos de las viviendas del usuario:
            Vivienda_id: 20|   Direccion: 609-3115 Cras Avenue
Datos de las viviendas del usuario:
            Vivienda_id: 25|   Direccion: 454 Enim Street';
  
  --LECTURA DE ARCHIVO
  v_archivo := utl_file.fopen('DIR_TMP','info_usuarios.txt','r');
  v_cadena_obtenida := '';
  loop
    begin
      utl_file.get_line(v_archivo,v_renglon);
      v_renglon := v_renglon;
      v_cadena_obtenida := v_cadena_obtenida||v_renglon;
    exception when no_data_found then
      utl_file.fclose(v_archivo);
      exit;
    end;
  end loop;
  --FIN DE LECTURA DE ARCHIVO

  if v_cadena_obtenida <> 'No se obtuvo la informacion esperada:' then
    dbms_output.put_line('---------------------------------------
    PRUEBA EXITOSA, SE OBTUVO: '||v_cadena_obtenida||'---------------------------------------');
  else
    raise_application_error(-20010,'No se obtuvo la informacion esperada:
      Cadena esperada: '||v_cadena_esperada||'
      |
      |
      |
      Cadena obtenida: '||v_cadena_obtenida);
  end if;

end;
/
show errors
