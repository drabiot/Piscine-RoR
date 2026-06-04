#!/bin/sh

curl -s $1 | grep "http" | cut -f "2" -d '"'
