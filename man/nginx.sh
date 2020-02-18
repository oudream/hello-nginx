#!/usr/bin/env bash

nginx -s quit
#  stop — fast shutdown
#  quit — graceful shutdown
#  reload — reloading the configuration file
#  reopen — reopening the log files
kill -s QUIT 1628
ps -ax | grep nginx

nginx -g "pid /var/run/nginx.pid; worker_processes `sysctl -n hw.ncpu`;"
#  -g directives — set global configuration directives, for example,
#  -c file — use an alternative configuration file instead of a default file.
#  -p prefix — set nginx path prefix, i.e. a directory that will keep server files (default value is /usr/local/nginx).
#  -q — suppress non-error messages during configuration testing.
#  -t — test the configuration file: nginx checks the configuration for correct syntax, and then tries to open files referred in the configuration.
#  -T — same as -t, but additionally dump configuration files to standard output (1.9.2).
#  -v — print nginx version.
#  -V — print nginx version, compiler version, and configure parameters.

# news release
open http://hg.nginx.org/nginx/

# doc
open http://nginx.org/en/docs/
# HTTPS servers
open http://nginx.org/en/docs/http/configuring_https_servers.html
# 中文 https://zhuanlan.zhihu.com/p/31202053
# 中文 https://juejin.im/post/5aa7704c6fb9a028bb18a993

open https://www.nginx.com/resources/wiki/start/topics/examples/full/
# guide
open http://nginx.org/en/docs/beginners_guide.html
# command-line parameters
open http://nginx.org/en/docs/switches.html


# download
open https://nginx.org/download/

# NGINX Ingress Controller for Kubernetes
open https://github.com/sous-chefs/nginx
# NGINX-based Media Streaming Server
open https://github.com/arut/nginx-rtmp-module

# cookbook
open https://github.com/openresty/nginx-tutorials
open http://openresty.org/download/agentzh-nginx-tutorials-en.html
open http://blog.sina.com.cn/openresty

# kubernetes
open https://github.com/kubernetes/ingress-nginx

# Automated nginx proxy for Docker containers using docker-gen
open https://github.com/jwilder/nginx-proxy

# lua
open https://github.com/openresty/lua-nginx-module
