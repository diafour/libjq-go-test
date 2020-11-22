#!/usr/bin/env bash

set -eo pipefail

if [[ $1 == "--clean" ]] ; then
  docker rmi libjq-go-simple:latest
  exit 0
fi


docker build . -t libjq-go-simple:latest

docker run --rm -ti libjq-go-simple:latest