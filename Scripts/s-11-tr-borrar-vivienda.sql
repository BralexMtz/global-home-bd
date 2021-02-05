--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de trigger para borrar una a más viviendas

create or replace trigger tr_notifica
for delete on mensaje
compound trigger

type mensaje_eliminar_type is record(
  mensaje_id mensaje.mensaje_id%type;
  titulo mensaje.titulo%type;
  cuerpo mensaje.cuerpo%type;
  leido mensaje.cuerpo%type;
  respuesta mensaje.respuesta%type;
  vivienda_id mensaje.vivienda_id%type;
  usuario_id mensaje.usuario_id%type;
);

type mensaje_list_type is table of mensaje_eliminar_type;

mensajes_list precio_list_type := mensaje_list_type();

before each row is
  v_index number;
begin
  mensajes.list.extend;
  v_index := mensajes_list.last;
  mensajes_list(v_index).mensaje_id := :old.mensaje_id;
  mensajes_list(v_index).titulo := :old.titulo;
  mensajes_list(v_index).cuerpo := :old.cuerpo;
  mensajes_list(v_index).leido := :old.leido;
  mensajes_list(v_index).respuesta := :old.respuesta;
  mensajes_list(v_index).vivienda_id := :old.vivienda_id;
  mensajes_list(v_index).usuario_id := :old.usuario_id;
end before each row;
after statement is
begin
  forall i in mensajes_list.first .. mensajes_list.last
    if mensajes_list(i).leido = 0 then
      delete from mensaje where mensaje_id = mensajes_list(i).mensaje_id;
    end if;
end after statement;
end;
/
show errors