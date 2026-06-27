#!/bin/bash
set -e;
set -u;

docker pull lacledeslan/gamesvr-tf2:base-latest

echo -e '\n\033[1m[Build tf2classified]\033[0m'
docker build . -f linux.Dockerfile --rm -t lacledeslan/gamesvr-tf2classified:latest --build-arg BUILDNODE="$(cat /proc/sys/kernel/hostname)";
docker run -it --rm lacledeslan/gamesvr-tf2classified:latest ./ll-tests/gamesvr-tf2classified.sh;
docker push lacledeslan/gamesvr-tf2classified:latest
