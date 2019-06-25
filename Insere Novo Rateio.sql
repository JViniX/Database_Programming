--SP_WHO

DECLARE @numero INT
SET @numero = (select max(hon_seq) from hon)
print @numero

INSERT INTO hon ( 
hon_dthr_ini, hon_cnv_cod, hon_med, hon_psv_vinc, hon_aux, hon_ctf, hon_str, 
hon_cc1, hon_cc3, hon_cc4, hon_tpctf, hon_vl1, hon_vl2, hon_vl3, hon_str_solic, hon_vl5, 
hon_seq, hon_pc1, hon_pc2, hon_pc3, hon_pc4, hon_pc5, hon_status, hon_ctf_categ, hon_emp_cod, 
hon_usr_login_cad, hon_dthr_cad, hon_usr_login_alt, hon_dthr_alt, hon_gmr_cod, 
hon_psv_solic, hon_ih_origem, hon_cc6, hon_pc6, hon_vl6, hon_dia, hon_smk_tipo, 
hon_smk_cod, hon_ind_rat, hon_cnv_emp_cod, hon_psv_tipo_solic, hon_vl4 ) 
VALUES ( 
'10-18-2015 0:0:0.000', 'PAC', 935, 'S', 0, '6011', 'CC', 
'3001' /*Conta MEXEC*/, '1001' /*Conta STR*/, '1025' /*Conta EMP*/, 'M', 0.0000, 0.0000, 0.0000, '999', 0.0000, 
@numero /*Número*/, 17.60 /*%MEXEC*/, 0.00, 56.00 /*%STR*/, 0.00, 0.00, 'S', 'O', 0, 
'JULIO', '10-20-2015 11:45:58.040', 'JULIO', '10-20-2015 11:45:58.040', 0, 
41161 /*COD MedSol*/, 'A', '4116' /*Conta MedSol*/, 26.40 /*% Med Sol*/, 0.0000, 'QD', 'M', 
'1229' /*smk_cod*/, 'N', 0, '0', 150.0000 /*Custo*/ )



