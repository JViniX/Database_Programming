/*DECLARACAO DE VARIAVEIS*/
DECLARE @MES_ATUAL INT
DECLARE @ANO_ATUAL INT

/*PEGA O ANO E MES ATUAL*/
SET @MES_ATUAL = 2
SET @ANO_ATUAL = 2015


/*Trás todas OS´s e Lentes/Materiais*/
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor, i.SMM_COD, p.SMK_NOME Material, sum(i.smm_qt) Qtd
, replace(cast((m.MTE_DESCONTO/m.MTE_VALOR)*100 as decimal(5,2)),'.',',') + '%' DescPerce, 'R$ '+replace(cast((i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') DescReal, 'R$ '+replace(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),'.',',') Pago, i.smm_usr_login_lanc

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
/*inner join mte m on m.mte_serie = i.smm_mte_serie and m.mte_seq = i.smm_mte_seq*/
inner join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg

			WHERE I.SMM_OSM = O.OSM_NUM
			AND I.SMM_OSM_SERIE = O.OSM_SERIE
			AND M.MTE_OSM_SERIE = O.OSM_SERIE
			AND M.MTE_OSM = O.OSM_NUM
			/*AND M.MTE_STATUS = 'Z'*/
			AND MONTH(O.OSM_DTHR) = @MES_ATUAL
			AND YEAR(O.OSM_DTHR) = @ANO_ATUAL
			AND I.SMM_SFAT <> 'C'
			AND I.SMM_COD = P.SMK_COD 
			AND I.SMM_TPCOD  = P.SMK_TIPO
			AND I.SMM_COD <> '261'
			AND I.SMM_COD <> 'LENTENTR'
			AND I.SMM_COD <> 'ELU'
			AND I.SMM_COD <> 'COPER'
			AND (I.SMM_STR = 'SLC'
			OR I.SMM_STR = 'PRO'
			OR I.SMM_STR = 'LCV')
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE '%TESTE %')



