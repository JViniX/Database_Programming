/*
select * from bcp where bcp_serie = '116' and bcp_num = '5708'
select cpg_credor, *  from ipg  --ipg_cpg_num = '2271' and ipg_cpg_serie = '117'
inner join cpg on cpg_serie = ipg_cpg_serie and ipg_cpg_num = cpg_num
where ipg_bcp_serie = '116' and ipg_bcp_num = '5708'
*/

select
mcc.mcc_doc as documento,
convert(varchar,mcc.mcc_dt,103) as data,
convert(varchar,left(mcc.mcc_mmyy,4)) + '/' + convert(varchar,right(mcc.mcc_mmyy,2)) as competencia,
cfo.cfo_cod,cfo.cfo_nome as classificacao,
ipg.ipg_cfo_cod,
case
	when mcc.mcc_obs = 'Pagamentos Diversos'
		then 'Pag. a '+ cpg_credor
	else mcc.mcc_obs
end as historico,
--mcc.mcc_obs historico,
replace(cast((mcc.mcc_deb - (
case
	when (mcc.mcc_cre <= (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento))))
		then mcc.mcc_cre
	when (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento))) is null
		then mcc.mcc_cre
	else (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento)))
end
)
) as numeric(10,2)),'.',',') as movimento,
--replace(cast((mcc.mcc_deb - mcc.mcc_cre) as numeric(10,2)),'.',',') as movimento_or,
replace(cast(mcc.mcc_deb as numeric(10,2)),'.',',') as entradas,
--mcc.mcc_cre, 
replace(cast(
case
	when (mcc.mcc_cre <= (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento))))
		then mcc.mcc_cre
	when (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento))) is null
		then mcc.mcc_cre
	else (ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa + ipg.ipg_desp_ac) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento)))
end
as numeric(10,2)),'.',',') as saidas,

convert(varchar,mcc.mcc_dt_compensa,103) as conciliadoem,
convert(varchar,mcc.mcc_serie) + '-' + convert(varchar,mcc.mcc_lote) as lote,
ccr.ccr_tit as banco,
isnull(convert(varchar,mcc.mcc_bcp_serie) + '-' + convert(varchar,mcc.mcc_bcp_num),'') as baixa,
gcc.gcc_descr as empresa
,
convert(varchar,bcp.bcp_dthr,103) as DataBaixa,
bcp.bcp_nomial_a Nominal,
bcp.bcp_tipo_pag Tipo_Pag,
isnull(convert(varchar,ipg.ipg_cpg_serie) + '-' + convert(varchar,ipg.ipg_cpg_num),'') as Compromisso,
cpg.cpg_credor Credor,
replace(cast(ipg.ipg_valor as numeric(10,2)),'.',',') as Comp_Valor,
replace(cast((ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento) as numeric(10,2)),'.',',') as Comp_Desc,
replace(cast((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa) as numeric(10,2)),'.',',') as Comp_Multa,
replace(cast(ipg.ipg_valor + ((ipg.ipg_valor_cpg_Multa + ipg.ipg_valor_multa) - (ipg.ipg_valor_cpg_desc + ipg.ipg_valor_complemento)) as numeric(10,2)),'.',',') as Comp_Val_Pago,
ipg.ipg_status Status_Pgto,
convert(varchar,ipg.ipg_dt_pgto,103) as Data_Pgto


 from mcc 

inner join ccr on mcc_ccr = ccr_cod
inner join gcc on gcc.gcc_cod = ccr.ccr_gcc_cod
inner join cfo on cfo.cfo_cod = mcc.mcc_cfo_cod
left join bcp on bcp_serie = mcc_bcp_serie and bcp_num = mcc_bcp_num
left join ipg on ipg_bcp_serie = mcc_bcp_serie and ipg_bcp_num = mcc_bcp_num
left join cpg on cpg_serie = ipg_cpg_serie and ipg_cpg_num = cpg_num
where  
mcc_dt_compensa >= '2017-04-28 00:00' and mcc_dt_compensa < '2017-04- 29 00:00'
and ccr_fluxo_caixa = 'S' and ccr_gcc_cod in (1,5)
and ccr.ccr_tit = 'CAIXA H.O.S.'
and mcc_tipo = 'R'
--and mcc.mcc_serie and mcc.mcc_lote

--group by mcc_mmyy, cfo.cfo_cod, cfo.cfo_nome, mcc.MCC_OBS, mcc_bcp_serie, mcc_bcp_num, mcc_dt

order by mcc.mcc_dt, mcc.mcc_bcp_serie, mcc.mcc_bcp_num, ipg.ipg_cpg_serie, ipg.ipg_cpg_num


------ Quantidade das Classificações ------
select cfo.cfo_nome Classificação, count(*) Qtd
 from mcc 

inner join ccr on mcc_ccr = ccr_cod
inner join gcc on gcc.gcc_cod = ccr.ccr_gcc_cod
inner join cfo on cfo.cfo_cod = mcc.mcc_cfo_cod

where  
mcc_dt_compensa >= '2017-07-01 00:00' and mcc_dt_compensa < '2017-09-01 00:00'
and ccr_fluxo_caixa = 'S' 
and ccr_gcc_cod in (1,5) 
and mcc_tipo = 'R'
--and mcc.mcc_dt_compensa is null
--and ccr.ccr_tit = 'CAIXA H.O.S.'
--and mcc.mcc_serie and mcc.mcc_lote

group by cfo.cfo_nome

