#!/bin/bash

set -e

cd /source/client && npm install && bower install --allow-root --config.interactive=false -s

cd /source

sbt test
sbt assembly
