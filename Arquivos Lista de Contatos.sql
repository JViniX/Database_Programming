
/*Hono Convênio Medico Externo*/
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(100)
Declare @Caminho Varchar(100)
Declare @MesAno DateTime
Declare @Comando1 Varchar(1000)

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = GETDATE()
Set @Titulo = 'Todos Pacientes Cadastrados Ate '+ convert(varchar(11),@MesAno)+'.xls'
Set @Caminho = 'D:\Extratos\'+@Titulo
Set @Comando1 =
'
select
convert(varchar(10),PAC_REG)+'' - ''+rtrim(PAC_NOME) "Name",PAC_FONE "HomePhone",PAC_CELULAR "MobilePhone"
from pac
'
EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1