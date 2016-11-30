#!/bin/bash

set -e

echo "gregorio..."

sbt "testOnly *Spec"
sbt assembly
