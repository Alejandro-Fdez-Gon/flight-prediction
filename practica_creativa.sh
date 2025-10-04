#!/bin/bash

# Comprobamos el argumento que se pasa al script
case "$1" in
    instalacion)
        echo "Ejecutando el script encargado de realizar todas las instalaciones..."
        ./scripts/dependencias.sh
        ;;
    modelos)
        echo "Ejecutando el script encargado de entrenar los modelos..."
        ./scripts/modelos.sh
        ;;
    ej_local)
        echo "Ejecutando el script para el despliegue en local..."
        ./scripts/local.sh
        ;;
    ej_docker)
        echo "Ejecutando el script para el despliegue en docker..."
        ./scripts/docker.sh
        ;;
    air_local)
        echo "Ejecutando el script para el despliegue local de Airflow..."
        ./scripts/air_local.sh
        ;;
    air_docker)
        echo "Ejecutando el script para el despliegue en docker de Airflow..."
        ./scripts/air_docker.sh
        ;;
    help|-h|--help)
        ./scripts/help.sh
        ;;
    *)
        echo "Comando no reconocido. Usa uno de los siguientes: air_local, air_docker, ej_docker, ej_local, instalacion, modelos ."
        echo "Si desea mas informacion use el parametro help / -h / --help"
        ;;
esac
