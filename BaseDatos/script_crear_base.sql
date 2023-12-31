USE [EcoMigrar]
GO
/****** Object:  UserDefinedFunction [dbo].[doLet]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[doLet]
(
 @s_value    VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
begin

declare @s_patern varchar(500)
declare @i_index int,@i_index2 int
----
declare @i_let_N1 int
declare @i_let_N2 int
----
declare @i_row int
declare @i_ns int

set @s_patern='%[^ 0-9A-Za-z;:,.()!/\-]%'
set @i_ns=0
--CHAR(244)ô
--CHAR(43)+
--CHAR(230)æ    ├æ=Ñ
set @i_index=1
set @i_row=0

-----test
if patindex(@s_patern,@s_value)=0 begin
	IF CHARINDEX(CHAR(195),@s_value)=0 begin 
		return @s_value
	end
end
-----test


while @i_index!= 0  
begin
	set @i_index=patindex(@s_patern,@s_value)
	set @i_row=@i_row  +1 
	---IF @i_index=0 SET @i_index=CHARINDEX(CHAR(195),@s_value)
	if @i_row>10 begin
		break
	end

	IF @i_index=0 begin
		SET @i_index=CHARINDEX(CHAR(195),@s_value)
	end else begin
		--°
		set @i_let_N1=ascii(SUBSTRING(@s_value,@i_index,1))
		if @i_let_N1=176 or @i_let_N1=9 SET @i_index=CHARINDEX(CHAR(194),@s_value)
	end


	if @i_index>0 begin
		set @i_let_N1=ascii(SUBSTRING(@s_value,@i_index,1))
		set @i_let_N2=ascii(SUBSTRING(@s_value,@i_index+1,1))
	end else begin
		break
	end
	 

	--/├æ=Ñ / char: 43,230
	if @i_let_N1=43 and @i_let_N2=230 begin
		set @s_value=Concat( left(@s_value,@i_index-1),'Ñ',right(@s_value,(len(@s_value) -  (@i_index+1))))
		set @i_ns=1
	end
	--/├ô = O / char: ├=43 - ô=244
	if @i_let_N1=43 and @i_let_N2=244 begin
		set @s_value=Concat( left(@s_value,@i_index-1),'O',right(@s_value,(len(@s_value) -  (@i_index+1))))
		set @i_ns=1		 
	end
	
	--Ã‘ Ñ/  Ã=145 
	if @i_let_N1=145 begin 		 
		set @s_value=Concat( left(@s_value,@i_index-2),'Ñ',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1 
	end

	---Ã“ = 147 / Ó 
	if @i_let_N1=147 begin 	 
		set @s_value=Concat( left(@s_value,@i_index-2),'O',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1		 
	end

	---Ã“ = 129 / Á
	if @i_let_N1=129 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'A',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1		
	end

	---‰ = 129 / É
	if @i_let_N1=137 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'E',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end
	---Ãš = 195 /Ú
	if @i_let_N1=195 begin 
		set @s_value=Concat( left(@s_value,@i_index-1),'U',right(@s_value,(len(@s_value) -  (@i_index))-1  )  )
		set @i_ns=1
	end
	---‰ = 141 / í
	if @i_let_N1=141 begin 
		set @s_value=Concat( left(@s_value,@i_index-2),'I',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end
	---Â° = 194 / °
	if @i_let_N1=194 begin 
		set @s_value=Concat( left(@s_value,@i_index -1),'',right(@s_value,(len(@s_value) -  (@i_index))))
		set @i_ns=1
	end

	---Â = 160 / ''
	if @i_let_N1=160 begin
		set @s_value=Concat( left(@s_value,@i_index-2),' ',right(@s_value,(len(@s_value) -  (@i_index))))
		 set @i_ns=1
	end



	if @i_ns=0 break
	set @i_ns=0
end

	return @s_value

end
GO
/****** Object:  UserDefinedFunction [dbo].[doRow]    Script Date: 08/08/2023 11:03:41 p.m. ******/
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
ASbegindeclare @s_celda varchar(max)declare @i_nro intdeclare @idx int ---set @s_fila='20;SALUD;44;SALUD INDIVIDUAL;96;ATENCION MEDICA BASICA;1;256;ATENCION DE EMERGENCIAS Y URGENCIAS;22;SAN MARTIN;5;RECURSOS DETERMINADOS;15;FONDO DE COMPENSACION REGIONAL - FONCOR;27;SUB CUENTA - FONCOR - LEY 31069;6;GASTO DE CAPITAL;2;6;ADQUISICION DE ACTIVOS NO FINANCIEROS;2;CONSTRUCCION DE EDIFICIOS Y ESTRUCTURAS;2;EDIFICIOS O UNIDADES NO RESIDENCIALES;3;INSTALACIONES MEDICAS;2;COSTO DE CONSTRUCCION POR CONTRATA0;0;0;0;522110.67;522110.67;522110.67' if right(@s_fila,1)<>';' set @s_fila=@s_fila+';' --Terminar en ';'-- if @i_col=1 return left( @s_fila ,charindex(';',@s_fila)-1)------- set @s_fila=right(@s_fila,len(@s_fila) - charindex(';',@s_fila))--- if @i_nro=2 return left( @s_fila ,charindex(';',@s_fila)-1) ----set @i_nro=0set @idx=1
while @idx!= 0     
begin     
	 set @i_nro=@i_nro+1	 if @i_nro=@i_col begin		 set @s_celda=left( @s_fila ,charindex(';',@s_fila)-1)		 return @s_celda		 break	 end	 
	 set @s_fila=right(@s_fila,len(@s_fila) - charindex(';',@s_fila))	 set @idx= charindex(';',@s_fila)end return @s_fila end
