-- ROB Conv

select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, i.smm_pacote, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor 
/* ,replace(cast((m.MTE_DESCONTO/m.MTE_VALOR)*100 as decimal(5,2)),'.',',') + '%' DescPerce, 'R$ '+replace(cast((i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') DescReal, 'R$ '+replace(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') Pago
*/, i.smm_usr_login_lanc

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
/*inner join mte m on m.mte_serie = i.smm_mte_serie and m.mte_seq = i.smm_mte_seq
inner join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM*/
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg

/*(SELECT ISNULL(SUM (I.SMM_QT),0)*/

			WHERE  /*O.OSM_DTHR >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))

			and (i.smm_pacote = 'P' or i.smm_pacote is null)
			AND (I.SMM_SFAT = 'F' or I.SMM_SFAT = 'P')*/
			--AND C.CNV_CAIXA_FATURA = 'F'
			--AND C.CNV_CAIXA_FATURA = 'C'
			--and M.MTE_STATUS = 'D'

			--AND I.SMM_STR = 'EXL' 
			--AND SMM_PAC_REG NOT IN (SELECT PAC_REG FROM PAC WHERE PAC_NOME LIKE '%TESTE %')
			i.smm_osm_serie = '116'
			and i.smm_osm in
('15454',
'16426',
'22569',
'23330',
'23404',
'14725',
'14735',
'14745',
'14690',
'15849',
'19103',
'23166',
'19157',
'22461',
'22447',
'22450')

order by smm_osm_serie, smm_osm
