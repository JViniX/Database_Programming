
SELECT PAC.PAC_PRONT, pac.pac_reg pac, PAC.PAC_NOME, psv.psv_cod, psv.psv_fila_nome, fle.fle_str_cod, str.str_str_cod, fle.fle_dthr_reg, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_CHEGADA,FLE.FLE_DTHR_FINAL,
	datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO) DuraEsper, datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_FINAL)  DuraçãoAtend, fle.fle_usr_login, fle.fle_usr_atendimento

	/*count(distinct(PAC.PAC_PRONT)) Pacientes, sum(datediff(mi, FLE.FLE_DTHR_CHEGADA, FLE.FLE_DTHR_ATENDIMENTO)) DuraEsper, sum(datediff(mi, FLE.FLE_DTHR_ATENDIMENTO, FLE.FLE_DTHR_FINAL))  DuraçãoAtend*/
 FROM PAC, FLE, PSV, str 
 WHERE FLE.FLE_PSV_COD = PSV.PSV_COD AND 
       FLE.FLE_PAC_REG = PAC.PAC_REG  AND 
		fle.fle_str_cod = str.str_cod and
		str.str_str_cod = 'HOS' and
		MONTH(O.OSM_DTHR) = @MES_ATUAL and
		YEAR(O.OSM_DTHR) = @ANO_ATUAL and
		psv.psv_cod in ('1122','9355','43667','92245','7004','7005','7006','2845','2044','19150','2518','1707','3519','2036','1885','935','41161','4141','1895','4998','3429','2081','3159','4366','2245','3579','3616')

ORDER BY PAC.PAC_PRONT asc, fle.fle_dthr_reg ASC

fle.fle_pac_reg = '251261' 
select psv_cod, psv_fila_nome from psv order by psv_fila_nome asc like '%pré%'
select * from osm where osm_dthr >= '2015-04-17'
select * from fle where psv_fila_nome like '%pre%'
select * from str where str_nome like '%pre%'


declare @dataini datetime
declare @datafim datetime
declare @segundos int
declare @minutos int

set @dataini = '2015-04-01 08:00:00'
set @datafim = '2015-04-02 08:01:59'

select datediff(yy, @dataini, @datafim) ano, datediff(mm, @dataini, @datafim) mes, datediff(dd, @dataini, @datafim) dia, datediff(hh, @dataini, @datafim) hora, datediff(mi, @dataini, @datafim) minu, datediff(ss, @dataini, @datafim) seg
select ((((datediff(yy, @dataini, @datafim)*12)*30)*24)*60)*60 ano, datediff(mm, @dataini, @datafim)*30*24*60*60 mes, datediff(dd, @dataini, @datafim)*24*60*60 dia, (datediff(hh, @dataini, @datafim)*60)*60 hora, datediff(mi, @dataini, @datafim)*60 minu, datediff(ss, @dataini, @datafim) seg

