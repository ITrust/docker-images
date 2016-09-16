FROM graylog2/server:latest
MAINTAINER Clement Casse <ccasse@itrust.fr>

ENV CEF_PLUGIN_VERSION "1.1.0"

RUN wget -O "/tmp/GeoLite2-City.mmdb.gz" "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz" && \
    gunzip "/tmp/GeoLite2-City.mmdb.gz" && \
    chown graylog:graylog "/tmp/GeoLite2-City.mmdb" && \
    wget -O "/usr/share/graylog/plugin/graylog-plugin-input-cef-${CEF_PLUGIN_VERSION}.jar" \
      "http://github.com/Graylog2/graylog-plugin-cef/releases/download/${CEF_PLUGIN_VERSION}/graylog-plugin-input-cef-${CEF_PLUGIN_VERSION}.jar"