GO
/****** Object:  Table [dbo].[BD_FUNCION_SALUD_GR_Limpio]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BD_FUNCION_SALUD_GR_Limpio](
	[ANO_EJE] [nvarchar](max) NULL,
	[MES_EJE] [nvarchar](max) NULL,
	[NIVEL_GOBIERNO] [nvarchar](max) NULL,
	[SECTOR] [nvarchar](max) NOT NULL,
	[PLIEGO] [nvarchar](max) NOT NULL,
	[SEC_EJEC] [nvarchar](max) NULL,
	[UE] [nvarchar](max) NOT NULL,
	[UE_DEP] [nvarchar](max) NOT NULL,
	[UE_PROV] [nvarchar](max) NOT NULL,
	[DISTRITO_UE] [nvarchar](max) NOT NULL,
	[SEC_FUNC] [nvarchar](max) NULL,
	[CATEG_PRESUP] [nvarchar](max) NOT NULL,
	[TIPO_PRODPROY] [nvarchar](max) NOT NULL,
	[PROD_POY] [nvarchar](max) NULL,
	[ACTIVIDAD] [nvarchar](max) NULL,
	[FUNCION] [nvarchar](max) NOT NULL,
	[DIV_FUNCIONAL] [nvarchar](max) NULL,
	[GRUPO_FUNCIONAL] [nvarchar](max) NULL,
	[META] [nvarchar](max) NULL,
	[FINALIDAD_N] [nvarchar](max) NULL,
	[DEPARTAMENTO_META] [nvarchar](max) NULL,
	[FF] [nvarchar](max) NULL,
	[FF_RUBRO] [nvarchar](max) NULL,
	[FF_TIPORECURSO] [nvarchar](max) NULL,
	[CATEGORIA_GASTO] [nvarchar](max) NULL,
	[TIPO_TRANSACCION] [nvarchar](max) NULL,
	[GENERICA_GASTO] [nvarchar](max) NULL,
	[SUBGENERICA_GASTO] [nvarchar](max) NULL,
	[SUBGENERICA_DET_GASTO] [nvarchar](max) NULL,
	[ESPECIFICA_GASTO] [nvarchar](max) NULL,
	[ESPECIFICA_DET_GASTO] [nvarchar](max) NULL,
	[CADENA_GASTO] [nvarchar](max) NULL,
	[MONTO_PIA] [nvarchar](max) NULL,
	[MONTO_PIM] [nvarchar](max) NULL,
	[MONTO_CERTIFICADO] [nvarchar](max) NULL,
	[MONTO_COMPROMETIDO_ANUAL] [nvarchar](max) NULL,
	[MONTO_COMPROMETIDO] [nvarchar](max) NULL,
	[MONTO_DEVENGADO] [nvarchar](max) NULL,
	[MONTO_GIRADO] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eco_tempo]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eco_tempo](
	[id_temp] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[cvs_nombreEje] [varchar](250) NULL,
	[ANO_EJE] [float] NULL,
	[MES_EJE] [float] NULL,
	[NIVEL_GOBIERNO] [varchar](700) NULL,
	[NIVEL_GOBIERNO_NOMBRE] [varchar](700) NULL,
	[SECTOR] [float] NULL,
	[SECTOR_NOMBRE] [varchar](700) NULL,
	[PLIEGO] [float] NULL,
	[PLIEGO_NOMBRE] [varchar](700) NULL,
	[SEC_EJEC] [float] NULL,
	[EJECUTORA] [float] NULL,
	[EJECUTORA_NOMBRE] [varchar](700) NULL,
	[DEPARTAMENTO_EJECUTORA] [float] NULL,
	[DEPARTAMENTO_EJECUTORA_NOMBRE] [varchar](700) NULL,
	[PROVINCIA_EJECUTORA] [float] NULL,
	[PROVINCIA_EJECUTORA_NOMBRE] [varchar](700) NULL,
	[DISTRITO_EJECUTORA] [float] NULL,
	[DISTRITO_EJECUTORA_NOMBRE] [varchar](700) NULL,
	[SEC_FUNC] [float] NULL,
	[PROGRAMA_PPTO] [float] NULL,
	[PROGRAMA_PPTO_NOMBRE] [varchar](700) NULL,
	[TIPO_ACT_PROY] [float] NULL,
	[TIPO_ACT_PROY_NOMBRE] [varchar](700) NULL,
	[PRODUCTO_PROYECTO] [varchar](700) NULL,
	[PRODUCTO_PROYECTO_NOMBRE] [varchar](700) NULL,
	[ACTIVIDAD_ACCION_OBRA] [varchar](700) NULL,
	[ACTIVIDAD_ACCION_OBRA_NOMBRE] [varchar](700) NULL,
	[FUNCION] [float] NULL,
	[FUNCION_NOMBRE] [varchar](700) NULL,
	[DIVISION_FUNCIONAL] [float] NULL,
	[DIVISION_FUNCIONAL_NOMBRE] [varchar](700) NULL,
	[GRUPO_FUNCIONAL] [float] NULL,
	[GRUPO_FUNCIONAL_NOMBRE] [varchar](700) NULL,
	[META] [float] NULL,
	[FINALIDAD] [float] NULL,
	[META_NOMBRE] [varchar](700) NULL,
	[DEPARTAMENTO_META] [float] NULL,
	[DEPARTAMENTO_META_NOMBRE] [varchar](700) NULL,
	[FUENTE_FINANCIAMIENTO] [float] NULL,
	[FUENTE_FINANCIAMIENTO_NOMBRE] [varchar](700) NULL,
	[RUBRO] [float] NULL,
	[RUBRO_NOMBRE] [varchar](700) NULL,
	[TIPO_RECURSO] [float] NULL,
	[TIPO_RECURSO_NOMBRE] [varchar](700) NULL,
	[CATEGORIA_GASTO] [float] NULL,
	[CATEGORIA_GASTO_NOMBRE] [varchar](700) NULL,
	[TIPO_TRANSACCION] [float] NULL,
	[GENERICA] [float] NULL,
	[GENERICA_NOMBRE] [varchar](700) NULL,
	[SUBGENERICA] [float] NULL,
	[SUBGENERICA_NOMBRE] [varchar](700) NULL,
	[SUBGENERICA_DET] [float] NULL,
	[SUBGENERICA_DET_NOMBRE] [varchar](700) NULL,
	[ESPECIFICA] [float] NULL,
	[ESPECIFICA_NOMBRE] [varchar](700) NULL,
	[ESPECIFICA_DET] [float] NULL,
	[ESPECIFICA_DET_NOMBRE] [varchar](700) NULL,
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
/****** Object:  Table [dbo].[eco_tempoTarea]    Script Date: 08/08/2023 11:03:41 p.m. ******/
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
/****** Object:  Table [dbo].[eco_tempoTarea_error]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eco_tempoTarea_error](
	[id_temperro] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
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
	[MONTO_GIRADO] [nvarchar](max) NULL,
	[ECO_NROERRO] [int] NULL,
	[ECO_METAERRO] [int] NULL,
	[ECO_ROWDATA] [nvarchar](max) NULL,
 CONSTRAINT [PK_eco_tempoTarea_error] PRIMARY KEY CLUSTERED 
(
	[id_temperro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[eco_tempoTareaN2]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[eco_tempoTareaN2](
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
/****** Object:  StoredProcedure [dbo].[pms_ecomin_MtCVSproceso]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---- test
/*

-----script para testing 

declare @s_error_msg varchar(350) 
declare @i_error_nro int
declare @i_nroFile int

exec pms_ecomin_MtCVSproceso
	@i_nroFile=1,
	@s_rutaFile ='\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR.csv',
	@s_error_msg =@s_error_msg out,
	@i_error_nro =@i_error_nro out

select	msg		=@s_error_msg,
		i_error	=@i_error_nro


*/
CREATE procedure [dbo].[pms_ecomin_MtCVSproceso]
@i_nroFile int,
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

