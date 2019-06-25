
SELECT count(*)
/*select
AGM.AGM_MED as med, 
AGM.AGM_LOC as loc, 
AGM.AGM_HINI as hIni, 
AGM.AGM_DTMRC as hMarc, 
AGM.AGM_CONFIRM_DTHR as hConf, 
AGM.AGM_CANC_DTHR as hCanc, 
AGM.AGM_EXT as ext, 
AGM.AGM_STAT as status, 
AGM.AGM_CONFIRM_STAT as statusConfirmacao, 
PAC.PAC_REG as pacienteCodigo, 
PAC.PAC_EST_CIVIL as pacienteEstadoCivil, 
PAC.PAC_SEXO as pacienteSexo,
PAC.PAC_NUMCPF as pacienteCPF,
PAC.PAC_NUMRG as pacienteRG,   
PAC.PAC_NOME as paciente, 
convert(varchar(15), PAC.PAC_NASC, 103) as pacienteNascimento,
PAC.PAC_FONE as pacienteFone, 
PAC.PAC_FONE2 as pacienteFone2, 
PAC.PAC_CELULAR as pacienteCelular, 
PAC.PAC_EMAIL as pacienteEmail,
AGM.AGM_SMK,
SMK.SMK_ROT as exameRotulo,
SMK.SMK_NOME as exame, 
SMK.SMK_INST as exameInstrucao,   
CTF.CTF_CATEG as tipo,
ESP.ESP_NOME as especialidade,   
PSV.PSV_NOME as medico, 
PSV.PSV_APEL as medicoApelido,
CASE PSV.PSV_COD
WHEN '2044' THEN 'Dr. Danilo Amaral'
WHEN '2518' THEN 'Dr. Fábio Morais'
WHEN '3519' THEN 'Dr. Gustavo Melo'
WHEN '3429' THEN 'Dra. Ana Cândida'
WHEN '2036' THEN 'Dr. Joaquim Fontes' 
END as medicoSMS,
PSV.PSV_EMAIL as medicoEmail,
PSV.PSV_DT_NASC as medicoNascimento,
PSV.PSV_CELULAR as medicoCelular,
PSV.PSV_FONE1 as medicoFone1,
PSV.PSV_FONE2 as medicoFone2,
PSV.PSV_FONE3 as medicoFone3,
PSV.PSV_SEXO as medicoSexo, 
CNV.CNV_NOME as pacienteConvenio,
CASE WHEN ( PAC.PAC_IND_ACEITA_SMS IS NULL OR PAC.PAC_IND_ACEITA_SMS = 'S') THEN 'N' ELSE 'S' END as ignor,
convert(varchar(15), AGM.AGM_HINI, 103) as data,         
AGM.AGM_HINI as hora,
CASE WHEN ( DATEPART(Hh, AGM.AGM_HINI) < 12 ) THEN 'manhã' ELSE 'tarde' END as periodo,
(convert(varchar(15), AGM.AGM_HINI, 103)  + ' ' + convert(varchar(5), AGM.AGM_HINI, 114)) as datahora,
CASE WHEN ( CTF.CTF_CATEG = 'C' ) THEN 'sua consulta' WHEN ( CTF.CTF_CATEG = 'E' ) THEN 'seu exame' ELSE 'seu atendimento' END AS categoria,
PSV.PSV_COD AS prioridade,
CASE WHEN ( CTF.CTF_CATEG = 'C' ) THEN 'Consulta'    WHEN ( CTF.CTF_CATEG = 'E' ) THEN 'Exame' ELSE 'Atendimento' END AS tipoFormatado,
PAC.PAC_OBS,
SMK.SMK_TIPO_CONSULTA,
STR.STR_NOME as setorNome, 
STR.STR_COD as setorCodigo, 
CASE STR_PAI.STR_COD
WHEN '1' THEN 'São José'
WHEN 'HOS' THEN 'São José'
WHEN '4' THEN 'Lagarto-SE'
WHEN '5' THEN 'Centro Médico Jardins'
END as setorPaiNome,  
STR_PAI.STR_COD as setorPaiCodigo
*/
FROM AGM 
INNER JOIN PAC ON AGM.AGM_PAC = PAC.PAC_REG 
INNER JOIN SMK ON AGM.AGM_TPSMK = SMK.SMK_TIPO AND AGM.AGM_SMK = SMK.SMK_COD 
INNER JOIN CTF ON SMK.SMK_TIPO = CTF.CTF_TIPO AND SMK.SMK_CTF = CTF.CTF_COD 
INNER JOIN PSV ON AGM.AGM_MED = PSV.PSV_COD 
INNER JOIN ESM ON ESM.ESM_MED = PSV.PSV_COD 
INNER JOIN ESP ON ESM.ESM_ESP = ESP.ESP_COD  
INNER JOIN LOC ON LOC.LOC_COD = AGM.AGM_LOC  
INNER JOIN STR ON STR.STR_COD = LOC.LOC_STR  
LEFT JOIN STR STR_PAI ON STR.STR_STR_COD = STR_PAI.STR_COD 
LEFT JOIN CNV ON CNV.CNV_COD = PAC.PAC_CNV  

WHERE ( ESM.ESM_DEFAULT = 'S' )  
AND ( AGM.AGM_STAT = 'A'  )
AND ( CTF.CTF_CATEG = 'C' )
and AGM.AGM_SMK in ('CONSMU', '10101012', '00010017')
--AND ( PSV.PSV_COD IN ('2044', '2518', '3519', '3429', '2036')) 
AND AGM.agm_dtmrc >= '2016-06-22 00:00'
AND AGM.agm_dtmrc < '2016-06-23 00:00'


--select * from smk where smk_nome like '%consulta%'
-- and(convert(varchar(15), AGM.AGM_HINI, 102) = convert(varchar(15), getdate() + 1, 102))
--select * from ctf

--order by AGM.AGM_SMK

select agm_stat, count(*) from agm where 
agm_dtmrc >= '2016-05-01 00:00'
AND agm_dtmrc < '2016-06-01 00:00'
group by agm_stat