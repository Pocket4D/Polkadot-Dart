import 'dart:typed_data';

import 'package:polkadot_dart/metadata/MetadataVersioned.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

const VERSION_IDX = 4;

// magic + lowest supported version
final EMPTY_METADATA = u8aConcat(Uint8List.fromList([0x6d, 0x65, 0x74, 0x61, 9]));
final EMPTY_U8A = Uint8List.fromList([]);

Uint8List sanitizeInput([dynamic _value]) {
  if (_value == null) {
    _value = EMPTY_U8A;
  }
  if (isString(_value)) {
    return sanitizeInput(u8aToU8a(_value));
  }

  return _value.length == 0 ? EMPTY_METADATA : _value;
}

MetadataVersioned decodeMetadata(Registry registry, dynamic _value) {
  final value = sanitizeInput(_value);
  final version = value[VERSION_IDX];

  try {
    final result = new MetadataVersioned(registry, value);
    return result;
  } catch (error) {
    // This is an f-ing hack as a follow-up to another ugly hack
    // https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
    // when we fail on V9, try to re-parse it as v10... yes... HACK
    if (version == 9) {
      value[VERSION_IDX] = 10;

      return decodeMetadata(registry, value);
    }

    throw error;
  }
}

class Metadata extends MetadataVersioned {
  Metadata(Registry registry, [dynamic value]) : super(registry, decodeMetadata(registry, value));
  static Metadata constructor(Registry registry, [dynamic value]) => Metadata(registry, value);
}
