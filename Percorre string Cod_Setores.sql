declare @COD_IND INT
declare @Setor NVARCHAR(50)
declare @Cod_Setores NVARCHAR(500)
Declare @Contador int

Set @Contador = 1

while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
Begin
	Select @Setor = Nome, @Cod_Setores = Cod_Setores from validasmart.dbo.setores where idx = @Contador
	create table #tempteste (idx int identity(1,1),nome varchar(30),cod_setor varchar(5)) set identity_insert #tempteste on
	Insert into #tempteste (idx, cod_setor) select * from StringToTable(@Cod_Setores,',')
	update str set str_codorg = @Setor where str_cod in (select cod_setor from #tempteste)
	drop table #tempteste
	Print (@Setor)
	Set @Contador = @Contador + 1
end
--drop table #tempteste
--select * from #tempteste
--select * from validasmart.dbo.setores

--select * from str

select * from gcc
