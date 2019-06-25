
select smm.smm_osm_serie "OS Serie", smm.smm_osm "OS Num", smm.smm_sfat "Status Fat", smm.smm_str "Cod. Setor", str.str_nome "Setor", 
	smm.smm_med "CRM", psv.psv_nome "Prestador", osm.osm_cnv "Cod. Conv.", cnv.cnv_nome "Convenio", cnv.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(Osm.OSM_DTHR))+'/'+convert(varchar(4),year(osm.OSM_DTHR)) as "MÊS/ANO", convert(varchar, Osm.OSM_DTHR, 103) Data, convert(varchar, Osm.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(smm.smm_vlr as numeric(10,2)),'.',',') Valor, replace(cast((MTE.MTE_DESCONTO/MTE.MTE_VALOR)*100 as decimal(5,2)),'.',',') + '%' DescPerce, 'R$ '+replace(cast((smm.SMM_VLR* (Mte.MTE_DESCONTO/Mte.MTE_VALOR)) as decimal(10,2)),'.',',') DescReal, 'R$ '+replace(cast(smm.SMM_VLR - (smm.SMM_VLR* (Mte.MTE_DESCONTO/Mte.MTE_VALOR)) as decimal(10,2)),'.',',') Pago, smm.smm_usr_login_lanc
from  smm
inner join osm on osm.osm_serie = smm.smm_osm_serie and osm.osm_num = smm.smm_osm
inner join mte on mte.mte_serie = smm.smm_mte_serie and mte.mte_seq = smm.smm_mte_seq
inner join psv on psv.psv_cod = smm.smm_med 
inner join str on str.str_cod = smm.smm_str
inner join cnv on osm.osm_cnv = cnv.cnv_cod
where
smm.smm_osm_serie >= 115 /*and 
smm.smm_sfat = 'f' and
smm.smm_str <> 'CFR' and
osm.osm_cnv <> '51' and
cnv.CNV_CAIXA_FATURA <> 'B'*/
order by smm_osm_serie, smm_osm
