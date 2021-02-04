--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 31/01/2021
--@Descripción: Creación de vistas para el proyecto de BD

create or replace view ventas(
  duenio, ventas_totales_vacacionales, vivienda_id, direccion, cantidad_max, porcentaje
) as select v.duenio, q2.ventas_totales, q1.vivienda_id,v.direccion,q1.ventas_max,((q1.ventas_max/q2.ventas_totales)*100) as porcentaje
    from  vivienda v 
    join vivienda_vacacional vv on v.vivienda_id = vv.vivienda_id
    join usuario u on u.usuario_id = v.duenio
    join (
      select vi.vivienda_id, sum(a.num_dias_ocupara*vv.costo_dia) as ventas_max
      from vivienda vi
      join vivienda_vacacional vv on vi.vivienda_id = vv.vivienda_id
      join alquiler a on vv.vivienda_id = a.vivienda_id
      where vi.duenio=u.usuario_id
      group by vi.vivienda_id
      having sum(a.num_dias_ocupara*vv.costo_dia) = (
        select max(sum(a.num_dias_ocupara*vv.costo_dia)
        from vivienda vi
        join vivienda_vacacional vv on vi.vivienda_id = vv.vivienda_id
        join alquiler a on vv.vivienda_id = a.vivienda_id
        where vi.duenio=u.usuario_id
        group by vi.vivienda_id
      )
    ) q1
    on q1.vivienda_id = v.vivienda_id
    join (
      select vi.duenio, sum(a.num_dias_ocupara*vv.costo_dia) as ventas_totales
      from vivienda vi
      join vivienda_vacacional vv on vi.vivienda_id = vv.vivienda_id
      join alquiler a on vv.vivienda_id = a.vivienda_id
      where vi.duenio=u.usuario_id
      group by vi.duenio
    ) q2 
    on q2.duenio = v.duenio
    group by u.usuario_id;


create or replace view pago_usuario(
  vivienda_id, usuario_id, precio_vivienda, monto_acumulado, cantidad_faltante, monto_por_mes
) as select v.vivienda_id, vt.usuario_id, vt.precio_inicial, q1.suma,
       (vt.precio_inicial-q1.suma), (vt.precio_inicial/vt.num_mensualidades)
     from  vivienda v 
     join vivienda_venta vt on v.vivienda_id = vt.vivienda_id
     join usuario u on vt.usuario_id = u.usuario_id
     join ( 
        select pa.vivienda_id, sum(pa.importe_pago) as suma
        from pago_vivienda pa
        where pa.vivienda_id = v.vivienda_id
        group by pa.vivienda_id
     ) q1 on v.vivienda_id = q1.vivienda_id;

-- promedio de numero de estrellas
create or replace view viviendas_5_estrellas(
  vivienda_id, num_estrellas
) as select vc.vivienda_id, avg(c.num_estrellas), v.direccion, v.descripcion
     from vivienda_vacacional vc 
     join vivienda v on vc.vivienda_id = v.vivienda_id
     join alquiler a on vc.vivienda_id = a.vivienda_id
     join calificacion_vivienda c on c.alquiler_id = a.alquiler_id
     where  v.estado_id = 1
     group by vc.vivienda_id, v.direccion, v.descripcion
     having avg(c.num_estrellas) > 4;

