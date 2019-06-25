-- Geral ROB Part
--SET ARITHABORT OFF 
--SET ANSI_WARNINGS OFF
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", case s.str_str_cod when '4' then 'Focus' when '5' then 'CMJ' else s.str_str_cod end as Empresa,
	i.SMM_COD , p.SMK_NOME, p.smk_pacote, i.smm_pacote, ctf.ctf_nome Classe, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Tipo Cobraca", I.SMM_TIPO_FATURA "Tipo Fatura",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor 

,replace(isnull(cast((m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))*100 as decimal(5,2)),0),'.',',') + '%' DescPerce, 'R$ '+replace(isnull(cast((i.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))) as decimal(10,2)),0),'.',',') DescReal, 'R$ '+replace(isnull(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))) as decimal(10,2)),i.SMM_VLR),'.',',') Pago
, i.smm_usr_login_lanc, M.MTE_STATUS

SELECT ISNULL(SUM (I.SMM_VLR),0)
--SELECT ISNULL(SUM (I.SMM_VLR - (I.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0)))),0)
from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
/*inner join mte m on m.mte_serie = i.smm_mte_serie and m.mte_seq = i.smm_mte_seq*/
--right join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join smk p on i.SMM_COD = p.SMK_COD AND i.SMM_TPCOD = p.SMK_TIPO
inner join ctf on p.smk_ctf = ctf.ctf_cod
inner join pac on i.smm_pac_reg = pac.pac_reg

			WHERE  MONTH(O.OSM_DTHR) = @MES_ATUAL
			AND YEAR(O.OSM_DTHR) = @ANO_ATUAL
			and (i.smm_pacote = 'P' or i.smm_pacote is null)
			AND (I.SMM_SFAT = 'F' or I.SMM_SFAT = 'P')
			and i.smm_str = 'CC'
			AND C.CNV_CAIXA_FATURA = 'F'
			--and M.MTE_STATUS = 'D'

			

--select * from str

order by smm_osm_serie, smm_osm

--select 0/1* from mte where mte_pac_reg = '468648'
--mte_status = 'Z' order by mte_dthr

