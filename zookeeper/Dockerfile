FROM itrust/confluent:3.0

ENV ZK_DATA_DIR "/var/lib/zookeeper"
ENV KAFKA_LOG4J_OPTS -Dlog4j.configuration=file:${CONFLUENT_HOME}/etc/kafka/log4j.properties

ADD start-zookeeper.sh /usr/local/sbin/start-zookeeper.sh

# Send all logs to stdout (so that they are shown by `docker logs`)
RUN rm ${CONFLUENT_HOME}/etc/kafka/log4j.properties &&\
    echo 'log4j.rootLogger=INFO, stdout' >> ${CONFLUENT_HOME}/etc/kafka/log4j.properties &&\
    echo 'log4j.appender.stdout=org.apache.log4j.ConsoleAppender' >> ${CONFLUENT_HOME}/etc/kafka/log4j.properties &&\
    echo 'log4j.appender.stdout.layout=org.apache.log4j.PatternLayout' >> ${CONFLUENT_HOME}/etc/kafka/log4j.properties &&\
    echo 'log4j.appender.stdout.layout.ConversionPattern=[%d] %p %m (%c)%n' >> ${CONFLUENT_HOME}/etc/kafka/log4j.properties &&\
    mkdir ${ZK_DATA_DIR} &&\
    chown -R ${CONFLUENT_GROUP}:${CONFLUENT_USER} ${ZK_DATA_DIR} /usr/local/sbin/start-zookeeper.sh ${CONFLUENT_HOME}/etc/kafka/zookeeper.properties &&\
    chmod +x /usr/local/sbin/start-zookeeper.sh



RUN chmod +x /usr/local/sbin/start-zookeeper.sh

USER ${CONFLUENT_USER}
VOLUME ["${ZK_DATA_DIR}"]

ENTRYPOINT ["/usr/local/sbin/start-zookeeper.sh"]
