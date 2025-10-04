# Realtime Predictive Analytics Course

This repository contains the **final project** developed for the **Big Data: Fundamentals and Infrastructure** course, part of the second year of the Master’s Degree in Telecommunication Engineering.  

The goal of the project is to implement a **realtime predictive analytics system** using **PySpark, Kafka, MongoDB**, and other Big Data tools.  

## 🖥️ System Overview  

The project implements a **realtime data processing pipeline** that allows submitting data through a web interface, processing it in a Spark Streaming job, storing results in MongoDB, and displaying predictions to the user.  

### Frontend Architecture  

The frontend collects user input via a web form and sends it to the backend. The server generates a request message with the necessary derived fields and sends it to a Kafka topic. The client receives a UUID to poll for results.  

### Backend Architecture  

The backend includes:  
- **Batch processing**: Historical data is processed in PySpark to train predictive models.  
- **Realtime processing**: Spark Streaming listens to Kafka topics for prediction requests, runs the model, and stores results in MongoDB.  

This architecture allows **using the same model for both batch and realtime predictions**.  

## ⚙️ Installation  

Install the components required for the system. Suggested versions:  

- **Python 3.7+**: [Installation guide](https://realpython.com/installing-python/)  
- **MongoDB 6.0+**: [Installation guide](https://docs.mongodb.com/manual/installation/)  
- **Apache Spark 3.3+**: [Installation guide](https://spark.apache.org/docs/latest/)  
- **Kafka 3.4+**: [Quickstart guide](https://kafka.apache.org/quickstart)  

### Python Environment  

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### Start Kafka and Zookeeper

1. **Start Zookeeper**  
```bash
bin/zookeeper-server-start.sh config/zookeeper.properties
```

2. **Start Kafka**  
```bash
bin/kafka-server-start.sh config/server.properties
```

3. **Create Prediction Topic**  
```bash
bin/kafka-topics.sh --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 1 \
  --topic prediction_requests
```

### Setup MongoDB

1. **Check MongoDB Status**  

```bash
# If installed directly
service mongod status

# If using Docker
docker ps
docker logs mongo
```

2. **Import Initial Data**  

```bash
./resources/import_distances.sh
```

3. **Verify Imported Records*  

```bash
mongo
use big_data_project
db.predictions.find()
```

### Train Model with PySpark

1. **Go to resources directory**  

```bash
cd resources
```

2. **Set environment variables**

```bash
export JAVA_HOME=/path/to/java
export SPARK_HOME=/path/to/spark
```

3. Run the training script

```bash
python3 train_spark_mllib_model.py .
```

4. Check output

```bash
ls ../models
```

### Run Realtime Prediction

1. **Set project path**  

```bash
export PROJECT_HOME=/path/to/practica_creativa
```

2. **Go to the web application directory**  

```bash
cd resources/web
```

3. **Run the Flask application**  

```bash
python3 predict_flask.py
```

4. **Open the web interface**

Visit http://localhost:5000/flights/delays/predict_kafka and enter:
- Non-zero departure delay
- ISO-formatted date (e.g., 2016-12-25)
- Valid carrier code (AA or DL)
- Origin and destination airports (e.g., ATL → SFO)
- Flight number (e.g., 1519)
- The prediction will appear once the Spark Streaming job processes it.

### 🛠️ Automation Scripts

Several shell scripts have been created to automate installation, training, and deployment processes:

```bash
./practica_creativa.sh <command>
```

**Available commands:**

| Command      | Description                                                   |
|-------------|---------------------------------------------------------------|
| instalacion | Installs all dependencies and configures the environment.    |
| modelos     | Trains all predictive models.                                 |
| ej_local    | Copies files, compiles Scala, and runs the system locally.   |
| ej_docker   | Copies files, compiles Scala, and runs the system using Docker. |
| air_local   | Deploys Airflow locally with the DAG loaded.                 |
| air_docker  | Deploys Airflow via Docker.                                   |
| help        | Displays help information.                                    |

These scripts manage all the complex steps, including:

- Cloning the repository and downloading datasets  
- Installing Python, MongoDB, Spark, Scala, Kafka, Docker, and Airflow  
- Configuring environment variables  
- Training models and running the prediction system locally or via Docker  
- Deploying Apache Airflow with database initialization and user creation  

Use these scripts to **simplify project setup and execution**.
