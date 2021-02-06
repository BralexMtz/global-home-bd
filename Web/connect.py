import cx_Oracle
import db_config

con = cx_Oracle.connect(db_config.user, db_config.pw, db_config.dsn)
print("Database version:", con.version)


cur = con.cursor()
cur.execute('select * from usuario where NOMBRE_USUARIO like \'a%\' ');

res = cur.fetchall()
for row in res:
    print(row[2])