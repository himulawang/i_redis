#!/bin/bash

cd ..
rm -rf ./dartdoc-viewer
rm -rf ./docstmp
docgen --compile \
 --package-root=./packages \
 --verbose \
 --no-include-sdk \
 --no-include-dependent-packages \
 --out=./docstmp \
 --exclude-lib="dart:core" \
 ./i_redis.dart

cp -rf ./dartdoc-viewer/client/out/web ./doc
rm -rf ./doc/packages
cp -rf ./dartdoc-viewer/client/out/packages ./doc/packages
rm -rf ./dartdoc-viewer