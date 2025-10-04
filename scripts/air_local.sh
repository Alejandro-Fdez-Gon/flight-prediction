#!/bin/bash

# Activar el entorno virtual para airflow
cd practica_creativa
source ./resources/airflow/env_air/bin/activate

# Configurar la base de datos de Airflow
echo "----------------------------------------------------------------"
echo "Configurando la DB de Airflow..."
echo "----------------------------------------------------------------"
airflow db init

# Crear usuario admin
echo "----------------------------------------------------------------"
echo "Creando un usuario..."
echo "----------------------------------------------------------------"
airflow users create \
    --username admin \
    --firstname Peter \
    --lastname Parker \
    --role Admin \
    --email spiderman@superhero.org

# Arrancar Airflow con el servidor web y el scheduler
echo
echo "----------------------------------------------------------------"
echo "Instrucciones a seguir para la ejecución del programa"
echo "----------------------------------------------------------------"
echo "Arranque dos terminales, incluida esta, y ejecute los siguientes comandos"
echo
echo "----------------------------------------------------------------"
echo "Terminal 1: Lanzamiento del Scheduler de Airflow"
echo "----------------------------------------------------------------"
echo "source ${AIRFLOW_HOME}/env_air/bin/activate"
echo "airflow scheduler"
echo
echo "----------------------------------------------------------------"
echo "Terminal 2: Lanzamiento del Webserver de Airflow"
echo "----------------------------------------------------------------"
echo "source ${AIRFLOW_HOME}/env_air/bin/activate"
echo "airflow webserver --port 8080"
echo
