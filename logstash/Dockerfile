FROM docker.elastic.co/logstash/logstash-oss:6.2.3

RUN bin/logstash-plugin install logstash-output-gelf \
 && bin/logstash-plugin install logstash-output-syslog \
 && bin/logstash-plugin install logstash-filter-alter 
