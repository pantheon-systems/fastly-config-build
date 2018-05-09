#!/usr/bin/env bash

set -e

branch=1.x

docker build -t quay.io/getpantheon/terraform:${branch} .
docker push quay.io/getpantheon/terraform:${branch}

#docker tag quay.io/getpantheon/terraform:${branch} quay.io/getpantheon/terraform:latest
#docker push quay.io/getpantheon/terraform:latest
