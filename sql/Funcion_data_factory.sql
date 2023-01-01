/*

-- Clean Not Balearic data:
Delete from Staging_DatosAemet 
where Provincia != 'Illes Balears'

-- Clean Fecha, extract hora T max/min, hora racha
update Staging_DatosAemet 
set	fecha = REPLACE( REPLACE(Fecha, 'Aemet',''), '.xls',''),
	hora_T_max = reverse(substring(REVERSE(Temperaturamaxima),2,5)), 
 	hora_T_min = reverse(substring(REVERSE(Temperaturaminima),2,5)),  
 	hora_Racha = reverse(substring(REVERSE(racha),2,5)),
 	hora_velocidadmaxima =  reverse(substring(REVERSE(Velocidadmaxima),2d,5)),
 	Temperaturamaxima = SUBSTRING(Temperaturamaxima,0, charindex('(',temperaturamaxima)),
	Temperaturaminima = SUBSTRING(Temperaturaminima,0, charindex('(',Temperaturaminima)),
	Racha  = SUBSTRING(Racha,0, charindex('(',Racha))

-- update Cod_Estacion
update Staging_DatosAemet 
set cod_estacion = e.cod_estacion
from Staging_DatosAemet stg
inner join Estaciones e
	on e.Estaciones  = stg.Estacion 


-- update agregated rain data

with delta as(
select 	id,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 1 PRECEDING and current row) d2 ,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 2 PRECEDING and current row) d3 ,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 6 PRECEDING and current row) d7 ,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 13 PRECEDING and current row) d14 ,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 19 PRECEDING and current row) d20 ,
		sum(cast(Precipitacion0024h as decimal(6,2))) over (partition by Estacion order by Fecha rows BETWEEN 29 PRECEDING and current row) d30
from Staging_DatosAemet sda 
)
update  Staging_DatosAemet 
set Preci_2d = d.d2,
	Preci_3d = d.d3,
	Preci_7d = d.d7,
	Preci_14d = d.d14,
	Preci_20d = d.d20,
	Preci_30d = d.d30	
from Staging_DatosAemet stg
inner join delta d 
	on d.id = stg.id


*/
Select * 
from Staging_DatosAemet sda 
INNER JOIN Estaciones e 
	on e.Estaciones = 

where 1=1
and Estacion  = 'Escorca, Son Torrella'
and Precipitacion0024h > cast (80 as decimal(6,2))
order by fecha	desc




	
	


