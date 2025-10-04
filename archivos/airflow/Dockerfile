FROM apache/airflow:2.10.4
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" iso8601 findspark numpy scikit-learn
USER root
RUN apt-get update && apt-get install -y wget && \
    wget http://www.mirbsd.org/~tg/Debs/sources.txt/wtf-bookworm.sources && \
    mkdir -p /etc/apt/sources.list.d && \
    mv wtf-bookworm.sources /etc/apt/sources.list.d/ && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    wget -q https://archive.apache.org/dist/spark/spark-3.3.0/spark-3.3.0-bin-hadoop3.tgz && \
    tar -xf spark-3.3.0-bin-hadoop3.tgz && \
    rm spark-3.3.0-bin-hadoop3.tgz && \
    mv spark-3.3.0-bin-hadoop3 /opt/spark
ENV SPARK_HOME=/opt/spark                    
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
USER airflow
