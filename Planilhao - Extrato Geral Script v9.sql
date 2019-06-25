drop table #Extrato
declare @AnoS Varchar(4)
set @AnoS = '2015'

SELECT  
O.OSM_SERIE "Série", O.OSM_NUM "Número", i.smm_num Seq_OS, I.SMM_SFAT "Status Fat", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
		o.osm_mreq "CRM.Solic", sol.psv_nome "Med.Solic", i.smm_str Cod_Setor, s.str_codorg Setor,
		i.smm_pac_reg "Registro", pac.pac_pront Pront, pac.pac_nome Paciente, i.smm_med "CRM", crm.psv_nome "Prestador", i.smm_aux "CRM.Aux", aux.psv_nome "Med.Aux", 
		O.OSM_CNV CodCNV, C.CNV_NOME "Convênio", pln.pln_nome Plano,
		I.SMM_COD "Código", P.SMK_NOME "Descrição", P.SMK_ROT Rótulo, ctf.ctf_nome "Classe SMK", i.smm_pacote Classif_Item,  
		Case
			when
				(P.SMK_CTF in ('6016','5039','6014','5020','0001','5052','6012','5001','5050','5016','5024','6013','6006','5053','6015') and (i.smm_pacote = 'C' or i.smm_pacote is null) and I.SMM_SFAT <> 'C')  then 'S'
			else 'N'		
		End Volume, CFO.CFO_NOME "Classe FI", 
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0'
			else I.SMM_QT 
		End Qtd,
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0,00'
			else replace(cast(i.smm_vlr as numeric(10,2)),'.',',')
		End Valor,  
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0,00'
			else replace(cast(isnull(I.SMM_AJUSTE_VLR,0) as numeric(10,2)),'.',',')
		End Desconto, 
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0,00'
			else replace(cast((i.smm_vlr + isnull(I.SMM_AJUSTE_VLR,0)) as numeric(10,2)),'.',',')
		End "Valor Pago",
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0,00'
			else replace(cast(isnull(v.V_GLOSA,0) as numeric(10,2)),'.',',')
		End Glosado, 
		Case
			when 
				i.smm_pacote = 'P' or I.SMM_SFAT = 'C'
				then '0,00'
			else replace(cast(isnull(v.V_RECEB,0) as numeric(10,2)),'.',',')
		End Recebido, 
		i.smm_tipo_fatura "Faturado Para", i.smm_usr_login_lanc Usuário, I.SMM_HON_SEQ Rateio

into #Extrato

from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join str as s on i.smm_str = s.str_cod
inner join CTF on P.SMK_CTF = CTF.CTF_COD
inner join CFO on CTF.CTF_CFO_COD = CFO.CFO_COD
inner join CNV as C on O.OSM_CNV = C.CNV_COD 
left join pln on pln.pln_cnv_cod = O.OSM_CNV and pln.pln_cod = o.osm_pln_cod	
inner join psv crm on crm.psv_cod = i.smm_med
inner join psv sol on sol.psv_cod = o.osm_mreq
left join psv aux on aux.psv_cod = i.smm_aux	
inner join pac on pac.pac_reg = i.smm_pac_reg	
left join  V_EXT_TOT v on v.V_OSM_SERIE = i.SMM_OSM_SERIE AND v.V_OSM_NUM = i.SMM_OSM and v.V_SMM_NUM = i.SMM_NUM 

			WHERE  
				--s.str_str_cod <> ''4'' 
				--I.smm_str in ('CC', 'EXL') 
				--and o.osm_dthr >= '2017-06-01 00:00' and O.OSM_DTHR < '2017-07-01 00:00'
				--and PAC.pac_nome not like '%TESTE%'
				O.OSM_SERIE = '117' and O.OSM_NUM = '28537'
                
				--and c.CNV_NOME like ''%FOCUS%''
--and year(O.OSM_DTHR) = 2015

--'2015-01-01 00:00' and O.OSM_DTHR < '2016-01-01 00:00')
				
				
-----------------------

select I.*,

cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(h.hon_pc1 as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", replace(cast(h.hon_vl1 as numeric(10,2)),'.',',') "R$ Rat Med Exec", 
replace((ISNULL(H.HON_PC1,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL1,0)*cast(Qtd as int))),'.',',') MedExePag,
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(h.hon_pc2 as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", replace(cast(h.hon_vl2 as numeric(10,2)),'.',',') "R$ Rat Med Aux", 
replace((ISNULL(H.HON_PC2,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL2,0)*cast(Qtd as int))),'.',',') MedAuxPag,
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(h.hon_pc6 as numeric(10,2)),'.',',')+'%' "% Rat Med solic", replace(cast(h.hon_vl6 as numeric(10,2)),'.',',') "R$ Rat Med solic", 
replace((ISNULL(H.HON_PC6,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL6,0)*cast(Qtd as int))),'.',',') MedSolPag,

replace(cast(
			((ISNULL(H.HON_PC1,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL1,0)*cast(Qtd as int)))
			+(ISNULL(H.HON_PC2,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL2,0)*cast(Qtd as int)))
			+(ISNULL(H.HON_PC6,0)*((cast(replace(Valor,',','.') as numeric(10,2)) + isnull(cast(replace(Desconto,',','.') as numeric(10,2)),0)) - ((ISNULL(H.HON_VL1,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL2,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL3,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL4,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL5,0)*cast(Qtd as int)) + (ISNULL(H.HON_VL6,0)*cast(Qtd as int))))/100)+((ISNULL(H.HON_VL6,0)*cast(Qtd as int))))
as numeric(10,2)),'.',',') "Total Hono Pago R$"

from #Extrato I
left join hon as h on I.Rateio = H.HON_SEQ
left join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
left join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
left join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')

order by Série, Número, Seq_OS





