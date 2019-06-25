
USE [smart]
GO
/****** Object:  StoredProcedure [dbo].[up_Extrato_ProdSemMov]    Script Date: 08/21/2017 09:46:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*DECLARACAO DE VARIAVEIS*/

Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)

Set @Titulo = 'Estoque Sem Movimentação Fev17-Mai17.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = '
SELECT gmm.gmm_nome Grupo,   
         LMA.LMA_NOME Linha,   
         MAT.MAT_COD Cod,   
         MAT.MAT_DESC_RESUMIDA Descricao,   
         replace(cast(ISNULL(MAT.MAT_VLR_PM,0) as numeric(10,2)),''.'','','') Preco_Medio,
         ETQ.ETQ_QUANTIDADE Qtd_TT, 
		 replace(cast(ISNULL(sum(MAT.MAT_VLR_PM * ETQ.ETQ_QUANTIDADE),0) as numeric(10,2)),''.'','','') Valor,
			sba.sba_nome Almox, 
			sba.sba_cod  Almox_Cod,   
		LOT.LOT_NUM Lote, 
		convert(varchar, lot.lot_data_entrada, 103) Lote_Entrada,
		convert(varchar, lot.lot_data_validade, 103) Lote_Validade,
       ETL.ETL_QUANTIDADE Qtd_lote

    FROM gmm, LMA, MAT, cfg, ETQ, SBA, ETL, LOT  

   WHERE ( LMA.LMA_GMM_COD = gmm.gmm_cod ) and  
         ( MAT.MAT_GMM_COD = LMA.LMA_GMM_COD ) and  
         ( MAT.MAT_LMA_COD = LMA.LMA_COD ) and  
         ( MAT.MAT_COD = ETQ.ETQ_MAT_COD ) and 
		 (  ETL.ETL_SBA_COD = ETQ.ETQ_SBA_COD  ) AND 
       (  ETL.ETL_MAT_COD = ETQ.ETQ_MAT_COD  ) AND 
       (  ETL.ETL_LOT_NUM = LOT.LOT_NUM  )  AND 
		(  LOT.LOT_MAT_COD =* MAT.MAT_COD  ) AND 
			( etq.etq_sba_cod = sba.sba_cod ) AND  	
			ETQ.ETQ_QUANTIDADE <> 0 and 
			ETL.ETL_QUANTIDADE <> 0 and
			( mat.mat_del_logica = ''N'' ) AND
			( mat.mat_ind_suspender_comprar = ''N'' ) and
			mat.mat_ind_consignado = ''N'' and
			sba.sba_nome not like ''%FOCUS%''

		 		
	and NOT EXISTS (  SELECT mma_mat_cod  
						 FROM mma 
						WHERE ( MMA.MMA_MAT_COD = MAT.MAT_COD ) and 
							 ( MMA.MMA_DATA_ATUAL >= ''2017-02-01 00:00'') AND  
         					( MMA.MMA_DATA_ATUAL <= ''2017-06-01 00:00'') AND 
								( MMA.MMA_SBA_COD like 1  ) 
						)

GROUP BY gmm.gmm_nome,   
         LMA.LMA_NOME,   
         MAT.MAT_COD,   
         MAT.MAT_DESC_RESUMIDA,   
		ETQ.ETQ_QUANTIDADE,
		 MAT.MAT_VLR_PM, 
			sba.sba_nome, 
			sba.sba_cod , 
		LOT.LOT_NUM,  
		lot.lot_data_entrada,
		lot.lot_data_validade,
		ETL.ETL_QUANTIDADE

ORDER BY sba.sba_nome ASC, 
			gmm.gmm_nome ASC,   
         LMA.LMA_NOME ASC,   
         MAT.MAT_DESC_RESUMIDA ASC
'

EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1




