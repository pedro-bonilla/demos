# Env variables to be used on a later creation of a mssql container for testing
$env:mssql_container_eula = 'Y'
$env:mssql_container_sa_passw = 'Sql_1234'
$env:mssql_container_agent = 'true'
$env:mssql_container_name = 'bonisql'
$env:mssql_container_port = '1433:1433'
$env:mssql_container_image = 'microsoft/mssql-server-windows-developer'