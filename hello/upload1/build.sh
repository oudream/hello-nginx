#!/bin/bash


readonly VERSION='1.0.0'

cd "$(dirname $0)"

docker build ${@} -t oudream/hello-nginx-upload:1.0.1 .
#docker build ${@} -t oudream/hello-nginx-upload:${VERSION} .
#
#docker push oudream/hello-nginx-upload:${VERSION}

docker build -t nginx-upload:v1 . -f Dockerfile
docker run -d -p 80:80 -p 8080:8080 --name nginx-upload nginx-upload:v1
