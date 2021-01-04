import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

// import 'package:polkadot_dart/types/interfaces/offchain/definitions.info.dart';
import 'package:polkadot_dart/types/types.dart';

void main() {
  encodeTypesTest(); // rename this test name
}

void encodeTypesTest() {
  group('encodeTypeDef', () {
    test('correctly encodes a complex struct', () {
      expect(
          jsonDecode(encodeTypeDef(TypeDef.fromMap({
            "info": TypeDefInfo.Struct,
            "sub": [
              {"info": TypeDefInfo.Plain, "name": 'a', "type": 'u32'},
              {
                "info": TypeDefInfo.Struct,
                "name": 'b',
                "sub": [
                  {"info": TypeDefInfo.Plain, "name": 'c', "type": 'u32'},
                  {
                    "info": TypeDefInfo.Vec,
                    "name": 'd',
                    "sub": {"info": TypeDefInfo.Plain, "type": 'u32'},
                    "type": ''
                  }
                ],
                "type": ''
              }
            ],
            "type": ''
          }))),
          {"a": 'u32', "b": '{"c":"u32","d":"Vec<u32>"}'});
    });

    test('correctly encodes a complex struct (named)', () {
      expect(
          jsonDecode(encodeTypeDef(TypeDef.fromMap({
            "info": TypeDefInfo.Struct,
            "sub": [
              {"info": TypeDefInfo.Plain, "name": 'a', "type": 'u32'},
              {
                "info": TypeDefInfo.Struct,
                "name": 'b',
                "sub": [
                  {"info": TypeDefInfo.Plain, "name": 'c', "type": 'u32'},
                  {
                    "displayName": 'Something',
                    "info": TypeDefInfo.Vec,
                    "name": 'd',
                    "sub": {"info": TypeDefInfo.Plain, "type": 'u32'},
                    "type": ''
                  }
                ],
                "type": ''
              }
            ],
            "type": ''
          }))),
          {"a": 'u32', "b": '{"c":"u32","d":"Something"}'});
    });

    test('correctly encodes a complex enum', () {
      expect(
          jsonDecode(encodeTypeDef(TypeDef.fromMap({
            "info": TypeDefInfo.Enum,
            "sub": [
              {"info": TypeDefInfo.Plain, "name": 'a', "type": 'u32'},
              {
                "info": TypeDefInfo.Struct,
                "name": 'b',
                "sub": [
                  {"info": TypeDefInfo.Plain, "name": 'c', "type": 'u32'},
                  {
                    "info": TypeDefInfo.Vec,
                    "name": 'd',
                    "sub": {"info": TypeDefInfo.Plain, "type": 'u32'},
                    "type": ''
                  }
                ],
                "type": ''
              },
              {
                "info": TypeDefInfo.Enum,
                "name": 'f',
                "sub": [
                  {"info": TypeDefInfo.Plain, "name": 'g', "type": 'Null'},
                  {"info": TypeDefInfo.Plain, "name": 'h', "type": 'Null'}
                ],
                "type": ''
              }
            ],
            "type": ''
          }))),
          {
            "_enum": {"a": 'u32', "b": '{"c":"u32","d":"Vec<u32>"}', "f": '{"_enum":["g","h"]}'}
          });
    });

    test('correctly encodes a complex enum (named)', () {
      expect(
          jsonDecode(encodeTypeDef(TypeDef.fromMap({
            "info": TypeDefInfo.Enum,
            "sub": [
              {"info": TypeDefInfo.Plain, "name": 'a', "type": 'u32'},
              {
                "displayName": 'Something',
                "info": TypeDefInfo.Struct,
                "name": 'b',
                "sub": [
                  {"info": TypeDefInfo.Plain, "name": 'c', "type": 'u32'},
                  {
                    "info": TypeDefInfo.Vec,
                    "name": 'd',
                    "sub": {"info": TypeDefInfo.Plain, "type": 'u32'},
                    "type": ''
                  }
                ],
                "type": ''
              },
              {
                "displayName": 'Option',
                "info": TypeDefInfo.Option,
                "name": 'e',
                "sub": {
                  "displayName": 'Result',
                  "info": TypeDefInfo.Result,
                  "sub": [
                    {"info": TypeDefInfo.Null, "type": ''},
                    {"info": TypeDefInfo.Plain, "type": 'u32'}
                  ],
                  "type": ''
                },
                "type": ''
              }
            ],
            "type": ''
          }))),
          {
            "_enum": {"a": 'u32', "b": 'Something', "e": 'Option<Result<Null, u32>>'}
          });
    });
  });
}
