# -*- coding: utf-8 -*-
import os
import json
import time
import logging
 
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
 

# init logger
UPLOAD_FILE_PATH = os.path.join(os.path.dirname(__file__), '..', '..', 'files')
os.environ["TZ"] = "Asia/Shanghai"
log_path = 'log/upload.log'

if not os.path.exists(os.path.dirname(log_path)):
    os.makedirs(os.path.dirname(log_path))

LOG = logging.getLogger('view')
LOG.setLevel(logging.DEBUG)
filehandler = logging.handlers.TimedRotatingFileHandler(
    log_path, 'midnight')
formatter = logging.Formatter(
    '%(asctime)s %(name)-8s %(levelname)-5s: %(message)s')
filehandler.setFormatter(formatter)
filehandler.suffix = "%Y%m%d"
LOG.addHandler(filehandler)
 
 
@csrf_exempt
def upload(request):
    request_params = request.POST
    file_name = request_params['file_name']
    file_content_type = request_params['file_content_type']
    file_md5 = request_params['file_md5']
    file_path = request_params['file_path']
    file_size = request_params['file_size']
    file_user = request_params.get('user', None)

    ip_address = request.META.get('HTTP_X_REAL_IP') or request.META.get('HTTP_REMOTE_ADD')

    content = {
        'name': file_name,
        'content_type': file_content_type,
        'path': file_path,
        'size': file_size,
        'ip': ip_address,
        'state': 0,
        'error': ''
    }

    if not file_user:
        content['state'] = -1
        content['error'] = 'user field not set'
        LOG.error('no user request: %s %s' % (file_name, ip_address) )
        return http_response(content)
 
    # move to new name 'date+some_tag+name'
    now = time.strftime("%Y%m%d_%H%M", time.localtime())
    new_file_name = '%s_%s' % (now, file_name)
    new_file_dir = os.path.join(UPLOAD_FILE_PATH, file_user)
    new_file_path = os.path.join(new_file_dir, new_file_name)

    LOG.info('result: %s %s %s' % (file_user, file_name, ip_address))

    if not os.path.exists(new_file_dir):
        os.makedirs(new_file_dir)
    # with open(new_file_path, 'a') as new_file:
    #     with open(file_path, 'rb') as f:
    #         new_file.write(f.read())
    os.rename(file_path, new_file_path)
 
    response = http_response(content)

    return response

def http_response(content):
    content = json.dumps(content)
    response = HttpResponse(content, content_type='application/json; charset=utf-8')
    return response
