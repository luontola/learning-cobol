#!/bin/sh
set -eux
docker run --rm -it -v $PWD:/root/cobol -w /root/cobol gregcoleman/docker-cobol /bin/bash
