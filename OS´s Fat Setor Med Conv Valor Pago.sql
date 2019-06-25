
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, p.smk_tipo, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor 
 ,replace(cast((m.MTE_DESCONTO/m.MTE_VALOR)*100 as decimal(5,2)),'.',',') + '%' DescPerce, 'R$ '+replace(cast((i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') DescReal, 'R$ '+replace(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') Pago
, i.smm_usr_login_lanc, M.MTE_STATUS

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
/*inner join mte m on m.mte_serie = i.smm_mte_serie and m.mte_seq = i.smm_mte_seq*/
inner join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg

/*(SELECT ISNULL(SUM (I.SMM_QT),0)*/

			WHERE i.smm_osm_serie = 115 and i.smm_osm = 50646 and 
			M.MTE_STATUS = 'D'
			AND MONTH(O.OSM_DTHR) = 4
			AND YEAR(O.OSM_DTHR) = 2015
			AND I.SMM_SFAT <> 'C'
			AND I.SMM_TPCOD = 'S'
			AND I.SMM_COD <> 'COPER'
			AND I.SMM_COD <> 'CONSRET'
			AND (I.SMM_STR = 'C1'
			OR I.SMM_STR = 'C2'
			OR I.SMM_STR= 'C3'
			OR I.SMM_STR = 'C4'
			OR I.SMM_STR = 'C5'
			OR I.SMM_STR = 'C6'
			OR I.SMM_STR = 'CTD'
			OR I.SMM_STR = 'CFR'
			OR I.SMM_STR = 'CMU'
			OR I.SMM_STR = 'CU1'
			OR I.SMM_STR = 'CU2'
			OR I.SMM_STR = 'GON'
			OR I.SMM_STR = 'PC2'
			OR I.SMM_STR = 'PR1'
			OR I.SMM_STR = 'TS')
			AND P.SMK_CTF <> '5021'
			AND P.SMK_CTF <> '5037'
			AND P.SMK_CTF <> '5023'
			AND P.SMK_CTF <> '5028'
			AND P.SMK_CTF <> '5022'
			AND P.SMK_CTF <> '5043'
			AND P.SMK_CTF <> '5038'
			AND P.SMK_CTF <> '1712'
 			AND I.SMM_COD <> 'HONOCIR'
			AND I.SMM_COD <> 'HON'
			AND I.SMM_COD <> 'CONSUCOH' 
			AND I.SMM_COD NOT LIKE 'MM%'
			AND I.SMM_COD NOT LIKE 'MAT%'
			AND I.SMM_COD <> 'MEDSOL'	
   			
			AND  O.OSM_CNV <> 'PFE' 
			AND  O.OSM_CNV <> 'PCN' 
			AND  O.OSM_CNV <> 'PTL'
			AND C.CNV_CAIXA_FATURA = 'C' 
			AND O.OSM_CNV <> '51' 
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE '%TESTE %')

order by smm_osm_serie, smm_osm


