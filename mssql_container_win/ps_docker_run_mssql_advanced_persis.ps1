# Cargamos nuestras variables
.\ps_container_creation_variables_mssql_advanced_persist.ps1

# Levantamos nuestro contenedor
docker run -e "ACCEPT_EULA=$env:mssql_container_eula" `
-e "SA_PASSWORD=$env:mssql_container_sa_passw" `
-e "MSSQL_AGENT_ENABLED=$env:mssql_container_agent" `
--volume=$env:mssql_container_volume `-e attach_dbs=$env:mssql_container_attach `--name $env:mssql_container_name `
--network $env:mssql_container_network `
--ip $env:mssql_container_ip `
-p $env:mssql_container_port `
-d $env:mssql_container_image