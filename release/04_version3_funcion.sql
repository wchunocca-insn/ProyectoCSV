 
GO

/****** Object:  UserDefinedFunction [dbo].[doRow]    Script Date: 31/07/2023 11:32:38 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[doRow]
(
 @s_fila    VARCHAR(MAX), 
 @i_col  INT
)
RETURNS VARCHAR(MAX)
AS
begin
declare @s_celda varchar(max)
declare @i_nro int
declare @idx int

 ---set @s_fila='20;SALUD;44;SALUD INDIVIDUAL;96;ATENCION MEDICA BASICA;1;256;ATENCION DE EMERGENCIAS Y URGENCIAS;22;SAN MARTIN;5;RECURSOS DETERMINADOS;15;FONDO DE COMPENSACION REGIONAL - FONCOR;27;SUB CUENTA - FONCOR - LEY 31069;6;GASTO DE CAPITAL;2;6;ADQUISICION DE ACTIVOS NO FINANCIEROS;2;CONSTRUCCION DE EDIFICIOS Y ESTRUCTURAS;2;EDIFICIOS O UNIDADES NO RESIDENCIALES;3;INSTALACIONES MEDICAS;2;COSTO DE CONSTRUCCION POR CONTRATA0;0;0;0;522110.67;522110.67;522110.67'

 if right(@s_fila,1)<>';' set @s_fila=@s_fila+';' --Terminar en ';'

-- if @i_col=1 return left( @s_fila ,charindex(';',@s_fila)-1)
----
--- set @s_fila=right(@s_fila,len(@s_fila) - charindex(';',@s_fila))
--- if @i_nro=2 return left( @s_fila ,charindex(';',@s_fila)-1) 
----
set @i_nro=0
set @idx=1

while @idx!= 0     
begin     
	 set @i_nro=@i_nro+1

	 if @i_nro=@i_col begin
		 set @s_celda=left( @s_fila ,charindex(';',@s_fila)-1)
		 return @s_celda
		 break
	 end	 
	 set @s_fila=right(@s_fila,len(@s_fila) - charindex(';',@s_fila))
	 set @idx= charindex(';',@s_fila)
end 

return @s_fila

 end
GO


