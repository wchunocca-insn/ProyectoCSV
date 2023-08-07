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
 

