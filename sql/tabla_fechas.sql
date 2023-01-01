/*
create table fechas(
fecha date,
mes int,
dia int,
ano int ,
semana int,
trimestre int
);


-- generar fechas per con l'imite
DECLARE @startDate date = CAST('2013-01-01' AS date),
    @endDate date = CAST('2030-12-31' AS date);

SELECT DATEADD(day, number - 1, @startDate) AS [Date]
FROM (
    SELECT ROW_NUMBER() OVER (
        ORDER BY n.object_id
        )
    FROM sys.all_objects n
    ) S(number)
WHERE number <= DATEDIFF(day, @startDate, @endDate) + 1

)
insert into fechas (fecha)
select date from delta


-- dates recursivo
DECLARE @startDate date = CAST('2013-01-01' AS date),
    @endDate date = CAST('2030-12-31' AS date);
 
with Date_CTE AS 
(
    SELECT [Date] = @startDate 
    
    UNION ALL 
    
    SELECT [Date] = DATEADD(day, 1, [Date])
    FROM Date_CTE
    WHERE [Date] < @endDate
)

insert into fechas (fecha)
SELECT [Date] FROM Date_CTE
OPTION (MAXRECURSION 0)

--set day, mes, ano, semana from fecha

update fechas 
set mes = month(fecha), 
dia = day(fecha), 
ano = year(fecha),
semana = DATEPART(week,fecha)
*/




update fechas 
set mes = month(fecha), 
dia = day(fecha), 
ano = year(fecha),
semana = DATEPART(week,fecha)

select * from fechas 
