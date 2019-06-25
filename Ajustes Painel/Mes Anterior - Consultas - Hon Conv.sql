/*Hono Convênio Medico Interno*/
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(100)
Declare @Caminho Varchar(100)
Declare @Dia DateTime
Declare @DataIni DateTime
Declare @DataFim DateTime
Declare @Setor Varchar(500)
Declare @Consulta nVarchar(max)

Set @Setor = 'and (I.SMM_STR = ''C1''
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
				OR I.SMM_STR = ''TS'''+')'


Set @Dia = GETDATE() 
Set @DataIni = DATEADD(D,1-DAY(@Dia),DATEADD(M,-1,CONVERT(varchar(23),@Dia,112))) 
Set @DataFim = DATEADD(D,1-DAY(@Dia),CONVERT(varchar(23),@Dia,112))
Set @Titulo = 'Consultas Matriz Honorários Convênios '+ CONVERT(CHAR(7),@DataIni,120)
Set @Caminho = 'D:\Extratos\'+@Titulo+'.xls'
Set @Consulta = '
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", rtrim(s.str_nome) "Setor", case s.str_str_cod when ''4'' then ''Focus'' when ''5'' then ''CMJ'' else s.str_str_cod end as Empresa,
	i.SMM_COD Cod, p.SMK_NOME Serviço, i.smm_qt Qtd, i.smm_pacote Pacote, ctf.ctf_nome Classe, pac.pac_reg Registro, pac.pac_nome Paciente, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Tipo Cobraca", I.SMM_TIPO_FATURA "Tipo Fatura",
	convert(varchar(2),month(o.OSM_DTHR))+''/''+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
''R$ ''+replace(cast(i.smm_vlr as numeric(10,2)),''.'','','') ValorPago, i.smm_usr_login_lanc "Usuário", 

H.HON_SEQ "Rateio No.",
cc1.ccr_tit "Med Exec", isnull(h.hon_cc1, ''99999'') "Conta Med Exec", replace(cast(ISNULL(H.HON_PC1,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Med Exec", ''R$''+replace(cast(ISNULL(H.HON_VL1,0) as numeric(10,2)),''.'','','') "R$ Rat Med Exec", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0))),0) as numeric(10,2)),''.'','','')  "R$ Hono Med Exec",
cc2.ccr_tit "Med Aux", isnull(h.hon_cc2, ''99999'') "Conta Med Aux", replace(cast(ISNULL(H.HON_PC2,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Med Aux", ''R$''+replace(cast(ISNULL(H.HON_VL2,0) as numeric(10,2)),''.'','','') "R$ Rat Med Aux", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))),0) as numeric(10,2)),''.'','','') "R$ Hono Med Aux",
cc3.ccr_tit "Setor Exec", isnull(h.hon_cc3, ''99999'') "Conta Setor Exec", replace(cast(ISNULL(H.HON_PC3,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Setor Exec", ''R$''+replace(cast(ISNULL(H.HON_VL3,0) as numeric(10,2)),''.'','','') "R$ Rat Setor Exec", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC3,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL3,0))),0) as numeric(10,2)),''.'','','') "R$ Setor Exec",
cc4.ccr_tit "Empresa", isnull(h.hon_cc4, ''99999'') "Conta Empresa", replace(cast(ISNULL(H.HON_PC4,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Empresa", ''R$''+replace(cast(ISNULL(H.HON_VL4,0) as numeric(10,2)),''.'','','') "R$ Rat Empresa", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC4,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL4,0))),0) as numeric(10,2)),''.'','','') "R$ Empresa",
cc5.ccr_tit "Setor Solic", isnull(h.hon_cc5, ''99999'') "Conta Setor Solic", replace(cast(ISNULL(H.HON_PC5,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Setor Solic", ''R$''+replace(cast(ISNULL(H.HON_VL5,0) as numeric(10,2)),''.'','','') "R$ Rat Setor Solic", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC5,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL5,0))),0) as numeric(10,2)),''.'','','') "R$ Setor Solic",
cc6.ccr_tit "Med solic", isnull(h.hon_cc6, ''99999'') "Conta Med solic", replace(cast(ISNULL(H.HON_PC6,0) as numeric(10,2)),''.'','','')+''%'' "% Rat Med solic", ''R$''+replace(cast(ISNULL(H.HON_VL6,0) as numeric(10,2)),''.'','','') "R$ Rat Med solic", ''R$''+replace(cast(ISNULL(((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0))),0) as numeric(10,2)),''.'','','') "R$ Hono Med Solic",
''R$''+replace(cast(ISNULL(
			(((ISNULL(H.HON_PC1,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL1,0))))+
			(((ISNULL(H.HON_PC2,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL2,0))))+
			(((ISNULL(H.HON_PC6,0)*(I.SMM_VLR - (ISNULL(H.HON_VL1,0) + ISNULL(H.HON_VL2,0) + ISNULL(H.HON_VL3,0) + ISNULL(H.HON_VL4,0) + ISNULL(H.HON_VL5,0) + ISNULL(H.HON_VL6,0)))/100)+(ISNULL(H.HON_VL6,0))))
,0) as numeric(10,2)),''.'','','') 
"Total Pag Hon R$"

--SELECT ISNULL(SUM (I.smm_vlr),0)
from osm as o
inner join smm as i on I.SMM_OSM = O.OSM_NUM AND I.SMM_OSM_SERIE = O.OSM_SERIE	
right join hon as h on I.SMM_HON_SEQ = H.HON_SEQ
right join ccr as cc1 on cc1.ccr_cod = isnull(h.hon_cc1, ''99999'')
right join ccr as cc2 on cc2.ccr_cod = isnull(h.hon_cc2, ''99999'')
right join ccr as cc3 on cc3.ccr_cod = isnull(h.hon_cc3, ''99999'')
right join ccr as cc4 on cc4.ccr_cod = isnull(h.hon_cc4, ''99999'')
right join ccr as cc5 on cc5.ccr_cod = isnull(h.hon_cc5, ''99999'')
right join ccr as cc6 on cc6.ccr_cod = isnull(h.hon_cc6, ''99999'')
inner join SMK as P on I.SMM_COD = P.SMK_COD AND I.SMM_TPCOD = P.SMK_TIPO
inner join CNV as C on O.OSM_CNV = C.CNV_COD 	
inner join psv crm on crm.psv_cod = i.smm_med	
inner join str s on s.str_cod = i.smm_str	
inner join ctf on p.smk_ctf = ctf.ctf_cod
inner join pac on i.smm_pac_reg = pac.pac_reg	
		
where

			O.OSM_DTHR >= '''+CONVERT(varchar(23),@DataIni,112)+'''
			AND O.OSM_DTHR < '''+CONVERT(varchar(23),@DataFim,112)+'''
			and (i.smm_pacote = ''C'' or i.smm_pacote is null)
			AND (I.SMM_SFAT = ''F'' or I.SMM_SFAT = ''P'')
			and I.SMM_TIPO_FATURA = ''E''

			AND C.CNV_CAIXA_FATURA = ''F'' 
			
			'+@Setor+'
						
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE ''%TESTE %'')

Order by O.OSM_NUM'

select @Consulta
/*
EXEC sp_makewebtask 
	@outputfile = @Caminho,
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Consulta
*/