#!/bin/sh -e

docker build -t cabot-build -f Dockerfile.build .
rm -rf build/*.whl
docker run --rm -v `pwd`/build:/build cabot-build "cp /code/dist/*.whl /build/"
CABOT_VERSION=`docker run --rm cabot-build 'git describe --tags'`
docker build --squash -t cabot -t cabot:$CABOT_VERSION -f Dockerfile .
