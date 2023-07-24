USE [master]
GO
/****** Object:  Database [Migracion]    Script Date: 23/07/2023 07:26:49 p.m. ******/
CREATE DATABASE [Migracion]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BDEJEDIA', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BDEJEDIA.mdf' , SIZE = 1380352KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BDEJEDIA_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BDEJEDIA_log.ldf' , SIZE = 6166080KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Migracion] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Migracion].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Migracion] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Migracion] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Migracion] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Migracion] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Migracion] SET ARITHABORT OFF 
GO
ALTER DATABASE [Migracion] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Migracion] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Migracion] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Migracion] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Migracion] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Migracion] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Migracion] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Migracion] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Migracion] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Migracion] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Migracion] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Migracion] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Migracion] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Migracion] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Migracion] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Migracion] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Migracion] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Migracion] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Migracion] SET RECOVERY FULL 
GO
ALTER DATABASE [Migracion] SET  MULTI_USER 
GO
ALTER DATABASE [Migracion] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Migracion] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Migracion] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Migracion] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Migracion', N'ON'
GO
USE [Migracion]
GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_MtCVSproceso]    Script Date: 23/07/2023 07:26:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'

---	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'

CREATE procedure [dbo].[pms_ecomin_MtCVSproceso]
@s_rutaFile varchar(500)
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

declare @s_script_go varchar(500)
truncate table eco_tempoTarea
SET @s_script_go = 'BULK INSERT eco_tempoTarea  
		FROM ''' + @s_rutaFile + '''		
		WITH
			(
			FIRSTROW=2,
			FIELDTERMINATOR = '';'',
			ROWTERMINATOR = ''\n''
			)'

exec (@s_script_go)

select @@ROWCOUNT

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



GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_MtCVSproceso_20]    Script Date: 23/07/2023 07:26:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'

---	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR.csv'


Create procedure [dbo].[pms_ecomin_MtCVSproceso_20]
@s_rutaFile varchar(500)
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

declare @s_script_go varchar(500)
truncate table eco_tempoTarea
SET @s_script_go = 'BULK INSERT eco_tempoTarea  
		FROM ''' + @s_rutaFile + '''		
		WITH
			(
			FIRSTROW=2,
			FIELDTERMINATOR = '';'',
			ROWTERMINATOR = ''\n''
			)'

exec (@s_script_go)

select @@ROWCOUNT

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



GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_mtTareaCVS]    Script Date: 23/07/2023 07:26:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pms_ecomin_mtTareaCVS]
@s_key varchar(15),
@s_parm1 varchar(20),
@s_parm2 varchar(20),
@s_parm3 varchar(20),
@s_msgError varchar(250) out

as


if @s_key='clear' begin

	truncate table eco_tempo
	return
end


