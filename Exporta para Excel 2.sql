
-- Hono Part Med Ext
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(50)
Declare @MesAno DateTime

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112)))
Set @Titulo = 'Marcações da Portinho' --+ convert(varchar(2),month(@MesAno))+'/'+convert(varchar(4),year(@MesAno))

EXEC sp_makewebtask 
	@outputfile = 'D:\JV\Marcações da Portinho.xls',  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
SELECT PAC.PAC_NOME, 
       AGM.AGM_DTMRC, 
       CM.CNV_NOME CNV_NOME_CM, 
       PSV.PSV_CRM, 
       SMK.SMK_NOME, 
       AGM.AGM_STAT, 
       AGM.AGM_HINI, 
       USR.USR_NOME, 
       PSV.PSV_NOME, 
       COUNT(*), 
       AGM.AGM_OBS
 FROM PAC, AGM, PSV, SMK, USR, CTF, CNV CM 
 WHERE ( AGM.AGM_PAC = PAC.PAC_REG ) AND 
       ( AGM.AGM_MED = PSV.PSV_COD ) AND 
       ( SMK.SMK_TIPO = AGM.AGM_TPSMK ) AND 
       ( SMK.SMK_COD = AGM.AGM_SMK ) AND 
       ( AGM.AGM_TPSMK = CTF.CTF_TIPO ) AND 
       ( AGM.AGM_CTF = CTF.CTF_COD ) AND 
       ( AGM.AGM_USR_LOGIN = USR.USR_LOGIN ) AND 
       (  AGM.AGM_CNV_COD *= CM.CNV_COD  )  AND 
        AGM.AGM_DTMRC >= ''2017-01-01 00:00:00'' AND 
         --  AGM.AGM_DTMRC < ''2017-06-13 00:00:00'' )   ) AND 
       ( AGM.AGM_STAT not in  ( ''B'',''C'' )  ) AND 
        AGM.AGM_USR_LOGIN LIKE ''%.PS'' 
 GROUP BY PAC.PAC_NOME, 
       AGM.AGM_DTMRC, 
       CM.CNV_NOME, 
       PSV.PSV_CRM, 
       SMK.SMK_NOME, 
       AGM.AGM_STAT, 
       AGM.AGM_HINI, 
       USR.USR_NOME, 
       PSV.PSV_NOME, 
       AGM.AGM_OBS
 ORDER BY USR.USR_NOME ASC, 
       PSV.PSV_NOME ASC'