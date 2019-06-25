select * from mte where mte_serie = '117' and mte_seq = '8693'


SELECT SUM(MMA_VALOR), SUM(MMA_QTD)  FROM MMA
SELECT *  FROM MMA
WHERE
MMA_MAT_COD = '20270' AND
MMA_DATA_MOV >= '2017-01-01 00:00' AND
MMA_TIPO_OPERACAO IN ('E5', 'S5')

use smart
select * from gmm 
select mat_cod Cod, mat_desc_completa Descr, mat_qt_est_atual Estoq_Atual, mat_gmm_cod Grupo, mat_vlr_pm Val_PM_Unit, (mat_vlr_pm * mat_qt_est_atual) Val_TT from mat 
where mat_gmm_cod in ('29', '26', '4', '2', '17', '330', '10', '50', '3', '15')


select mat_cod Cod, mat_desc_completa Descr, mat_gmm_cod Grupo, 
isnull(mat_qt_est_atual,0) Estoq_Atual, 
convert(money, mat_vlr_pm) AS "Valor Unit.", 
replace(cast(ISNULL(mat_vlr_pm,0) * isnull(mat_qt_est_atual,0) as numeric(10,2)),'.',',') AS "Valor TT",
convert(money, (mat_vlr_pm * (convert(money, mat_qt_est_atual)))) ValTT2
from mat 
where 
mat_gmm_cod in ('29', '26', '4', '2', '17', '30', '10', '50', '3', '15')

select distinct(mat_gmm_cod) Grupo, sum(mat_qt_est_atual) Qtd, sum(convert(money, mat_vlr_pm * mat_qt_est_atual)) from mat 
where mat_gmm_cod in ('29', '26', '4', '2', '17', '30', '10', '50', '3', '15')
group by mat_gmm_cod

select * from mat
use stratws
select * from indicadores where nome like '%Medicamentos%'

select * from indicadoressimples where idindicador = 994