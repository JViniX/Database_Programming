SELECT SMK_COD, SMK_ROT, CMP_ITEM FROM SMK --WHERE SMK_ROT LIKE '%AUX%'
INNER JOIN CMP ON CMP_COD = SMK_COD
WHERE CMP_ITEM LIKE '%1281%'
ORDER BY CMP_ITEM

SELECT * FROM SMM WHERE SMM_HON_SEQ = '3047'

--UPDATE PRE
SET PRE_TIPO_PRECO_ZERO = 'A'
WHERE PRE_TAB_COD = 'COR'

select smk.smk_nome, * from pre 
inner join smk on PRE_smk_COD = smk_cod
where PRE_TAB_COD = 'PLI'

select * from pre
select * from smk where smk_nome like '%LIO%'

select smm_hon_seq, count(*) from smm where smm_cod = '1281' and 
group by smm_hon_seq

select * from agm