FROM java:8-jre

MAINTAINER Maxime Cottret <mcottret@itrust.fr>

ENV SPARK_VERSION 1.5.1
ENV HADOOP_VERSION hadoop2.6
ENV SCALA_VERSION 2.10
ENV ELASTIC_VERSION 2.1.1

# miniconda installation
RUN apt-get update --fix-missing && apt-get install -y vim wget curl bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.10.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.10.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.14.1

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

#spark installation
RUN mkdir /opt/externals

RUN pip install py2neo elasticsearch && \
    curl http://mirrors.ircam.fr/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz | tar -xz -C /opt/ && \
    wget -qO- -O /opt/externals/elasticsearch-hadoop-${ELASTIC_VERSION}.jar http://central.maven.org/maven2/org/elasticsearch/elasticsearch-hadoop/${ELASTIC_VERSION}/elasticsearch-hadoop-${ELASTIC_VERSION}.jar && \
    wget -qO- -O /opt/externals/elasticsearch-spark_${SCALA_VERSION}-${ELASTIC_VERSION}.jar http://central.maven.org/maven2/org/elasticsearch/elasticsearch-spark_${SCALA_VERSION}/${ELASTIC_VERSION}/elasticsearch-spark_${SCALA_VERSION}-${ELASTIC_VERSION}.jar && \
    wget -qO- -O /opt/externals/spark-streaming-kafka-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar http://central.maven.org/maven2/org/apache/spark/spark-streaming-kafka-assembly_${SCALA_VERSION}/${SPARK_VERSION}/spark-streaming-kafka-assembly_${SCALA_VERSION}-${SPARK_VERSION}.jar

RUN ln -s /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION} /opt/spark
ENV SPARK_HOME /opt/spark
ENV PATH /opt/spark/bin:/opt/spark/sbin:${PATH}

EXPOSE 4040