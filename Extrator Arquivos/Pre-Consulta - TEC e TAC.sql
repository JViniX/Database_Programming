/*Hono Convênio Medico Interno*/
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(100)
Declare @Caminho Varchar(100)
Declare @Dia DateTime
Declare @Consulta nVarchar(max)

/*PEGA O ANO E MES ATUAL*/
Set @Dia = DATEADD(D,1-DAY(getdate()),DATEADD(M,-1,CONVERT(varchar(23),getdate(),112)))
Set @Titulo = 'Pré-Consulta TEC e TAC 2016'-- + CONVERT(CHAR(7),@Dia,127)
Set @Caminho = 'D:\Extratos\'+@Titulo+'.xls'

EXEC sp_makewebtask 
	@outputfile = @Caminho,
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
select pac.pac_reg Registro, pac.pac_nome Paciente, psv.psv_fila_nome Fila, fle.fle_dthr_chegada Chegada, fle.fle_dthr_atendimento Inicio_Atend, fle.fle_dthr_final Fim_Atend, datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO) TEC, datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, fle.fle_dthr_final) TAC
			 FROM FLE, PSV, str, PAC 
			 WHERE FLE.FLE_PSV_COD = PSV.PSV_COD AND 
				   FLE.FLE_PAC_REG = PAC.PAC_REG  AND 
					fle.fle_str_cod = str.str_cod and
					str.str_str_cod = ''HOS'' and
					FLE.FLE_DTHR_CHEGADA >= ''2016-01-01'' and
					--DATEADD(D,1-DAY(getdate()),DATEADD(M,-1,CONVERT(varchar(23),getdate(),112))) and       
					--FLE.FLE_DTHR_CHEGADA < DATEADD(D,1-DAY(getdate()),CONVERT(varchar(23),getdate(),112)) and       
					--psv.psv_cod in (''28456'', ''83429'', ''11212'', ''12081'', ''22455'', ''11236'', ''36167'', ''54321'', ''41163'', ''73159'', ''36166'', ''11215'', ''11111'', ''11211'', ''11213'', ''11224'', ''43669'', ''1123'', ''11451'', ''1236'', ''7001'', ''8'', ''11222'', ''1145'', ''11214'', ''99912'')
					psv.psv_cod in (''1122'',''9355'',''43667'',''92245'',''7004'',''7005'',''7006'',''2845'',''2044'',''19150'',''2518'',''1707'',''3519'',''2036'',''1885'',''935'',''41161'',''4141'',''1895'',''4998'',''3429'',''2081'',''3159'',''4366'',''2245'',''3579'',''3616'')
					
order by fle.fle_dthr_chegada'