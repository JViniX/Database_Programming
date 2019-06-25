-- Vol Encaixe novos Pacientes

/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(50)
Declare @MesAno DateTime

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112)))
Set @Titulo = 'Consultas Vol Encaixe novos Pacientes: '+ convert(varchar(2),month(@MesAno))+'/'+convert(varchar(4),year(@MesAno))

EXEC sp_makewebtask 
	@outputfile = 'D:\Extratos\Consultas Vol Encaixe novos Pacientes.xls',  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
select distinct(pac.pac_reg),i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, i.smm_qt Qtd,  pac.pac_nome, convert(varchar, pac.pac_dreg, 103) "Cadastrado em", i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+''/''+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 ''R$ ''+replace(cast(i.smm_vlr as numeric(10,2)),''.'','','') Valor, i.smm_usr_login_lanc "Usuário", fle.fle_marc_extra "Encaixe"

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
--inner join fle f on o.osm_serie = f.fle_osm_serie and o.osm_num = f.fle_osm_num
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg
left join fle on fle.fle_pac_reg = pac.pac_reg

/*(SELECT ISNULL(SUM (I.SMM_QT),0)*/
--select * from fle
--select * from pac

			WHERE  o.OSM_DTHR >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			--and pac.pac_dreg >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			--and pac.pac_dreg < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
			--and fle.fle_marc_extra = ''*''
 
			AND I.SMM_SFAT <> ''C''
			AND  O.OSM_CNV <> ''PFE'' 
			AND  O.OSM_CNV <> ''PCN''
			AND  O.OSM_CNV <> ''PTL''
			AND C.CNV_COD <> ''SUS''
			AND C.CNV_COD <> ''SAD''
			AND I.SMM_TPCOD = ''S''
			AND I.SMM_COD <> ''COPER''
			AND I.SMM_COD <> ''CONSRET''
			AND (I.SMM_STR = ''C1''
			OR I.SMM_STR = ''C2''
			OR I.SMM_STR= ''C3''
			OR I.SMM_STR = ''C4''
			OR I.SMM_STR = ''C5''
			OR I.SMM_STR = ''C6''
			OR I.SMM_STR = ''CTD''
			OR I.SMM_STR = ''CFR''
			OR I.SMM_STR = ''CMU''
			OR I.SMM_STR = ''CN1''
			OR I.SMM_STR = ''CU1''
			OR I.SMM_STR = ''CU2''
			OR I.SMM_STR = ''GON''
			OR I.SMM_STR = ''PC2''
			OR I.SMM_STR = ''PR1''
			OR I.SMM_STR = ''TS'')
			AND P.SMK_CTF <> ''5021''
			AND P.SMK_CTF <> ''5037''
			AND P.SMK_CTF <> ''5023''
			AND P.SMK_CTF <> ''5028''
			AND P.SMK_CTF <> ''5022''
			AND P.SMK_CTF <> ''5043''
			AND P.SMK_CTF <> ''5038''
			AND P.SMK_CTF <> ''1712''
 			AND I.SMM_COD <> ''HONOCIR''
			AND I.SMM_COD <> ''HON''
			AND I.SMM_COD <> ''CONSUCOH'' 
			AND I.SMM_COD NOT LIKE ''MM%''
			AND I.SMM_COD NOT LIKE ''MAT%''
			AND I.SMM_COD <> ''MEDSOL''	
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE ''%TESTE %'')

order by i.smm_osm_serie, i.smm_osm'
