#!/bin/sh
set -eu
cobc -free -x -o out.o "$1"
./out.o
