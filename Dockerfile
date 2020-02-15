FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common \
 && add-apt-repository ppa:chris-lea/libsodium \
 && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \980op
 && apt-get install -y libsodium18 python-pip

# RUN pip install shadowsocks
RUN pip install git+https://github.com/shadowsocks/shadowsocks.git@master

ENTRYPOINT ["/usr/local/bin/ssserver"]