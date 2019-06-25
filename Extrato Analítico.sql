SELECT  osm.osm_dthr, osm.osm_serie, osm.osm_num, osm.osm_pac ,pac.pac_nome ,osm.osm_str ,           smm.smm_str ,           smm.smm_tpcod ,           smm.smm_cod ,           smm.smm_qt ,           smm.smm_vlr ,           smm.smm_med ,           ext.ext_valor_glosa ,           ext.ext_valor_receb ,           smm.smm_num ,           pac.pac_dt_valid ,           smm.smm_dthr_exec ,           smm.smm_hon_seq ,           psv_a.psv_cc ,           psv_a.psv_nome ,           psv_a.psv_crm ,           smm.smm_obs_amostra ,           smk.smk_rot ,           cnv.cnv_nome ,           osm.osm_mreq ,           smm.smm_tipo_fatura ,           smm.smm_aux ,ext.ext_mog_cod ,smm.smm_ajuste_vlr ,ext.ext_valor_imposto , 'ATEND',ext.ext_valor_complemento ,str.str_nome ,cfg.cfg_dummy_date as emissao, cfg.cfg_dummy_date as vencimento, cfg.cfg_homepage as fatura, str.str_nome as setor_sup
FROM osm, smm, pac, hon, psv psv_a, smk, cnv, ext, psv psv_b, str, cfg     
WHERE 
( ext.ext_osm_serie =* smm.smm_osm_serie) and
( ext.ext_osm_num =* smm.smm_osm) and
( ext.ext_smm_num =* smm.smm_num) and
( pac.pac_reg = osm.osm_pac ) and
( smm.smm_osm = osm.osm_num ) and
( smm.smm_osm_serie = osm.osm_serie ) and
( smm.smm_hon_seq = hon.hon_seq ) and
( smm.smm_med = psv_a.psv_cod ) and
( smk.smk_tipo = smm.smm_tpcod ) and
( smk.smk_cod = smm.smm_cod ) and
( psv_b.psv_cod = osm.osm_mreq ) and
( osm.osm_cnv = cnv.cnv_cod ) and
( str.str_cod = osm.osm_str ) and          
( ( osm.osm_dthr >= '2015-07-09 00:00') and  ( osm.osm_dthr <= '2015-07-10 00:00') ) --and
/*( ( HON_CC1 = '99999' and  ( psv_a.psv_cc = :a_sConta ) ) or          
( HON_CC1 = :a_sConta ) or          
( HON_CC2 = :a_sConta ) or          
( HON_CC3 = :a_sConta ) or          
( HON_CC4 = :a_sConta ) or          
( HON_CC5 = :a_sConta ) or          
( HON_CC6 = :a_sConta ) or          
( hon.hon_cc2 = '99999'  and          
( hon.hon_pc2 <> 0 or hon.hon_vl2 <> 0 ) and          
(  exists ( SELECT 1 FROM psv c WHERE c.psv_cod = smm.smm_aux AND c.psv_cc = :a_sConta ) )  ) or          
( hon.hon_pc6 <> 0 and          
( psv_b.psv_cc = :a_sConta )  ) and          
( hon.hon_cc6 = '99999' ) ) and */         
--( smm.smm_pacote is null or  ( smm.smm_pacote = 'C' )  )   
ORDER BY osm.osm_num

/*
SELECT * FROM EXT
WHERE EXT_dt_MOV >= '2015-06-11 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
aND EXT_dt_MOV  < '2015-06-12 00:00'
*/

/*
select * from mcc
WHERE mcc_dt >= '2015-07-02 00:00'--DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
aND mcc_dt  < '2015-07-03 00:00'
*/