declare @s_nombreTabla varchar(100)
set @s_nombreTabla ='eco_tempoTarea'
if @i_nroFile=2 set @s_nombreTabla ='eco_tempoTareaN2'

		begin try 
	
			set @s_error_msg='' ;set @i_error_nro=0
			
			if @i_nroFile=1 begin
				truncate table eco_tempoTarea
			end
			if @i_nroFile=2 begin
				truncate table eco_tempoTareaN2
			end


			declare @s_script_go varchar(700)
			
			SET @s_script_go = 'BULK INSERT '+@s_nombreTabla+'  
					 FROM ''' + @s_rutaFile + '''		
					WITH
						(
						FIRSTROW=2,
						FIELDTERMINATOR = '';'',
						ROWTERMINATOR = ''\n'',
						CODEPAGE = ''ACP''
						)'
				---		print @s_script_go
			exec (@s_script_go)
			
			--------truncar Log
		---	DBCC SHRINKFILE ('EcoMigrar_log', 1)
		--	DBCC SHRINKFILE ('EcoMigrar_log',0 ,TRUNCATEONLY)
		---	DBCC SHRINKFILE (N'EcoMigrar' , 0, TRUNCATEONLY)



		----------/ Separar errores
			begin
				---print 'Separar errores'	
				truncate table eco_tempoTarea_error
				if  @i_nroFile=1 begin
					insert into eco_tempoTarea_error
					(
						ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
						SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
						PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
						PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
						PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
						DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
						META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
						RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
						TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
						SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
						MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
						MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
					)
					select 
						ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
						SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
						PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
						PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
						PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
						DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
						META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
						RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
						TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
						SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
						MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
						MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
					from eco_tempoTarea t
					where 
					charindex(';',MONTO_GIRADO)>0
					---
					delete from eco_tempoTarea where charindex(';',MONTO_GIRADO)>0
				
				end
				-----------
				if  @i_nroFile=2 begin
					insert into eco_tempoTarea_error
					(
						ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
						SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
						PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
						PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
						PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
						DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
						META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
						RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
						TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
						SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
						MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
						MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
					)
					select 
						ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
						SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
						PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
						PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
						PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
						DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
						META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
						RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
						TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
						SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
						MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
						MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
					from eco_tempoTareaN2 t
					where 
					charindex(';',MONTO_GIRADO)>0
					---
					delete from eco_tempoTareaN2 where charindex(';',MONTO_GIRADO)>0
				
				end
				------------


			end
			------------------/ rowdata

			----/ Concaternar FilaCVS
			begin 

			---print 'Concatenar fila ECO_ROWDATA '

			 Update eco_tempoTarea_error
			 set	ECO_ROWDATA	=s_rowdatos,
					ECO_NROERRO	=1
			 From eco_tempoTarea_error m inner join
			 (
			 select 
				id= id_temperro,
				s_rowdatos= 
				replace(	(
					case 
					when  right(FUNCION,1)='"' then		 
					 concat(isnull(PRODUCTO_PROYECTO_NOMBRE,''),',',isnull(ACTIVIDAD_ACCION_OBRA,''),',',isnull(ACTIVIDAD_ACCION_OBRA_NOMBRE,''),',',isnull(FUNCION,''))
					when  right(ACTIVIDAD_ACCION_OBRA_NOMBRE,1)='"' then		 
					 concat(isnull(PRODUCTO_PROYECTO_NOMBRE,''),',',isnull(ACTIVIDAD_ACCION_OBRA,''),',',isnull(ACTIVIDAD_ACCION_OBRA_NOMBRE,''),';',isnull(FUNCION,''))
					when  right(ACTIVIDAD_ACCION_OBRA,1)='"' then		 
					 concat(isnull(PRODUCTO_PROYECTO_NOMBRE,''),',',isnull(ACTIVIDAD_ACCION_OBRA,''),';',isnull(ACTIVIDAD_ACCION_OBRA_NOMBRE,''),';',isnull(FUNCION,''))
					 else 
					 concat(isnull(PRODUCTO_PROYECTO_NOMBRE,''),';',isnull(ACTIVIDAD_ACCION_OBRA,''),';',isnull(ACTIVIDAD_ACCION_OBRA_NOMBRE,''),';',isnull(FUNCION,''))
					 end
					 ),'"','') --PRODUCTO_PROYECTO_NOMBRE	ACTIVIDAD_ACCION_OBRA	ACTIVIDAD_ACCION_OBRA_NOMBRE	FUNCION	
					+
					Concat( ';',
					isnull(FUNCION_NOMBRE,'')	,';',
					isnull(DIVISION_FUNCIONAL,'')	,';',isnull(DIVISION_FUNCIONAL_NOMBRE,'')	,';',
					isnull(GRUPO_FUNCIONAL,'')	,';',isnull(GRUPO_FUNCIONAL_NOMBRE,'')	,';',
					isnull(META,'')	,';',isnull(FINALIDAD,'')	,';',isnull(META_NOMBRE,'')	,';'
					)
					+
					replace((
						case 
						when right(FUENTE_FINANCIAMIENTO_NOMBRE,1)='"' then
							concat( isnull(DEPARTAMENTO_META,''),';',isnull(DEPARTAMENTO_META_NOMBRE,''),',',isnull(FUENTE_FINANCIAMIENTO,''),',',isnull(FUENTE_FINANCIAMIENTO_NOMBRE,''))
						when right(FUENTE_FINANCIAMIENTO,1)='"' then
							concat( isnull(DEPARTAMENTO_META,''),';',isnull(DEPARTAMENTO_META_NOMBRE,''),',',isnull(FUENTE_FINANCIAMIENTO,''),';',isnull(FUENTE_FINANCIAMIENTO_NOMBRE,''))	
						when right(DEPARTAMENTO_META_NOMBRE,1)='"' then
							concat( isnull(DEPARTAMENTO_META,''),',',isnull(DEPARTAMENTO_META_NOMBRE,''),';',isnull(FUENTE_FINANCIAMIENTO,''),';',isnull(FUENTE_FINANCIAMIENTO_NOMBRE,''))	
						else 
							concat( isnull(DEPARTAMENTO_META,''),';',isnull(DEPARTAMENTO_META_NOMBRE,''),';',isnull(FUENTE_FINANCIAMIENTO,''),';',isnull(FUENTE_FINANCIAMIENTO_NOMBRE,''))	
						end	 -- DEPARTAMENTO_META	,DEPARTAMENTO_META_NOMBRE	,FUENTE_FINANCIAMIENTO	,FUENTE_FINANCIAMIENTO_NOMBRE,
					 ),'"','')
					 +
						Concat( ';',
								isnull(RUBRO,'')				,';',isnull(RUBRO_NOMBRE,'')			,';',
								isnull(TIPO_RECURSO,'')			,';',isnull(TIPO_RECURSO_NOMBRE,'')		,';',
								isnull(CATEGORIA_GASTO,'')		,';',isnull(CATEGORIA_GASTO_NOMBRE,'')	,';',
								isnull(TIPO_TRANSACCION,'')		,';',
								isnull(GENERICA,'')				,';',isnull(GENERICA_NOMBRE,'')			,';',
								isnull(SUBGENERICA,'')			,';',isnull(SUBGENERICA_NOMBRE,'')		,';',
								isnull(SUBGENERICA_DET,'')		,';',isnull(SUBGENERICA_DET_NOMBRE,'')	,';',
 								isnull(ESPECIFICA,'')			,';',isnull(ESPECIFICA_NOMBRE,'')		,';',
								isnull(ESPECIFICA_DET,'')		,';',isnull(ESPECIFICA_DET_NOMBRE,'')	,';',
								isnull(MONTO_PIA,'')			,';',isnull(MONTO_PIM,'')	,';',isnull(MONTO_CERTIFICADO,'')	,';',
								isnull(MONTO_COMPROMETIDO_ANUAL,''),';',	
								isnull(MONTO_COMPROMETIDO,'')	,';',isnull(MONTO_DEVENGADO,'')	,';',isnull(MONTO_GIRADO,'') 
						)
			 from eco_tempoTarea_error
			 ) t on m.id_temperro=t.id
			 where isnull(ECO_NROERRO,0)=0
		end


			begin
				 --print 'update columnas '
				update eco_tempoTarea_error
				set 
						ECO_NROERRO=2,
						ECO_ROWDATA='',
						PRODUCTO_PROYECTO_NOMBRE=dbo.doRow(ECO_ROWDATA,1) ,
						ACTIVIDAD_ACCION_OBRA=dbo.doRow(ECO_ROWDATA,2) ,
						ACTIVIDAD_ACCION_OBRA_NOMBRE=dbo.doRow(ECO_ROWDATA,3) ,
						FUNCION=dbo.doRow(ECO_ROWDATA,4) ,
						FUNCION_NOMBRE=dbo.doRow(ECO_ROWDATA,5) ,
						DIVISION_FUNCIONAL=dbo.doRow(ECO_ROWDATA,6) ,
						DIVISION_FUNCIONAL_NOMBRE=dbo.doRow(ECO_ROWDATA,7) ,
						GRUPO_FUNCIONAL=dbo.doRow(ECO_ROWDATA,8) ,
						GRUPO_FUNCIONAL_NOMBRE=dbo.doRow(ECO_ROWDATA,9) ,
						META=dbo.doRow(ECO_ROWDATA,10) ,
						FINALIDAD=dbo.doRow(ECO_ROWDATA,11) ,
						META_NOMBRE=dbo.doRow(ECO_ROWDATA,12) ,
						DEPARTAMENTO_META=dbo.doRow(ECO_ROWDATA,13) ,
						DEPARTAMENTO_META_NOMBRE=dbo.doRow(ECO_ROWDATA,14) ,
						FUENTE_FINANCIAMIENTO=dbo.doRow(ECO_ROWDATA,15) ,
						FUENTE_FINANCIAMIENTO_NOMBRE=dbo.doRow(ECO_ROWDATA,16) ,
						RUBRO=dbo.doRow(ECO_ROWDATA,17) ,
						RUBRO_NOMBRE=dbo.doRow(ECO_ROWDATA,18) ,
						TIPO_RECURSO=dbo.doRow(ECO_ROWDATA,19) ,
						TIPO_RECURSO_NOMBRE=dbo.doRow(ECO_ROWDATA,20) ,
						CATEGORIA_GASTO=dbo.doRow(ECO_ROWDATA,21) ,
						CATEGORIA_GASTO_NOMBRE=dbo.doRow(ECO_ROWDATA,22) ,
						TIPO_TRANSACCION=dbo.doRow(ECO_ROWDATA,23) ,
						GENERICA=dbo.doRow(ECO_ROWDATA,24) ,
						GENERICA_NOMBRE=dbo.doRow(ECO_ROWDATA,25) ,
						SUBGENERICA=dbo.doRow(ECO_ROWDATA,26) ,
						SUBGENERICA_NOMBRE=dbo.doRow(ECO_ROWDATA,27) ,
						SUBGENERICA_DET=dbo.doRow(ECO_ROWDATA,28) ,
						SUBGENERICA_DET_NOMBRE=dbo.doRow(ECO_ROWDATA,29) ,
						ESPECIFICA=dbo.doRow(ECO_ROWDATA,30) ,
						ESPECIFICA_NOMBRE=dbo.doRow(ECO_ROWDATA,31) ,
						ESPECIFICA_DET=dbo.doRow(ECO_ROWDATA,32) ,
						ESPECIFICA_DET_NOMBRE=dbo.doRow(ECO_ROWDATA,33) ,
						MONTO_PIA=dbo.doRow(ECO_ROWDATA,34) ,
						MONTO_PIM=dbo.doRow(ECO_ROWDATA,35) ,
						MONTO_CERTIFICADO=dbo.doRow(ECO_ROWDATA,36) ,
						MONTO_COMPROMETIDO_ANUAL=dbo.doRow(ECO_ROWDATA,37) ,
						MONTO_COMPROMETIDO=dbo.doRow(ECO_ROWDATA,38) ,
						MONTO_DEVENGADO=dbo.doRow(ECO_ROWDATA,39) ,
						MONTO_GIRADO=dbo.doRow(ECO_ROWDATA,40) 
				from eco_tempoTarea_error
				where ECO_NROERRO=1 
				and isnull(ECO_ROWDATA,'')<>''
		end
		---------------- re insert 
			
			if  @i_nroFile=1 begin
				insert into eco_tempoTarea
				(
					ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
					SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
					PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
					PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
					PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
					DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
					META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
					RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
					TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
					SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
					MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
					MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
				)
				select 
					ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
					SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
					PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
					PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
					PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
					DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
					META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
					RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
					TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
					SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
					MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
					MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
				from eco_tempoTarea_error  t
			end 
			if  @i_nroFile=2 begin
				insert into eco_tempoTareaN2
				(
					ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
					SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
					PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
					PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
					PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
					DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
					META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
					RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
					TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
					SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
					MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
					MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
				)
				select 
					ANO_EJE, MES_EJE, NIVEL_GOBIERNO, NIVEL_GOBIERNO_NOMBRE, SECTOR, SECTOR_NOMBRE, PLIEGO, PLIEGO_NOMBRE, 
					SEC_EJEC, EJECUTORA, EJECUTORA_NOMBRE, DEPARTAMENTO_EJECUTORA, DEPARTAMENTO_EJECUTORA_NOMBRE, 
					PROVINCIA_EJECUTORA, PROVINCIA_EJECUTORA_NOMBRE, DISTRITO_EJECUTORA, DISTRITO_EJECUTORA_NOMBRE, SEC_FUNC, 
					PROGRAMA_PPTO, PROGRAMA_PPTO_NOMBRE, TIPO_ACT_PROY, TIPO_ACT_PROY_NOMBRE, PRODUCTO_PROYECTO, 
					PRODUCTO_PROYECTO_NOMBRE, ACTIVIDAD_ACCION_OBRA, ACTIVIDAD_ACCION_OBRA_NOMBRE, FUNCION, FUNCION_NOMBRE, 
					DIVISION_FUNCIONAL, DIVISION_FUNCIONAL_NOMBRE, GRUPO_FUNCIONAL, GRUPO_FUNCIONAL_NOMBRE, META, FINALIDAD, 
					META_NOMBRE, DEPARTAMENTO_META, DEPARTAMENTO_META_NOMBRE, FUENTE_FINANCIAMIENTO, FUENTE_FINANCIAMIENTO_NOMBRE, 
					RUBRO, RUBRO_NOMBRE, TIPO_RECURSO, TIPO_RECURSO_NOMBRE, CATEGORIA_GASTO, CATEGORIA_GASTO_NOMBRE, 
					TIPO_TRANSACCION, GENERICA, GENERICA_NOMBRE, SUBGENERICA, SUBGENERICA_NOMBRE, SUBGENERICA_DET, 
					SUBGENERICA_DET_NOMBRE, ESPECIFICA, ESPECIFICA_NOMBRE, ESPECIFICA_DET, ESPECIFICA_DET_NOMBRE, 
					MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, 
					MONTO_COMPROMETIDO, MONTO_DEVENGADO, MONTO_GIRADO 
				from eco_tempoTarea_error  t
			end


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


GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_MtCVSproceso_test]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR_PRUEBA.csv'

---	exec pms_ecomin_MtCVSproceso '\\oeides-home\DatosQ\BD_FUNCION_SALUD_GR.csv'


Create procedure [dbo].[pms_ecomin_MtCVSproceso_test]
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
/****** Object:  StoredProcedure [dbo].[pms_ecomin_mtTareaCVS]    Script Date: 08/08/2023 11:03:41 p.m. ******/
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

set @s_msgError=''

if @s_key='depura-n1' begin

begin try


		TRUNCATE TABLE BD_FUNCION_SALUD_GR_Limpio
		INSERT INTO BD_FUNCION_SALUD_GR_Limpio
		(
		ANO_EJE, MES_EJE, NIVEL_GOBIERNO, SECTOR, PLIEGO, SEC_EJEC, UE, UE_DEP, UE_PROV, DISTRITO_UE, SEC_FUNC, CATEG_PRESUP, TIPO_PRODPROY, PROD_POY, ACTIVIDAD, FUNCION, 
                         DIV_FUNCIONAL, GRUPO_FUNCIONAL, META, FINALIDAD_N, DEPARTAMENTO_META, FF, FF_RUBRO, FF_TIPORECURSO, CATEGORIA_GASTO, TIPO_TRANSACCION, GENERICA_GASTO, SUBGENERICA_GASTO, 
                         SUBGENERICA_DET_GASTO, ESPECIFICA_GASTO, ESPECIFICA_DET_GASTO, CADENA_GASTO, MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, MONTO_COMPROMETIDO, 
                         MONTO_DEVENGADO, MONTO_GIRADO

		)
		SELECT  top 10000 ANO_EJE,
			   MES_EJE,
			   NIVEL_GOBIERNO_NOMBRE [NIVEL_GOBIERNO],
			   CONCAT(SECTOR,'. ',SECTOR_NOMBRE)[SECTOR],
			   CONCAT(PLIEGO,'. ',PLIEGO_NOMBRE)[PLIEGO],
			   SEC_EJEC,
			   CONCAT(RIGHT('000' + RTRIM(EJECUTORA),3),'. ',EJECUTORA_NOMBRE)[UE],
			   CONCAT(RIGHT('00' + RTRIM(DEPARTAMENTO_EJECUTORA),2),'. ',DEPARTAMENTO_EJECUTORA_NOMBRE)[UE_DEP],
			   CONCAT(RIGHT('00' + RTRIM(PROVINCIA_EJECUTORA),2),'. ',PROVINCIA_EJECUTORA_NOMBRE)[UE_PROV],
			   CONCAT(RIGHT('00' + RTRIM(DISTRITO_EJECUTORA),2),'. ',DISTRITO_EJECUTORA_NOMBRE)[DISTRITO_UE],
			   SEC_FUNC,
			   CONCAT(RIGHT('0000' + RTRIM(PROGRAMA_PPTO),4),'. ',PROGRAMA_PPTO_NOMBRE)[CATEG_PRESUP],
			   CONCAT(TIPO_ACT_PROY,'. ',(CASE WHEN TIPO_ACT_PROY_NOMBRE = 'ACTIVIDAD' THEN 'PRODUCTO' ELSE 'PROYECTO' END))[TIPO_PRODPROY],
			   RTRIM(CONCAT(PRODUCTO_PROYECTO,'. ',PRODUCTO_PROYECTO_NOMBRE))[PROD_POY],
			   RTRIM(CONCAT(ACTIVIDAD_ACCION_OBRA,'. ',REPLACE(ACTIVIDAD_ACCION_OBRA_NOMBRE, '  ', ' ')))[ACTIVIDAD],
			   CONCAT(FUNCION,'. ',FUNCION_NOMBRE)[FUNCION],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(DIVISION_FUNCIONAL),2),'. ',DIVISION_FUNCIONAL_NOMBRE))[DIV_FUNCIONAL],
			   RTRIM(CONCAT(RIGHT('000' + RTRIM(GRUPO_FUNCIONAL),3),'. ',GRUPO_FUNCIONAL_NOMBRE))[GRUPO_FUNCIONAL],
			   META,
			   RTRIM(CONCAT(RIGHT('000000' + RTRIM(FINALIDAD),6),'. ',META_NOMBRE))[FINALIDAD_N],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(DEPARTAMENTO_META),2),'. ',DEPARTAMENTO_META_NOMBRE))[DEPARTAMENTO_META],
			   RTRIM(CONCAT(FUENTE_FINANCIAMIENTO,'. ',FUENTE_FINANCIAMIENTO_NOMBRE))[FF],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(RUBRO),2),'. ',RUBRO_NOMBRE))[FF_RUBRO],
			   CASE
				   WHEN ISNUMERIC(LEFT(TIPO_RECURSO, 1))=1 THEN
				   RTRIM(CONCAT(RIGHT('00' + RTRIM(TIPO_RECURSO),2),'. ',TIPO_RECURSO_NOMBRE))
				   ELSE CONCAT('.. ',TIPO_RECURSO_NOMBRE)
				   END AS [FF_TIPORECURSO],
			   RTRIM(CONCAT(CATEGORIA_GASTO,'. ',CATEGORIA_GASTO_NOMBRE))[CATEGORIA_GASTO],
			   TIPO_TRANSACCION,
			   RTRIM(CONCAT(GENERICA,'. ',GENERICA_NOMBRE))[GENERICA_GASTO],
			   RTRIM(CONCAT(SUBGENERICA,'. ',SUBGENERICA_NOMBRE))[SUBGENERICA_GASTO],
			   RTRIM(CONCAT(SUBGENERICA_DET,'. ',SUBGENERICA_DET_NOMBRE))[SUBGENERICA_DET_GASTO],
			   RTRIM(CONCAT(ESPECIFICA,'. ',ESPECIFICA_NOMBRE))[ESPECIFICA_GASTO],
			   RTRIM(CONCAT(ESPECIFICA_DET,'. ',ESPECIFICA_DET_NOMBRE))[ESPECIFICA_DET_GASTO],
			   RTRIM(CONCAT(TIPO_TRANSACCION,'.',GENERICA,'.',SUBGENERICA,'.',SUBGENERICA_DET,'.',ESPECIFICA,'.',ESPECIFICA_DET,'. ',ESPECIFICA_DET_NOMBRE))[CADENA_GASTO],
			   MONTO_PIA,
			   MONTO_PIM,
			   MONTO_CERTIFICADO,
			   MONTO_COMPROMETIDO_ANUAL,
			   MONTO_COMPROMETIDO,
			   MONTO_DEVENGADO,
			   MONTO_GIRADO	   
		FROM eco_tempoTarea


