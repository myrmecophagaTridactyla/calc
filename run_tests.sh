#!/bin/bash

set -e

if [1 = 1]
then
  sbt "testOnly *Spec"
  sbt assembly
fi
