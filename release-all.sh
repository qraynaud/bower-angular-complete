#!/usr/bin/env bash
set -ue

find ./build -type f | while read file; do ./release.sh $(basename ${file%.sh}); done
