-- Vol Retorno
/*DECLARACAO DE VARIAVEIS*/
Declare @Titulo Varchar(50)
Declare @MesAno DateTime

/*PEGA O ANO E MES ATUAL*/
Set @MesAno = DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112)))
Set @Titulo = 'Exames Vol Retorno: '+ convert(varchar(2),month(@MesAno))+'/'+convert(varchar(4),year(@MesAno))

EXEC sp_makewebtask 
	@outputfile = 'D:\Extratos\Exames Vol Retorno.xls',  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = '
select i.smm_osm_serie "OS Serie", i.smm_osm "OS Num", i.smm_sfat "Status Fat", i.smm_str "Cod. Setor", s.str_nome "Setor", 
	i.SMM_COD , p.SMK_NOME, i.smm_qt Qtd, pac.pac_reg, pac.pac_nome, i.smm_med "CRM", crm.psv_nome "Prestador", o.osm_cnv "Cod. Conv.", c.cnv_nome "Convenio", c.CNV_CAIXA_FATURA "Cobraca",
	convert(varchar(2),month(o.OSM_DTHR))+''/''+convert(varchar(4),year(o.OSM_DTHR)) as "MÊS/ANO", convert(varchar, o.OSM_DTHR, 103) Data, convert(varchar, o.OSM_DTHR, 108) Hora, 
 ''R$ ''+replace(cast(i.smm_vlr as numeric(10,2)),''.'','','') Valor 
/* ,replace(cast((m.MTE_DESCONTO/m.MTE_VALOR)*100 as decimal(5,2)),''.'','','') + ''%'' DescPerce, ''R$ ''+replace(cast((i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),''.'','','') DescReal, ''R$ ''+replace(cast(i.SMM_VLR - (i.SMM_VLR* (m.MTE_DESCONTO/m.MTE_VALOR)) as decimal(10,2)),''.'','','') Pago
*/, i.smm_usr_login_lanc

from  smm i
inner join osm o on o.osm_serie = i.smm_osm_serie and o.osm_num = i.smm_osm
/*inner join mte m on m.mte_serie = i.smm_mte_serie and m.mte_seq = i.smm_mte_seq
inner join mte m on M.MTE_OSM_SERIE = O.OSM_SERIE AND M.MTE_OSM = O.OSM_NUM*/
inner join psv crm on crm.psv_cod = i.smm_med 
inner join str s on s.str_cod = i.smm_str
inner join cnv c on o.osm_cnv = c.cnv_cod
inner join smk p on i.SMM_COD = p.SMK_COD	AND i.SMM_TPCOD = p.SMK_TIPO
inner join pac on i.smm_pac_reg = pac.pac_reg

/*(SELECT ISNULL(SUM (I.SMM_QT),0)*/

			WHERE  O.OSM_DTHR >= DATEADD(D,1-DAY(GETDATE()),DATEADD(M,-1,CONVERT(CHAR(8),GETDATE(),112))) 
			AND O.OSM_DTHR < DATEADD(D,1-DAY(getdate()),CONVERT(CHAR(8),getdate(),112))
 
			AND I.SMM_SFAT <> ''C''
			AND I.SMM_TPCOD = ''S''
			and o.osm_cnv = ''RET''
			AND( I.SMM_STR = ''ARG'' 
				OR I.SMM_STR = ''ART''
				OR I.SMM_STR = ''AVL''
				OR I.SMM_STR = ''CV''
				OR I.SMM_STR = ''PAQ''
				OR I.SMM_STR = ''ECO''
				OR I.SMM_STR = ''ERG''
				OR I.SMM_STR = ''MIC''
				OR I.SMM_STR = ''OCT''
				OR I.SMM_STR = ''OPD''
				OR I.SMM_STR = ''OCV''
				OR I.SMM_STR = ''OCZ''
				OR I.SMM_STR = ''OR''
				OR I.SMM_STR = ''RET''
				OR I.SMM_STR = ''REX''
				OR I.SMM_STR = ''TOP''
				OR I.SMM_STR = ''TPZ''
				OR I.SMM_STR = ''US''
				OR I.SMM_STR = ''VER''
				OR I.SMM_STR = ''YAG'')
			AND SMM_PAC_REG NOT IN (SELECT PAC_REG 
						FROM PAC 
						WHERE PAC_NOME LIKE ''%TESTE %'')

order by smm_osm_serie, smm_osm'
