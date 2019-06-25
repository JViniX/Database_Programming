/*  SELECT MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         MAT.MAT_CONS_MEDIO,   
         MAT.MAT_UNM_COD_SAIDA,   
         MAT.mat_vlr_pm,   
         cfg.cfg_emp,   
         LMA.LMA_NOME,   
         gmm.gmm_nome,   
         gmm.gmm_cod,   
         LMA.LMA_COD,   
         SUM ( ETQ.ETQ_QUANTIDADE ) as estoque, 
			ROUND ( ( SUM ( CASE WHEN etq.etq_cml_preco_medio is null THEN 0 ELSE etq.etq_cml_preco_medio END * etq.etq_quantidade ) / SUM ( ETQ.ETQ_QUANTIDADE ) ) * 1.0000000000, 10 ) etq_etq_cml_preco_medio, 
			ROUND ( SUM ( CASE WHEN etq.etq_cml_preco_medio is null THEN 0 ELSE etq.etq_cml_preco_medio END * etq.etq_quantidade ), 10 ) as valor_total,
			mat.mat_prc_ult_entrada as saldo_residual,
			mat.mat_unm_cod_entrada,
			MAT.MAT_IND_FRACIONADO,
			MAT.MAT_FAT_CONV_S_V,
			CASE WHEN MAT.MAT_IND_CONSIGNADO = 'S' THEN 'S' ELSE 'N' END as consignado,
			MAT.MAT_IND_APLIC_DIRETA
    FROM MAT,   
         cfg,   
         gmm,   
         LMA,   
         ETQ  
   WHERE ( LMA.LMA_GMM_COD = gmm.gmm_cod ) and  
         ( LMA.LMA_GMM_COD = MAT.MAT_GMM_COD ) and  
         ( LMA.LMA_COD = MAT.MAT_LMA_COD ) and  
         ( ETQ.ETQ_MAT_COD = MAT.MAT_COD ) and  
         ( MAT.MAT_COD > 0 ) and 
			( 8=8 )  
GROUP BY MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         MAT.MAT_CONS_MEDIO,   
         MAT.MAT_UNM_COD_SAIDA,   
         MAT.mat_vlr_pm,   
         cfg.cfg_emp,   
         LMA.LMA_NOME,   
         gmm.gmm_nome,   
         gmm.gmm_cod,   
         LMA.LMA_COD, 
			mat.mat_prc_ult_entrada,
			mat.mat_unm_cod_entrada,
			MAT.MAT_IND_FRACIONADO,
			MAT.MAT_FAT_CONV_S_V,
			CASE WHEN MAT.MAT_IND_CONSIGNADO = 'S' THEN 'S' ELSE 'N' END,
			MAT.MAT_IND_APLIC_DIRETA 
  HAVING SUM ( etq.etq_quantidade ) <> 0 

UNION ALL

  SELECT MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         MAT.MAT_CONS_MEDIO,   
         MAT.MAT_UNM_COD_SAIDA,   
         MAT.mat_vlr_pm,   
         cfg.cfg_emp,   
         LMA.LMA_NOME,   
         gmm.gmm_nome,   
         gmm.gmm_cod,   
         LMA.LMA_COD,   
         SUM ( ETQ.ETQ_QUANTIDADE ), 
			mat.mat_vlr_pm etq_etq_cml_preco_medio, 
			ROUND ( SUM ( CASE WHEN etq.etq_cml_preco_medio is null THEN 0 ELSE etq.etq_cml_preco_medio END * etq.etq_quantidade ), 10 ), 
			mat.mat_prc_ult_entrada,
			mat.mat_unm_cod_entrada,
			MAT.MAT_IND_FRACIONADO,
			MAT.MAT_FAT_CONV_S_V,
			CASE WHEN MAT.MAT_IND_CONSIGNADO = 'S' THEN 'S' ELSE 'N' END,
			MAT.MAT_IND_APLIC_DIRETA 
    FROM MAT,   
         cfg,   
         gmm,   
         LMA,   
         ETQ  
   WHERE ( LMA.LMA_GMM_COD = gmm.gmm_cod ) and  
         ( LMA.LMA_GMM_COD = MAT.MAT_GMM_COD ) and  
         ( LMA.LMA_COD = MAT.MAT_LMA_COD ) and  
         ( ETQ.ETQ_MAT_COD = MAT.MAT_COD ) and  
         ( MAT.MAT_COD > 0 ) and 
			( 8=8 ) 
GROUP BY MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         MAT.MAT_CONS_MEDIO,   
         MAT.MAT_UNM_COD_SAIDA,   
         MAT.mat_vlr_pm,   
         cfg.cfg_emp,   
         LMA.LMA_NOME,   
         gmm.gmm_nome,   
         gmm.gmm_cod,   
         LMA.LMA_COD, 
			mat.mat_prc_ult_entrada,
			mat.mat_unm_cod_entrada,
			MAT.MAT_IND_FRACIONADO,
			MAT.MAT_FAT_CONV_S_V,
			CASE WHEN MAT.MAT_IND_CONSIGNADO = 'S' THEN 'S' ELSE 'N' END,
			MAT.MAT_IND_APLIC_DIRETA  
  HAVING SUM ( etq.etq_quantidade ) = 0 

UNION ALL */

