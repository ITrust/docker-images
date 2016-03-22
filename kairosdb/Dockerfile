FROM debian:jessie

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV KAIROSDB_VERSION 1.1.1

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

# Install Kairosdb
ADD https://github.com/kairosdb/kairosdb/releases/download/v${KAIROSDB_VERSION}/kairosdb_${KAIROSDB_VERSION}-1_all.deb .
RUN dpkg -i kairosdb_${KAIROSDB_VERSION}-1_all.deb && rm -f kairosdb_${KAIROSDB_VERSION}-1_all.deb


ADD kairosdb.properties /tmp/kairosdb.properties
ADD run_kairos.sh /usr/bin/run_kairos.sh
RUN chmod +x /usr/bin/run_kairos.sh

# Kairos ports
EXPOSE 8080
EXPOSE 4242
EXPOSE 2003
EXPOSE 2004

# Run kairosdb in foreground on boot
CMD [ "/usr/bin/run_kairos.sh" ]
