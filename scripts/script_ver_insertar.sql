------------
select imp_nrogrupo,count(*) 
from [dbo].[eco_tempo] with(nolock)
group by imp_nrogrupo order by imp_nrogrupo


select imp_nrogrupo,count(*) 
from [dbo].[eco_tempo_N2] with(nolock)
group by imp_nrogrupo order by imp_nrogrupo


------------
select 
(select count(*) from [dbo].[eco_tempo] with(nolock))+
(select count(*) from [dbo].[eco_tempo_N2] with(nolock))n2
------------


 
 --14 min ,114781
--118269
--11:40- 11:57 ,17min ()
--102874
--12:08-12:30
--158384
--39596.35



