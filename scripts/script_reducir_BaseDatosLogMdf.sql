Create procedure pms_ecomin_reducirBD
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