SELECT MAT.MAT_COD,   
		MAT.MAT_DESC_RESUMIDA,   
		MAT.MAT_CONS_MEDIO,   
		MAT.MAT_UNM_COD_SAIDA,   
		MAT.mat_vlr_pm,   
		cfg.cfg_emp,   
		LMA.LMA_NOME,   
		gmm.gmm_nome,   
		gmm.gmm_cod,   
		LMA.LMA_COD,   
		sum ( mma_qtd * mma_tipo_es_fator * -1 ), 
		0, 
		ROUND ( sum ( mma_valor * mma_tipo_es_fator * -1 ), 10 ), 
		mat.mat_prc_ult_entrada as saldo_residual,
		mat.mat_unm_cod_entrada,
		MAT.MAT_IND_FRACIONADO,
		MAT.MAT_FAT_CONV_S_V,
		CASE WHEN mma.mma_ind_consig = 'S' THEN 'S' ELSE 'N' END as consignado,
		MMA.MMA_IND_APLIC_DIRETA
    FROM MMA LEFT OUTER JOIN ETQ ON ( mma.mma_mat_cod = etq.etq_mat_cod AND mma.mma_sba_cod = etq.etq_sba_cod ), 
			MAT,   
         cfg,   
         gmm,   
         LMA  
	WHERE ( mma.mma_data_mov >= '2017-04-30 23:59' ) AND 
         ( LMA.LMA_GMM_COD = MAT.MAT_GMM_COD ) and  
         ( LMA.LMA_COD = MAT.MAT_LMA_COD ) and  
         ( MMA.MMA_MAT_COD = MAT.MAT_COD ) and  
         ( MAT.MAT_COD > 0 ) AND 
			( gmm.gmm_cod = mma.mma_gmm_cod ) 
			and ( 7=7 ) 
GROUP BY MAT.MAT_COD,   
		MAT.MAT_DESC_RESUMIDA,   
		MAT.MAT_CONS_MEDIO,   
		MAT.MAT_UNM_COD_SAIDA,   
		MAT.mat_vlr_pm,   
		cfg.cfg_emp,   
		LMA.LMA_NOME,   
		gmm.gmm_nome,   
		gmm.gmm_cod,   
		LMA.LMA_COD,   
		mat.mat_prc_ult_entrada,
		mat.mat_unm_cod_entrada,
		MAT.MAT_IND_FRACIONADO,
		MAT.MAT_FAT_CONV_S_V,
		CASE WHEN mma.mma_ind_consig = 'S' THEN 'S' ELSE 'N' END,
		MMA.MMA_IND_APLIC_DIRETA
 