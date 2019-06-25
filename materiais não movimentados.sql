 SELECT gmm.gmm_nome,   
         LMA.LMA_NOME,   
         MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         cfg.cfg_emp,
         MAT.MAT_VLR_PM,
         SUM(ETQ.ETQ_QUANTIDADE), 
			sba.sba_nome, 
			sba.sba_cod  
    FROM gmm,   
         LMA,   
         MAT,   
         cfg,
         ETQ, 
			SBA 
   WHERE ( LMA.LMA_GMM_COD = gmm.gmm_cod ) and  
         ( MAT.MAT_GMM_COD = LMA.LMA_GMM_COD ) and  
         ( MAT.MAT_LMA_COD = LMA.LMA_COD ) and  
         ( MAT.MAT_COD = ETQ.ETQ_MAT_COD ) and 
			( etq.etq_sba_cod = sba.sba_cod ) AND  
         ( gmm.gmm_cod like :a_gmmcod ) AND  
         ( LMA.LMA_COD like :a_lmacod ) AND 
			( sba.sba_cod like :a_sSbacod ) AND 	
			( mat.mat_del_logica = 'N' ) AND
			( mat.mat_ind_suspender_comprar = 'N' ) AND 		
	NOT EXISTS (  SELECT mma_mat_cod  
						 FROM mma 
						WHERE ( MMA.MMA_MAT_COD = MAT.MAT_COD ) and 
								( ( MMA.MMA_DATA_ATUAL >= :a_dthrini ) AND  
         					( MMA.MMA_DATA_ATUAL <= :a_dthrfim ) AND 
								( MMA.MMA_SBA_COD like :a_sSbaCod  ) ) )

GROUP BY gmm.gmm_nome,   
         LMA.LMA_NOME,   
         MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
         cfg.cfg_emp,
         MAT.MAT_VLR_PM, 
			sba.sba_nome, 
			sba.sba_cod 

ORDER BY sba.sba_nome ASC, 
			gmm.gmm_nome ASC,   
         LMA.LMA_NOME ASC,   
         MAT.MAT_DESC_RESUMIDA ASC   
