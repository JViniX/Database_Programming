select 
--count(pac_reg)
pac_reg, pac_fone, pac_fone2, pac_celular, pac_dult
from pac
where 
((pac_fone <> '1' and pac_fone is not null) or
(pac_fone2 <> '1' and pac_fone is not null) or
 (pac_celular <> '1' and pac_fone is not null))
and 
pac_dult >= '2016-01-01'
order by pac_reg