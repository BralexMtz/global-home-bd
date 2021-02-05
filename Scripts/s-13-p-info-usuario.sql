--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Creacion de un procedure que escriba la informacion de un usuario

prompt conectando como sys
connect sys as sysdba

create or replace directory dir_tmp as '/home/jesus/Documents/ProyectoBD/global-home-bd';
grant read, write on directory dir_tmp to PM_PROY_ADMIN;

prompt conectando como PM_PROY_ADMIN
connect PM_PROY_ADMIN

create or replace procedure info_usuario(
    p_usuario_id in number
) is 

v_archivo utl_file.file_type;
cursor cur_datos_usuario is
  select u.*
  from usuario u 
  where u.usuario_id = p_usuario_id;

cursor cur_datos_vivienda is
  select v.*
  from vivienda v
  where v.duenio = p_usuario_id;

begin
  v_archivo := utl_file.fopen('DIR_TMP','info_usuarios.txt','w');
  for i in cur_datos_usuario loop
    if i.usuario_id is not null then
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
      utl_file.put_line(v_archivo,'No hay datos que coincidan');
    end if;
  end loop;
  utl_file.fclose(v_archivo);
end;
/
show errors