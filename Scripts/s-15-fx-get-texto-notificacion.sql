--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de la funcion que da el mensaje de notificacion

create or replace function get_texto_notificacion(
  p_usuario_id number, p_vivienda_id number
) return varchar2 is

v_nombre_usuario usuario.nombre_usuario%type;
v_direccion vivienda.direccion%type;
v_mensaje varchar2(500);
begin 

  select nombre_usuario into v_nombre_usuario
  from usuario u
  where u.usuario_id=p_usuario_id;

  select v.direccion into v_direccion
  from vivienda v
  where v.vivienda_id=p_vivienda_id;
  
  v_mensaje := 'Hoy es tu dia de suerte '||v_nombre_usuario||
    ', ya que la vivienda con ID: '||p_vivienda_id||' ubicada en '||v_direccion||' esta DISPONIBLE por ahora.';

  return v_mensaje;
end;
/
show errors