#!/bin/sh
#
# Configure nginx for an ARM Linux system. The objs/Makefile is
# modified in script at the end.


# Remove everything we can.
# We will add things one-by-one accoording to our needs in add_modules.
without=$(cat configure_withouts.txt)

add_modules="" #"--add-module=../ngx_ext_modules/lua-nginx-module --add-module=../ngx_ext_modules/ngx_http_rp_module"
add_conf_params="--with-zlib=/opt/arm --with-pcre=/opt/arm"
export VERSION=$1
export REVISION=$2
echo ${without} | xargs ./configure ${add_conf_params} ${add_modules}


# Make it cross-compilable
cat objs/Makefile | tail -n +3 > objs/Makefile.tmp
echo "CROSS_COMPILE=arm-linux-gnueabi-" > objs/Makefile
echo "CC =	\$(CROSS_COMPILE)gcc" >> objs/Makefile
cat objs/Makefile.tmp >> objs/Makefile
rm objs/Makefile.tmp
