/*Hono Convênio Medico Interno*/

select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", rtrim(s.str_nome) "Setor", case s.str_str_cod when '4' then 'Focus' when '5' then 'CMJ' else s.str_str_cod end as Empresa,
	i.SMM_COD , p.SMK_NOME, i.smm_qt Qtd, i.smm_pacote Pacote, ctf.ctf_nome Classe, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Tipo Cobraca", I.SMM_TIPO_FATURA "Tipo Fatura",
	convert(varchar(2),month(o.OSM_DTHR))+'/'+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor,0,0,'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') ValorPago
--, replace(cast(m.MTE_DESCONTO as numeric(10,2)),'.',',')+'%'  "Desconto OS", 'R$ '+replace(cast(m.MTE_VALOR as numeric(10,2)),'.',',') "Valor OS"
-- ,replace(isnull(cast((m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))*100 as decimal(5,2)),0),'.',',') + '%' DescPerce, 'R$ '+replace(isnull(cast((i.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))) as decimal(10,2)),0),'.',',') DescReal, 'R$ '+replace(isnull(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0))) as decimal(10,2)),i.SMM_VLR),'.',',') Pago
, i.smm_usr_login_lanc, 'n/a','n/a',
--M.MTE_STATUS, M.MTE_IND_REC_NF,
		
H.HON_SEQ "Rateio No.",
cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(ISNULL(H.HON_PC1,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", 'R$'+replace(cast(ISNULL(H.HON_VL1,0) as numeric(10,2)),'.',',') "R$ Rat Med Exec", ((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0)))  "R$ Hono Med Exec",
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(ISNULL(H.HON_PC2,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", 'R$'+replace(cast(ISNULL(H.HON_VL2,0) as numeric(10,2)),'.',',') "R$ Rat Med Aux", ((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))) "R$ Hono Med Aux",
cc3.ccr_tit "Setor Exec", isnull(h.hon_cc3, '99999') "Conta Setor Exec", replace(cast(ISNULL(H.HON_PC3,0) as numeric(10,2)),'.',',')+'%' "% Rat Setor Exec", 'R$'+replace(cast(ISNULL(H.HON_VL3,0) as numeric(10,2)),'.',',') "R$ Rat Setor Exec", ((ISNULL(H.HON_PC3,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL3,0))) "R$ Setor Exec",
cc4.ccr_tit "Empresa", isnull(h.hon_cc4, '99999') "Conta Empresa", replace(cast(ISNULL(H.HON_PC4,0) as numeric(10,2)),'.',',')+'%' "% Rat Empresa", 'R$'+replace(cast(ISNULL(H.HON_VL4,0) as numeric(10,2)),'.',',') "R$ Rat Empresa", ((ISNULL(H.HON_PC4,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL4,0))) "R$ Empresa",
cc5.ccr_tit "Setor Solic", isnull(h.hon_cc5, '99999') "Conta Setor Solic", replace(cast(ISNULL(H.HON_PC5,0) as numeric(10,2)),'.',',')+'%' "% Rat Setor Solic", 'R$'+replace(cast(ISNULL(H.HON_VL5,0) as numeric(10,2)),'.',',') "R$ Rat Setor Solic", ((ISNULL(H.HON_PC5,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL5,0))) "R$ Setor Solic",
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(ISNULL(H.HON_PC6,0) as numeric(10,2)),'.',',')+'%' "% Rat Med solic", 'R$'+replace(cast(ISNULL(H.HON_VL6,0) as numeric(10,2)),'.',',') "R$ Rat Med solic", ((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0))) "R$ Hono Med Solic",

			(((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0))))+
			(((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))))+
			(((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0)))) 
"Total Pag Hon R$"

--SELECT ISNULL(SUM (I.smm_vlr),0)
from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
right join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
right join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
right join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
right join ccr as cc3 on cc3.ccr_cod = isnull(h.hon_cc3, '99999')
right join ccr as cc4 on cc4.ccr_cod = isnull(h.hon_cc4, '99999')
right join ccr as cc5 on cc5.ccr_cod = isnull(h.hon_cc5, '99999')
right join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join CNV as C on O.OSM_CNV = C.CNV_COD 	
inner join psv crm on crm.psv_cod = i.smm_med	
inner join str s on s.str_cod = i.smm_str	
inner join ctf on p.smk_ctf = ctf.ctf_cod
inner join pac on i.smm_pac_reg = pac.pac_reg					
		
			--O.OSM_DTHR >= '2015-01-01 00:00:00' --DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			--AND O.OSM_DTHR < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			
			WHERE  
			/*MONTH(O.OSM_DTHR) = 12
			AND YEAR(O.OSM_DTHR) = 2015
			and (i.smm_pacote = 'P' or i.smm_pacote is null)
			AND (I.SMM_SFAT = 'F' or I.SMM_SFAT = 'P')
			AND C.CNV_CAIXA_FATURA = 'F'*/
			i.smm_osm_serie = '115' and 
			i.smm_osm = '122457'


			--and i.smm_vlr <> 0
			--AND C.CNV_CAIXA_FATURA = 'F' 
			
			/*AND I.SMM_SFAT <> 'C'
			AND I.SMM_TIPO_FATURA = 'E'
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
			AND I.SMM_COD <> 'CONSUCOH' 
			AND (I.SMM_MED = '2845'/*ALLAN LUZ*/
				OR I.SMM_MED = '3429'/*Ana Candida*/
				OR I.SMM_MED = '2081'/*CLÉCIA VILANOVA*/
				OR I.SMM_MED = '2044'/*DANILO AMARAL*/
				OR I.SMM_MED = '19150'/*EUDO MENDONÇA*/
				OR I.SMM_MED = '2518'/*FÁBIO MORAIS*/
				OR I.SMM_MED = '1707'/*FÁBIO RIBAS*/
				OR I.SMM_MED = '3519'/*GUSTAVO MELO*/
				OR I.SMM_MED = '2036'/*JOAQUIM FONTES*/
				OR I.SMM_MED = '4366'/*Lydianne Lumack do Monte Agra*/
				OR I.SMM_MED = '1885'/*MÁRCIO PIMENTA*/
				OR I.SMM_MED = '935'/*MÁRIO URSULINO*/
				OR I.SMM_MED = '2245'/*MÕNICA ANDRADE*/
				OR I.SMM_MED = '3579'/*NAYANA MAYNART*/
				OR I.SMM_MED = '4998'/*Nathália Florencio Ferro*/
				OR I.SMM_MED = '41161'/*Viviane Cardoso Santos*/
				OR I.SMM_MED = '3616'/*TANIA NUNES*/
				OR I.SMM_MED = '903'/*JOSÉ FERREIRA*/)
			AND  O.OSM_CNV <> 'PFE' 
			AND  O.OSM_CNV <> 'PCN' 
			AND  O.OSM_CNV <> 'PTL'
			
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE '%TESTE %')*/

			--and (ISNULL(H.HON_PC1,0) + ISNULL(H.HON_PC2,0) + ISNULL(H.HON_PC6,0) +  ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL6,0)) <> 0

--Order by O.OSM_NUM

