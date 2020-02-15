FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common \
 && add-apt-repository ppa:chris-lea/libsodium \
 && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y libsodium-dev python-pip wget

RUN wget https://github.com/jedisct1/libsodium/releases/download/1.0.13/libsodium-1.0.13.tar.gz \
&& tar zxvf libsodium-1.0.13.tar.gz \
&& cd libsodium-1.0.13 \
&& ./configure \
&& make && make install && ldconfig

RUN pip install shadowsocks

ENTRYPOINT ["/usr/local/bin/ssserver"]


# usage:
# docker run -d --restart=always -p 1314:1314 ficapy/shadowsocks -s 0.0.0.0 -p 1314 -k $PD -m chacha20
