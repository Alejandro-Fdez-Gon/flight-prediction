#!/bin/bash

# Copiar los archivos para la ejecucion en local
echo "Copiando archivos predict_flask.py y MakePrediction.scala..."
cp "archivos/local/predict_flask.py" "${PROJECT_HOME}/resources/web"
cp "archivos/local/MakePrediction.scala" "${PROJECT_HOME}/flight_prediction/src/main/scala/es/upm/dit/ging/predictor/MakePrediction.scala"

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

# Arrancar mongod de MongoDB
echo "----------------------------------------------------------------"
echo "Arrancando MongoDB..."
echo "----------------------------------------------------------------"
sudo systemctl start mongod

# Instrucciones para el usuario
echo
echo "----------------------------------------------------------------"
echo "¡ Archivos copiados y empaquetados !"
echo "----------------------------------------------------------------"
echo
echo "----------------------------------------------------------------"
echo "Instrucciones a seguir para la ejecución del programa"
echo "----------------------------------------------------------------"
echo "Arranque cuatro terminales, incluida esta, y ejecute los siguientes comandos"
echo
echo "----------------------------------------------------------------"
echo "Terminal 1: Lanzamiento de Zookeeper"
echo "----------------------------------------------------------------"
echo "${PROJECT_HOME}/kafka_2.12-3.4.0/bin/zookeeper-server-start.sh ${PROJECT_HOME}/kafka_2.12-3.4.0/config/zookeeper.properties"
echo
echo "----------------------------------------------------------------"
echo "Terminal 2: Lanzamiento de Apache Kafka"
echo "----------------------------------------------------------------"
echo "${PROJECT_HOME}/kafka_2.12-3.4.0/bin/kafka-server-start.sh ${PROJECT_HOME}/kafka_2.12-3.4.0/config/server.properties"
echo
echo "----------------------------------------------------------------"
echo "Terminal 3: Lanzamiento de Scala"
echo "----------------------------------------------------------------"
echo "spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local[*] --packages org.mongodb.spark:mongo-spark-connector_2.12:10.1.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0 $PROJECT_HOME/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar"
echo
echo "----------------------------------------------------------------"
echo "Terminal 4: Lanzamiento de Flask"
echo "----------------------------------------------------------------"
echo "source ${PROJECT_HOME}/env/bin/activate"
echo "python3 ${PROJECT_HOME}/resources/web/predict_flask.py"
