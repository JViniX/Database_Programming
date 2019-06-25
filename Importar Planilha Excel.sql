select * from mat where mAT_COD = '22593'
mat_gmm_cod = 10 and mat_desc_resumida like '%OASYS PARA ASTI%'

insert into hon
SELECT * FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0','Excel 8.0;DATABASE=D:\JV\Book2.XLS','SELECT * FROM [Book1$]')

select max(hon_seq) from hon
