FROM java:8-jre

MAINTAINER Maxime Cottret <mcottret@itrust.fr>

ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION hadoop2.6
ENV SCALA_VERSION 2.10
ENV ELASTIC_VERSION 2.1.1

RUN mkdir /opt/externals

RUN apt-get update && apt-get install -y vim curl wget python-pip python-dev && \
    pip install py2neo && \
    curl http://mirrors.ircam.fr/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz | tar -xz -C /opt/ && \
    wget -qO- -O /opt/externals/elasticsearch-hadoop-${ELASTIC_VERSION}.jar http://central.maven.org/maven2/org/elasticsearch/elasticsearch-hadoop/${ELASTIC_VERSION}/elasticsearch-hadoop-${ELASTIC_VERSION}.jar && \
    wget -qO- -O /opt/externals/elasticsearch-spark_${SCALA_VERSION}-${ELASTIC_VERSION}.jar http://central.maven.org/maven2/org/elasticsearch/elasticsearch-spark_${SCALA_VERSION}/${ELASTIC_VERSION}/elasticsearch-spark_${SCALA_VERSION}-${ELASTIC_VERSION}.jar && \
    wget -qO- -O /opt/externals/spark-streaming-kafka-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar http://central.maven.org/maven2/org/apache/spark/spark-streaming-kafka-assembly_${SCALA_VERSION}/${SPARK_VERSION}/spark-streaming-kafka-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar

RUN ln -s /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} /opt/spark
ENV SPARK_HOME /opt/spark
ENV PATH /opt/spark/bin:/opt/spark/sbin:${PATH}

EXPOSE 4040