from itrust/imply-base:1.3.0

ADD druid-data-entrypoint.sh /druid-data-entrypoint.sh
RUN chmod +x /druid-data-entrypoint.sh

ENTRYPOINT ["/druid-data-entrypoint.sh"]
CMD ["bin/supervise", "-c", "conf/supervise/data.conf"]

EXPOSE 8083 8091 8100-8199 8200