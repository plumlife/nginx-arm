FROM ubuntu:14.04

MAINTAINER Parnell Springmeyer <parnell@plumlife.com>

RUN curl http://nginx.org/download/nginx-1.9.0.tar.gz | tar xf

ADD ./nginx /nginx

WORKDIR /nginx

RUN mkdir _install

RUN echo $(cat configure_withouts.txt) | xargs ./configure --with-zlib=/opt/arm/zlib-1.2.8 --with-pcre=/opt/arm/pcre-8.35 --with-http_ssl_module --prefix=./_install

# cat objs/Makefile | tail -n +3 > objs/Makefile.tmp
# echo "CROSS_COMPILE=arm-linux-gnueabi-" > objs/Makefile
# echo "CC =	\$(CROSS_COMPILE)gcc" >> objs/Makefile
# cat objs/Makefile.tmp >> objs/Makefile
# rm objs/Makefile.tmp
