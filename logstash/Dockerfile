from logstash:2
MAINTAINER Maxime Cottret <mcottret@itrust.fr>
VOLUME ["/config-dir"]
RUN apt-get update && apt-get install -y libzmq3-dev && \
    rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN gosu /opt/logstash/bin/logstash-plugin install logstash-input-beats
RUN gosu /opt/logstash/bin/logstash-plugin install logstash-filter-translate

