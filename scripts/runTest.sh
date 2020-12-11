#!/bin/bash

flutter test --coverage test/polkadot_dart_test.dart
genhtml -o coverage coverage/lcov.info



if [ "$(open coverage/index-sort-l.html)" = "" ] 
  then
    echo "Opened coverage/index-sort-l.html"
else
    echo "Use browser to open coverage/index-sort-l.html"
fi