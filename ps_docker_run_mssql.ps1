# This command line requires $env:mssql_container to be precreated. 
# Run .\ps_container_creation_variables_mssql.ps1

docker run -e "ACCEPT_EULA=$env:mssql_container_eula" `
-e "sa_password=$env:mssql_container_sa_passw" `
-e "MSSQL_AGENT_ENABLED=$env:mssql_container_agent" `
--name $env:mssql_container_name `
-p $env:mssql_container_port `
-d $env:mssql_container_image
