
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", 
	c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor 
 ,replace(cast((m.MTE_DESCONTO/m.MTE_VALOR)*100 as decimal(5,2)),'.',',') + '%' DescPerce, 'R$ '+replace(cast((i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') DescReal, 'R$ '+replace(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') Pago
/*, mcc.mcc_usr_login
, mcc.mcc_hon_seq Rateio, ccr.ccr_tit Titular, 'R$ '+replace(cast(mcc.mcc_cre as numeric(10,2)),'.',',') Crédito
*/
from  mcc
inner join mte m on m.mte_nfs_numero = mcc.mcc_nfs_num and M.MTE_OSM_SERIE = mcc.mcc_serie and mcc.mcc_hon_seq is not null
inner join osm o on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
inner join smm i on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = mcc.mcc_str_cod
inner join cnv c on mcc.mcc_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg
right join ccr on mcc.mcc_ccr = ccr_cod

/*(SELECT ISNULL(SUM (I.SMM_QT),0)*/

			where --
			--AND I.SMM_SFAT <> 'C'
			--
			--O.OSM_DTHR >= '2015-06-11 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			--AND O.OSM_DTHR < '2015-06-12 00:00' --DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			O.OSM_NUM = '24820'
			and O.OSM_SERIE	= '116'
			--and 
			and i.smm_sfat = 'F'
			and M.MTE_STATUS = 'D'
			--and mcc.mcc_hon_seq = 2807--is not null
			--and M.MTE_IND_REC_NF = 'F'

order by i.smm_osm_serie, i.smm_osm