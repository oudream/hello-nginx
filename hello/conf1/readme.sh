#!/usr/bin/env bash

mkdir /opt/conf1 && cd /opt/conf1

mkdir -p /opt/conf1/vhosts
mkdir -p /opt/conf1/data/logs/nginx
mkdir -p /opt/conf1/data/www/demo-80
mkdir -p /opt/conf1/data/www/demo-8080
echo '<h1>NGINX SERVER PORT 80</h1>' >/opt/conf1/data/www/demo-80/index.html
echo '<h1>NGINX SERVER PORT 80 404 NOT FOUND</h1>' >/opt/conf1/data/www/demo-80/404.html
echo '<h1>NGINX SERVER PORT 8080</h1>' >/opt/conf1/data/www/demo-8080/index.html
echo '<h1>NGINX SERVER PORT 8080 404 NOT FOUND</h1>' >/opt/conf1/data/www/demo-8080/404.html

cat > /opt/conf1/mime.types <<EOF
types {
    text/html                             html htm shtml;
    text/css                              css;
    text/xml                              xml;
    image/gif                             gif;
    image/jpeg                            jpeg jpg;
    application/javascript                js;
    application/rss+xml                   rss;
    text/plain                            txt;
    image/png                             png;
    image/tiff                            tif tiff;
    image/x-icon                          ico;
    image/x-ms-bmp                        bmp;
    image/svg+xml                         svg svgz;
    image/webp                            webp;
    application/font-woff                 woff;
    application/json                      json;
}
EOF

cat > /opt/conf1/nginx.conf <<EOF
user  www-data;
worker_processes  auto;
error_log  /opt/conf1/data/logs/nginx/error.log  info;
pid        /opt/conf1/data/logs/nginx/nginx.pid;

events {
    worker_connections  65535;
}

http {
    include       /opt/conf1/mime.types;
    default_type  application/octet-stream;
    sendfile      on;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /opt/conf1/data/logs/nginx/access.log  main;
    include    /opt/conf1/vhosts/*.conf;
}
EOF

cat > /opt/conf1/vhosts/demo.conf <<EOF
# 80 端口测试
server {
    listen       8801;
    server_name  localhost;

    location / {
        root   /opt/conf1/data/www/demo-80;
        index  index.html index.htm;
    }
    error_page  404     /404.html;
}
# 8080 端口测试
server {
    listen       8802;
    server_name  localhost;

    location / {
        root   /opt/conf1/data/www/demo-8080;
        index  index.html index.htm;
    }
    error_page  404     /404.html;
}
EOF


netstat -tlunp | grep nginx
ps aux | grep nginx

# -t 检查配置
nginx -t -c /opt/conf1/nginx.conf
# -s reload 可以平滑重启 nginx
nginx -c /opt/conf1/nginx.conf
nginx -s stop
nginx -s reload


open