FROM debian:stretch-slim

ARG NODE_VERSION="6.x"
# Available values `https://github.com/wazuh/wazuh/releases`
ARG OSSEC_VERSION="v2.1.1"
# Available values `https://github.com/wazuh/wazuh-api/releases`
ARG OSSEC_API_VERSION="v2.1.1"

ENV DEBIAN_FRONTEND="noninteractive"

COPY ./preloaded-vars.conf /tmp/preloaded-vars.conf

## System preparation: update system, install requirements, download sources
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        apache2-utils \
        curl \
        gcc \
        git \
        gnupg2 \
        libc6-dev \
        libssl-dev \
        make \
        procps \
        python2.7 \
        python-pip \
 && curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}" | bash - \
 && apt-get install -y nodejs \
 && pip install xmljson \
 && mkdir -p "/tmp/ossec-source" \
 && curl -L "https://github.com/wazuh/wazuh/archive/${OSSEC_VERSION}.tar.gz" | tar -xz -C "/tmp/ossec-source" --strip-components=1 \
 && rm "/tmp/ossec-source/etc/preloaded-vars.conf" \
 && mv "/tmp/preloaded-vars.conf" "/tmp/ossec-source/etc/preloaded-vars.conf" \
 && cd "/tmp/ossec-source" \
 && bash ./install.sh \
 && mkdir -p "/var/ossec/etc/custom_decoders" \
 && chgrp ossec "/var/ossec/etc/custom_decoders" \
 && curl -s -o install_api.sh "https://raw.githubusercontent.com/wazuh/wazuh-api/${OSSEC_API_VERSION}/install_api.sh" \
 && bash ./install_api.sh download \
 && rm -rf "/tmp/*" \
 && apt-get autoremove --purge -y \
        gcc \
        git \
        gnupg2 \
        make \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/ossec

COPY ./generate-api-conf.sh ./generate-api-conf.sh
COPY ./generate-ossec-conf.sh ./generate-ossec-conf.sh
COPY ./entrypoint.sh ./entrypoint.sh
RUN chmod u+x ./generate-api-conf.sh ./generate-ossec-conf.sh ./entrypoint.sh

VOLUME ["/var/ossec/config", "/var/ossec/logs", "/var/ossec/stats"]
EXPOSE 1514 1515 55000

CMD [ "./entrypoint.sh" ]
