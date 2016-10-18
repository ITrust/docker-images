from logstash:2
VOLUME ["/config-dir"]
RUN apt-get update && apt-get install -y libzmq3-dev && \
    rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN /opt/logstash/bin/logstash-plugin install logstash-filter-translate
RUN /opt/logstash/bin/logstash-plugin install logstash-input-beats
RUN /opt/logstash/bin/logstash-plugin install logstash-codec-cef
RUN /opt/logstash/bin/logstash-plugin install logstash-filter-cidr

