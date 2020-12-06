import 'dart:typed_data';

import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class CodecNull extends BaseCodec {
  Registry registry;

  Null get value => null;

  CodecNull(Registry registry) {
    this.registry = registry;
  }

  static CodecNull constructor(Registry registry, [dynamic value]) => CodecNull(registry);

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return 0;
  }

  /// @description returns a hash of the contents
  H256 get hash {
    throw '.hash is not implemented on Codec';
  }

  /// @description Checks if the value is an empty value(always true)
  bool get isEmpty {
    return true;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq([dynamic other]) {
    return other is CodecNull || (other == null);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return '0x';
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  Null toHuman([bool isExtended]) {
    return this.toJSON();
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  Null toJSON() {
    return null;
  }

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Null';
  }

  /// @description Returns the string representation of the value
  String toString() {
    return '';
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  Uint8List toU8a([dynamic isBare]) {
    return Uint8List(0);
  }
}
