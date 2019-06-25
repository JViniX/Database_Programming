
select mat_cod "Código", mat_desc_completa, convert(varchar, mat_dthr_ult_entrada, 103), 
replace(cast(mat_prc_ult_entrada as numeric(10,2)),'.',',') , 
replace(cast(mat_vlr_pm as numeric(10,2)),'.',',')  from mat where mat_gmm_cod = 55