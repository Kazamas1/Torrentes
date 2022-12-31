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
 	hora_velocidadmaxima =  reverse(substring(REVERSE(Velocidadmaxima),2,5)),
 	Temperaturamaxima = SUBSTRING(Temperaturamaxima,0, charindex('(',temperaturamaxima)),
	Temperaturaminima = SUBSTRING(Temperaturaminima,0, charindex('(',Temperaturaminima)),
	Racha  = SUBSTRING(Racha,0, charindex('(',Racha))

*/
Select * from Staging_DatosAemet sda 





