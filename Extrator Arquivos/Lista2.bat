
Echo on
cls
echo "Inicio de Script"

echo
echo "Cirurgias"
sqlcmd -d Smart -i "Cirurgia - Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Cirurgia - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Cirurgia - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Cirurgia - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Cirurgia - Hon Part NC.sql"
sqlcmd -d Smart -i "Cirurgia - MatMed.sql"
sqlcmd -d Smart -i "Cirurgia - ROB Con.sql"
sqlcmd -d Smart -i "Cirurgia - ROB Part.sql"
sqlcmd -d Smart -i "Cirurgia - Vol Conv.sql"
sqlcmd -d Smart -i "Cirurgia - Vol Part.sql"

echo
echo "Consultas"
sqlcmd -d Smart -i "Consultas - Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Consultas - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Consultas - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Consultas - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Consultas - Hon Part NC.sql"
sqlcmd -d Smart -i "Consultas - MatMed.sql"
sqlcmd -d Smart -i "Consultas - ROB Con.sql"
sqlcmd -d Smart -i "Consultas - ROB Part.sql"
sqlcmd -d Smart -i "Consultas - Vol Conv.sql"
sqlcmd -d Smart -i "Consultas - Vol Cort.sql"
sqlcmd -d Smart -i "Consultas - Vol Part.sql"
sqlcmd -d Smart -i "Consultas - Vol SUS.sql"

echo
echo "Exames"
sqlcmd -d Smart -i "Exames -  Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Exames - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Exames - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Exames - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Exames - Hon Part NC.sql"
sqlcmd -d Smart -i "Exames - MatMed.sql"
sqlcmd -d Smart -i "Exames - ROB Con.sql"
sqlcmd -d Smart -i "Exames - ROB Part.sql"
sqlcmd -d Smart -i "Exames - Vol Conv.sql"
sqlcmd -d Smart -i "Exames - Vol Cort.sql"
sqlcmd -d Smart -i "Exames - Vol Part.sql"
sqlcmd -d Smart -i "Exames - Vol Ret.sql"

echo
echo "Excimer"
sqlcmd -d Smart -i "Excimer - Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Excimer - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Excimer - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Excimer - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Excimer - Hon Part NC.sql"
sqlcmd -d Smart -i "Excimer - MatMed.sql"
sqlcmd -d Smart -i "Excimer - ROB Con.sql"
sqlcmd -d Smart -i "Excimer - ROB Part.sql"
sqlcmd -d Smart -i "Excimer - Vol Conv.sql"
sqlcmd -d Smart -i "Excimer - Vol Part.sql"

echo
echo "Focus Consulta"
sqlcmd -d Smart -i "Focus Consulta - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Focus Consulta - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Focus Consulta - Hon Part NC.sql"
sqlcmd -d Smart -i "Focus Consulta - MatMed.sql"
sqlcmd -d Smart -i "Focus Consulta - ROB Con.sql"
sqlcmd -d Smart -i "Focus Consulta - ROB Part.sql"
sqlcmd -d Smart -i "Focus Consulta - Vol Conv.sql"
sqlcmd -d Smart -i "Focus Consulta - Vol Cort.sql"
sqlcmd -d Smart -i "Focus Consultas -  Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Focus Consultas - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Focus Consultas - Vol Part.sql"

echo
echo "Focus Lentes"
sqlcmd -d Smart -i "Focus Lentes - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Focus Lentes - Hon Part NC.sql"
sqlcmd -d Smart -i "Focus Lentes - ROB Part.sql"
sqlcmd -d Smart -i "Focus Lentes - Vol Part.sql"
sqlcmd -d Smart -i "Focus Lentes -MatMed.sql"

echo
echo "Jardins Consultas"
sqlcmd -d Smart -i "Jardins Consultas - Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Jardins Consultas - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Jardins Consultas - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Jardins Consultas - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Jardins Consultas - Hon Part NC.sql"
sqlcmd -d Smart -i "Jardins Consultas - MatMed.sql"
sqlcmd -d Smart -i "Jardins Consultas - ROB Con.sql"
sqlcmd -d Smart -i "Jardins Consultas - ROB Part.sql"
sqlcmd -d Smart -i "Jardins Consultas - Vol Conv.sql"
sqlcmd -d Smart -i "Jardins Consultas - Vol Cort.sql"
sqlcmd -d Smart -i "Jardins Consultas - Vol Part.sql"

echo
echo "Jardins Exames"
sqlcmd -d Smart -i "Jardins Exames -  Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Jardins Exames - Hon Conv Med Int.sql
sqlcmd -d Smart -i "Jardins Exames - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Jardins Exames - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Jardins Exames - Hon Part NC.sql"
sqlcmd -d Smart -i "Jardins Exames - MatMed.sql"
sqlcmd -d Smart -i "Jardins Exames - ROB Con.sql"
sqlcmd -d Smart -i "Jardins Exames - ROB Part.sql"
sqlcmd -d Smart -i "Jardins Exames - Vol Conv.sql"
sqlcmd -d Smart -i "Jardins Exames - Vol Cort.sql"
sqlcmd -d Smart -i "Jardins Exames - Vol Part.sql"
sqlcmd -d Smart -i "Jardins Exames - Vol Ret.sql"

echo
echo "Jardins Lentes"
sqlcmd -d Smart -i "Jardins Lentes - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Jardins Lentes - Hon Part NC.sql"
sqlcmd -d Smart -i "Jardins Lentes - MatMed.sql"
sqlcmd -d Smart -i "Jardins Lentes - ROB Part.sql"
sqlcmd -d Smart -i "Jardins Lentes - Vol Part.sql"

echo
echo "Focus Exames"
sqlcmd -d Smart -i "Lagarto Exames -  Hon Conv Med Ext.sql"
sqlcmd -d Smart -i "Lagarto Exames - Hon Conv Med Int.sql"
sqlcmd -d Smart -i "Lagarto Exames - Hon Part Med Ext.sql"
sqlcmd -d Smart -i "Lagarto Exames - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Lagarto Exames - Hon Part NC.sql"
sqlcmd -d Smart -i "Lagarto Exames - ROB Con.sql"
sqlcmd -d Smart -i "Lagarto Exames - ROB Part.sql"
sqlcmd -d Smart -i "Lagarto Exames - Vol Conv.sql"
sqlcmd -d Smart -i "Lagarto Exames - Vol Cort.sql"
sqlcmd -d Smart -i "Lagarto Exames - Vol Part.sql"
sqlcmd -d Smart -i "Lagarto Exames -MatMed.sql"

echo
echo "Lentes"
sqlcmd -d Smart -i "Lentes - Hon Part Med Int.sql"
sqlcmd -d Smart -i "Lentes - Hon Part NC.sql"
sqlcmd -d Smart -i "Lentes - ROB Part.sql"
sqlcmd -d Smart -i "Lentes - Vol Part.sql"
sqlcmd -d Smart -i "Lentes -MatMed.sql"

echo
echo "Pré-consulta"
sqlcmd -d Smart -i "Pre-Consulta - TEP e TAP.sql"
sqlcmd -d Smart -i "Pre-Consulta - TEC e TAC.sql"
sqlcmd -d Smart -i "Pre-Consulta - TER e TAR.sql"

echo
echo "Fim do Script"
echo
echo

