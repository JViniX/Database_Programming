declare @Codigo varchar(10)
declare @TabelaS varchar(3)
declare @TabelaM varchar(3)

set @Codigo = 'CTMA60AC'
set @TabelaS = 'PAC'
set @TabelaM = 'MEP'

select smk_cod, smk_nome, pre_umo_sigla, pre_vlr_p1 from smk
inner join pre on pre_tab_cod = @TabelaS and pre_smk_cod = smk_cod
where smk_cod = @Codigo

select smk_cod, smk_nome, pre_umo_sigla, pre_vlr_p1 from cmp 
inner join smk on cmp_item = smk_cod
inner join pre on pre_tab_cod = @TabelaS and pre_smk_cod = cmp_item
where cmp_cod = @Codigo

select smk_cod, smk_nome, pre_umo_sigla, pre_vlr_p1 from cmp 
inner join smk on cmp_item = smk_cod
inner join pre on pre_tab_cod = @TabelaM and pre_smk_cod = cmp_item
where cmp_cod = @Codigo
--select * from cmp