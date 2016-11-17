FROM alpine:latest
MAINTAINER CHristopher HALMA <chalma@itrust.fr>

RUN  apk add --update rsyslog && \ 
        apk update --repository http://dl-3.alpinelinux.org/alpine/edge/main && \
	apk add  --repository http://dl-3.alpinelinux.org/alpine/edge/main rsyslog-hiredis rsyslog-tls\
	&& rm -rf /var/cache/apk/*

COPY ./etc/rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]
