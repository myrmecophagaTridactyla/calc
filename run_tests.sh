#!/bin/bash

set -e

echo "gregorio..."

if [1 = 1]
then
  sbt "testOnly *Spec"
  sbt assembly
fi
