FROM debian:jessie

MAINTAINER Maxime Cottret <mcottret@itrust.fr>

ENV SPARK_VERSION 1.6.0
ENV HADOOP_VERSION hadoop2.6

# miniconda installation
RUN apt-get update --fix-missing && apt-get install -y wget curl bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.16.0-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.16.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.16.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.18.3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# JAVA
ENV JAVA_HOME /usr/jdk1.8.0_31
ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# SPARK
ENV SPARK_VERSION 1.6.0
ENV HADOOP_VERSION 2.6
ENV SPARK_PACKAGE spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION
ENV SPARK_HOME /usr/$SPARK_PACKAGE
ENV PATH $PATH:$SPARK_HOME/bin
RUN curl -sL --retry 3 \
  "http://d3kbcqa49mib13.cloudfront.net/$SPARK_PACKAGE.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $SPARK_HOME /usr/spark

# JUPYTER
ADD *.sh /usr/spark/
RUN chmod +x /usr/spark/*.sh
RUN mkdir -p /root/.ivy2/jars
RUN conda install jupyter && conda clean -yt

# configure IPYTHON_OPTS
RUN mkdir -p /root/.jupyter
ADD jupyter_notebook_config.py /root/.jupyter/
RUN mkdir /notebooks
VOLUME ['/notebooks']
WORKDIR /notebooks
