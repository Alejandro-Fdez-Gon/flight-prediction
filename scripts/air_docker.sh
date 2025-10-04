# Configurar la base de datos de Airflow
echo "----------------------------------------------------------------"
echo "Desplegando Airflow mediante contenedores docker..."
echo "----------------------------------------------------------------"
cd ${PROJECT_HOME}
docker-compose -f ../archivos/airflow/docker-compose.yml up
