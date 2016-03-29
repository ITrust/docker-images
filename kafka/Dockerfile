FROM java:8-jre-alpine

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV KAFKA_VERSION 0.8.2.2
ENV KAFKA_HOME /opt/kafka

RUN apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl && rm -rf /var/cache/apk/*
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN mkdir /opt \
  && curl -sS http://apache.mirrors.ovh.net/ftp.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.10-${KAFKA_VERSION}.tgz  | tar -xzf - -C /tmp \
  && mv /tmp/kafka_* $KAFKA_HOME \
  && chown -R root:root $KAFKA_HOME

RUN addgroup kafka && adduser -D  -G kafka -s /bin/false kafka \
  && mkdir /var/lib/kafka \
  && mkdir /var/log/kafka \
  && chown -R kafka:kafka /var/lib/kafka \
  && chown -R kafka:kafka /var/log/kafka

EXPOSE 9092

VOLUME ["/var/lib/kafka"]

ADD start-kafka.sh /usr/local/sbin/start-kafka.sh

RUN chmod +x /usr/local/sbin/start-kafka.sh

ENTRYPOINT ["/usr/local/sbin/start-kafka.sh"]
