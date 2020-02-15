FROM alpine:3.4

RUN if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.ustc.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories ;fi  \
    &&  apk update && apk upgrade \
    && apk add python py-pip libsodium

COPY . /shadowsocks
WORKDIR /shadowsocks
RUN python setup.py install

ENTRYPOINT ["/usr/bin/ssserver"]
