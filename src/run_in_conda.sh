#!/usr/bin/env bash

echo "$@"
echo "foo bar"
source ~/miniconda3/bin/activate \
    && echo "baz" \
    && source activate 'test-qgis-segfault' && echo "bar" \
    && $@
