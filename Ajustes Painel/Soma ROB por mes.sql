use stratws

--select * from indicadoressimples 

select MONTH(iss.data), replace(cast(sum(iss.valor) as numeric(10,2)),'.',',')
from indicadoressimples iss 
inner join indicadores i on i.idindicador = iss.idindicador 
where i.nome like '%R.O.B%'
and MONTH(iss.data) = 10
AND YEAR(iss.data) = 2015
group by MONTH(iss.data)