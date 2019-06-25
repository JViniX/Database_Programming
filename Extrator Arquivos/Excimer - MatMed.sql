/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(50)
Declare @MesAno DateTime

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112)))
Set @Titulo = 'Excimer Mat/Med: '+ convert(varchar(2),month(@MesAno))+'/'+convert(varchar(4),year(@MesAno))

EXEC sp_makewebtask 
	@outputfile = 'D:\Extratos\Excimer MatMed.xls',  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = 
'SELECT v.mma_sma_serie "Solic Serie", v.mma_sma_num as "No.Solic", sma_data as "Data Solic", s.sma_usr_login_sol as "Usr. Solic.", al.sba_nome as "Almoxarifado",
				V.MMA_MAT_COD AS "Cod Mat", M.MAT_DESC_COMPLETA AS "Desc Mat", v.mma_serie "Mov. Serie ", v.mma_num "Mov. No.", V.MMA_DATA_MOV AS "Mov. Data Hora", V.MMA_TIPO_OPERACAO "Mov. Tipo", V.MMA_STR_COD AS "Setor", 
				replace(cast(V.MMA_VLR_PM as numeric(10,2)),''.'','','') AS "Valor Unit.", V.MMA_QTD AS "Qtd", 
				replace(cast(ISNULL(V.MMA_VLR_PM * V.MMA_QTD,0) as numeric(10,2)),''.'','','') AS "Valor TT", 
				mma_usr_login as "Usr. Resp" 

				FROM MMA V
				inner join MAT M on V.MMA_MAT_COD = M.MAT_COD
				inner join sba al on v.mma_sba_cod = al.sba_cod
				left join sma s on v.mma_sma_serie = sma_serie and v.mma_sma_num = sma_num

			WHERE V.MMA_TIPO_ES = ''S''
		
			AND MMA_DATA_MOV >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND MMA_DATA_MOV < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
					
				AND V.MMA_STR_COD = ''EXL''
				AND (V.MMA_TIPO_OPERACAO = ''S1'' OR V.MMA_TIPO_OPERACAO = ''S2'')
				AND M.MAT_GMM_COD <> 1 
				AND M.MAT_GMM_COD <> 2
				AND M.MAT_GMM_COD <> 4
				AND M.MAT_GMM_COD <> 6
				AND M.MAT_GMM_COD <> 19
				AND M.MAT_GMM_COD <> 17
				AND M.MAT_GMM_COD <> 25
				AND M.MAT_GMM_COD <> 26
				AND M.MAT_GMM_COD <> 27
				AND M.MAT_GMM_COD <> 28
				AND M.MAT_GMM_COD <> 29

ORDER BY V.MMA_num'