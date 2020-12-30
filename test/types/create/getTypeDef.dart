import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/getTypeDef.dart';
import 'package:polkadot_dart/types/create/registry.dart';
import 'package:polkadot_dart/types/create/types.dart';

void main() {
  getTypeDefTest(); // rename this test name
}

void getTypeDefTest() {
  group('getTypeDef', () {
    test('maps empty tuples to empty tuple', () {
      // print(getTypeDef('()');
      expect(getTypeDef('()').toMap(), {"info": TypeDefInfo.Tuple, "sub": [], "type": '()'});
    });

    test('properly decodes a BTreeMap<u32, Text>', () {
      expect(getTypeDef('BTreeMap<u32, Text>').toMap(), {
        "info": TypeDefInfo.BTreeMap,
        "sub": [
          {"info": TypeDefInfo.Plain, "type": 'u32'},
          {"info": TypeDefInfo.Plain, "type": 'Text'}
        ],
        "type": 'BTreeMap<u32,Text>'
      });
    });

    test('properly decodes a BTreeSet<Text>', () {
      expect(getTypeDef('BTreeSet<Text>').toMap(), {
        "info": TypeDefInfo.BTreeSet,
        "sub": {"info": TypeDefInfo.Plain, "type": 'Text'},
        "type": 'BTreeSet<Text>'
      });
    });

    test('properly decodes a Result<u32, Text>', () {
      expect(getTypeDef('Result<u32, Text>').toMap(), {
        "info": TypeDefInfo.Result,
        "sub": [
          {"info": TypeDefInfo.Plain, "type": 'u32'},
          {"info": TypeDefInfo.Plain, "type": 'Text'}
        ],
        "type": 'Result<u32,Text>'
      });
    });

    test('properly decodes a Result<Result<(), u32>, Text>', () {
      expect(getTypeDef('Result<Result<Null,u32>,Text>').toMap(), {
        "info": TypeDefInfo.Result,
        "sub": [
          {
            "info": TypeDefInfo.Result,
            "sub": [
              {"info": TypeDefInfo.Plain, "type": 'Null'},
              {"info": TypeDefInfo.Plain, "type": 'u32'}
            ],
            "type": 'Result<Null,u32>'
          },
          {"info": TypeDefInfo.Plain, "type": 'Text'}
        ],
        "type": 'Result<Result<Null,u32>,Text>'
      });
    });

    test('returns a type structure', () {
      expect(
          getTypeDef('(u32, Compact<u32>, Vec<u64>, Option<u128>, (Text,Vec<(Bool,u128)>))')
              .toMap(),
          {
            "info": TypeDefInfo.Tuple,
            "sub": [
              {"info": TypeDefInfo.Plain, "type": 'u32'},
              {
                "info": TypeDefInfo.Compact,
                "sub": {"info": TypeDefInfo.Plain, "type": 'u32'},
                "type": 'Compact<u32>'
              },
              {
                "info": TypeDefInfo.Vec,
                "sub": {"info": TypeDefInfo.Plain, "type": 'u64'},
                "type": 'Vec<u64>'
              },
              {
                "info": TypeDefInfo.Option,
                "sub": {"info": TypeDefInfo.Plain, "type": 'u128'},
                "type": 'Option<u128>'
              },
              {
                "info": TypeDefInfo.Tuple,
                "sub": [
                  {"info": TypeDefInfo.Plain, "type": 'Text'},
                  {
                    "info": TypeDefInfo.Vec,
                    "sub": {
                      "info": TypeDefInfo.Tuple,
                      "sub": [
                        {"info": TypeDefInfo.Plain, "type": 'Bool'},
                        {"info": TypeDefInfo.Plain, "type": 'u128'}
                      ],
                      "type": '(Bool,u128)'
                    },
                    "type": 'Vec<(Bool,u128)>'
                  }
                ],
                "type": '(Text,Vec<(Bool,u128)>)'
              }
            ],
            "type": '(u32,Compact<u32>,Vec<u64>,Option<u128>,(Text,Vec<(Bool,u128)>))'
          });
    });

    test('returns a type structure (sanitized)', () {
      expect(getTypeDef('Vec<(Box<PropIndex>, Proposal,Lookup::Target)>').toMap(), {
        "info": TypeDefInfo.Vec,
        "sub": {
          "info": TypeDefInfo.Tuple,
          "sub": [
            {"info": TypeDefInfo.Plain, "type": 'PropIndex'},
            {"info": TypeDefInfo.Plain, "type": 'Proposal'},
            {"info": TypeDefInfo.Plain, "type": 'LookupTarget'}
          ],
          "type": '(PropIndex,Proposal,LookupTarget)'
        },
        "type": 'Vec<(PropIndex,Proposal,LookupTarget)>'
      });
    });

    test('returns a type structure (actual)', () {
      expect(getTypeDef('Vec<(PropIndex, Proposal, AccountId)>').toMap(), {
        "info": TypeDefInfo.Vec,
        "sub": {
          "info": TypeDefInfo.Tuple,
          "sub": [
            {"info": TypeDefInfo.Plain, "type": 'PropIndex'},
            {"info": TypeDefInfo.Plain, "type": 'Proposal'},
            {"info": TypeDefInfo.Plain, "type": 'AccountId'}
          ],
          "type": '(PropIndex,Proposal,AccountId)'
        },
        "type": 'Vec<(PropIndex,Proposal,AccountId)>'
      });
    });

    test('returns an actual Struct', () {
      expect(
          getTypeDef('{"balance":"Balance","account_id":"AccountId","log":"(u64, Signature)"}')
              .toMap(),
          {
            "info": TypeDefInfo.Struct,
            "sub": [
              {"info": TypeDefInfo.Plain, "name": 'balance', "type": 'Balance'},
              {"info": TypeDefInfo.Plain, "name": 'account_id', "type": 'AccountId'},
              {
                "info": TypeDefInfo.Tuple,
                "name": 'log',
                "sub": [
                  {"info": TypeDefInfo.Plain, "type": 'u64'},
                  {"info": TypeDefInfo.Plain, "type": 'Signature'}
                ],
                "type": '(u64,Signature)'
              }
            ],
            "type": '{"balance":"Balance","account_id":"AccountId","log":"(u64,Signature)"}'
          });
    });

    // // FIXME - not handled atm
    test('creates a nested fixed vec', () {
      expect(getTypeDef('[[u8;32];3]').toMap(), {
        "ext": {"length": 3, "type": '[u8;32]'},
        "info": TypeDefInfo.VecFixed,
        "sub": {
          "ext": {"length": 32},
          "info": TypeDefInfo.VecFixed,
          "sub": {"info": TypeDefInfo.Plain, "type": 'u8'},
          "type": '[u8;32]'
        },
        "type": '[[u8;32];3]'
      });
    },
        skip:
            'TODO: Not supported atm, see: https://github.com/polkadot-js/api/blob/50737b7ef7a17773ecda71ff7a0b90aaa0fb7404/packages/types/src/create/getTypeDef.spec.ts#L255');

    test('creates recursive structures', () {
      final registry = new TypeRegistry();

      registry.register({
        "Recursive": {"data": 'Vec<Recursive>'}
      });

      final raw = registry.createType('Recursive').toRawType();

      expect(getTypeDef(raw).toMap(), {
        "info": TypeDefInfo.Struct,
        "sub": [
          {
            "info": TypeDefInfo.Vec,
            "name": 'data',
            "sub": {"info": TypeDefInfo.Plain, "type": 'Recursive'},
            "type": 'Vec<Recursive>'
          }
        ],
        "type": '{"data":"Vec<Recursive>"}'
      });
    });
  });
}
