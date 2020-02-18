简单的文件上传服务

服务端：nginx + django后续处理


### Requires

1. nginx + nginx_upload_module
2. uwsgi
3. django

### deploy

./install.sh

### Run

uwsgi -i uwsgi.ini
(should run in the uwsgi.ini directory)

### Test

up.html or up.py
