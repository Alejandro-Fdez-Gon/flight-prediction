#!/bin/bash

# Descargar repositorio de github
echo "----------------------------------------------------------------"
echo "Clonando el repositorio de GitHub..."
echo "----------------------------------------------------------------"
git clone https://github.com/Big-Data-ETSIT/practica_creativa.git

# Cambiar al directorio del repositorio
echo "----------------------------------------------------------------"
echo "Cambiando al directorio practica_creativa..."
echo "----------------------------------------------------------------"
cd practica_creativa

# Descargar datos
echo "----------------------------------------------------------------"
echo "Descargando datos necesarios..."
echo "----------------------------------------------------------------"
resources/download_data.sh

# Actualizar el sistema e instalar python3-venv
echo "----------------------------------------------------------------"
echo "Actualizacion del sistema e instalacion de python3-env..."
echo "----------------------------------------------------------------"
sudo apt update
sudo apt install -y python3-venv

# Crear un entorno virtual y activarlo
echo "----------------------------------------------------------------"
echo "Creando y activando el entorno virtual..."
echo "----------------------------------------------------------------"
python3 -m venv env
source env/bin/activate

# Instalar las dependencias de Python
echo "----------------------------------------------------------------"
echo "Instalando las dependencias de Python..."
echo "----------------------------------------------------------------"
pip install -r requirements.txt

# Instalar SBT
echo "----------------------------------------------------------------"
echo "Instalando SBT..."
echo "----------------------------------------------------------------"
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install -y sbt

# Instalar MongoDB
echo "----------------------------------------------------------------"
echo "Instalando y configurando MongoDB..."
echo "----------------------------------------------------------------"
sudo apt-get install gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
./resources/import_distances.sh
mkdir -p mongo/scripts mongo/data
cp ../archivos/docker/import_distances.sh ./mongo/scripts
cp ./data/origin_dest_distances.jsonl ./mongo/scripts
sudo systemctl stop mongod

# Instalar OpenJDK 8 y Spark
echo "----------------------------------------------------------------"
echo "Instalando OpenJDK y Spark..."
echo "----------------------------------------------------------------"
sudo apt install -y openjdk-8-jdk
wget https://archive.apache.org/dist/spark/spark-3.3.3/spark-3.3.3-bin-hadoop3.tgz
tar -xvf spark-3.3.3-bin-hadoop3.tgz
sudo mv spark-3.3.3-bin-hadoop3 /opt/spark

# Instalar Scala
echo "----------------------------------------------------------------"
echo "Instalando Scala..."
echo "----------------------------------------------------------------"
wget https://downloads.lightbend.com/scala/2.12.10/scala-2.12.10.tgz
tar -xvzf scala-2.12.10.tgz
sudo mv scala-2.12.10 /opt/scala

# Instalar Kafka
echo "----------------------------------------------------------------"
echo "Instalando Kafka y Zookeeper..."
echo "----------------------------------------------------------------"
wget https://archive.apache.org/dist/kafka/3.4.0/kafka_2.12-3.4.0.tgz
tar -xvzf kafka_2.12-3.4.0.tgz

# Instalar Docker
echo "----------------------------------------------------------------"
echo "Instalando Docker..."
echo "----------------------------------------------------------------"
sudo apt install docker.io -y
sudo apt install docker-compose -y
sudo usermod -aG docker $USER

# Instalar Airflow
echo "----------------------------------------------------------------"
echo "Instalando Airflow..."
echo "----------------------------------------------------------------"
deactivate
python3 -m venv ./resources/airflow/env_air
source ./resources/airflow/env_air/bin/activate
AIRFLOW_VERSION=2.10.4
PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
pip install iso8601 findspark numpy scikit-learn
mkdir -p resources/airflow/dags resources/airflow/logs resources/airflow/plugins
mv resources/airflow/setup.py resources/airflow/dags/train.py

# Configurar las variables de entorno de forma permanente
echo "----------------------------------------------------------------"
echo "Configurando las variables de entorno..."
echo "----------------------------------------------------------------"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> ~/.bashrc
echo "export SCALA_HOME=/opt/scala" >> ~/.bashrc
echo "export PATH=\$PATH:\$SCALA_HOME/bin" >> ~/.bashrc
echo "export SPARK_MASTER=spark://spark-master:7077" >> ~/.bashrc
echo "export PROJECT_HOME=$(pwd)" >> ~/.bashrc
echo "export AIRFLOW_HOME=$(pwd)/resources/airflow" >> ~/.bashrc
echo "export AIRFLOW__CORE__LOAD_EXAMPLES=False" >> ~/.bashrc
echo "export AIRFLOW_UID=$(id -u)" >> ~/.bashrc

# Limpiar archivos descargados
echo "----------------------------------------------------------------"
echo "Limpiando los archivos descargados..."
echo "----------------------------------------------------------------"
sudo rm kafka_2.12-3.4.0.tgz
sudo rm libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo rm scala-2.12.10.tgz
sudo rm spark-3.3.3-bin-hadoop3.tgz

echo "----------------------------------------------------------------"
echo "¡ Instalacion finalizada !"
echo "----------------------------------------------------------------"
echo "Recuerde actualizar las variables de entorno mediante el comando: source ~/.bashrc"
echo "Por favor, reinicie su sesión o ejecute tambien el siguiente comando para aplicar" 
echo -e "\tlos cambios de Docker: newgrp docker"