end try
begin catch
	 set @s_msgError=Cast( (select ERROR_MESSAGE() icod) as varchar(250) )
end catch
---
	return
 


end



if @s_key='depura-n2' begin

begin try


		---TRUNCATE TABLE BD_FUNCION_SALUD_GR_Limpio
		INSERT INTO BD_FUNCION_SALUD_GR_Limpio
		(
		ANO_EJE, MES_EJE, NIVEL_GOBIERNO, SECTOR, PLIEGO, SEC_EJEC, UE, UE_DEP, UE_PROV, DISTRITO_UE, SEC_FUNC, CATEG_PRESUP, TIPO_PRODPROY, PROD_POY, ACTIVIDAD, FUNCION, 
                         DIV_FUNCIONAL, GRUPO_FUNCIONAL, META, FINALIDAD_N, DEPARTAMENTO_META, FF, FF_RUBRO, FF_TIPORECURSO, CATEGORIA_GASTO, TIPO_TRANSACCION, GENERICA_GASTO, SUBGENERICA_GASTO, 
                         SUBGENERICA_DET_GASTO, ESPECIFICA_GASTO, ESPECIFICA_DET_GASTO, CADENA_GASTO, MONTO_PIA, MONTO_PIM, MONTO_CERTIFICADO, MONTO_COMPROMETIDO_ANUAL, MONTO_COMPROMETIDO, 
                         MONTO_DEVENGADO, MONTO_GIRADO

		)
		SELECT  top 10000 ANO_EJE,
			   MES_EJE,
			   NIVEL_GOBIERNO_NOMBRE [NIVEL_GOBIERNO],
			   CONCAT(SECTOR,'. ',SECTOR_NOMBRE)[SECTOR],
			   CONCAT(PLIEGO,'. ',PLIEGO_NOMBRE)[PLIEGO],
			   SEC_EJEC,
			   CONCAT(RIGHT('000' + RTRIM(EJECUTORA),3),'. ',EJECUTORA_NOMBRE)[UE],
			   CONCAT(RIGHT('00' + RTRIM(DEPARTAMENTO_EJECUTORA),2),'. ',DEPARTAMENTO_EJECUTORA_NOMBRE)[UE_DEP],
			   CONCAT(RIGHT('00' + RTRIM(PROVINCIA_EJECUTORA),2),'. ',PROVINCIA_EJECUTORA_NOMBRE)[UE_PROV],
			   CONCAT(RIGHT('00' + RTRIM(DISTRITO_EJECUTORA),2),'. ',DISTRITO_EJECUTORA_NOMBRE)[DISTRITO_UE],
			   SEC_FUNC,
			   CONCAT(RIGHT('0000' + RTRIM(PROGRAMA_PPTO),4),'. ',PROGRAMA_PPTO_NOMBRE)[CATEG_PRESUP],
			   CONCAT(TIPO_ACT_PROY,'. ',(CASE WHEN TIPO_ACT_PROY_NOMBRE = 'ACTIVIDAD' THEN 'PRODUCTO' ELSE 'PROYECTO' END))[TIPO_PRODPROY],
			   RTRIM(CONCAT(PRODUCTO_PROYECTO,'. ',PRODUCTO_PROYECTO_NOMBRE))[PROD_POY],
			   RTRIM(CONCAT(ACTIVIDAD_ACCION_OBRA,'. ',REPLACE(ACTIVIDAD_ACCION_OBRA_NOMBRE, '  ', ' ')))[ACTIVIDAD],
			   CONCAT(FUNCION,'. ',FUNCION_NOMBRE)[FUNCION],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(DIVISION_FUNCIONAL),2),'. ',DIVISION_FUNCIONAL_NOMBRE))[DIV_FUNCIONAL],
			   RTRIM(CONCAT(RIGHT('000' + RTRIM(GRUPO_FUNCIONAL),3),'. ',GRUPO_FUNCIONAL_NOMBRE))[GRUPO_FUNCIONAL],
			   META,
			   RTRIM(CONCAT(RIGHT('000000' + RTRIM(FINALIDAD),6),'. ',META_NOMBRE))[FINALIDAD_N],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(DEPARTAMENTO_META),2),'. ',DEPARTAMENTO_META_NOMBRE))[DEPARTAMENTO_META],
			   RTRIM(CONCAT(FUENTE_FINANCIAMIENTO,'. ',FUENTE_FINANCIAMIENTO_NOMBRE))[FF],
			   RTRIM(CONCAT(RIGHT('00' + RTRIM(RUBRO),2),'. ',RUBRO_NOMBRE))[FF_RUBRO],
			   CASE
				   WHEN ISNUMERIC(LEFT(TIPO_RECURSO, 1))=1 THEN
				   RTRIM(CONCAT(RIGHT('00' + RTRIM(TIPO_RECURSO),2),'. ',TIPO_RECURSO_NOMBRE))
				   ELSE CONCAT('.. ',TIPO_RECURSO_NOMBRE)
				   END AS [FF_TIPORECURSO],
			   RTRIM(CONCAT(CATEGORIA_GASTO,'. ',CATEGORIA_GASTO_NOMBRE))[CATEGORIA_GASTO],
			   TIPO_TRANSACCION,
			   RTRIM(CONCAT(GENERICA,'. ',GENERICA_NOMBRE))[GENERICA_GASTO],
			   RTRIM(CONCAT(SUBGENERICA,'. ',SUBGENERICA_NOMBRE))[SUBGENERICA_GASTO],
			   RTRIM(CONCAT(SUBGENERICA_DET,'. ',SUBGENERICA_DET_NOMBRE))[SUBGENERICA_DET_GASTO],
			   RTRIM(CONCAT(ESPECIFICA,'. ',ESPECIFICA_NOMBRE))[ESPECIFICA_GASTO],
			   RTRIM(CONCAT(ESPECIFICA_DET,'. ',ESPECIFICA_DET_NOMBRE))[ESPECIFICA_DET_GASTO],
			   RTRIM(CONCAT(TIPO_TRANSACCION,'.',GENERICA,'.',SUBGENERICA,'.',SUBGENERICA_DET,'.',ESPECIFICA,'.',ESPECIFICA_DET,'. ',ESPECIFICA_DET_NOMBRE))[CADENA_GASTO],
			   MONTO_PIA,
			   MONTO_PIM,
			   MONTO_CERTIFICADO,
			   MONTO_COMPROMETIDO_ANUAL,
			   MONTO_COMPROMETIDO,
			   MONTO_DEVENGADO,
			   MONTO_GIRADO	   
		FROM eco_tempoTareaN2


