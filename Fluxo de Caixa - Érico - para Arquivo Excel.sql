USE [smart]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)

Set @Titulo = 'Fluxo de Caixa Érico - Out2016-Jul2017.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = 
'
declare @datainicial as datetime
declare @datafinal as datetime
declare @conta as integer
declare @gcc as varchar(15)

set @datainicial = ''2016-10-01 00:00:000''
set @datafinal = ''2017-08-01 00:00:000''
set @gcc = ''3''

select
mcc.mcc_doc as documento,convert(varchar,mcc.mcc_dt,103) as data,
convert(varchar,left(mcc.mcc_mmyy,4)) + ''/'' + convert(varchar,right(mcc.mcc_mmyy,2)) as competencia,
cfo.cfo_cod,cfo.cfo_nome as classificacao,
mcc.mcc_obs as historico,
mcc.mcc_deb - mcc.mcc_cre as movimento,
mcc.mcc_deb as entradas,mcc.mcc_cre as saidas,
0 as saldo,
convert(varchar,mcc.mcc_dt_compensa,103) as conciliadoem,
convert(varchar,mcc.mcc_serie) + ''-'' + convert(varchar,mcc.mcc_lote) as lote,
ccr.ccr_tit as banco,
isnull(convert(varchar,mcc.mcc_bcp_serie) + ''-'' + convert(varchar,mcc.mcc_bcp_num),'''') as baixa,
gcc.gcc_descr as empresa
into #tmp_extrato
from
mcc,cfo,ccr,gcc
where
(cfo.cfo_cod = mcc.mcc_cfo_cod)
and (ccr.ccr_cod = mcc.mcc_ccr)
and gcc.gcc_cod = ccr.ccr_gcc_cod
--and mcc.mcc_bcp_serie is not null
--and ((ccr_gcc_cod = @gcc and ccr_tipo = 2)
and ((ccr_tipo = 2)
and (mcc.mcc_dt_compensa >= @datainicial and mcc.mcc_dt_compensa < @datafinal)
and (mcc.mcc_tipo = ''r'')
and (mcc.mcc_concilia = ''s''))

select
documento,data,competencia,cfo_cod,classificacao,historico,
entradas - saidas as movimento,entradas,saidas, 0 as saldo,
''as conciliadoem, lote,'' as banco,baixa
into #tmp_extrato_cfo
from
vud_cpg_ipg_cfo bx
where
bx.baixa in
(
select
distinct convert(varchar,mcc_bcp_serie) + ''-'' + convert(varchar,mcc_bcp_num)
from
vud_mcc_bcp_ccr
where
--ccr_gcc_cod = @gcc and ccr_tipo_cod = 2
ccr_tipo_cod = 2
and (mcc_dt_compensa >= @datainicial and mcc_dt_compensa < @datafinal)
and mcc_tipo = ''r''
and mcc_concilia = ''s''
)
--Gera o fluxo usando as tabelas temporarias
select * from #tmp_extrato ex where ex.baixa = ''''
union all
select
documento,data,competencia,cfo_cod,classificacao,historico,movimento,entradas,
case
when (vlr_baixa <> vlr_extrato) then (saidas/vlr_baixa)*vlr_extrato
else saidas end as saidas,
saldo,convert(varchar,mcc_dt_compensa,103) as conciliadoem,lote,conta as banco,baixa,empresa
from (
select *,
(select max(ex.conciliadoem) from #tmp_extrato ex where ex.baixa = cf.baixa) as mcc_dt_compensa,
(select sum(ex.saidas) from #tmp_extrato ex where ex.baixa = cf.baixa) as vlr_extrato,
(select sum(excfo.saidas) from #tmp_extrato_cfo excfo where excfo.baixa = cf.baixa) as vlr_baixa,
(select top 1 banco from #tmp_extrato ex where ex.baixa = cf.baixa) as conta,
(select top 1 gcc.gcc_descr from ccr,gcc where gcc.gcc_cod = ccr.ccr_gcc_cod and ccr_tit = (select top 1 banco from #tmp_extrato ex where ex.baixa = cf.baixa)) as empresa

from #tmp_extrato_cfo cf) as tmp1

--Apaga as tabelas temporarias
drop table #tmp_extrato
drop table #tmp_extrato_cfo
'

EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1
