
SELECT year(O.OSM_DTHR), s.str_nome, sum(I.SMM_QT)
		from SMM I, CNV C, SMK P, OSM O, STR S 
			WHERE I.SMM_OSM = O.OSM_NUM
			AND I.SMM_OSM_SERIE = O.OSM_SERIE
			AND I.SMM_COD = P.SMK_COD 
			AND I.SMM_TPCOD  = P.SMK_TIPO
   			AND O.OSM_CNV = C.CNV_COD 
			and s.str_cod = i.smm_str
			and O.OSM_CNV in ('SUS', 'SAD')
			AND O.OSM_DTHR >= '2010-01-01 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < '2016-01-01 00:00'--DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			AND I.SMM_SFAT = 'F'
			AND C.CNV_CAIXA_FATURA = 'F'
			AND I.SMM_TPCOD = 'S'
			AND I.SMM_COD <> 'COPER'
			--AND I.SMM_STR = 'EXL' 
			AND P.SMK_CTF <> '5021'
			AND P.SMK_CTF <> '5037'
			AND P.SMK_CTF <> '5023'
			AND P.SMK_CTF <> '5022'
			AND P.SMK_CTF <> '5043'
			AND P.SMK_CTF <> '5038'
			AND P.SMK_CTF <> '1712'
 			AND I.SMM_COD <> 'HONOCIR'
			AND I.SMM_COD <> 'COPER'
			AND I.SMM_COD <> 'HON'
			AND I.SMM_COD <> 'TAXA'
			and I.SMM_COD not in ('VITREPOS', 'VITRESUS', 'PACSUSV', 'PACVITSU', 'TRANSSUS', 'LENSX', 'FEMTO')
			AND I.SMM_COD NOT LIKE 'MM%'
			AND I.SMM_COD NOT LIKE 'MAT%'
			AND I.SMM_COD <> 'MEDSOL'
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE '%TESTE %')

group by year(O.OSM_DTHR), s.str_nome
order by year(O.OSM_DTHR), s.str_nome