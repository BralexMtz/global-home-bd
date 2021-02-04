--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de trigger para validar que un usuario tenga tarjeta de credito

create or replace trigger trg_tarjeta_credito
before insert on alquiler
  declare 
  v_tarjeta_credito_id tarjeta_credito.tarjeta_credito_id%type;

  begin
    select t.tarjeta_credito_id into v_tarjeta_credito_id
    from tarjeta_credito t 
    right join usuario u on u.usuario_id = t.usuario_id
    where u.usuario_id = :new.usuario_id;

    if v_tarjeta_credito_id is null then
      raise_application_error(-20001,'El cliente con ID '|| :new.usuario_id 
        ||' no tiene una tarjeta de credito registrada');
    end if;
  end;
  /
  show errors