end try
begin catch
	 set @s_msgError=Cast( (select ERROR_MESSAGE() icod) as varchar(250) )
end catch
---
	return
 


end



if @s_key='letras-n1' begin

begin try


-------- COLUMNAS ACTUALIZAR
/*
1. ACTIVIDAD_ACCION_OBRA_NOMBRE
2. PRODUCTO_PROYECTO_NOMBRE
3. GRUPO_FUNCIONAL_NOMBRE
4. META_NOMBRE
5. SUBGENERICA_DET_NOMBRE
6. ESPECIFICA_NOMBRE
7. ESPECIFICA_DET_NOMBRE
8. EJECUTORA_NOMBRE
*/
--Ã‘ Ñ/  Ã=145 
---Ã“ = 147 / Ó 
---Ã“ = 129 / Á
---‰ = 129 / É
---Ãš = 195 /Ú
---‰ = 141 / í

-------------1 ) / ACTIVIDAD_ACCION_OBRA_NOMBRE
Update eco_tempoTarea
set ACTIVIDAD_ACCION_OBRA_NOMBRE=dbo.doLet(ACTIVIDAD_ACCION_OBRA_NOMBRE) 
where ACTIVIDAD_ACCION_OBRA_NOMBRE in 
(
	select  ACTIVIDAD_ACCION_OBRA_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ACTIVIDAD_ACCION_OBRA_NOMBRE)>0
	group by ACTIVIDAD_ACCION_OBRA_NOMBRE
)

