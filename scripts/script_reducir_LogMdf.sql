 		
		----Reducir tamaño base
		DBCC SHRINKFILE ('EcoMigrar_log',0 ,TRUNCATEONLY)
		DBCC SHRINKFILE (N'EcoMigrar' , 0, TRUNCATEONLY)