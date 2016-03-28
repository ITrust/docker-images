FROM java:8-jre-alpine

MAINTAINER Maxime COTTRET <mcottret@itrust.fr>

ENV KAIROSDB_VERSION 1.1.1

RUN apk add --update --no-cache bash gawk sed grep bc coreutils gettext curl && rm -rf /var/cache/apk/*
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

# Install Kairosdb
RUN  mkdir /opt \
  && curl -sSL https://github.com/kairosdb/kairosdb/releases/download/v${KAIROSDB_VERSION}/kairosdb-${KAIROSDB_VERSION}-1.tar.gz | tar -xzf - -C /opt \
  && chown -R root:root /opt/kairosdb

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
