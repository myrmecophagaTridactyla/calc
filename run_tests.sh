#!/bin/bash

set -e

if [1 = 1]
then
  mongod &
  sbt "testOnly *Spec"
  mongod --shutdown
  sbt assembly
fi
