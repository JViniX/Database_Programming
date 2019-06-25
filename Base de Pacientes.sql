

USE [smart]
GO
/****** Object:  StoredProcedure [dbo].[up_Extrato_HonoPart]    Script Date: 03/13/2017 18:25:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)


Set @Titulo = 'Base cadastral de pacientes do HOS (incluindo Lagarto).xls' 
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = 
'
select pac_reg Registro, convert(varchar, pac_dreg, 103) DataRegistro, pac_pront Prontuário, pac_nome Nome, pac_sexo Sexo, 
pac_nasc DataNascimento, FLOOR(DATEDIFF(DAY, pac_nasc, GETDATE()) / 365.25) Idade_Hoje, pac_cid Residência,convert(varchar, pac_dult, 103) DataUltAtendimento,
case 
		when pac_pront_status = ''O''
			then ''Óbito'' 
		when pac_pront_status = ''I''
			then ''Inativo''
		else ''Ativo''
end StatusReg
from pac
order by pac_reg
'
EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1

