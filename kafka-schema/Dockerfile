FROM itrust/confluent:3.0

ADD start-schema-registry.sh /usr/local/sbin/start-schema-registry.sh

# Send all logs to stdout (so that they are shown by `docker logs`)
RUN chown -R ${CONFLUENT_USER}:${CONFLUENT_GROUP} ${CONFLUENT_HOME}/etc/schema-registry/schema-registry.properties /usr/local/sbin/start-schema-registry.sh &&\
    chmod +x /usr/local/sbin/start-schema-registry.sh

USER $CONFLUENT_USER
EXPOSE 9081

ENTRYPOINT ["/usr/local/sbin/start-schema-registry.sh"]
