

select
mcc.mcc_doc as documento,
convert(varchar,mcc.mcc_dt,103) as data,
convert(varchar,left(mcc.mcc_mmyy,4)) + '/' + convert(varchar,right(mcc.mcc_mmyy,2)) as competencia,
cfo.cfo_cod, cfo.cfo_nome as classificacao, 
mcc.mcc_obs historico,
sum(mcc.mcc_deb) as entradas,
sum(mcc.mcc_cre) as saidas,

convert(varchar,mcc.mcc_dt_compensa,103) as conciliadoem,
convert(varchar,mcc.mcc_serie) + '-' + convert(varchar,mcc.mcc_lote) as lote,
ccr.ccr_tit as banco,
mcc.mcc_bcp_serie, mcc.mcc_bcp_num,
gcc.gcc_descr as empresa
/*,

*/
into #tempdb

 from mcc 

inner join ccr on mcc_ccr = ccr_cod
inner join gcc on gcc.gcc_cod = ccr.ccr_gcc_cod
inner join cfo on cfo.cfo_cod = mcc.mcc_cfo_cod


where  
mcc_dt_compensa >= '2016-07-01 00:00' and mcc_dt_compensa < '2017-09-01 00:00'
and ccr_fluxo_caixa = 'S' 
and ccr_gcc_cod in (1,5) 
and mcc_tipo = 'R'
--and mcc.mcc_dt_compensa is null
--and ccr.ccr_tit = 'CAIXA H.O.S.'
--and mcc.mcc_serie and mcc.mcc_lote

group by mcc_mmyy, cfo.cfo_cod, cfo.cfo_nome, mcc.mcc_cfo_cod, mcc.MCC_OBS, mcc_bcp_serie, mcc_bcp_num, mcc_dt, mcc_dt_compensa, mcc.MCC_SERIE, mcc.MCC_LOTE, ccr.CCR_TIT,
gcc.GCC_DESCR
order by mcc.mcc_dt, mcc.mcc_bcp_serie, mcc.mcc_bcp_num --, ipg.ipg_cpg_serie, ipg.ipg_cpg_num

--------------------------------------------------------------------------------------------------------
select --documento,
data,
competencia,
cfo_cod, classificacao,
case
	when historico = 'Pagamentos Diversos'
		then 'Pag. a '+ cpg_credor
	else historico
end as historico,
replace(cast((entradas - (
case
	when (saidas <= (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad))))
		then saidas
	when (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad))) is null
		then saidas
	else (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad)))
end
)
) as numeric(10,2)),'.',',') as movimento,
--replace(cast((mcc.mcc_deb - mcc.mcc_cre) as numeric(10,2)),'.',',') as movimento_or,
replace(cast(entradas as numeric(10,2)),'.',',') as entradas,
--mcc.mcc_cre, 
replace(cast(
case
	when (saidas <= (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad))))
		then saidas
	when (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad))) is null
		then saidas
	else (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento + ipg.ipg_valor_ad)))
end
as numeric(10,2)),'.',',') as saidas,

conciliadoem,
lote,
banco,
isnull(convert(varchar,mcc_bcp_serie) + '-' + convert(varchar,mcc_bcp_num),'') as baixa,
empresa

from #tempdb
left join bcp on bcp_serie = mcc_bcp_serie and bcp_num = mcc_bcp_num
left join ipg on ipg_bcp_serie = mcc_bcp_serie and ipg_bcp_num = mcc_bcp_num
left join cpg on cpg_serie = ipg_cpg_serie and ipg_cpg_num = cpg_num
--where

drop table #tempdb


