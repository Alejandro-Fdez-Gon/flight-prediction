#!/bin/bash

# Cambiar al directorio del repositorio
echo "----------------------------------------------------------------"
echo "Cambiando al directorio practica_creativa..."
echo "----------------------------------------------------------------"
cd practica_creativa

# Activamos el entorno virtual de python
echo "----------------------------------------------------------------"
echo "Activando entorno virtual..."
echo "----------------------------------------------------------------"
source env/bin/activate

# Entrenamiento de los modelos
echo "----------------------------------------------------------------"
echo "Creacion de los modelos..."
echo "----------------------------------------------------------------"
python3 resources/train_spark_mllib_model.py .

echo "----------------------------------------------------------------"
echo "¡ Creacion finalizada !"
echo "----------------------------------------------------------------"
