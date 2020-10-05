.\ps_container_creation_variables_mssql_advanced.ps1

docker run -e "ACCEPT_EULA=$env:mssql_container_eula" `
-e "SA_PASSWORD=$env:mssql_container_sa_passw" `
-e "MSSQL_AGENT_ENABLED=$env:mssql_container_agent" `
--volume=D:/SQLServer/Data/:C:/temp/ `-e attach_dbs="[{'dbName':'persistida','dbFiles':['C:\\temp\\persistida_data.mdf','C:\\temp\\persistida_log.ldf']}]" `--name $env:mssql_container_name `
--network $env:mssql_container_network `
--ip $env:mssql_container_ip `
-p $env:mssql_container_port `
-d $env:mssql_container_image