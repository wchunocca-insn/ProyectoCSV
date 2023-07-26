------------
select imp_nrogrupo,count(*) 
from [dbo].[eco_tempo] with(nolock)
group by imp_nrogrupo order by imp_nrogrupo



------------
select 
(select count(*) from [dbo].[eco_tempo] with(nolock))
------------

--1146

 
 --14 min ,114781
--118269
--11:40- 11:57 ,17min ()
--102874
--12:08-12:30
--158384
--39596.35

--11:32 - 11:50


