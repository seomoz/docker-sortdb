FROM ubuntu:latest
MAINTAINER Bob Aman <bob@moz.com>

# All terminals should have pretty colors.
ENV PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[00m\]\$ " \
  TERM="xterm-color"

RUN apt-get update && \
  apt-get install -y wget && \
  mkdir -p mkdir -p /opt/bin /opt/src /var/lib/sortdb

RUN wget -q -O /opt/src/sortdb-1.1.linux-amd64.go1.4.2.tar.gz \
  https://github.com/jehiah/sortdb/releases/download/v1.1/sortdb-1.1.linux-amd64.go1.4.2.tar.gz && \
  cd /opt/src && tar -xzvf /opt/src/sortdb-1.1.linux-amd64.go1.4.2.tar.gz && \
  mv /opt/src/sortdb-1.1.linux-amd64.go1.4.2/sortdb /opt/bin/sortdb && \
  rm -rf /opt/src/sortdb-1.1.linux-amd64.go1.4.2*

COPY ./start /opt/bin/start

EXPOSE 8080

# The volume is omitted because Docker doesn't currently support UNVOLUME.
# We can't use this as a base image to bake in a data set unless we omit this.
# VOLUME ["/var/lib/sortdb"]

CMD [ "/opt/bin/start" ]
