FROM itrust/confluent:3.0

ENV KAFKA_LOGS "/var/log/kafka"
ENV KAFKA_LOG_DIRS "/var/lib/kafka"

ADD start-kafka.sh /usr/local/sbin/start-kafka.sh

RUN mkdir -p ${KAFKA_LOG_DIRS} ${KAFKA_LOGS} &&\
    chown -R ${CONFLUENT_USER}:${CONFLUENT_GROUP} ${KAFKA_LOG_DIRS} ${KAFKA_LOGS} ${CONFLUENT_HOME}/etc/kafka/server.properties /usr/local/sbin/start-kafka.sh &&\
    chmod +x /usr/local/sbin/start-kafka.sh


USER ${CONFLUENT_USER}
VOLUME ["${KAFKA_LOG_DIRS}", "${KAFKA_LOGS}"]
EXPOSE 9092

ENTRYPOINT ["/usr/local/sbin/start-kafka.sh"]
CMD ${CONFLUENT_HOME}/bin/kafka-server-start ${CONFLUENT_HOME}/etc/kafka/server.properties
