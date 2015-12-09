FROM alpine
MAINTAINER mcottret@itrust.fr
RUN apk --update add socat
USER nobody
ENTRYPOINT ["socat"]
CMD ["-h"]
