--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de la funcion que da el mensaje de notificacion

declare
v_nombre_usuario usuario.nombre_usuario%type;
v_direccion vivienda.direccion%type;
v_mensaje varchar2(300);
v_usuario_id usuario.usuario_id%type;
v_vivienda_id vivienda.vivienda_id%type;

begin 

  -- Vivienda vacacional
  select * into v_vivienda_id
  from (
    select vv.vivienda_id
    from vivienda_vacacional vv
    join vivienda v
    on vv.vivienda_id=v.vivienda_id
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;
  -- Random index usuario
  select * into v_usuario_id
  from (
    select u.usuario_id 
    from usuario u
    order by DBMS_RANDOM.RANDOM
  ) where rownum = 1;

  select nombre_usuario into v_nombre_usuario
  from usuario u
  where u.usuario_id=v_usuario_id;

  select v.direccion into v_direccion
  from vivienda v
  where v.vivienda_id=v_vivienda_id;

   dbms_output.put_line('
  -------------------------------------------------------------------------------
  #       PRUEBA - FUNCION GENERA TEXTO NOTIFICACION - ESCENARIO 1
  -------------------------------------------------------------------------------
  Obteniendo...

  VIVIENDA_ID: '||v_vivienda_id||'
  USUARIO_ID: '||v_usuario_id||'
  ');

  select get_texto_notificacion(v_usuario_id,v_vivienda_id) into v_mensaje
  from dual;

  if v_mensaje like '%'||v_nombre_usuario||'%'
    and v_mensaje like '%'||v_direccion||'%'
    then
     dbms_output.put_line('
      >>>>>>>>>>     PRUEBA FUNCION GENERA BLOB EXITOSA OK :)
      ');
  end if;

end;
/
show errors