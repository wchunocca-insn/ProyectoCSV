------------
select imp_nrogrupo,count(*) 
from [dbo].[eco_tempo] with(nolock)
group by imp_nrogrupo order by imp_nrogrupo
------------
select count(*) from [dbo].[eco_tempo] with(nolock)
------------


 

 




