from itrust/imply-base:1.3.0

ADD druid-query-entrypoint.sh /druid-query-entrypoint.sh
RUN chmod +x /druid-query-entrypoint.sh

ENTRYPOINT ["/druid-query-entrypoint.sh"]
CMD ["bin/supervise", "-c", "conf/supervise/query.conf"]

EXPOSE 8082 9095