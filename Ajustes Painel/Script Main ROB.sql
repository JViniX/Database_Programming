/*NOVO PAINEL: MATRIZ PARA ROB*/

/*DECLARACAO DE VARIAVEIS*/
DECLARE @MES_ATUAL INT
DECLARE @ANO_ATUAL INT
DECLARE @ROB_Part DECIMAL(12,2)
DECLARE @ROB_Conv DECIMAL(12,2)

/*PEGA O ANO E MES ATUAL*/
SET @MES_ATUAL = 10
SET @ANO_ATUAL = 2015
SET @ROB_Part = 0
SET @ROB_Conv = 0

/*INICIO DO SCRIPT*/
SET @ROB_Part = (SELECT ISNULL(SUM (I.SMM_VLR - (I.SMM_VLR* (m.MTE_DESCONTO/nullif(m.MTE_VALOR,0)))),0)
					from  smm i
					inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
					right join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM
					inner join cnv c on o.osm_cnv = c.cnv_cod
					inner join pac on i.smm_pac_reg = pac.pac_reg

						WHERE  MONTH(O.OSM_DTHR) = @MES_ATUAL
						AND YEAR(O.OSM_DTHR) = @ANO_ATUAL
						and (i.smm_pacote = 'P' or i.smm_pacote is null)
						AND (I.SMM_SFAT = 'F' or I.SMM_SFAT = 'P')
						AND C.CNV_CAIXA_FATURA = 'C'
						and M.MTE_STATUS = 'D')

SET @ROB_Conv = (SELECT ISNULL(SUM (I.SMM_VLR),0)
					from  smm i
					inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
					inner join cnv c on o.osm_cnv = c.cnv_cod
					inner join pac on i.smm_pac_reg = pac.pac_reg

						WHERE  MONTH(O.OSM_DTHR) = @MES_ATUAL
						AND YEAR(O.OSM_DTHR) = @ANO_ATUAL
						and (i.smm_pacote = 'P' or i.smm_pacote is null)
						AND (I.SMM_SFAT = 'F' or I.SMM_SFAT = 'P')
						AND C.CNV_CAIXA_FATURA = 'F')


SELECT @ROB_Part "Part", @ROB_Conv "Conv", @ROB_Part + @ROB_Conv "Total"