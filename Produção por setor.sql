SELECT  CONVERT ( VARCHAR(4), DATEPART ( yy, OSM.OSM_DTHR ) ) + '-' +  REPLICATE ( '0', 2 - DATALENGTH ( CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) ) ) ) +  CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) ) , 
       SMM.SMM_STR, 
       STR.STR_NOME, 
       /*OSM.OSM_CNV, 
       CNV.CNV_NOME, */
       SUM ( SMM.SMM_VLR )
 FROM SMM, OSM, STR, CNV 
 WHERE (  SMM.SMM_SFAT <> 'C'  ) AND 
       ( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
       ( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
       ( OSM.OSM_CNV = CNV.CNV_COD ) AND 
       ( STR.STR_COD = SMM.SMM_STR )  AND 
       ( ( OSM.OSM_DTHR >= '2015-01-01 00:00:00' AND 
           OSM.OSM_DTHR < '2015-01-31 23:59:59' )   ) AND 
        (smm.SMM_STR = 'C1'
			OR smm.SMM_STR = 'C2'
			OR smm.SMM_STR= 'C3'
			OR smm.SMM_STR = 'C4'
			OR smm.SMM_STR = 'C5'
			OR smm.SMM_STR = 'C6'
			OR smm.SMM_STR = 'CTD'
			OR smm.SMM_STR = 'CFR'
			OR smm.SMM_STR = 'CMU'
			OR smm.SMM_STR = 'CU1'
			OR smm.SMM_STR = 'CU2'
			OR smm.SMM_STR = 'GON'
			OR smm.SMM_STR = 'PC2'
			OR smm.SMM_STR = 'PR1'
			OR smm.SMM_STR = 'TS')	 AND 
       ( SMM.SMM_COD not in  ( 'CONSUCOH' )  )

 GROUP BY  CONVERT ( VARCHAR(4), DATEPART ( yy, OSM.OSM_DTHR ) ) + '-' +  REPLICATE ( '0', 2 - DATALENGTH ( CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) ) ) ) +  CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) ) , 
       SMM.SMM_STR, 
       STR.STR_NOME
       /*OSM.OSM_CNV, 
       CNV.CNV_NOME*/
 ORDER BY  CONVERT ( VARCHAR(4), DATEPART ( yy, OSM.OSM_DTHR ) ) + '-' +  REPLICATE ( '0', 2 - DATALENGTH ( CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) ) ) ) +  CONVERT ( VARCHAR(2), DATEPART ( mm, OSM.OSM_DTHR ) )  ASC, 
       STR.STR_NOME ASC