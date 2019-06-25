
SELECT O.OSM_SERIE "Série", O.OSM_NUM "Número", i.smm_num Seq_OS, I.SMM_SFAT "Status Fat", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
		o.osm_mreq "CRM.Solic", sol.psv_nome "Med.Solic", i.smm_str Cod_Setor, s.str_codorg Setor,
		i.smm_pac_reg "Registro", pac.pac_pront Pront, pac.pac_nome Paciente, i.smm_med "CRM", crm.psv_nome "Prestador", i.smm_aux "CRM.Aux", aux.psv_nome "Med.Aux", 
		O.OSM_CNV CodCNV, C.CNV_NOME "Convênio", pln.pln_nome Plano,
		I.SMM_COD "Código", P.SMK_NOME "Descrição", P.SMK_ROT Rótulo, ctf.ctf_nome "Classe SMK", i.smm_pacote Classif_Item,  
		Case
			when
				P.SMK_CTF in ('6016','5039','6014','5020','0001','5052','6012','5001','5050','5016','5024','6013','6006','5053','6015') then 'S'
			else 'N'		
		End Volume, CFO.CFO_NOME "Classe FI", I.SMM_QT "Qtd.",		
		replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor,  replace(cast(isnull(I.SMM_AJUSTE_VLR,0) as numeric(10,2)),'.',',') Desconto, replace(cast((i.smm_vlr + isnull(I.SMM_AJUSTE_VLR,0)) as numeric(10,2)),'.',',') Valor_Pago,
		--replace(cast(isnull(ext.ext_valor_glosa,0) as numeric(10,2)),'.',',') Glosado, replace(cast(isnull(ext_valor_receb,0) as numeric(10,2)),'.',',') Recebido,  
		replace(cast(isnull(v.V_GLOSA,0) as numeric(10,2)),'.',',') Glosado, replace(cast(isnull(v.V_RECEB,0) as numeric(10,2)),'.',',') Recebido, 
		i.smm_tipo_fatura "Faturado Para", i.smm_usr_login_lanc Usuário, H.HON_SEQ "Rateio No.",

cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(h.hon_pc1 as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", 'R$ '+replace(cast(h.hon_vl1 as numeric(10,2)),'.',',') "R$ Rat Med Exec", (ISNULL(H.HON_PC1,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL1,0)*I.SMM_QT)) MedExePag,
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(h.hon_pc2 as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", 'R$ '+replace(cast(h.hon_vl2 as numeric(10,2)),'.',',') "R$ Rat Med Aux", (ISNULL(H.HON_PC2,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL2,0)*I.SMM_QT)) MedAuxPag,
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(h.hon_pc6 as numeric(10,2)),'.',',')+'%' "% Rat Med solic", 'R$'+replace(cast(h.hon_vl6 as numeric(10,2)),'.',',') "R$ Rat Med solic", (ISNULL(H.HON_PC6,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL6,0)*I.SMM_QT)) MedSolPag,

'R$ '+replace(cast(
			((ISNULL(H.HON_PC1,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL1,0)*I.SMM_QT))
			+(ISNULL(H.HON_PC2,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL2,0)*I.SMM_QT))
			+(ISNULL(H.HON_PC6,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL6,0)*I.SMM_QT)))
as numeric(10,2)),'.',',') "Total Hono Pago R$"

--select sum(v.V_GLOSA)
from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
left join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
left join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
left join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
left join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')
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
--left join  EXT on ext.ext_OSM_SERIE = i.SMM_OSM_SERIE AND ext.ext_OSM_NUM = i.SMM_OSM and ext.ext_SMM_NUM = i.SMM_NUM 
left join  V_EXT_TOT v on v.V_OSM_SERIE = i.SMM_OSM_SERIE AND v.V_OSM_NUM = i.SMM_OSM and v.V_SMM_NUM = i.SMM_NUM 
--left join mog on EXT.EXT_MOG_COD = MOG.MOG_COD

			WHERE  I.SMM_SFAT <> 'C' --in ('F', 'P')
				--and (i.smm_pacote = 'C' or i.smm_pacote is null)
				--AND SMM_PAC_REG NOT IN (SELECT PAC_REG FROM PAC WHERE PAC_NOME LIKE '%TESTE %')
				--AND (M.MTE_STATUS = ''D'' or M.MTE_STATUS is null)
				--and s.str_str_cod <> '4'
				--and s.str_cod in (''CC'')
				--and c.cnv_nome like '%SUS%'
				--and o.OSM_NUM = '118243' and o.OSM_SERIE = '116'
				and (O.OSM_DTHR >= '2017-01-01 00:00' and O.OSM_DTHR < '2017-02-01 00:00')
				--and I.SMM_COD in  ( '405010010', '405010079', '405010206', '405040202', '405050216', '405050364', '405010184')
				--and P.SMK_cod like '%09603055%'
				--and CTF.ctf_nome like '%cirurgia%'

order by smm_osm_serie, smm_osm, i.SMM_NUM

