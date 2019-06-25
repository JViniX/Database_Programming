USE [smart]

/*DECLARACAO DE VARIAVEIS*/
Declare @Mes nvarchar(2)
Declare @Ano nvarchar(4)
Declare @Setor nvarchar(50)
Declare @Cod_Setores nvarchar(500)

Declare @Titulo Varchar(255)
Declare @Caminho Varchar(max)
Declare @Comando1 nvarchar(max)

Set @Titulo = 'Agenda 2013.xls' --@Ano+'-'+@Mes+' - '+' Geral.xls'
Set @Caminho = 'D:\JV\'+@Titulo
Set @Comando1 = '
SELECT      agm.agm_med CRM, psv.psv_apel Medico, 

case (DATEPART(DW,agm.agm_hini))
  when 1 then ''DOMINGO''
  when 2 then ''SEGUNDA-FEIRA''
  when 3 then ''TERÇA-FEIRA''
  when 4 then ''QUARTA-FEIRA''
  when 5 then ''QUINTA-FEIRA''
  when 6 then ''SEXTA-FEIRA''
  when 7 then ''SÁBADO''
end
DiaSemana, convert(varchar, agm.agm_hini, 103) Data, convert(varchar, agm.agm_hini, 108) Hora, 
case agm_str_cod
	when ''4'' then ''Focus''
	when ''5'' then ''Jardins''
	when ''HOS'' then ''Matriz''
	else agm_str_cod
end Unidade,
pac.pac_pront Prontuario, pac.pac_nome PacNome,  pac.pac_fone Fone,           FLOOR(DATEDIFF(DAY, (pac.pac_nasc), GETDATE()) / 365.25) Idade,   
agm.agm_smk Cod,   smk.smk_nome Servico,  ctf.ctf_nome Classe, agm.agm_loc "Local",  agm.agm_stat "Status",   cnv.cnv_nome Convenio ,               
          agm.agm_dtmrc "Marcado em"       
        --   agm.agm_str_cod ,           smk.smk_rot ,           loc.loc_str ,           agm.agm_cnv_cod     
FROM agm ,           pac ,  ctf,         cfg ,           smk ,           loc   , psv , cnv 
WHERE ( pac.pac_reg = agm.agm_pac ) and          ( smk.smk_tipo = agm.agm_tpsmk ) and      agm.agm_cnv_cod = cnv.cnv_cod and     
( smk.smk_cod = agm.agm_smk ) and          ( loc.loc_cod = agm.agm_loc ) and   (agm.agm_med = psv.psv_cod)   and    
agm.agm_ctf = ctf.ctf_cod and 
(( agm.agm_hini >= ''2013-01-01 00:00'' ) and ( agm.agm_hini < ''2014-01-01 00:00'' ))        

ORDER BY agm.agm_med          ASC,           agm.agm_hini          ASC  '


EXEC sp_makewebtask 
	@outputfile = @Caminho,  
	@colheaders =1, 
	@FixedFont=0,@lastupdated=0,@resultstitle=@Titulo,
	@query = @Comando1


