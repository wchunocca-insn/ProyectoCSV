 
/****** Object:  Table [dbo].[BD_FUNCION_SALUD_GR_Limpio]    Script Date: 26/07/2023 23:18:22 ******/
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