-------------2 / PRODUCTO_PROYECTO_NOMBRE

Update eco_tempoTarea
set PRODUCTO_PROYECTO_NOMBRE=dbo.doLet(PRODUCTO_PROYECTO_NOMBRE) 
where PRODUCTO_PROYECTO_NOMBRE in 
(
	select  PRODUCTO_PROYECTO_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', PRODUCTO_PROYECTO_NOMBRE)>0
	group by PRODUCTO_PROYECTO_NOMBRE
)
 

-------------3 / PRODUCTO_PROYECTO_NOMBRE

Update eco_tempoTarea
set GRUPO_FUNCIONAL_NOMBRE=dbo.doLet(GRUPO_FUNCIONAL_NOMBRE) 
where GRUPO_FUNCIONAL_NOMBRE in 
(
	select  GRUPO_FUNCIONAL_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', GRUPO_FUNCIONAL_NOMBRE)>0
	group by GRUPO_FUNCIONAL_NOMBRE
)
 

-------------4 / META_NOMBRE

Update eco_tempoTarea
set META_NOMBRE=dbo.doLet(META_NOMBRE) 
where META_NOMBRE in 
(
	select  META_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', META_NOMBRE)>0
	group by META_NOMBRE
)
 

-------------5 / SUBGENERICA_DET_NOMBRE

Update eco_tempoTarea
set SUBGENERICA_DET_NOMBRE=dbo.doLet(SUBGENERICA_DET_NOMBRE) 
where SUBGENERICA_DET_NOMBRE in 
(
	select  SUBGENERICA_DET_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', SUBGENERICA_DET_NOMBRE)>0
	group by SUBGENERICA_DET_NOMBRE
)
 

-------------6 / ESPECIFICA_NOMBRE

Update eco_tempoTarea
set ESPECIFICA_NOMBRE=dbo.doLet(ESPECIFICA_NOMBRE) 
where ESPECIFICA_NOMBRE in 
(
	select  ESPECIFICA_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ESPECIFICA_NOMBRE)>0
	group by ESPECIFICA_NOMBRE
)
 
 
-------------7 / ESPECIFICA_NOMBRE

Update eco_tempoTarea
set ESPECIFICA_DET_NOMBRE=dbo.doLet(ESPECIFICA_DET_NOMBRE) 
where ESPECIFICA_DET_NOMBRE in 
(
	select  ESPECIFICA_DET_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ESPECIFICA_DET_NOMBRE)>0
	group by ESPECIFICA_DET_NOMBRE
)
 

