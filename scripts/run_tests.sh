#!/bin/bash

set -e

cd /source

sbt test
sbt assembly
