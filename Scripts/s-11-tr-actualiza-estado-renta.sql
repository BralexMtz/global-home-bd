--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de trigger que actualice el estado de la vivienda cuando se haga insert en contrato renta

create or replace trigger actualiza_estado_renta
  after insert on contrato_renta
  for each row
  declare
  v_estado_id vivienda.estado_id%type;

  begin

    select estado_id into v_estado_id
    from vivienda 
    where vivienda_id=:new.vivienda_id;

    if v_estado_id=1 then
      update vivienda set estado_id=2, fecha_estado=:new.fecha where vivienda_id = :new.vivienda_id;
    else
      raise_application_error(-20011,'La vivienda no está disponible, actualmente tiene estado: '||v_estado_id);
    end if;
  end;
  /
  show errors