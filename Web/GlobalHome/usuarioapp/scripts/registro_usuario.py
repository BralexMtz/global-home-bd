import cx_Oracle
from . import db_config 

def insert(nombre,ap_paterno,ap_materno,correo,username,contrasenia,celular):
  con = cx_Oracle.connect(db_config.user, db_config.pw, db_config.dsn)
  print("Database version:", con.version)
  cur=con.cursor()
  cur.execute("""insert into usuario (usuario_id, correo, nombre_usuario, nombre, ap_paterno, ap_materno, contrasenia, celular)
   values (usuario_seq.nextval, :correo, :username,:nombre,:ap_paterno,:ap_materno,:contrasenia,:celular)""",
   [correo,username,nombre,ap_paterno,ap_materno,contrasenia,celular] )
  
  con.commit()
  cur.close()
  con.close()
