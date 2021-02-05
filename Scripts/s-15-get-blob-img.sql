--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 05/02/2021
--@Descripción: Funcion para obtener objeto blob 


prompt conectando como SYS
connect sys as sysdba
prompt creando objeto

create or replace directory fotos_dir as '/tmp/bases/fotos';

prompt otorgando permisos de lectura al usuario

grant read on directory fotos_dir to pm_proy_admin;

prompt connectando con pm_proy_admin

connect pm_proy_admin/ jorge


------------------------------------------------------
set serveroutput on
create or replace function get_blob_img (
  p_nombre_imagen varchar2
) return blob is

  --Referencia/puntero al archivop
  v_bfile bfile;
  v_foto blob;

  --Se requieren porque le procedimiento necesita la salida
  v_src_offset number;
  v_dest_offset number;
  v_src_length number;
  v_blob_length number;

begin 

  v_bfile :=bfilename('FOTOS_DIR',p_nombre_imagen);

  if dbms_lob.fileexists(v_bfile) = 0 then 
    raise_application_error(-20001, 'El archivo '||p_nombre_imagen
      ||' no existe en el objeto fotos_dir');
  end if;

  if dbms_lob.fileisopen(v_bfile) = 1 then
    raise_application_error(-20002, 'El archivo esta abierto, debe estar cerrado');
  end if;


-- se usa for update para evitar que otros usuarios intenten escribir o leer en la 
-- columna foto

  v_foto:=empty_blob();

  dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
  v_src_offset :=1;
  v_dest_offset := 1;
  v_src_length := dbms_lob.getlength(v_bfile);

  --Se lee el contenido completo del archivo ya que su tamañao es pequeño
  --para archivos grandes la caraga debe ser por partes para evitar
  --matar a la RAM

  dbms_lob.loadblobfromfile(
      dest_lob   => v_foto, 
      src_bfile  => v_bfile,
      amount     => v_src_length,
      src_offset => v_src_offset,
      dest_offset=> v_dest_offset
  );
  --cerrando el archivo
  dbms_lob.close(v_bfile);

  --Verificando la cantidad de bytes escritos en el objeto blob
  v_blob_length := dbms_lob.getlength(v_foto);

  if v_src_length = v_blob_length then
    --todo bien
    dbms_output.put_line('Carga exitosa, para la foto: '||p_nombre_imagen);
    return v_foto;
  else
    --ERROR!
    raise_application_error(-20003, 
      'Longitud cargada en la columna foto inválida');
  end if;

end;
/
show errors

prompt creando el directorio /tmp/bases/fotos en caso de no existir
!mkdir -p /tmp/bases/fotos

prompt copiando todas las fotos a /tmp/bases/fotos
!cp ../fotos/* /tmp/bases/fotos

prompt cambiando permisos
!chmod 777 /tmp/bases/fotos

--
