import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

void main() {
  btreeSetTest(); // rename this test name
}

void btreeSetTest() {
  final registry = TypeRegistry();

  test('provides a toBigInt interface', () {
    expect(CodecInt(registry, -1234).toBigInt(), BigInt.from(-1234));
  });

  test('provides a toBn interface', () {
    expect(CodecInt(registry, -1234).toBn().toInt(), -1234);
  });

  test('provides a toNumber interface', () {
    expect(CodecInt(registry, -1234).toNumber(), -1234);
  });

  test('converts to Little Endian from the provided value', () {
    expect(CodecInt(registry, -1234).toU8a(),
        Uint8List.fromList([46, 251, 255, 255, 255, 255, 255, 255]));
  });

  test('converts to Little Endian from the provided value (bitLength)', () {
    expect(CodecInt(registry, -1234, 32).toU8a(), Uint8List.fromList([46, 251, 255, 255]));
  });

  test('converts to hex/string', () {
    final i = CodecInt(registry, '0x12', 16);

    expect(i.toHex(), '0x0012');
    expect(i.toString(), '18');
  });
  test('converts to equivalents', () {
    final a = CodecInt(registry, '-123');

    expect(CodecInt(registry, a).toNumber(), -123);
  });

  group('static with', () {
    print("⚠️ ：TODO");
    // test('allows default toRawType', () {
    //   expect((CodecInt.withParams(64))(registry).toRawType(), 'i64');
    // });

    //   test('allows toRawType override', () {
    //     expect((CodecInt.withParams(64, 'SomethingElse'))(registry).toRawType(), 'SomethingElse');
    //   });
  });
}
