SELECT OSM.OSM_SERIE, 
       OSM.OSM_NUM, 
		smm.smm_num,
		SMM.SMM_COD, 
       SMK.SMK_ROT, 
       SMM.SMM_VLR, 
     V_EXT_TOT.V_RECEB, 
     V_EXT_TOT.V_GLOSA, 
       EXT.EXT_VALOR_RECEB, 
 ( EXT_VALOR_RECEB + EXT_VALOR_GLOSA )  as formula_7, 
       EXT.EXT_VALOR_GLOSA    ,
       MOG.MOG_NOME
 FROM SMM, SMK,  EXT, OSM, MOG, V_EXT_TOT
 WHERE (  SMM.SMM_SFAT <> 'C'  ) AND 
       ( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
       ( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
       ( SMK.SMK_TIPO = SMM.SMM_TPCOD ) AND 
       ( SMK.SMK_COD = SMM.SMM_COD ) AND 
       (  EXT.EXT_OSM_SERIE = SMM.SMM_OSM_SERIE  ) AND 
       (  EXT.EXT_OSM_NUM = SMM.SMM_OSM  ) AND 
       (  EXT.EXT_SMM_NUM = SMM.SMM_NUM  ) AND 
      (  EXT.EXT_MOG_COD = MOG.MOG_COD  ) AND 
       (  V_EXT_TOT.V_OSM_SERIE = SMM.SMM_OSM_SERIE  ) AND 
       (  V_EXT_TOT.V_OSM_NUM = SMM.SMM_OSM  ) AND 
       (  V_EXT_TOT.V_SMM_NUM = SMM.SMM_NUM  )  AND 
       ( ( OSM.OSM_DTHR >= '2016-11-01 00:00:00' AND 
           OSM.OSM_DTHR < '2016-12-01 00:00:00' )   ) --AND 
     --  ( EXT.EXT_VALOR_GLOSA <> 0 ) 
AND      ( OSM.OSM_NUM = 118243 ) 
--and  ( OSM.OSM_NUM = 15425 )
 ORDER BY OSM.OSM_SERIE ASC, 
       OSM.OSM_NUM ASC, 
       SMK.SMK_ROT ASC