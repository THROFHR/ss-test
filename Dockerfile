FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common \
 && add-apt-repository ppa:chris-lea/libsodium \
 && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y libsodium-dev python-pip


# RUN pip install shadowsocks
RUN pip install shadowsocks

RUN mkdir -p /usr/src/app
COPY . /usr/src/app

ENTRYPOINT ["/usr/local/bin/ssserver"]