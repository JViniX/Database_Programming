
SELECT OSM.OSM_SERIE Série, OSM.OSM_NUM Número, osm.osm_dthr Data_OS,
		SMM.SMM_COD Código, 
       SMK.SMK_NOME Descrição, 
       SMM.SMM_QT Qtd, 
		str.str_codorg Setor,
       PSV.PSV_APEL, 
		CNV.CNV_NOME Convênio, 
		RDI.RDI_FORMA_PAG,
		CRE.CRE_NOME Cartao_Mome, 
		replace(cast(CRE_TAXA as numeric(10,2)),'.',',') Cartao_Taxa,
       replace(cast(RDI.RDI_VALOR as numeric(10,2)),'.',',') Valor_Parc, 
       convert(varchar, MTE.MTE_DTHR, 103) Data_Mov, 
       convert(varchar, RDI.RDI_VCTO, 103) Vcto_Parc
		
 FROM SMM, SMK, CNV, RDI, PSV, MTE, OSM , CRE, str, pac
 WHERE (  SMM.SMM_SFAT <> 'C'  ) AND 
       ( OSM.OSM_SERIE = SMM.SMM_OSM_SERIE ) AND 
       ( OSM.OSM_NUM = SMM.SMM_OSM ) AND 
       ( OSM.OSM_CNV = CNV.CNV_COD ) AND 
       ( SMK.SMK_TIPO = SMM.SMM_TPCOD ) AND 
       ( SMK.SMK_COD = SMM.SMM_COD ) AND 
       ( PSV.PSV_COD = SMM.SMM_MED ) AND 
		pac.pac_reg = smm.smm_pac_reg	and
       (  SMM.SMM_MTE_SEQ = MTE.MTE_SEQ  ) AND 
       (  SMM.SMM_MTE_SERIE = MTE.MTE_SERIE  ) AND 
       (  RDI.RDI_MTE_SEQ = MTE.MTE_SEQ  ) AND 
       (  RDI.RDI_MTE_SERIE = MTE.MTE_SERIE  )  AND 
		RDI.rdi_cre_cod = CRE.CRE_COD AND
		smm.smm_str = str.str_cod and
        osm.osm_dthr >= '2000-01-01 00:00:00' AND osm.osm_dthr < '2018-01-01 00:00:00' AND 
		--year(Osm.OSM_DTHR) = 2016 and

	 --str.str_str_cod = '4' and
       RDI.RDI_FORMA_PAG not in ('E', 'R' ) --and
				--cnv.CNV_NOME like '%CHEQUE%'

		
order by OSM_SERIE, osm_num