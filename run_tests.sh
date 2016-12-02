#!/bin/bash

set -e

echo ">>>>,======,*=~~ ... . .. .. ... .. . . .. ..^^.. . .. ."

sbt "testOnly *Spec"
sbt assembly
