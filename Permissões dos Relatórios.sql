select * from ars 
where 
ars_rls_cod = 1058
1033
1058--ars_usr_login = 'ALLISSON'
ars_usr_login = 'MEDICWARE'

INSERT INTO ARS (ARS_RLS_COD, ARS_USR_LOGIN, ARS_TIPO, ARS_IND_EIS, ARS_IND_WEBLAUDOS, ARS_IND_FAVORITO, ARS_IND_SMARTWEB)
VALUES (377, 'MEDICWARE', 'A', 'N', 'N', 'N', 'S')

update ars 
set ars_usr_login = 'MEDICWARE'
where  ars_usr_login = 'JOSEPHLIMA'


update ars 
set ars_tipo = 'A'
where  
ars_usr_login = 'JULIO' 
AND ars_rls_cod = '755'

select * from rls where rls_titulo like '%COmpro%'

