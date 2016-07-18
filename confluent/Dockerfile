FROM java:8-jre-alpine

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV SCALA_VERSION="2.11"
ENV CONFLUENT_MAJOR_VERSION="3.0"
ENV CONFLUENT_PATCH_VERSION="0"
ENV CONFLUENT_USER confluent
ENV CONFLUENT_GROUP confluent
ENV CONFLUENT_HOME /opt/confluent
ENV PATH $CONFLUENT_HOME:$PATH

RUN apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl && rm -rf /var/cache/apk/*
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN mkdir /opt \
  && curl -sS http://packages.confluent.io/archive/${CONFLUENT_MAJOR_VERSION}/confluent-${CONFLUENT_MAJOR_VERSION}.${CONFLUENT_PATCH_VERSION}-${SCALA_VERSION}.tar.gz | tar -xzf - -C /tmp \
  && mv /tmp/confluent-* $CONFLUENT_HOME \
  && chown -R root:root $CONFLUENT_HOME

RUN addgroup ${CONFLUENT_GROUP} && adduser -D  -G ${CONFLUENT_GROUP} -s /bin/false ${CONFLUENT_USER}
