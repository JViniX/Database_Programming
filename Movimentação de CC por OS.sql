select 
mte_osm_serie Série, mte_osm OS, pac_nome, mcc_dt Data, mcc.mcc_hon_seq Rateio, 
mcc_ccr Conta, ccr.ccr_tit Titular, 'R$ '+replace(cast(mcc.mcc_cre as numeric(10,2)),'.',',') Crédito
from mcc 
left join ccr on mcc.mcc_ccr = ccr_cod
inner join mte m on m.mte_nfs_numero = mcc.mcc_nfs_num and M.MTE_OSM_SERIE = mcc.mcc_serie
inner join pac on pac_reg = mte_pac_reg
where 
mcc_dt >= '2015-07-09 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
aND mcc_dt  < '2015-07-10 00:00'
and mcc_hon_seq is not null
order by mte_serie, mte_osm, mcc_ccr


