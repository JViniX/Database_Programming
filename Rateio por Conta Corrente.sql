
declare @OS_Num varchar(6)
declare @OS_Serie varchar(3)

set @OS_Serie = '117'
set @OS_Num ='101107'--'38593'--'38592'--

--select * from mcc where mcc_nfs_num = @OS_Num and mcc_osm_serie = @OS_Serie
--------------------------------------------------------------------------------------------------
select 
mte_osm_serie Série, mte_osm OS, pac_nome Paciente, mcc_dt Data, mcc.mcc_hon_seq Rateio, 
mcc_ccr Conta, ccr.ccr_tit Titular, 'R$ '+replace(cast(mcc.mcc_cre as numeric(10,2)),'.',',') Crédito
--select *
from mcc 
left join ccr on mcc.mcc_ccr = ccr_cod
LEFT join mte m on m.mte_nfs_numero = mcc.mcc_nfs_num and M.MTE_OSM_SERIE = mcc.mcc_serie
LEFT join pac on pac_reg = mte_pac_reg
where --mcc.mcc_hon_seq = '3053'
	--M.MTE_STATUS = 'D' AND
			mte_osm = @OS_Num
			and mte_osm_serie	= @OS_Serie
			--and i.smm_sfat = 'F'
			--and ccr.ccr_tit Titular = '1100'
			and mcc.mcc_hon_seq is not null -- = '2777' --
			--and mcc_dt >= '2016-08-30'
order by mte_serie, mte_osm, mcc.mcc_hon_seq
--------------------------------------------------------------------------------------------------

SELECT O.OSM_SERIE "Série", O.OSM_NUM "Número", I.SMM_SFAT "Status Fat", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, i.smm_str Setor, I.SMM_COD "Código", 
		P.SMK_NOME "Descrição", p.smk_ctf Classe, i.smm_med "CRM", crm.psv_nome "Prestador", C.CNV_NOME "Convênio", 
		I.SMM_QT "Qtd.", 'R$ '+replace(cast(i.smm_vlr as numeric(10,2)),'.',',') Valor,  'R$ '+replace(cast(isnull(I.SMM_AJUSTE_VLR,0) as numeric(10,2)),'.',',') Desconto, 'R$ '+replace(cast((i.smm_vlr + isnull(I.SMM_AJUSTE_VLR,0)) as numeric(10,2)),'.',',') Valor_Pago,
		i.smm_usr_login_lanc Usuário, I.SMM_HON_SEQ "Rateio No.", --M.MTE_STATUS,

cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, '99999') "Conta Med Exec", replace(cast(h.hon_pc1 as numeric(10,2)),'.',',')+'%' "% Rat Med Exec", 'R$ '+replace(cast(h.hon_vl1 as numeric(10,2)),'.',',') "R$ Rat Med Exec", (ISNULL(H.HON_PC1,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL1,0)*I.SMM_QT)) MedExecPag,
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, '99999') "Conta Med Aux", replace(cast(h.hon_pc2 as numeric(10,2)),'.',',')+'%' "% Rat Med Aux", 'R$ '+replace(cast(h.hon_vl2 as numeric(10,2)),'.',',') "R$ Rat Med Aux", (ISNULL(H.HON_PC2,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL2,0)*I.SMM_QT)) MedAuxPag,
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, '99999') "Conta Med solic", replace(cast(h.hon_pc6 as numeric(10,2)),'.',',')+'%' "% Rat Med solic", 'R$'+replace(cast(h.hon_vl6 as numeric(10,2)),'.',',') "R$ Rat Med solic", (ISNULL(H.HON_PC6,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL6,0)*I.SMM_QT)) MedSolPag,

'R$ '+replace(cast(
			((ISNULL(H.HON_PC1,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL1,0)*I.SMM_QT))
			+(ISNULL(H.HON_PC2,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL2,0)*I.SMM_QT))
			+(ISNULL(H.HON_PC6,0)*((I.SMM_VLR + isnull(I.SMM_AJUSTE_VLR,0)) - ((ISNULL(H.HON_VL1,0)*I.SMM_QT) + (ISNULL(H.HON_VL2,0)*I.SMM_QT) + (ISNULL(H.HON_VL3,0)*I.SMM_QT) + (ISNULL(H.HON_VL4,0)*I.SMM_QT) + (ISNULL(H.HON_VL5,0)*I.SMM_QT) + (ISNULL(H.HON_VL6,0)*I.SMM_QT)))/100)+((ISNULL(H.HON_VL6,0)*I.SMM_QT)))
as numeric(10,2)),'.',',') "Total Hono Pago R$"

from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
inner join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
inner join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, '99999')
inner join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, '99999')
inner join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, '99999')
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join CNV as C on O.OSM_CNV = C.CNV_COD 	
inner join psv crm on crm.psv_cod = i.smm_med		
--inner join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM

			WHERE  --I.SMM_SFAT in ('F', 'P') AND
				--and (i.smm_pacote = 'C' or i.smm_pacote is null)
				--AND C.CNV_CAIXA_FATURA = 'C' 
				--AND SMM_PAC_REG IN (SELECT PAC_REG FROM PAC WHERE PAC_NOME LIKE '%TESTE %')
--				AND M.MTE_STATUS = 'D'
				--and p.smk_nome like '%*est%'
				O.OSM_SERIE = @OS_Serie
				and O.OSM_NUM = @OS_Num
				
				--AND MONTH(O.OSM_DTHR) = '+convert(varchar(2),@Mes)+' 
				--AND YEAR(O.OSM_DTHR) = '2014'--'+convert(varchar(4),@Ano)+' 
				--AND I.SMM_STR in ()
				--and (ISNULL(H.HON_PC1,0) + ISNULL(H.HON_PC2,0) + ISNULL(H.HON_PC6,0) +  ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL6,0)) <> 0
				
order by smm_osm_serie, smm_osm