-------------8 / ESPECIFICA_NOMBRE

Update eco_tempoTarea
set EJECUTORA_NOMBRE=dbo.doLet(EJECUTORA_NOMBRE) 
where EJECUTORA_NOMBRE in 
(
	select  EJECUTORA_NOMBRE
	from eco_tempoTarea with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', EJECUTORA_NOMBRE)>0
	group by EJECUTORA_NOMBRE
)
 

end try
begin catch
	 set @s_msgError=Cast( (select ERROR_MESSAGE() icod) as varchar(250) )
end catch
---
	return
 


end


if @s_key='letras-n2' begin

begin try


-------- COLUMNAS ACTUALIZAR
/*
1. ACTIVIDAD_ACCION_OBRA_NOMBRE
2. PRODUCTO_PROYECTO_NOMBRE
3. GRUPO_FUNCIONAL_NOMBRE
4. META_NOMBRE
5. SUBGENERICA_DET_NOMBRE
6. ESPECIFICA_NOMBRE
7. ESPECIFICA_DET_NOMBRE
8. EJECUTORA_NOMBRE
*/
--Ã‘ Ñ/  Ã=145 
---Ã“ = 147 / Ó 
---Ã“ = 129 / Á
---‰ = 129 / É
---Ãš = 195 /Ú
---‰ = 141 / í

-------------1 ) / ACTIVIDAD_ACCION_OBRA_NOMBRE
Update eco_tempoTareaN2
set ACTIVIDAD_ACCION_OBRA_NOMBRE=dbo.doLet(ACTIVIDAD_ACCION_OBRA_NOMBRE) 
where ACTIVIDAD_ACCION_OBRA_NOMBRE in 
(
	select  ACTIVIDAD_ACCION_OBRA_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ACTIVIDAD_ACCION_OBRA_NOMBRE)>0
	group by ACTIVIDAD_ACCION_OBRA_NOMBRE
)

-------------2 / PRODUCTO_PROYECTO_NOMBRE

Update eco_tempoTareaN2
set PRODUCTO_PROYECTO_NOMBRE=dbo.doLet(PRODUCTO_PROYECTO_NOMBRE) 
where PRODUCTO_PROYECTO_NOMBRE in 
(
	select  PRODUCTO_PROYECTO_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', PRODUCTO_PROYECTO_NOMBRE)>0
	group by PRODUCTO_PROYECTO_NOMBRE
)
 

-------------3 / PRODUCTO_PROYECTO_NOMBRE

Update eco_tempoTareaN2
set GRUPO_FUNCIONAL_NOMBRE=dbo.doLet(GRUPO_FUNCIONAL_NOMBRE) 
where GRUPO_FUNCIONAL_NOMBRE in 
(
	select  GRUPO_FUNCIONAL_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', GRUPO_FUNCIONAL_NOMBRE)>0
	group by GRUPO_FUNCIONAL_NOMBRE
)
 

-------------4 / META_NOMBRE

Update eco_tempoTareaN2
set META_NOMBRE=dbo.doLet(META_NOMBRE) 
where META_NOMBRE in 
(
	select  META_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', META_NOMBRE)>0
	group by META_NOMBRE
)
 

-------------5 / SUBGENERICA_DET_NOMBRE

Update eco_tempoTareaN2
set SUBGENERICA_DET_NOMBRE=dbo.doLet(SUBGENERICA_DET_NOMBRE) 
where SUBGENERICA_DET_NOMBRE in 
(
	select  SUBGENERICA_DET_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', SUBGENERICA_DET_NOMBRE)>0
	group by SUBGENERICA_DET_NOMBRE
)
 

-------------6 / ESPECIFICA_NOMBRE

Update eco_tempoTareaN2
set ESPECIFICA_NOMBRE=dbo.doLet(ESPECIFICA_NOMBRE) 
where ESPECIFICA_NOMBRE in 
(
	select  ESPECIFICA_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ESPECIFICA_NOMBRE)>0
	group by ESPECIFICA_NOMBRE
)
 
 
-------------7 / ESPECIFICA_NOMBRE

Update eco_tempoTareaN2
set ESPECIFICA_DET_NOMBRE=dbo.doLet(ESPECIFICA_DET_NOMBRE) 
where ESPECIFICA_DET_NOMBRE in 
(
	select  ESPECIFICA_DET_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', ESPECIFICA_DET_NOMBRE)>0
	group by ESPECIFICA_DET_NOMBRE
)
 

-------------8 / ESPECIFICA_NOMBRE

Update eco_tempoTareaN2
set EJECUTORA_NOMBRE=dbo.doLet(EJECUTORA_NOMBRE) 
where EJECUTORA_NOMBRE in 
(
	select  EJECUTORA_NOMBRE
	from eco_tempoTareaN2 with(nolock)
	where
		patindex('%[^ 0-9A-Za-z;:,.()!/\-]%', EJECUTORA_NOMBRE)>0
	group by EJECUTORA_NOMBRE
)
 

end try
begin catch
	 set @s_msgError=Cast( (select ERROR_MESSAGE() icod) as varchar(250) )
end catch
---
	return
 


end

GO
/****** Object:  StoredProcedure [dbo].[pms_ecomin_reducirBD]    Script Date: 08/08/2023 11:03:41 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[pms_ecomin_reducirBD]
as
print 'instrucciones'

/*
use master
--Para Limpiar el Log de Transacciones es necesario realizar un Backup del Log
BACKUP DATABASE [EcoMigrar] TO  DISK = N'Q:\BackupLog.bak' 
WITH NOFORMAT, INIT,  NAME = N'EcoMigrar-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10


Backup log EcoMigrar 
to disk  ='Q:\BackupLog.bak'
--Una vez hecho el backup consultamos el nombre lógico de los archivos del log
--sp_helpdb EcoMigrar
--Antes de truncar el log cambiamos el modelo de recuperación a SIMPLE.

ALTER DATABASE EcoMigrar
SET RECOVERY SIMPLE;
GO
use EcoMigrar
--Reducimos el log de transacciones a  1 MB.
--DBCC SHRINKFILE('EcoMigrar_log', 1);
--Log
DBCC SHRINKFILE ('EcoMigrar_log',0 ,TRUNCATEONLY)
--Mdf
DBCC SHRINKFILE ('EcoMigrar',0 ,TRUNCATEONLY)

GO
--Cambiamos nuevamente el modelo de recuperación a Completo.
ALTER DATABASE EcoMigrar
SET RECOVERY FULL;
GO
*/
GO
