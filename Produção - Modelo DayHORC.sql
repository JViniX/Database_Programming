USE [smart]
GO
/****** Object:  StoredProcedure [dbo].[up_Extrato_HonoPart]    Script Date: 03/13/2017 18:25:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*DECLARACAO DE VARIAVEIS*/
--Declare @Mes nvarchar(2)
--Declare @Ano nvarchar(4)
--Declare @Setor nvarchar(50)
--Declare @Cod_Setores nvarchar(500)

Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)

--Set @Mes = '05'
--Set @Ano = '2012'
--select year(@Ano)

Set @Titulo = 'Produção HOS Jan2017 - Modelo DayHORC.xls' --@Ano+'-'+@Mes+' - '+' Geral.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = 

'
SELECT 
	PSV.PSV_COD,UPPER(PSV.PSV_NOME) AS PSV_NOME,PSV.PSV_CRM, 
	CV.CNV_COD,CV.CNV_NOME CNV_NOME_CV, 
	OSM.OSM_PAC, 
	PAC.PAC_NOME,
	CASE CTF.CTF_CATEG
		WHEN ''C'' THEN ''CONSULTA''
		WHEN ''E'' THEN ''EXAME''
		WHEN ''R'' THEN ''CIRUGIA''
		WHEN ''T'' THEN ''TAXAS''
		WHEN ''D'' THEN ''DIÁRIAS''
		WHEN ''A'' THEN ''EXAME''
		WHEN ''A'' THEN ''TERAPIA''
		WHEN ''O'' THEN ''OUTRAS''
		WHEN ''M'' THEN ''MATERIAIS''
		WHEN ''S'' THEN ''MATERIAIS ESPECIAIS''
		WHEN ''N'' THEN ''MEDICAMENTOS''
		WHEN ''G'' THEN ''GASES''
		WHEN ''O'' THEN ''OUTROS''
	ELSE ''NÃO ESPECIFICADO'' END AS CTF_CATEG,
	CTF.CTF_CTF_TIPO, 
	SMK.SMK_ROT, 
	SMM.SMM_DTHR_EXEC,
	OSM.OSM_SERIE,OSM.OSM_NUM,SMM.SMM_NUM,
	smm.smm_num_pai,	
	case smm.smm_sfat	
		when ''C'' then 0
	else smm.smm_qt end as smm_qt,
	case 
		when smm.smm_num_pai is null then smm.smm_qt
	else 0 end as smm_qt_real, 
	case
		when ((smm_pacote = ''c'') OR (smm_pacote IS NULL)) then SMM.SMM_VLR
	else 0 end as smm_vlr,
	case
		when ((smm_pacote = ''c'') OR (smm_pacote IS NULL)) then ''Normal''
	else ''Subst. Pacote'' end as pacote,	  
	smm_ajuste_vlr,
	SMM.SMM_STR,
	B.STR_NOME,
	BS.STR_COD AS STR_STR_COD,
	BS.STR_NOME AS STR_STR_NOME
FROM 
	PAC WITH (NOLOCK),  SMM WITH (NOLOCK),  PSV WITH (NOLOCK),  CNV CV WITH (NOLOCK),  OSM WITH (NOLOCK),  SMK WITH (NOLOCK),  STR BS WITH (NOLOCK),  CTF WITH (NOLOCK),  STR B 
	WITH (NOLOCK) 
WHERE   
	( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
	( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
	( ( ( OSM.OSM_CNV = CV.CNV_COD AND SMM.SMM_CTH_NUM IS NULL ) OR ( SMM.SMM_CNV_COD = CV.CNV_COD AND SMM.SMM_CTH_NUM IS NOT NULL ) ) ) AND 
	( B.STR_COD = OSM.OSM_STR ) AND 
	( SMK.SMK_TIPO = SMM.SMM_TPCOD ) AND 
	( SMK.SMK_COD = SMM.SMM_COD ) AND 
	( SMK.SMK_TIPO = CTF.CTF_TIPO ) AND 
	( SMK.SMK_CTF = CTF.CTF_COD ) AND 
	( OSM.OSM_PAC = PAC.PAC_REG ) AND 
	( PSV.PSV_COD = SMM.SMM_MED ) AND 
	(  B.STR_STR_COD = BS.STR_COD  )  AND 
	( CTF.CTF_NOME NOT IN  ( ''Diaria de Plantonista'' )  )
	AND ((OSM.OSM_DTHR >= ''1-1-2017 0:0:0.000'' AND OSM.OSM_DTHR <= ''2-1-2017 0:0:0.000''))
	AND ((CTF.CTF_CATEG in ( ''0'') ) or (''0'' in (''0'')))
	AND ((CTF.CTF_COD in ( 0) ) or (''0'' in (0)))
	AND ((BS.STR_COD in ( ''0'') ) or (''0'' in (''0'')))
	AND ((CV.CNV_COD in ( ''0'') ) or (''0'' in (''0'')))
	AND ((SMM.SMM_STR in ( ''0'') ) or (''0'' in (''0'')))
	AND ((SMM.SMM_MED in ( ''0'') ) or (''0'' in (''0'')))
	and B.STR_STR_COD <> ''4''
	--and smm.smm_osm_serie = 117 and smm.smm_osm in (109240,98658)
 ORDER BY 
	BS.STR_NOME ASC, 
    PSV.PSV_NOME ASC, 
    SMM.SMM_DTHR_EXEC ASC OPTION (LOOP JOIN, MAXDOP 1) 
'

EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1

--SELECT * FROM CRE