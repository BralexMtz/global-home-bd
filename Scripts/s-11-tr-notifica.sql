--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de trigger para actualizar las notificaciones cuando una vivienda relacionada esté disponible


create or replace trigger actualiza_estado_historico
after update of estado_id on vivienda
for each row

declare

  cursor cur_datos_usuarios_notificacion is
    select u.nombre_usuario, u.usuario_id 
    from usuario u
    join notificacion n
    on u.usuario_id=n.usuario_id
    where n.vivienda_id=:old.vivienda_id;

begin
  -- 
  select v.is_vacaciones into v_is_vacaciones
  from vivienda v
  where v.vivienda_id=:old.vivienda_id;

  if :new.estado_id = 1 and  v_is_vacaciones = 1
    then
    for u in cur_datos_usuarios_notificacion loop

        update notificacion 
        set enviado=1, texto=get_texto_notificacion(u.nombre_usuario,:new.vivienda_id)
        where usuario_id=u.usuario_id 
        and vivienda_id=:old.vivienda_id;
    
    end loop;
  end if;

end;
/