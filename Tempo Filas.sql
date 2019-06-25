/*PEGA O VALOR DO TEMPO MÉDIO DE ATENDIMENTO NA PRÉ-CONSULTA
select  sum(datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_FINAL)) / count(PAC.PAC_PRONT)*/
select distinct(PAC.PAC_PRONT), 
       PAC.PAC_NOME, 
	   psv.psv_cod,
	   psv.psv_apel,
	   psv.psv_nome,
       psv.psv_fila_nome, 
       FLE.FLE_DTHR_CHEGADA, 
       FLE.FLE_DTHR_REG, 
       FLE.FLE_DTHR_ATENDIMENTO, 
       FLE.FLE_DTHR_FINAL, datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_FINAL) Atendimento, datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO) Espera
			 FROM PAC, FLE, PSV, str 
			 WHERE FLE.FLE_PSV_COD = PSV.PSV_COD AND 
				   FLE.FLE_PAC_REG = PAC.PAC_REG  AND 
					fle.fle_str_cod = str.str_cod and
					str.str_str_cod = '5' and
					MONTH(FLE.FLE_DTHR_CHEGADA) = 10 and
					YEAR(FLE.FLE_DTHR_CHEGADA) = 2016 and
					--PAC.PAC_PRONT = '234328' and
/*					psv.psv_cod in ('28456', '83429', '11212', '12081', '22455', '11236', '36167', '54321', '41163', '73159', '36166', '11215', '11111', '11211', '11213', '11224', '43669', '1123', '11451', '1236', '7001', '8', '11222', '1145', '11214', '99912')
*/
					psv.psv_cod in ('1122','9355','43667','92245','2845','2044','19150','2518','1707','2036','1885','935','41161','4998','3429','2081','4366','2245','3579','3616')

order by FLE.FLE_DTHR_CHEGADA					
