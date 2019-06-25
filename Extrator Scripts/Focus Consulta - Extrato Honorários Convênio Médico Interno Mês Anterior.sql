/*Hono Convênio Medico Interno*/
SELECT O.OSM_SERIE "Série", O.OSM_NUM "Número", I.SMM_SFAT "Status Fat", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, I.SMM_COD "Código", 
		P.SMK_NOME "Descrição", i.smm_med "CRM", crm.psv_nome "Prestador", C.CNV_NOME "Convênio", I.SMM_QT "Qtd.", 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') "Valor", H.HON_SEQ "Rateio No.",

cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(ISNULL(H.HON_PC1,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", 'R$'+replace(cast(ISNULL(H.HON_VL1,0) as numeric(10,2)),'.',',') "R$ Rat Med Exec", ((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0)))*0.88  "R$ Hono Med Exec",
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(ISNULL(H.HON_PC2,0) as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", 'R$'+replace(cast(ISNULL(H.HON_VL2,0) as numeric(10,2)),'.',',') "R$ Rat Med Aux", ((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0)))*0.88 "R$ Hono Med Aux",
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(ISNULL(H.HON_PC6,0) as numeric(10,2)),'.',',')+'%' "% Rat Med solic", 'R$'+replace(cast(ISNULL(H.HON_VL6,0) as numeric(10,2)),'.',',') "R$ Rat Med solic", ((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0)))*0.88 "R$ Hono Med Solic",

			(((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0)))*0.88)+
			(((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0)))*0.88)+
			(((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0)))*0.88) 
"Total Pag Hon R$"
from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
inner join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
inner join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
inner join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
inner join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join CNV as C on O.OSM_CNV = C.CNV_COD 	
inner join psv crm on crm.psv_cod = i.smm_med					
		
where

			O.OSM_DTHR >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
		
			AND I.SMM_SFAT <> 'C'
			AND I.SMM_TIPO_FATURA = 'E'
			AND (I.SMM_STR = 'COL'
				OR I.SMM_STR = 'FC2')
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
				OR I.SMM_MED = '3616'/*TANIA NUNES*/
				OR I.SMM_MED = '4998'/*Nathália Florencio Ferro*/
				OR I.SMM_MED = '41161'/*Viviane Cardoso Santos*/
				OR I.SMM_MED = '903'/*JOSÉ FERREIRA*/)
			AND C.CNV_CAIXA_FATURA = 'F' 
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE '%TESTE %')

			and (ISNULL(H.HON_PC1,0) + ISNULL(H.HON_PC2,0) + ISNULL(H.HON_PC6,0) +  ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL6,0)) <> 0

Order by O.OSM_NUM

