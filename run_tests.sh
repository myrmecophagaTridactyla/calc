#!/bin/bash

set -e

echo ">>>>,======,*=~~ ... . .. .. ... .. . . .. ..^^.. . .. ."

cd /source/client && npm install && bower install --allow-root --config.interactive=false -s

echo "           >> --- NPM INSTALL AND BOWER INSTALL DONE --- <<"

cd /source

sbt test
sbt assembly
