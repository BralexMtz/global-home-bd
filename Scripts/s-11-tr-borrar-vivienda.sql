--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de trigger para borrar una a más viviendas

create or replace trigger tr_notifica
for delete on vivienda
compound trigger

type vi_actualizado_type is record(
  vi_estado_id vivienda.estado_id%type,
  vi_vivienda_id vivienda.vivienda_id%type
);

type viv_list_type is table of vi_actualizado_type;

vivienda_list viv_list_type := viv_list_type();

before each row is
  v_index number;
begin
  vivienda_list.extend;
  v_index := vivienda_list.last;

  vivienda_list(v_index).vi_estado_id := :new.estado_id;
  vivienda_list(v_index).vi_vivienda_id :=:new.vivienda_id;
  
end before each row;
after statement is
  cursor cur_datos_usuarios_notificacion is
    select u.nombre_usuario, u.usuario_id 
    from usuario u
    join notificacion n
    on u.usuario_id=n.usuario_id
    where n.vivienda_id=.vivienda_id;
  
  v_is_vacaciones number(1,0);


begin
  -- 
  forall i in vivienda_list.first .. vivienda_list.last
    select v.is_vacaciones into v_is_vacaciones
    from vivienda v
    where v.vivienda_id = i.vi_vivienda_id;

    if i.vi_estado_id = 1 and  v_is_vacaciones = 1
      then
      for u in cur_datos_usuarios_notificacion loop

          update notificacion 
          set enviado=1, texto=get_texto_notificacion(u.nombre_usuario,i.vi_vivienda_id)
          where usuario_id=u.usuario_id 
          and vivienda_id=i.vi_vivienda_id;
      
      end loop;

    end if;
  end after statement;
end;
/
show errors