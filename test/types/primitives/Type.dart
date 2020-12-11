import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/create.dart';
import 'package:polkadot_dart/types/primitives/Text.dart';
import 'package:polkadot_dart/types/primitives/Type.dart';

import 'package:polkadot_dart/utils/utils.dart';

void main() {
  typeTest(); // rename this test name
}

void typeTest() {
  group('Type', () {
    final registry = new TypeRegistry();

    test('fails to cleanup invalid boxes', () {
      expect(() => CodecType(registry, 'Box<Proposal'), throwsA(contains('find closing matching')));
    });

    test('cleans up tuples with a single value', () {
      expect(CodecType(registry, '(AccountId)').toString(), 'AccountId');
    });

    test('does not touch tuples with multiple values', () {
      expect(CodecType(registry, '(AccountId, Balance)').toString(), '(AccountId,Balance)');
    });

    test('handles nested types', () {
      expect(CodecType(registry, 'Box<Vec<AccountId>>').toString(), 'Vec<AccountId>');
    });

    test('handles nested types (embedded)', () {
      expect(CodecType(registry, '(u32, Box<Vec<AccountId>>)').toString(), '(u32,Vec<AccountId>)');
    });

    test('handles aliasses, multiples per line', () {
      expect(CodecType(registry, '(Vec<u8>, AccountId, Vec<u8>)').toString(),
          '(Bytes,AccountId,Bytes)');
    });

    test('removes whitespaces', () {
      expect(CodecType(registry, 'T :: AccountId').toString(), 'AccountId');
    });

    test('changes PairOf<T> -> (T, T)', () {
      expect(CodecType(registry, 'PairOf<T::Balance>').toString(), '(Balance,Balance)');
    });

    test('changes PairOf<T> (embedded) -> (T, T)', () {
      expect(CodecType(registry, '(Vec<u8>, PairOf<T::Balance>, Vec<AccountId>)').toString(),
          '(Bytes,(Balance,Balance),Vec<AccountId>)');
    });

    test('changes () -> ()', () {
      expect(CodecType(registry, '()').toString(), '()');
    });

    test('has the sanitized', () {
      expect(CodecType(registry, CodecText(registry, ' Box<Proposal> ')).toString(),
          'Proposal'); // eslint-disable-line
    });

    test('unwraps compact', () {
      expect(
          CodecType(registry, '<T::Balance as HasCompact>::Type').toString(), 'Compact<Balance>');
    });

    test('handles InherentOfflineReport', () {
      expect(
          CodecType(registry, '<T::InherentOfflineReport as InherentOfflineReport>::Inherent')
              .toString(),
          'InherentOfflineReport');
    });

    test('encodes correctly via toU8a()', () {
      final type = 'Compact<Balance>';

      expect(
          CodecText(registry, type).toU8a(),
          u8aConcat([
            Uint8List.fromList([type.length << 2]),
            stringToU8a(type)
          ]));
    });

    test('creates a decodable U8a for sanitized types', () {
      final original = '<T::InherentOfflineReport as InherentOfflineReport>::Inherent';
      final expected = 'InherentOfflineReport';
      final u8a = CodecType(registry, original).toU8a();
      final decoded = CodecType(registry, u8a);

      expect(decoded.encodedLength, original.length + 1); // extra byte for length
      expect(decoded.toString(), expected);
    });

    test('has the correct raw', () {
      expect(CodecType(registry).toRawType(), 'Type');
    });
  });
}
