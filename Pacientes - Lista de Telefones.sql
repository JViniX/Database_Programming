Declare @MesAno DateTime
Set @MesAno = GETDATE()-2 

select distinct(p.PAC_REG), convert(varchar(10),PAC_REG)+' - '+rtrim(p.PAC_NOME) "Name",p.PAC_FONE "HomePhone",p.PAC_CELULAR "MobilePhone",p.pac_fone2
from smm s
inner join pac as p on p.pac_reg = s.smm_pac_reg
where 
s.smm_str in ('SLC','PRO','LCV','JLC','FLL') and
((p.pac_fone <> '1' and p.pac_fone not like '792%' and p.pac_fone not like '793%' and p.pac_fone not like '794%' and p.pac_fone is not null) or
(p.pac_fone2 <> '1' and p.pac_fone2 not like '792%' and p.pac_fone2 not like '793%' and p.pac_fone2 not like '794%' and p.pac_fone2 is not null) or
 (p.pac_celular <> '1' and p.pac_celular not like '792%' and p.pac_celular not like '793%' and p.pac_celular not like '794%' and p.pac_celular is not null))
and p.pac_dult > '2016-01-01'
order by p.PAC_REG
