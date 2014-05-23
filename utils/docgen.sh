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

cp -rf ./dartdoc-viewer/client/out/web ./docs
rm -rf ./docs/packages
cp -rf ./dartdoc-viewer/client/out/packages ./docs/packages
rm -rf ./dartdoc-viewer