import os
import simplejson as json
import logging
import urllib2

try:
    from poster.encode import multipart_encode
    from poster.streaminghttp import register_openers
except:
    multipart_encode = None
    register_openers = None


MAX_UPLOAD_SIZE = 10 * 1024 * 1024

LOG = logging.getLogger("main")
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s %(name)-8s %(levelname)-5s: %(message)s',
    datefmt='%H:%M:%S'
)



def upload_result(upload_server, upload_user, file_path):
    if not upload_user:
        raise("Error: user field should set")

    size = os.path.getsize(file_path)
    if size > MAX_UPLOAD_SIZE:
        raise("Error: exceed the max upload size %s" % size)

    register_openers()

    datagen, headers = multipart_encode({
        'file': open(file_path, 'rb'),
        'user': upload_user
    })

    request = urllib2.Request(upload_server, datagen, headers)
    response = urllib2.urlopen(request)

    response = json.loads(response.read())
    if response['state'] == 0:
        LOG.info("result upload success!")
    else:
        LOG.error("result upload fail: %s" % response['error'])
