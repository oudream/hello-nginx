#!/usr/bin/env bash

sudo apt-get install zlib1g-dev libpcre3 libpcre3-dev

NGINX_PATH=$PWD
NGINX_VERSION=1.17.8
UPLOAD_MODULE_VERSION=2.3.0

CONFIG="\
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
		--user=nginx \
		--group=nginx \
		--with-http_ssl_module \
		--with-http_realip_module \
		--with-http_addition_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_random_index_module \
		--with-http_secure_link_module \
		--with-http_stub_status_module \
		--with-http_auth_request_module \
		--with-http_xslt_module=dynamic \
		--with-http_image_filter_module=dynamic \
		--with-http_geoip_module=dynamic \
		--with-threads \
		--with-stream \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-stream_realip_module \
		--with-stream_geoip_module=dynamic \
		--with-http_slice_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-compat \
		--with-file-aio \
		--with-http_v2_module \
		--add-module=${NGINX_PATH}/nginx-upload-module-$UPLOAD_MODULE_VERSION \
	"

curl -fSL https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz
tar -zxC ${NGINX_PATH} -f nginx.tar.gz
curl -fSL https://github.com/fdintino/nginx-upload-module/archive/$UPLOAD_MODULE_VERSION.tar.gz -o ${NGINX_PATH}/nginx_upload.tar.gz
tar xvzf ${NGINX_PATH}/nginx_upload.tar.gz -C ${NGINX_PATH}/
cd ${NGINX_PATH}/nginx-$NGINX_VERSION
./configure $CONFIG --with-debug
make -j$(getconf _NPROCESSORS_ONLN)
