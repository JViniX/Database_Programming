Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)

Set @Titulo = 'Hon Exames.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = 
'SELECT * FROM hon

where 
[HON_STATUS] = ''S'' 
and [HON_CTF] = 5001
and HON_PSV_SOLIC = 0
'	


EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1