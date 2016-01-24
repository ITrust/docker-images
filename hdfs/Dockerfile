FROM debian:jessie

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

RUN apt-get update && apt-get install -y --force-yes curl software-properties-common python-software-properties

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

WORKDIR /opt

ENV HADOOP_VERSION 2.6.3
RUN curl -s http://apache.mirrors.ovh.net/ftp.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -xz -C /opt/

RUN ln -s hadoop-${HADOOP_VERSION} hadoop

ENV HADOOP_HOME /opt/hadoop

RUN mkdir -p /opt/scripts
COPY files/* /opt/scripts/
RUN chmod +x /opt/scripts/*.sh
RUN mkdir /mnt/namenode && mkdir /mnt/datanode

EXPOSE 8020 50010 50020 50070 50075
