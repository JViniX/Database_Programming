

select cmp_cod, c.smk_rot, cmp_item, i.smk_rot, * from cmp
inner join smk as c on c.smk_cod = cmp.cmp_cod 
inner join smk as i on i.smk_cod = cmp.cmp_item
where  
--cmp_cod = 'CATGEWF'
cmp_item = '1162'
