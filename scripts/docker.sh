#!/bin/bash

# Copiar los archivos para la ejecucion en local
echo "Copiando archivos predict_flask.py y MakePrediction.scala..."
cp "archivos/docker/predict_flask.py" "${PROJECT_HOME}/resources/web"
cp "archivos/docker/MakePrediction.scala" "${PROJECT_HOME}/flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala"

# Cambiar al directorio de trabajo de scala
echo "Cambiando al directorio practica_creativa/flight_prediction..."
cd "${PROJECT_HOME}/flight_prediction"

# Compilar el archivo scala
echo "----------------------------------------------------------------"
echo "Compilando el archivo scala..."
echo "----------------------------------------------------------------"
sbt compile

# Empaquetar el archivo scala
echo "----------------------------------------------------------------"
echo "Empaquetando el archivo scala..."
echo "----------------------------------------------------------------"
sbt package

# Instrucciones para el usuario
echo
echo "----------------------------------------------------------------"
echo "¡ Archivos copiados y empaquetados !"
echo "----------------------------------------------------------------"
echo
echo "----------------------------------------------------------------"
echo "Iniciando ejecucion del docker compose..."
echo "----------------------------------------------------------------"
sudo systemctl stop mongod
cd "${PROJECT_HOME}"
docker-compose -f ../archivos/docker/docker-compose.yml up
