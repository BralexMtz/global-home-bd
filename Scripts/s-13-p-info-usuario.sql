--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Creacion de un procedure que escriba la informacion de un usuario

prompt conectando como sys
connect sys as sysdba

create or replace directory dir_tmp as '/tmp/bases/info_usuario';
grant read, write on directory dir_tmp to PM_PROY_ADMIN;

!mkdir -p /tmp/bases/info_usuario
!chmod 777 /tmp/bases/info_usuario
!touch /tmp/bases/info_usuario/info_usuarios.txt

prompt conectando como PM_PROY_ADMIN
connect PM_PROY_ADMIN

create or replace procedure info_usuario(
    p_usuario_id in number
) is 

v_archivo utl_file.file_type;
v_vivienda_id vivienda.vivienda_id%type;
v_direccion vivienda.direccion%type;
v_bandera_existe_usuario number(1,0) default 0;

cursor cur_datos_usuario is
  select u.*
  from usuario u 
  where u.usuario_id = p_usuario_id;

cursor cur_datos_vivienda is
  select v.vivienda_id, v.direccion
  from vivienda v
  where v.duenio = p_usuario_id;

begin
  v_archivo := utl_file.fopen('DIR_TMP','info_usuarios.txt','w');
  for i in cur_datos_usuario loop
    v_bandera_existe_usuario := 1;
    open cur_datos_vivienda;
    fetch cur_datos_vivienda into v_vivienda_id,v_direccion;

    if v_vivienda_id is not null then 
      close cur_datos_vivienda;
      utl_file.put_line(v_archivo,'Datos del usuario: 
        Usuario_id: '||i.usuario_id||'|   Nombre: '||i.Nombre||'|   Ap_paterno: '||i.ap_paterno
        ||'|   Ap_materno: '||i.ap_materno||'|   Nombre_usuario: '||i.nombre_usuario
        ||'|   Correo: '||i.correo||'|   Celular: '||i.celular||'
        ');
        for j in cur_datos_vivienda loop
          utl_file.put_line(v_archivo,'Datos de las viviendas del usuario:
            Vivienda_id: '||j.vivienda_id||'|   Direccion: '||j.direccion);
        end loop;

    else
      close cur_datos_vivienda;
      utl_file.put_line(v_archivo,'No hay datos que coincidan'); 
    end if;
  end loop;

  if v_bandera_existe_usuario = 0 then
    utl_file.put_line(v_archivo,'No hay datos que coincidan');
  end if;
  
  utl_file.fclose(v_archivo);
end;
/
show errors