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


create or replace view 

