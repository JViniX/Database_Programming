-- hono Part
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", rtrim(s.str_nome) "Setor",
	i.SMM_COD Cod_Serv, p.SMK_NOME Servico, i.smm_qt Qtd, ctf.ctf_nome Classe, pac.pac_reg Registro, pac.pac_nome Paciente, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", 
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor,  'R$ '+replace(cast(I.SMM_AJUSTE_VLR as numeric(10,2)),'.',',') Desconto, 'R$ '+replace(cast((i.smm_vlr + I.SMM_AJUSTE_VLR) as numeric(10,2)),'.',',') Valor_Pago
, i.smm_usr_login_lanc Usuário, M.MTE_STATUS, M.MTE_IND_REC_NF,

H.HON_SEQ "Rateio No.",
cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(ISNULL(H.HON_PC1,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", 'R$'+replace(cast(ISNULL(H.HON_VL1,0) as numeric(10,2)),'.',',') "R$ Rat Med Exec", 'R$ '+replace(cast(((ISNULL(H.HON_PC1,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0))) as numeric(10,2)),'.',',')  "R$ Hono Med Exec",
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(ISNULL(H.HON_PC2,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", 'R$'+replace(cast(ISNULL(H.HON_VL2,0) as numeric(10,2)),'.',',') "R$ Rat Med Aux", 'R$ '+replace(cast(((ISNULL(H.HON_PC2,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))) as numeric(10,2)),'.',',') "R$ Hono Med Aux",
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(ISNULL(H.HON_PC6,0) as numeric(10,2)),'.',',')+'%' "% Rat Med solic", 'R$'+replace(cast(ISNULL(H.HON_VL6,0) as numeric(10,2)),'.',',') "R$ Rat Med solic", 'R$ '+replace(cast(((ISNULL(H.HON_PC6,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0))) as numeric(10,2)),'.',',') "R$ Hono Med Solic",

'R$ '+replace(cast(
			(((ISNULL(H.HON_PC1,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0))))+
			(((ISNULL(H.HON_PC2,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))))+
			(((ISNULL(H.HON_PC6,0)*((I.SMM_VLR + I.SMM_AJUSTE_VLR) - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0)))) 
 as numeric(10,2)),'.',',') "Total Pag Hon R$"

from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
inner join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
inner join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
inner join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
inner join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join CNV as C on O.OSM_CNV = C.CNV_COD 	
inner join psv crm on crm.psv_cod = i.smm_med		
right join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
inner join str s on s.str_cod = i.smm_str	
inner join ctf on p.smk_ctf = ctf.ctf_cod
inner join pac on i.smm_pac_reg = pac.pac_reg	
		
where
		
			O.OSM_DTHR >= '2016-04-01 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < '2016-05-01 00:00'--DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			
			and I.SMM_SFAT in ('F', 'P')
			and (i.smm_pacote = 'C' or i.smm_pacote is null)
			AND C.CNV_CAIXA_FATURA = 'C'
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG FROM PAC WHERE PAC_NOME LIKE '%TESTE %')
			and M.MTE_STATUS = 'D'

			and i.smm_str = 'CC'

--			MONTH(O.OSM_DTHR) = 03
--			AND YEAR(O.OSM_DTHR) = 2016
			--i.smm_osm_serie = '116' AND i.smm_osm = '12968'
			
/*			AND (I.SMM_STR = 'C1'
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
				OR I.SMM_STR = 'TS')*/
			

			and (ISNULL(H.HON_PC1,0) + ISNULL(H.HON_PC2,0) + ISNULL(H.HON_PC6,0) +  ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL6,0)) <> 0

Order by O.OSM_NUM

