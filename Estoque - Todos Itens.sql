
select
mat_cod Cod, MAT_DESC_RESUMIDA Descr, mat_del_logica Excluido, mat_ind_consignado Consignado, mat_gmm_cod CodGrupo, gmm.gmm_nome GrpNome, mat_unm_cod_entrada UndEntrada, mat_unm_cod_saida UndSaida, 
convert(varchar, mat_dthr_ult_entrada, 103) DataUltEntrada, convert(varchar(2),month(mat_dthr_ult_entrada))+'/'+convert(varchar(4),year(mat_dthr_ult_entrada)) as "MÊS/ANO DataUltEntrada",
replace(cast(mat_qtd_ult_entrada as numeric(10,2)),'.',',') QtdUltEntrada, replace(cast(mat_prc_ult_entrada as numeric(10,2)),'.',',') PrecoUltEntr, 
convert(varchar, mat_dthr_ult_saida, 103) DataUltSaida, convert(varchar(2),month(mat_dthr_ult_saida))+'/'+convert(varchar(4),year(mat_dthr_ult_saida)) as "MÊS/ANO DataUltSaida", 
replace(cast(mat_vlr_pm as numeric(10,2)),'.',',') PrecoMedio, replace(cast(mat_vlr_pm_corrigido as numeric(10,2)),'.',',') PrecoMedioCorrigido, 
replace(cast(mat_qt_est_atual as numeric(10,2)),'.',',') SaldoAtual, replace(cast(mat_pt_ressuprimento as numeric(10,2)),'.',',') PT_Ressup, replace(cast(mat_pt_seguranca as numeric(10,2)),'.',',') EstoqSeg, mat_ind_curva_abc CurvaABC, 
replace(cast(mat_cons_medio as numeric(10,2)),'.',',') ConsumoMedio, replace(cast((mat_vlr_pm * mat_qt_est_atual) as numeric(10,2)),'.',',') SaldoEmReais,
convert(varchar, mat_dthr_cad, 103) DataCad, convert(varchar(2),month(mat_dthr_cad))+'/'+convert(varchar(4),year(mat_dthr_cad)) as "MÊS/ANO DataCad" 
from mat
left join gmm on gmm_cod = mat_gmm_cod



select * from mat