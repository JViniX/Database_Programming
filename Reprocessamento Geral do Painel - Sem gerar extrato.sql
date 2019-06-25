
/*DECLARACAO DE VARIAVEIS*/
declare @DATAATUAL DATETIME
declare @MES_ATUAL INT
declare @ANO_ATUAL INT
declare @COD_IND INT
declare @SETOR NVARCHAR(50)
declare @Cod_Setores NVARCHAR(500)
declare @Valor DECIMAL(12,2)
Declare @Contador int

--Atribuindo valores nas variáveis

SET @ANO_ATUAL = 2006

While @ANO_ATUAL <= 2009
BEGIN

	SET @MES_ATUAL = 01
	Print ('------------- Início às '+cast(getdate() as varchar(20))+' -------------')

	While @MES_ATUAL <= 12
	BEGIN

		SET @DATAATUAL =CAST(@ANO_ATUAL AS CHAR(4))+'-'+CAST(@MES_ATUAL AS CHAR(2))+'-01'
		SET @DATAATUAL =dateadd(m,1,dateadd(d,-day(@DATAATUAL),CONVERT(CHAR(8),@DATAATUAL,112)))

		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_MatMed from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_MatMed @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_MatMedBaixas @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					--EXEC up_Extrato_MatMedDev @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End



		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_ROBPart from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_ROBPart @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_ROBPart @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End



		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_ROBConv from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_ROBConv @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_ROBConv @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End



		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_ROBSUS from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_ROBSUS @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_ROBSUS @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End




		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolPart from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolPart @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_VolPart @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End



		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolConv from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolConv @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_VolConv @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End




		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolCort from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolCort @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_VolCort @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End




		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolSUS from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolSUS @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--EXEC up_Extrato_VolSUS @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End




		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolRet from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolRet @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--exec up_Extrato_VolRet @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End



		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_VolRevi from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_VolRevi @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--exec up_Extrato_VolRevi @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End


		Declare @HONORARIOS DECIMAL(12,2)
		Declare @HONORARIOS_CONVENIO DECIMAL(12,2)
		Declare @HONORARIOS_PARTICULAR DECIMAL(12,2)

		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_Hono from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					--exec up_PainelHonorarios @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Cod_Setores
					exec up_HonoConv @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @HONORARIOS_CONVENIO OUTPUT
					exec up_HonoPart @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @HONORARIOS_PARTICULAR OUTPUT

					/*SOMA OS VALORES*/
					Set @Honorarios = 0
					SET @HONORARIOS = ISNULL (@HONORARIOS_CONVENIO,0) + ISNULL (@HONORARIOS_PARTICULAR,0)

					/*COMANDO DE TESTES*/
					--Select @Setor Setor, @Cod_Ind Ind, @Cod_Setores, @HONORARIOS HonoTT, @HONORARIOS_CONVENIO HonoConv, @HONORARIOS_PARTICULAR HonoPart

					/*INSERCAO OU ATUALIZACAO DOS DADOS*/
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @HONORARIOS
					
					--exec up_Extrato_HonoPart @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					--exec up_Extrato_HonoConv @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores	
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))		
				end
			Set @Contador = @Contador + 1
		End




		Set @Valor = 0
		Set @Contador = 1

		while @Contador <= (Select max(idx) from validasmart.dbo.setores) 
		Begin
			Select @Setor = Nome, @Cod_Setores = Cod_Setores, @Cod_Ind = Cod_ind_Deducoes from validasmart.dbo.setores where idx = @Contador
			if @Cod_Ind is not null
				begin
					exec up_Deducoes @MES_ATUAL, @ANO_ATUAL, @Cod_Setores, @Valor OUTPUT
					exec up_GravaIndicador @DATAATUAL, @MES_ATUAL, @ANO_ATUAL, @COD_IND, @Valor
					--exec up_Extrato_Deducoes @MES_ATUAL, @ANO_ATUAL, @Setor, @Cod_Setores
					Print ('Setor: '+@Setor+', Indicador:'+cast(@Cod_Ind as varchar(4)))
				end
			Set @Contador = @Contador + 1
		End

		PRINT ('------------- '+ cast(getdate() as varchar(20))+' | '+CAST(@ANO_ATUAL AS CHAR(4))+'-'+CAST(@MES_ATUAL AS CHAR(2))+' CONCLUÍDO! -----------------')
		SET @MES_ATUAL = @MES_ATUAL + 1
		
	END

	Print ('------------- Término às '+cast(getdate() as varchar(20))+' -------------')

		SET @ANO_ATUAL = @ANO_ATUAL + 1
	
END

Print ('------------- Término às '+cast(getdate() as varchar(20))+' -------------')
