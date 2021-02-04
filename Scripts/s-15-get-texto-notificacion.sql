--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de la funcion que da el mensaje de notificacion

create or replace function get_texto_notificacion(
  p_nombre_usuario varchar2, p_vivienda_id varchar2
) return varchar2 is

v_mensaje varchar2(100);
begin 
  v_mensaje := 'Hoy es tu dia de suerte '||p_nombre_usuario||
    ', ya que la vivienda con ID: '||p_vivienda_id||' esta DISPONIBLE por ahora.';
  return v_mensaje;
end;
/
show errors