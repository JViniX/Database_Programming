select mat_cod, mat_desc_resumida, gmm_nome, sba_nome, etq_quantidade, etl_lot_num, etl_quantidade from mat
inner join gmm on gmm_cod = mat_gmm_cod
inner join etq on etq_mat_cod = mat_cod
inner join sba on sba_cod = etq_sba_cod
left join etl on etl_mat_cod = mat_cod and etl_sba_cod = etq_sba_cod
where 
mat_cod = '32'
--gmm_cod = '15' 
--and etq_quantidade <> 0 
--and (etl_quantidade <> 0 or etl_quantidade is null)
order by gmm_nome, mat_desc_resumida, sba_nome
--and case etl_lot_num when NULL then '' end

--select * from etl where etl_mat_cod = '32'

--select * from ETQ WHERE ETQ_MAT_COD = '32'
