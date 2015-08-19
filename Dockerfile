FROM debian:jessie

MAINTAINER huaxiujun <huaxiujun@aliyun.com>

#version
ENV OPEN_RESTY_VERSION 1.9.3.1

RUN apt-get update && \
    apt-get install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential

#download openresty
ADD https://openresty.org/download/ngx_openresty-$OPEN_RESTY_VERSION.tar.gz ./

# make && lean up system
RUN cd ngx_openresty-$OPEN_RESTY_VERSION && \
    ./configure --with-pcre-jit && \
    make && make install && \
    cd .. && \
    apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && \
    rm -rf ngx_openresty-$OPEN_RESTY_VERSION && rm ngx_openresty-$OPEN_RESTY_VERSION.tar.gz

EXPOSE 80
EXPOSE 443

WORKDIR /usr/local/openresty/nginx/sbin

ENTRYPOINT ["nginx"]

CMD ["-p","/data/","-c","conf/nginx.conf","-g","daemon off;"]
