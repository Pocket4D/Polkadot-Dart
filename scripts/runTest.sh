#!/bin/bash

flutter test --coverage test/polkadot_dart_test.dart
genhtml -o coverage coverage/lcov.info
open coverage/index-sort-l.html