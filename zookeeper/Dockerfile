FROM debian:jessie

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV ZOOKEEPER_VERSION 3.4.8

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

RUN curl -sS http://apache.mirrors.ovh.net/ftp.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /opt \
  && mv /opt/zookeeper-* /opt/zookeeper \
  && chown -R root:root /opt/zookeeper

RUN groupadd -r zookeeper \
  && useradd -c "Zookeeper" -d /var/lib/zookeeper -g zookeeper -M -r -s /sbin/nologin zookeeper \
  && mkdir /var/lib/zookeeper \
  && chown -R zookeeper:zookeeper /var/lib/zookeeper

EXPOSE 2181 2888 3888

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ADD start-zookeeper.sh /usr/local/sbin/start-zookeeper.sh

RUN chmod +x /usr/local/sbin/start-zookeeper.sh

ENTRYPOINT ["/usr/local/sbin/start-zookeeper.sh"]
