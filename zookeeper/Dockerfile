FROM java:8-jre-alpine

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV ZOOKEEPER_VERSION 3.4.8

RUN apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl && rm -rf /var/cache/apk/*
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN  mkdir /opt \
  && curl -sS http://apache.mirrors.ovh.net/ftp.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /opt \
  && mv /opt/zookeeper-* /opt/zookeeper \
  && chown -R root:root /opt/zookeeper

RUN addgroup zookeeper && adduser -D  -G zookeeper -s /bin/false zookeeper \
  && mkdir /var/lib/zookeeper \
  && chown -R zookeeper:zookeeper /var/lib/zookeeper

EXPOSE 2181 2888 3888

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ADD start-zookeeper.sh /usr/local/sbin/start-zookeeper.sh

RUN chmod +x /usr/local/sbin/start-zookeeper.sh

ENTRYPOINT ["/usr/local/sbin/start-zookeeper.sh"]
