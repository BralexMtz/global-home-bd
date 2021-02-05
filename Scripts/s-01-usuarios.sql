--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 28/01/2021
--@Descripción: Creación de usuario para el proyecto de bases de datos

whenever sqlerror exit rollback;

prompt Conectando a SYS
connect sys as sysdba

prompt creando usuario

declare 
  v_cuenta  number;
begin  
  ---------------------------------------------------
  --       USUARIO ADMIN
  ---------------------------------------------------

  select count(*) into v_cuenta
  from all_users 
  where username = 'PM_PROY_ADMIN';
  if v_cuenta = 0 then
    dbms_output.put_line('El usuario no existe');

  else
    dbms_output.put_line('El usuario ya existe, borrando ...');
    execute immediate
    'drop user PM_PROY_ADMIN cascade';

  end if;

  dbms_output.put_line('Creando usuario admin');
  execute immediate
  'create user PM_PROY_ADMIN identified by jorge quota unlimited on users';


  ---------------------------------------------------
  --       ROL ADMIN
  ---------------------------------------------------

  select count(*) into v_cuenta
  from dba_roles 
  where role = 'ROL_ADMIN';
  if v_cuenta = 0 then
    dbms_output.put_line('El rol no existe');
  else
    dbms_output.put_line('El rol ya existe, borrando ...');
    execute immediate
    'drop role ROL_ADMIN';
  end if;

  execute immediate 'create role ROL_ADMIN';

  execute immediate
  'grant create session, create table, create sequence, create procedure, 
    create trigger, create any directory, create synonym, create public synonym,
    create view to ROL_ADMIN';

  execute immediate
  'grant ROL_ADMIN to PM_PROY_ADMIN';

  dbms_output.put_line('Usuario listo');

  ---------------------------------------------------
  --       USUARIO INVITADO
  ---------------------------------------------------
  select count(*) into v_cuenta
    from all_users 
    where username = 'PM_PROY_INVITADO';
  if v_cuenta = 0 then
    dbms_output.put_line('El usuario no existe');

  else
    dbms_output.put_line('El usuario ya existe, borrando ...');
    execute immediate
    'drop user PM_PROY_INVITADO cascade';

  end if;

  dbms_output.put_line('Creando usuario invitado');
  execute immediate
  'create user PM_PROY_INVITADO identified by jorge quota unlimited on users';

  dbms_output.put_line('Usuario listo');
  
  ---------------------------------------------------
  --       ROL INVITADO
  ---------------------------------------------------

  select count(*) into v_cuenta
  from dba_roles 
  where role = 'ROL_INVITADO';
  if v_cuenta = 0 then
    dbms_output.put_line('El rol no existe');
  else
    dbms_output.put_line('El rol ya existe, borrando ...');
    execute immediate
    'drop role ROL_INVITADO';
  end if;

  execute immediate 'create role ROL_INVITADO';

  execute immediate
  'grant create session, create synonym to ROL_INVITADO';

  execute immediate
  'grant ROL_INVITADO to PM_PROY_INVITADO';
end;
/