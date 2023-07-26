USE [Migracion]
GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_MtCVSproceso]    Script Date: 25/07/2023 11:13:16 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'

---	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'
---- test
/*

-----script para testing 

declare @s_error_msg varchar(350) 
declare @i_error_nro int out

exec pms_ecomin_MtCVSproceso
	@s_rutaFile ='\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'
	@s_error_msg =@s_error_msg out
	@i_error_nro =@i_error_nro out

select	msg		=@s_error_msg,
		i_error	=@i_error_nro



*/
ALTER procedure [dbo].[pms_ecomin_MtCVSproceso]
@s_rutaFile varchar(500),
@s_error_msg varchar(350) out,
@i_error_nro int out
as
 /*
BULK INSERT eco_tempoTarea
FROM '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'
WITH
(
	FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n'
)
 */



begin

		begin try 
	
			set @s_error_msg='' ;set @i_error_nro=0
			
			truncate table eco_tempoTarea

			declare @s_script_go varchar(500)
			
			SET @s_script_go = 'BULK INSERT eco_tempoTarea  
					FROM ''' + @s_rutaFile + '''		
					WITH
						(
						FIRSTROW=2,
						FIELDTERMINATOR = '';'',
						ROWTERMINATOR = ''\n''
						)'

			exec (@s_script_go)

		end try
		begin catch
			set @s_error_msg=Cast( (select ERROR_MESSAGE() as msg) as varchar(350));
			set @i_error_nro=99
		end catch


	print @s_error_msg

--select @@ROWCOUNT

end

 /*
SET @Sql = 'BULK INSERT #CSVLine
FROM ''' + @InputFile + '''
WITH
(
FIRSTROW=' + CAST(@FirstLine as varchar) + ',
FIELDTERMINATOR = ''\n'',
ROWTERMINATOR = ''\n''
)'

EXEC(@sql)
*/
---select i_count=count(*) from eco_tempoTarea


