 

/****** Object:  Table [dbo].[eco_tempoTarea_error]    Script Date: 31/07/2023 11:33:29 p.m. ******/
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


