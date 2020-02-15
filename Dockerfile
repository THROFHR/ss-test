FROM alpine:3.7

RUN if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.ustc.edu.cn/alpine/v3.7/main/" > /etc/apk/repositories ;fi  \
    &&  apk update && apk upgrade \
    && apk add python py-pip libsodium

COPY . /shadowsocks
WORKDIR /shadowsocks
RUN python setup.py install

ENTRYPOINT ["/usr/bin/ssserver"]
