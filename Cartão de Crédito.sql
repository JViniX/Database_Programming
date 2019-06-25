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

Set @Titulo = 'Cartão de Crédito HOS 1s2017.xls' --@Ano+'-'+@Mes+' - '+' Geral.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = 
'
SELECT OSM.OSM_SERIE Série, OSM.OSM_NUM Número, osm.osm_dthr Data_OS,
		SMM.SMM_COD Código, 
       SMK.SMK_NOME Descrição, 
       SMM.SMM_QT Qtd, 
		str.str_codorg Setor,
       PSV.PSV_APEL, 
		CNV.CNV_NOME Convênio, 
		CRE.CRE_NOME Cartao_Mome, 
		replace(cast(CRE_TAXA as numeric(10,2)),''.'','','') Cartao_Taxa,
       replace(cast(RDI.RDI_VALOR as numeric(10,2)),''.'','','') Valor_Parc, 
       convert(varchar, MTE.MTE_DTHR, 103) Data_Mov, 
       convert(varchar, RDI.RDI_VCTO, 103) Vcto_Parc
		
 FROM SMM, SMK, CNV, RDI, PSV, MTE, OSM , CRE, str
 WHERE (  SMM.SMM_SFAT <> ''C''  ) AND 
       ( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
       ( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
       ( OSM.OSM_CNV = CNV.CNV_COD ) AND 
       ( SMK.SMK_TIPO = SMM.SMM_TPCOD ) AND 
       ( SMK.SMK_COD = SMM.SMM_COD ) AND 
       ( PSV.PSV_COD = SMM.SMM_MED ) AND 
       (  SMM.SMM_MTE_SEQ = MTE.MTE_SEQ  ) AND 
       (  SMM.SMM_MTE_SERIE = MTE.MTE_SERIE  ) AND 
       (  RDI.RDI_MTE_SEQ = MTE.MTE_SEQ  ) AND 
       (  RDI.RDI_MTE_SERIE = MTE.MTE_SERIE  )  AND 
		RDI.rdi_cre_cod = CRE.CRE_COD AND
		smm.smm_str = str.str_cod and
        osm.osm_dthr >= ''2017-01-01 00:00:00'' AND 
          osm.osm_dthr < ''2017-07-01 00:00:00'' AND 
	 str.str_str_cod <> ''4'' and
       ( RDI.RDI_FORMA_PAG = ''R'' )
		
order by osm_num
'

EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1

--SELECT * FROM CRE