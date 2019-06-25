

select ind.idindicador, ind.nome, convert(varchar(2),month(ind_s.data))+'/'+convert(varchar(4),year(ind_s.data)) as "MÊS/ANO", replace(cast((nullif(ind_s.valor,0)) as decimal(10,2)),'.',',') Valor, ind_s.DateUpdated
from indicadores as ind 
inner join indicadoressimples as ind_s on ind_s.IDIndicador = ind.idindicador
where ind.nome like '%excimer%'
and ind_s.data >= '2010-01-01' and ind_s.data < '2016-02-01' 

select * from 
AND P.SMK_CTF <> '5021'
			AND P.SMK_CTF <> '5037'
			AND P.SMK_CTF <> '5028'
			AND P.SMK_CTF <> '5023'
			AND P.SMK_CTF <> '5022'
			AND P.SMK_CTF <> '5043'
			AND P.SMK_CTF <> '5038'
			AND P.SMK_CTF <> '1712'




replace(cast(ISNULL(
,0) as numeric(10,3)),''.'','','') "Total Pag Hon R$"

			and (i.smm_pacote = ''C'' or i.smm_pacote is null)
			and I.SMM_SFAT in (''F'', ''P'')

and I.SMM_SFAT in ('F', 'P')


