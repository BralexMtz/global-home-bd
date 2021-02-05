--@Autor: Parada Pérez Jesús Bryan, Brayan Alexis Martinez Vazquez
--@Fecha creación: 3/02/2021
--@Descripción: Creacion de consultas

--Consulta que nos da la vivienda vacacional que más $$ ha generado
-- sinonimos
-- joins
-- funciones de agregacion
-- subconsultas

  select vi.vivienda_id,sum(a.num_dias_ocupara*vv.costo_dia) as ventas_max
  from casa vi
  join CX_vivienda_vacacional vv on vi.vivienda_id = vv.vivienda_id
  join CX_alquiler a on vv.vivienda_id = a.vivienda_id
  group by vi.vivienda_id
  having sum(a.num_dias_ocupara*vv.costo_dia) = (
    select max(sum(a.num_dias_ocupara*vv.costo_dia))
    from casa vii
    join CX_vivienda_vacacional vv on vii.vivienda_id = vv.vivienda_id
    join CX_alquiler a on vv.vivienda_id = a.vivienda_id
    group by vii.vivienda_id
  );


-- Consulta para obtener la viviendas en venta que tengan piscina(id=5) exceptuando las que se hayan vendido(id=5).
-- algebra relacional
-- joins
select v.* 
from vivienda v
join VIVIENDA_SERVICIO vs
on vs.VIVIENDA_ID=v.VIVIENDA_ID
where vs.SERVICIO_ID=5
INTERSECT
select *
from vivienda v
where v.IS_VENTA=1
minus
select *
from vivienda v
where v.ESTADO_ID=5;


-- consulta para obtener los datos del usuario que más servicios ha puesto a una vivienda vacacional de 5 estrellas .
-- joins
-- subconsultas
-- agregacion
-- vistas
select u.nombre,u.correo ,q1.VIVIENDA_ID,q1.direccion, q1.num_servicios_max
from usuario u
join (
  select vv.VIVIENDA_ID,vv.duenio,vv.direccion , count(*) as num_servicios_max
  from VIVIENDAS_5_ESTRELLAS v
  join vivienda vv 
  on vv.VIVIENDA_ID=v.VIVIENDA_ID
  join VIVIENDA_SERVICIO vs
  on v.vivienda_id=vs.VIVIENDA_ID
  group by vv.duenio,vv.VIVIENDA_ID,vv.direccion
  having count(*)=(
    select max(count(*)) 
    from VIVIENDAS_5_ESTRELLAS v
    join VIVIENDA_SERVICIO vs
    on v.vivienda_id=vs.VIVIENDA_ID
    group by v.vivienda_id
  )
)q1
on u.USUARIO_ID=q1.duenio;

-- Consulta para obtener todos los datos de las viviendas cercanas disponibles que 
-- cuentan con WIFI
-- joins
-- tabla temporal(vivienda cercana)
select v.* 
from vivienda_cercana vc
join vivienda v 
on v.VIVIENDA_ID=vc.VIVIENDA_ID
join VIVIENDA_SERVICIO vs
on vs.vivienda_id=v.vivienda_id
join servicio s
on s.SERVICIO_ID=vs.SERVICIO_ID
where s.NOMBRE='WIFI';

-- 


