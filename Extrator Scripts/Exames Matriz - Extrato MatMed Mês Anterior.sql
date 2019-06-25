SELECT v.mma_sma_serie "Solic Serie", v.mma_sma_num as "No.Solic", sma_data as "Data Solic", s.sma_usr_login_sol as "Usr. Solic.", al.sba_nome as "Almoxarifado",
V.MMA_MAT_COD AS "Cod Mat", M.MAT_DESC_COMPLETA AS "Desc Mat", v.mma_serie "Mov. Serie ", v.mma_num "Mov. No.", V.MMA_DATA_MOV AS "Mov. Data Hora", V.MMA_TIPO_OPERACAO "Mov. Tipo", V.MMA_STR_COD AS "Setor", 
replace(cast(V.MMA_VLR_PM as numeric(10,2)),'.',',') AS "Valor Unit.", V.MMA_QTD AS "Qtd", 
replace(cast(ISNULL(V.MMA_VLR_PM * V.MMA_QTD,0) as numeric(10,2)),'.',',') AS "Valor TT", 
mma_usr_login as "Usr. Resp" 

FROM MMA V
inner join MAT M on V.MMA_MAT_COD = M.MAT_COD
inner join sba al on v.mma_sba_cod = al.sba_cod
left join sma s on v.mma_sma_serie = sma_serie and v.mma_sma_num = sma_num

			WHERE V.MMA_TIPO_ES = 'S'
		
			AND MMA_DATA_MOV >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND MMA_DATA_MOV < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
					
			AND (MMA_STR_COD = 'ARG'
			OR MMA_STR_COD = 'ART'
			OR MMA_STR_COD = 'AVL'
			OR MMA_STR_COD = 'CV'
			OR MMA_STR_COD = 'PAQ'
			OR MMA_STR_COD = 'ECO'
			OR MMA_STR_COD = 'ERG'
			OR MMA_STR_COD = 'MIC'
			OR MMA_STR_COD = 'OCT'
			OR MMA_STR_COD = 'OCV'
			OR MMA_STR_COD = 'OCZ'
			OR MMA_STR_COD = 'OR'
			OR MMA_STR_COD = 'RET'
			OR MMA_STR_COD = 'REX'
			OR MMA_STR_COD = 'TOP'
			OR MMA_STR_COD = 'TPZ'
			OR MMA_STR_COD = 'US'
			OR MMA_STR_COD = 'YAG')
			AND (MMA_TIPO_OPERACAO = 'S1'
			OR MMA_TIPO_OPERACAO = 'S2')
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

ORDER BY V.MMA_num