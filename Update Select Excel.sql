
use smartlab

insert into smk
SELECT CI FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0','Excel 8.0;DATABASE=L:\JV\Safari 365 Grid.XLS','SELECT * FROM [Safari 365 Grid$]')

select pac_email, * from pac where pac_reg = '388412'

update pac
set pac_email = ''
where pac_reg in (SELECT CI FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0','Excel 8.0;DATABASE=L:\JV\Safari 365 Grid.XLS','SELECT * FROM [Safari 365 Grid$]'))
