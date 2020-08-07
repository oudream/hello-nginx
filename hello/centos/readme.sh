yum -y install \
gcc \
zlib-devel \
openssl-devel \
make \
pcre-devel \
libxml2-devel \
libxslt-devel \
libgcrypt-devel \
gd-devel \
perl-ExtUtils-Embed \
GeoIP-devel


groupadd -g 994 nginx
useradd -g 994 -u 996 -c "Nginx web server" -d /var/lib/nginx -s /sbin/nologin nginx
groupadd -g 994 nginx
useradd -g 994 -u 996 -c "Nginx web server" -d /var/lib/nginx -s /sbin/nologin nginx
curl -L https://github.com/nginx/nginx/archive/release-1.16.0.tar.gz > nginx-release-1.16.0.tar.gz
tar xf nginx-release-1.16.0.tar.gz
cd nginx-release-1.16.0


auto/configure \
--with-pcre \
--prefix=/opt/nginx-1.16.0 \
--user=nginx \
--group=nginx \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module=dynamic \
--with-http_image_filter_module \
--with-http_geoip_module=dynamic \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--without-http_charset_module \
--with-http_perl_module \
--with-mail=dynamic \
--with-mail_ssl_module \
--with-stream=dynamic \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_geoip_module=dynamic \
--with-stream_ssl_preread_module

make
make install