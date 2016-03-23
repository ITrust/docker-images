FROM debian:jessie

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV KAFKA_VERSION 0.9.0.1
ENV KAFKA_HOME /opt/kafka

RUN apt-get update && apt-get install -y --force-yes curl software-properties-common python-software-properties gettext && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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

RUN curl -sS http://apache.mirrors.ovh.net/ftp.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.11-${KAFKA_VERSION}.tgz  | tar -xzf - -C /tmp \
  && mv /tmp/kafka_* $KAFKA_HOME \
  && chown -R root:root $KAFKA_HOME

RUN groupadd -r kafka \
  && useradd -c "Kafka" -d /var/lib/kafka -g kafka -M -r -s /sbin/nologin kafka \
  && mkdir /var/lib/kafka \
  && mkdir /var/log/kafka \
  && chown -R kafka:kafka /var/lib/kafka \
  && chown -R kafka:kafka /var/log/kafka

EXPOSE 9092

VOLUME ["/var/lib/kafka"]

ADD start-kafka.sh /usr/local/sbin/start-kafka.sh

RUN chmod +x /usr/local/sbin/start-kafka.sh

ENTRYPOINT ["/usr/local/sbin/start-kafka.sh"]
