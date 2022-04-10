select 
estacion,
Fecha,
LuviaTotal,
sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 2 PRECEDING and current row) as meco
from DA_Baleares_Limpios dbl 




update DA_Baleares_Limpios 
Set Fecha = cast(SUBSTRING(Fecha, 6,10) as date)

update DA_Baleares_Limpios 
Set LuviaTotal = Precipitacion0024h + Precipitacion0006h + Precipitacion0612h + Precipitacion1218h + Precipitacion1824h


update DA_Baleares_Limpios 
Set Lluvia10d = sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 10 PRECEDING and current row)

,Luvia5d = sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 5 PRECEDING and current row)
,Lluvia2d = sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 2 PRECEDING and current row)


with delta as (
Select
id 
,sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 10 PRECEDING and current row) as d10
,sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 5 PRECEDING and current row) as d5
,sum(LuviaTotal) over (partition by Estacion order by Fecha rows BETWEEN 2 PRECEDING and current row) as d2
from DA_Baleares_Limpios
)
update DA_Baleares_Limpios 
inner join delta 
on delta.id = DA_Baleares_Limpios.id
/*and delta.Estacion = DA_Baleares_Limpios.Estacion */
set Lluvia10d = d10,
 Luvia5d = d5,
Lluvia2d = d2