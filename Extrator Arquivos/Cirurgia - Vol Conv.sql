-- Vol Conv
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(50)
Declare @MesAno DateTime

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112)))
Set @Titulo = 'Cirurgias Vol Conv: '+ convert(varchar(2),month(@MesAno))+'/'+convert(varchar(4),year(@MesAno))

EXEC sp_makewebtask 
	@outputfile = 'D:\Extratos\Cirurgias Vol Conv.xls',  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+''/''+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 ''R$ ''+replace(cast(i.smm_vlr as numeric(10,2)),''.'','','') Valor, i.smm_usr_login_lanc Usuário

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg

			WHERE  I.SMM_SFAT in (''F'', ''P'')
			and (i.smm_pacote = ''C'' or i.smm_pacote is null)
			AND C.CNV_CAIXA_FATURA = ''F'' 
			AND O.OSM_CNV NOT in (''SUS'', ''SAD'')
			AND P.SMK_CTF in (''5039'',''6014'',''5020'',''0001'',''5052'',''6012'',''5001'',''5050'',''5016'',''5024'',''6013'',''6006'',''5053'',''6015'')
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG FROM PAC WHERE PAC_NOME LIKE ''%TESTE %'')
			
			AND MONTH(O.OSM_DTHR) = 03
			AND YEAR(O.OSM_DTHR) = 2016
			AND I.SMM_STR = ''EXL''

order by smm_osm_serie, smm_osm'
