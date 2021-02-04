
create or replace trigger actualiza_estado_historico
after insert or update of estado_id on vivienda
for each row
declare
  v_estado_id number(2,0);
  v_fecha_estado date;
  v_hist_id number(10,0);
  v_vivienda_id number(10,0);
begin
  -- obtiene el consecutivo de la secuencia
  select historico_estado_vivienda_seq.nextval into v_hist_id from dual;
  --asigna valores a las variables con el nuevo estado y fecha
  v_estado_id := :new.estado_id;
  v_fecha_estado := :new.fecha_estado;
  v_vivienda_id := :new.vivienda_id;
  dbms_output.put_line('estado anterior: '|| :old.estado_id);
  dbms_output.put_line('estado nuevo: '|| :new.estado_id);
  dbms_output.put_line('insertando en historico, vivienda_id: '
  || v_vivienda_id ||', status_id: ' || v_estado_id
  ||', fecha: '|| v_fecha_estado||', hist_id: '||v_hist_id);
  -- inserta en el histórico
  insert into historico_estado_vivienda
    (historico_estado_vivienda_id,estado_id,fecha_estado,vivienda_id)
  values(v_hist_id,v_estado_id,v_fecha_estado,v_vivienda_id);
end;