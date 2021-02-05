--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Creación de vistas para el proyecto de BD

prompt Creando primer vista
create or replace view ventas_vacacionales_usuario(
  usuario_id, nombre, apellido_paterno, apellido_materno, ventas_vacacionales
) as select u.usuario_id, u.nombre, u.AP_PATERNO, u.AP_MATERNO, sum(a.num_dias_ocupara*vv.costo_dia)
from usuario u
join vivienda v
  on u.usuario_id=v.duenio
join vivienda_vacacional vv
  on v.vivienda_id=vv.vivienda_id
join alquiler a 
  on vv.vivienda_id = a.vivienda_id
group by u.usuario_id,u.nombre,u.AP_PATERNO,u.AP_MATERNO;


prompt Creando segunda vista
create or replace view pago_usuario(
  vivienda_id, usuario_id, precio_vivienda, monto_acumulado, cantidad_faltante, monto_por_mes
) as select v.vivienda_id, vt.usuario_id, vt.precio_inicial, q1.suma as precio_acumulado,
       (vt.precio_inicial-q1.suma) as faltante, (vt.precio_inicial/vt.num_mensualidades) as mensualidad
     from vivienda v 
     join ( 
        select pa.vivienda_id, sum(pa.importe_pago) as suma
        from pago_vivienda pa
        group by pa.vivienda_id
     ) q1 on v.vivienda_id = q1.vivienda_id
     join vivienda_venta vt on v.vivienda_id = vt.vivienda_id
     join usuario u on vt.usuario_id = u.usuario_id;


prompt Creando tercer vista
-- promedio de numero de estrellas
create or replace view viviendas_5_estrellas(
  vivienda_id, num_estrellas_promedio, direccion, descripcion
) as  select vc.vivienda_id, avg(c.num_estrellas) as promedio_estrellas, v.direccion, v.descripcion
     from vivienda_vacacional vc 
     join vivienda v on vc.vivienda_id = v.vivienda_id
     join alquiler a on vc.vivienda_id = a.vivienda_id
     join calificacion_vivienda c on c.alquiler_id = a.alquiler_id
     group by vc.vivienda_id, v.direccion, v.descripcion
     having avg(c.num_estrellas) > 4;