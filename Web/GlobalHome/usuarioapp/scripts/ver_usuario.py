import cx_Oracle
from . import db_config 
#import db_config
def ver(username):
    diccionario={}
    indice=0
    con = cx_Oracle.connect(db_config.user, db_config.pw, db_config.dsn)
    print("Database version:", con.version)
    cur=con.cursor()
    cur.execute("""select * from usuario where nombre_usuario = :username""",[username] )
    res = cur.fetchall()
    for row in res:
        print(row)
        diccionario['usuario_id']=row[0]
        diccionario['correo']=row[1]
        diccionario['nombre_usuario']=row[2]
        diccionario['nombre']=row[3]
        diccionario['ap_paterno']=row[4]
        diccionario['ap_materno']=row[5]
        diccionario['contrasenia']=row[6]
        diccionario['celular']=row[7]
    cur.close()
    con.close()
    
    return diccionario

