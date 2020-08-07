#!/usr/bin/env bash


# https://docs.nginx.com/nginx/admin-guide/monitoring/logging/
# Nginx 日志配置详情解析
# https://juejin.im/post/59f94f626fb9a045023af34c


#语法
access_log  path [format [buffer=size] [gzip[=level]] [flush=time] [if=condition]];
access_log  off;

#默认值
access_log logs/access.log combined;

#上下文
http, server, location, if in location, limit_except



http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        ##
        # Logging Settings
        ##

        log_format main '$remote_addr - $remote_user  [$time_local]  '
                       ' "$request"  $status  $body_bytes_sent  '
                       ' "$http_referer" --- "$http_user_agent" ';
        access_log /var/log/nginx/access.log main;
        error_log /var/log/nginx/error.log;
}