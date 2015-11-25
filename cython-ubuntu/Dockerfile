from ubuntu:trusty

RUN apt-get update && apt-get install -y vim python-dev python3-dev python-pip python3-pip gcc clang && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install cython && pip3 install cython
VOLUME /src
