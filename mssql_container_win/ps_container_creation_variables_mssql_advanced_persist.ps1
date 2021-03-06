﻿# Variables que usaremos en otros scripts
$env:mssql_container_eula = 'Y'
$env:mssql_container_sa_passw = 'Sql_1234'
$env:mssql_container_agent = 'true'
$env:mssql_container_name = 'bonisql'
$env:mssql_container_port = '41433:1433'
$env:mssql_container_image = 'microsoft/mssql-server-windows-developer'
$env:mssql_container_hostname = 'sql_guest'
$env:mssql_container_network = 'nat'
$env:mssql_container_ip = '172.19.240.100'
$env:mssql_container_volume = 'D:/SQLServer/Data/:C:/temp/'
$env:mssql_container_attach = "[{'dbName':'persistida','dbFiles':['C:\\temp\\persistida_data.mdf','C:\\temp\\persistida_log.ldf']}]"
