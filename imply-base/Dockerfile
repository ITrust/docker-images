FROM java:8-jre-alpine

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV IMPLY_MAJOR_VERSION="1.3"
ENV IMPLY_PATCH_VERSION="0"
ENV IMPLY_USER imply
ENV IMPLY_GROUP imply
ENV IMPLY_HOME /opt/imply

RUN apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl perl nodejs && rm -rf /var/cache/apk/*
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN mkdir /opt \
  && curl -sS http://static.imply.io/release/imply-${IMPLY_MAJOR_VERSION}.${IMPLY_PATCH_VERSION}.tar.gz | tar -xzf - -C /tmp \
  && mv /tmp/imply-* $IMPLY_HOME \
  && chown -R root:root $IMPLY_HOME

RUN addgroup ${IMPLY_GROUP} && adduser -D  -G ${IMPLY_GROUP} -s /bin/false ${IMPLY_USER}

ADD druid-base-entrypoint.sh /druid-base-entrypoint.sh
RUN chmod +x /druid-base-entrypoint.sh

WORKDIR $IMPLY_HOME

ENTRYPOINT ["/druid-base-entrypoint.sh"]