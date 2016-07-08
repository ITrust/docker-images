from itrust/imply-base:1.3.0

ADD druid-master-entrypoint.sh /druid-master-entrypoint.sh
RUN chmod +x /druid-master-entrypoint.sh

ENTRYPOINT ["/druid-master-entrypoint.sh"]
CMD ["bin/supervise", "-c", "conf/supervise/master-no-zk.conf"]

EXPOSE 1527 8081 8090