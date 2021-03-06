#!/bin/bash

# Script para listagem e montagem do JSON com as bases de dados
# Raul Libório, rauhmaru@opensuse.org / gmail.com

# Credenciais do banco
User=operador
Pwd="operador"

# Adicione aqui as bases de dados que nao queira que sejam monitoradas, separadas por pipe "|"
## 1. Não remova a primeira palavra "Database"

BasesExcluidas="Database|information_schema|lost\+found|performance_schema"

# Listagem das bases
ArrayBancos=($(mysql -u $User -hlocalhost -p$Pwd -e 'show databases;'|egrep -v "$BasesExcluidas"))

# Construção do JSON
echo -e "{\n\t\"data\":[\n"
Final=$(( ${#ArrayBancos[@]} - 1 ))
for Contador in $( seq 0 $Final ); do
        echo -e "\t{"
        echo -e "\t\t\"{#BASE}\":\"${ArrayBancos[$Contador]}\""
        if [[ $Contador -ne $Final ]]; then
                echo -e "\t},\n"
        else
                echo -e "\t}\n\t]\n}"

        fi
done
