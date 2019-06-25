declare @comando nvarchar(1000)
declare @setor varchar(100)
declare @PERIODO varchar(100)
DECLARE @HONORARIOS_CONVENIO DECIMAL(12,2)
declare @TT DECIMAL(12,2) 

SET @periodo = ' AND MONTH(O.OSM_DTHR) = 03 AND YEAR(O.OSM_DTHR) = 2016 '
set @setor = 'AND I.SMM_STR = ''CC'''

set @comando = dbo.ufsReadfileAsString('D:\Scripts', 'Hono Part - Valor.sql')

set @comando = @comando + @periodo + @setor
--set @HONORARIOS_CONVENIO = (
--exec (@comando) @HONORARIOS_CONVENIO
--)
--exec @comando
--exec @comando @HONORARIOS_CONVENIO



--set @comando = 'select count(*) from str'
--exec sp_executesql @comando, @HONORARIOS_CONVENIO  N'@HONORARIOS_CONVENIO DECIMAL(12,2) OUTPUT',
exec sp_executesql @comando, @TT=@HONORARIOS_CONVENIO OUTPUT
select @HONORARIOS_CONVENIO

--INSERT INTO validasmart.Teste(valor) VALUES(exec(@comando))
