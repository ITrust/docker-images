FROM docker.elastic.co/logstash/logstash-oss:6.1.1

RUN bin/logstash-plugin install logstash-output-gelf \
 && bin/logstash-plugin install logstash-output-syslog \
 && bin/logstash-plugin install logstash-filter-alter 
