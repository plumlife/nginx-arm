FROM ubuntu:14.04

MAINTAINER Parnell Springmeyer <parnell@plumlife.com>

ADD ./build-scripts /nginx-build
RUN mkdir /opt/arm

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabi \
    g++-arm-linux-gnueabi \
    gcc \
    g++ \
    git \
    curl \
    autoconf \
    make

WORKDIR /opt/arm

RUN curl https://www.openssl.org/source/openssl-1.0.1j.tar.gz | tar zx
RUN curl http://nginx.org/download/nginx-1.9.0.tar.gz | tar zx

RUN /nginx-build/build-utils

RUN cd nginx-1.9.0 && echo $(cat ../configure_withouts.txt) | xargs ./configure --with-http_ssl_module --without-http_rewrite_module --prefix=/opt/arm

RUN make
RUN cat objs/Makefile | tail -n +3 > objs/Makefile.tmp
RUN echo "CROSS_COMPILE=arm-linux-gnueabi-" > objs/Makefile
RUN echo "CC =	\$(CROSS_COMPILE)gcc" >> objs/Makefile
RUN cat objs/Makefile.tmp >> objs/Makefile
RUN rm objs/Makefile.tmp
RUN make
