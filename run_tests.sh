#!/bin/bash

set -e

echo ">>>>,======,*=~~ ... . .. .. ... .. . . .. ..^^.. . .. ."

cd /source

sbt test
sbt assembly