GO
/****** Object:  Table [dbo].[eco_tempo]    Script Date: 23/07/2023 07:26:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[eco_tempo](
	[id_temp] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cvs_nombreEje] [varchar](250) NULL,
	[ANO_EJE] [float] NULL,
	[MES_EJE] [float] NULL,
	[NIVEL_GOBIERNO] [varchar](350) NULL,
	[NIVEL_GOBIERNO_NOMBRE] [varchar](350) NULL,
	[SECTOR] [float] NULL,
	[SECTOR_NOMBRE] [varchar](350) NULL,
	[PLIEGO] [float] NULL,
	[PLIEGO_NOMBRE] [varchar](350) NULL,
	[SEC_EJEC] [float] NULL,
	[EJECUTORA] [float] NULL,
	[EJECUTORA_NOMBRE] [varchar](350) NULL,
	[DEPARTAMENTO_EJECUTORA] [float] NULL,
	[DEPARTAMENTO_EJECUTORA_NOMBRE] [varchar](350) NULL,
	[PROVINCIA_EJECUTORA] [float] NULL,
	[PROVINCIA_EJECUTORA_NOMBRE] [varchar](350) NULL,
	[DISTRITO_EJECUTORA] [float] NULL,
	[DISTRITO_EJECUTORA_NOMBRE] [varchar](350) NULL,
	[SEC_FUNC] [float] NULL,
	[PROGRAMA_PPTO] [float] NULL,
	[PROGRAMA_PPTO_NOMBRE] [varchar](350) NULL,
	[TIPO_ACT_PROY] [float] NULL,
	[TIPO_ACT_PROY_NOMBRE] [varchar](350) NULL,
	[PRODUCTO_PROYECTO] [varchar](350) NULL,
	[PRODUCTO_PROYECTO_NOMBRE] [varchar](350) NULL,
	[ACTIVIDAD_ACCION_OBRA] [varchar](350) NULL,
	[ACTIVIDAD_ACCION_OBRA_NOMBRE] [varchar](350) NULL,
	[FUNCION] [float] NULL,
	[FUNCION_NOMBRE] [varchar](350) NULL,
	[DIVISION_FUNCIONAL] [float] NULL,
	[DIVISION_FUNCIONAL_NOMBRE] [varchar](350) NULL,
	[GRUPO_FUNCIONAL] [float] NULL,
	[GRUPO_FUNCIONAL_NOMBRE] [varchar](350) NULL,
	[META] [float] NULL,
	[FINALIDAD] [float] NULL,
	[META_NOMBRE] [varchar](350) NULL,
	[DEPARTAMENTO_META] [float] NULL,
	[DEPARTAMENTO_META_NOMBRE] [varchar](350) NULL,
	[FUENTE_FINANCIAMIENTO] [float] NULL,
	[FUENTE_FINANCIAMIENTO_NOMBRE] [varchar](350) NULL,
	[RUBRO] [float] NULL,
	[RUBRO_NOMBRE] [varchar](350) NULL,
	[TIPO_RECURSO] [float] NULL,
	[TIPO_RECURSO_NOMBRE] [varchar](350) NULL,
	[CATEGORIA_GASTO] [float] NULL,
	[CATEGORIA_GASTO_NOMBRE] [varchar](350) NULL,
	[TIPO_TRANSACCION] [float] NULL,
	[GENERICA] [float] NULL,
	[GENERICA_NOMBRE] [varchar](350) NULL,
	[SUBGENERICA] [float] NULL,
	[SUBGENERICA_NOMBRE] [varchar](350) NULL,
	[SUBGENERICA_DET] [float] NULL,
	[SUBGENERICA_DET_NOMBRE] [varchar](350) NULL,
	[ESPECIFICA] [float] NULL,
	[ESPECIFICA_NOMBRE] [varchar](350) NULL,
	[ESPECIFICA_DET] [float] NULL,
	[ESPECIFICA_DET_NOMBRE] [varchar](350) NULL,
	[MONTO_PIA] [float] NULL,
	[MONTO_PIM] [float] NULL,
	[MONTO_CERTIFICADO] [float] NULL,
	[MONTO_COMPROMETIDO_ANUAL] [float] NULL,
	[MONTO_COMPROMETIDO] [float] NULL,
	[MONTO_DEVENGADO] [float] NULL,
	[MONTO_GIRADO] [float] NULL,
	[imp_nrogrupo] [int] NULL,
	[imp_nro] [int] NULL,
	[imp_nrofor] [int] NULL,
	[imp_fecha] [datetime] NULL,
 CONSTRAINT [PK_eco_tempo] PRIMARY KEY CLUSTERED 
(
	[id_temp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[eco_tempoTarea]    Script Date: 23/07/2023 07:26:49 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eco_tempoTarea](
	[ANO_EJE] [nvarchar](max) NULL,
	[MES_EJE] [nvarchar](max) NULL,
	[NIVEL_GOBIERNO] [nvarchar](max) NULL,
	[NIVEL_GOBIERNO_NOMBRE] [nvarchar](max) NULL,
	[SECTOR] [nvarchar](max) NULL,
	[SECTOR_NOMBRE] [nvarchar](max) NULL,
	[PLIEGO] [nvarchar](max) NULL,
	[PLIEGO_NOMBRE] [nvarchar](max) NULL,
	[SEC_EJEC] [nvarchar](max) NULL,
	[EJECUTORA] [nvarchar](max) NULL,
	[EJECUTORA_NOMBRE] [nvarchar](max) NULL,
	[DEPARTAMENTO_EJECUTORA] [nvarchar](max) NULL,
	[DEPARTAMENTO_EJECUTORA_NOMBRE] [nvarchar](max) NULL,
	[PROVINCIA_EJECUTORA] [nvarchar](max) NULL,
	[PROVINCIA_EJECUTORA_NOMBRE] [nvarchar](max) NULL,
	[DISTRITO_EJECUTORA] [nvarchar](max) NULL,
	[DISTRITO_EJECUTORA_NOMBRE] [nvarchar](max) NULL,
	[SEC_FUNC] [nvarchar](max) NULL,
	[PROGRAMA_PPTO] [nvarchar](max) NULL,
	[PROGRAMA_PPTO_NOMBRE] [nvarchar](max) NULL,
	[TIPO_ACT_PROY] [nvarchar](max) NULL,
	[TIPO_ACT_PROY_NOMBRE] [nvarchar](max) NULL,
	[PRODUCTO_PROYECTO] [nvarchar](max) NULL,
	[PRODUCTO_PROYECTO_NOMBRE] [nvarchar](max) NULL,
	[ACTIVIDAD_ACCION_OBRA] [nvarchar](max) NULL,
	[ACTIVIDAD_ACCION_OBRA_NOMBRE] [nvarchar](max) NULL,
	[FUNCION] [nvarchar](max) NULL,
	[FUNCION_NOMBRE] [nvarchar](max) NULL,
	[DIVISION_FUNCIONAL] [nvarchar](max) NULL,
	[DIVISION_FUNCIONAL_NOMBRE] [nvarchar](max) NULL,
	[GRUPO_FUNCIONAL] [nvarchar](max) NULL,
	[GRUPO_FUNCIONAL_NOMBRE] [nvarchar](max) NULL,
	[META] [nvarchar](max) NULL,
	[FINALIDAD] [nvarchar](max) NULL,
	[META_NOMBRE] [nvarchar](max) NULL,
	[DEPARTAMENTO_META] [nvarchar](max) NULL,
	[DEPARTAMENTO_META_NOMBRE] [nvarchar](max) NULL,
	[FUENTE_FINANCIAMIENTO] [nvarchar](max) NULL,
	[FUENTE_FINANCIAMIENTO_NOMBRE] [nvarchar](max) NULL,
	[RUBRO] [nvarchar](max) NULL,
	[RUBRO_NOMBRE] [nvarchar](max) NULL,
	[TIPO_RECURSO] [nvarchar](max) NULL,
	[TIPO_RECURSO_NOMBRE] [nvarchar](max) NULL,
	[CATEGORIA_GASTO] [nvarchar](max) NULL,
	[CATEGORIA_GASTO_NOMBRE] [nvarchar](max) NULL,
	[TIPO_TRANSACCION] [nvarchar](max) NULL,
	[GENERICA] [nvarchar](max) NULL,
	[GENERICA_NOMBRE] [nvarchar](max) NULL,
	[SUBGENERICA] [nvarchar](max) NULL,
	[SUBGENERICA_NOMBRE] [nvarchar](max) NULL,
	[SUBGENERICA_DET] [nvarchar](max) NULL,
	[SUBGENERICA_DET_NOMBRE] [nvarchar](max) NULL,
	[ESPECIFICA] [nvarchar](max) NULL,
	[ESPECIFICA_NOMBRE] [nvarchar](max) NULL,
	[ESPECIFICA_DET] [nvarchar](max) NULL,
	[ESPECIFICA_DET_NOMBRE] [nvarchar](max) NULL,
	[MONTO_PIA] [nvarchar](max) NULL,
	[MONTO_PIM] [nvarchar](max) NULL,
	[MONTO_CERTIFICADO] [nvarchar](max) NULL,
	[MONTO_COMPROMETIDO_ANUAL] [nvarchar](max) NULL,
	[MONTO_COMPROMETIDO] [nvarchar](max) NULL,
	[MONTO_DEVENGADO] [nvarchar](max) NULL,
	[MONTO_GIRADO] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [Migracion] SET  READ_WRITE 
GO
