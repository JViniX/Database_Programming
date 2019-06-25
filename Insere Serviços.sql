INSERT INTO smk 
( 
smk_cod, smk_tipo, smk_rot, smk_nome, smk_ctf, smk_str, smk_ld, smk_agd, smk_ind_med, smk_ordem, smk_sexo, smk_status, smk_tipo_amostra, 
smk_pacote, smk_terc, smk_ind_preco_conv, smk_ind_sus, smk_idade_min, smk_idade_max, smk_eld, smk_ind_coletadeira, smk_eld_horas, smk_ind_ld_rev, 
smk_ind_dicom, smk_pex_interv_min, smk_ind_agd_sessoes, smk_qtde_default, smk_ind_info_medico, smk_ind_web_laudo, smk_tiss_valor_zero, 
smk_ind_atende, smk_ind_sigiloso, smk_ind_confirm_agm, smk_ind_exib_res_prov, smk_ind_gera_laudo, smk_idade_min_dias, smk_ind_fratura, 
smk_ind_agd_mail_final 
) 
VALUES 
(
'MEDAU11', 'S', 'MEDICO AUXILIAR P11', 'MEDICO AUXILIAR P11', '5028', 'CC', '00', 0, 'N', 1000, 'A', 'A', 'N', 'N', 'N', 'T', 'A', 0, 999, 0.00,
 'N', 0, 'N', 'N', 0, 'N', 1, 'N', 'N', 'N', 'S', 'N', 'S', 'S', 'S', 0, 'N', 'S' 
)

--SELECT * FROM SMK WHERE smk_ordem = 1000