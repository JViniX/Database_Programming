/*Hono Convênio Medico Interno*/
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(100)
Declare @Caminho Varchar(100)
Declare @Dia DateTime
Declare @Consulta nVarchar(max)

/*PEGA O ANO E MES ATUAL*/
Set @Dia = DATEADD(D,1-DAY(getdate()),DATEADD(M,-1,CONVERT(varchar(23),getdate(),112)))
Set @Titulo = 'Pré-Consulta TER e TAR 2016'-- + CONVERT(CHAR(7),@Dia,127)
Set @Caminho = 'D:\Extratos\'+@Titulo+'.xls'

EXEC sp_makewebtask 
	@outputfile = @Caminho,
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
select pac.pac_reg Registro, pac.pac_nome Paciente, psv.psv_fila_nome Fila, fle.fle_dthr_chegada Chegada, fle.fle_dthr_atendimento Inicio_Atend, fle.fle_dthr_final Fim_Atend, datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO) TER, datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, fle.fle_dthr_final) TAR
			 FROM FLE, PSV, str, PAC 
			 WHERE FLE.FLE_PSV_COD = PSV.PSV_COD AND 
				   FLE.FLE_PAC_REG = PAC.PAC_REG  AND 
					fle.fle_str_cod = str.str_cod and
					str.str_str_cod = ''HOS'' and
					FLE.FLE_DTHR_CHEGADA >= ''2016-01-01'' and
					--DATEADD(D,1-DAY(getdate()),DATEADD(M,-1,CONVERT(varchar(23),getdate(),112))) and       
					--FLE.FLE_DTHR_CHEGADA < DATEADD(D,1-DAY(getdate()),CONVERT(varchar(23),getdate(),112)) and       
					psv.psv_cod in (''853'',''3911'',''9991'',''11113'',''11239'',''28458'',''31168'',''63429'',''99988'',''99991'',''99992'',''99993'',''99994'',''99995'',''99996'',''99997'',''99998'',''411162'',''423003'',''436689'')
					
order by fle.fle_dthr_chegada'