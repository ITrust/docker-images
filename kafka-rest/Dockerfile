FROM itrust/confluent:3.0


ADD start-kafka-rest.sh /usr/local/sbin/start-kafka-rest.sh

RUN chown -R ${CONFLUENT_USER}:${CONFLUENT_GROUP} ${CONFLUENT_HOME}/etc/kafka-rest /usr/local/sbin/start-kafka-rest.sh &&\
    chmod +x /usr/local/sbin/start-kafka-rest.sh

USER ${CONFLUENT_USER}

EXPOSE 9082

CMD [ "/usr/local/sbin/start-kafka-rest.sh" ]
