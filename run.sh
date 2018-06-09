#!/bin/sh
set -eu
cobc -free -x -o a.out "$1"
./a.out
