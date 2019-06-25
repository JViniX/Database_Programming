select distinct CONVERT(CHAR(10), FLE.FLE_DTHR_CHEGADA,103) DIA, PAC.PAC_PRONT, psv.psv_fila_nome,
PAC.PAC_NOME as paciente,
		/*PAC.PAC_REG as pacienteCodigo, 
     PAC.PAC_EST_CIVIL as pacienteEstadoCivil, 
     PAC.PAC_SEXO as pacienteSexo,
     PAC.PAC_NUMCPF as pacienteCPF,
     PAC.PAC_NUMRG as pacienteRG,   
     
     PAC.PAC_NASC as pacienteNascimento,
     PAC.PAC_FONE as pacienteFone, 
     PAC.PAC_FONE2 as pacienteFone2, 
     PAC.PAC_CELULAR as pacienteCelular, 
     PAC.PAC_EMAIL as pacienteEmail,
*/
	   psv.psv_apel,
       case psv.psv_fila_nome
		when 'Lydianne/MU' then 'Drª. Lydianne Agra'
		when 'Mônica/MU' then 'Drª. Monica Andrade'
		when 'Naiana/MU' then 'Drª. Naiana Maynart'
		when 'Viviane/MU' then 'Drª  Viviane Cardoso'
		else psv.psv_fila_nome
	   end 'Nome da Fila',

	   case str.str_str_cod
			when 'HOS' then 'HOS - Sao Jose'
			when '4' then 'HOS - Lagarto'
			when '5' then 'HOS - Jardins'
	   end as Unidade
/*,
       FLE.FLE_DTHR_CHEGADA, 
       FLE.FLE_DTHR_REG, 
       FLE.FLE_DTHR_ATENDIMENTO, 
       FLE.FLE_DTHR_FINAL, datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_FINAL) Atendimento, datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO) Espera
*/
			 FROM PAC, FLE, PSV, str 
			 WHERE FLE.FLE_PSV_COD = PSV.PSV_COD AND 
				   FLE.FLE_PAC_REG = PAC.PAC_REG  AND 
					fle.fle_str_cod = str.str_cod and
					FLE.FLE_DTHR_FINAL >= '2016-10-13' and FLE.FLE_DTHR_FINAL < '2016-10-18' and
					psv.psv_cod = '2845' --in ('1122','9355','43667','92245','2845','2044','19150','2518','1707','2036','1885','41161','4998','3429','2081','4366','2245','3579','3616')
					

order by CONVERT(CHAR(10), FLE.FLE_DTHR_CHEGADA,103), PAC.PAC_PRONT, psv.psv_fila_nome --, day(FLE.FLE_DTHR_CHEGADA)

