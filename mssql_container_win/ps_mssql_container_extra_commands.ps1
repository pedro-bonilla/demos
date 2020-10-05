# Cargar variables
.\ps_container_creation_variables_mssql_advanced.ps1

# Arrancar el contenedor
.\ps_docker_run_mssql_advanced.ps1

# Parar y volver a arrancar el contenedor
docker container stop bonisql
docker ps -a
docker container start bonisql
docker ps -a 

# Comprobar la ip asignada a un contenedor
docker container inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bonisql

# Probar una consulta
$ConnectionString = "Data source=172.19.240.100;Initial Catalog= master;User Id=sa;Password=Sql_1234"
Invoke-Sqlcmd -ConnectionString $ConnectionString -Query "SELECT 1"


# Una forma de comprobar el log
$path_log = docker inspect --format='{{.LogPath}}' bonisql
notepad2.exe $path_log