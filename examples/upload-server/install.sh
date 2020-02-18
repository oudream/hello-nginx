#!/bin/sh

DIR=/tmp/nginx
NGINX_USER=root
NGINX=nginx-1.8.0
NGINX_DIR=/usr/local/nginx

set -e

if test $(id -u) != 0; then 
    SUDO=sudo
fi

$SUDO yum install -y wget git openssl openssl-devel zlib pcre pcre-devel

if [ ! -d "$DIR" ]; then
    mkdir "$DIR"
fi

pushd $DIR

wget http://nginx.org/download/$NGINX.tar.gz
tar zxvf $NGINX.tar.gz

git clone -b 2.2 https://github.com/vkholodkov/nginx-upload-module

cd $NGINX

./configure \
--add-module=../nginx-upload-module \
--prefix=$NGINX_DIR \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--user=$NGINX_USER --group=$NGINX_USER

make -j 24 && make install

popd

# cp the config file
cp nginx.conf $NGINX_DIR/conf/nginx.conf

# start nginx 
$NGINX_DIR/sbin/nginx

# rm -rf $DIR

$SUDO yum install -y python python-devel python-pip
$SUDO pip install uwsgi django

uwsgi -i uwsgi.ini

