FROM python:2

ENV DJANGO_STATIC_DIR "/usr/src/FIR/static"

RUN mkdir -p /usr/src

RUN apt-get update && apt-get install -y netcat && \
    pip install mysql-python && \
    cd /usr/src && \
    git clone "https://github.com/certsocietegenerale/FIR.git"

WORKDIR /usr/src/FIR

COPY ./entrypoint.sh .
COPY ./set_default_data.sh .

RUN mkdir -p "${DJANGO_STATIC_DIR}" && \
    groupadd -r fir && \
    useradd -r -g fir -d "$(pwd)" -s /sbin/nologin -c "FIR user" fir && \
    chown -R fir:fir "$(pwd)" && \
    chmod u+x "$(pwd)/entrypoint.sh" && \
    chmod u+x "$(pwd)/set_default_data.sh" && \
    pip install -r requirements.txt

USER fir

VOLUME ["/usr/src/FIR/static"]

EXPOSE 8000

CMD ["./entrypoint.sh"]
