FROM ubuntu:22.04

RUN apt-get -y update \
    && apt-get install -y wget

WORKDIR /

COPY entrypoint.sh .

RUN [ "chmod", "+x", "/entrypoint.sh" ]

ENTRYPOINT [ "/entrypoint.sh" ]
