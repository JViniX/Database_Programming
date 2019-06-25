
SELECT SMM.SMM_COD, 
       SMK.SMK_NOME, 
       SMM.SMM_QT, CV.CNV_NOME, 
		smm.smm_osm_serie, smm.smm_osm, smm.smm_num, smm.smm_str, smm.smm_dthr_exec, smm.smm_yymm, 
		smm.smm_dthr_pend, smm.smm_dthr_coleta, smm.smm_dthr_lanc, smm.smm_dthr_alter, smm.smm_dt_result
 FROM SMM, SMK, OSM, CNV CV 
 WHERE (  SMM.SMM_SFAT <> 'C'  ) AND 
       ( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
       ( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
       ( ( ( OSM.OSM_CNV = CV.CNV_COD AND SMM.SMM_CTH_NUM IS NULL ) OR ( SMM.SMM_CNV_COD = CV.CNV_COD AND SMM.SMM_CTH_NUM IS NOT NULL ) ) ) AND 
       ( SMK.SMK_TIPO = SMM.SMM_TPCOD ) AND 
       ( SMK.SMK_COD = SMM.SMM_COD )  AND 
       ( ( OSM.OSM_DTHR >= '2014-12-01 00:00:00' AND 
           OSM.OSM_DTHR < '2014-12-31 23:59:59' )   ) AND 
       ( SMM.SMM_STR = 'SLC' ) AND 
       ( SMM.SMM_TPCOD = 'M' ) /*AND 
       ( SMM.SMM_COD = '261'   ) AND 
       ( CV.CNV_NOME not in  ( 'CORTESIA' )  )*/
 ORDER BY SMK.SMK_NOME ASC