import 'dart:typed_data';

import 'registry.dart';

class H256 {}

abstract class BaseCodec {
  static BaseCodec constructor;

  dynamic get value;

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength;

  /// @description Returns a hash of the value
  H256 get hash;

  /// @description Checks if the value is an empty value
  bool get isEmpty;

  /// @description The registry associated with this object
  Registry registry;

  /// @description Compares the value of the input to see if there is a match
  bool eq([dynamic other]);

  /// @description Returns a hex string representation of the value. isLe returns a LE(number-only) representation
  String toHex([bool isLe]);

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]);

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON();

  /// @description Returns the base runtime type name for this instance
  String toRawType();

  /// @description Returns the string representation of the value
  String toString();

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]);

  bool operator ==(Object other) {
    return eq(other);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

// abstract class Constructor<T extends BaseCodec> {
//   // eslint-disable-next-line @typescript-eslint/no-explicit-any
//   T newRegistry(Registry registry, Iterable<dynamic> value);
// }

typedef Constructor<T extends BaseCodec> = T Function(Registry registry, [dynamic value]);
typedef Constructor2<T extends BaseCodec> = T Function(Registry registry,
    [dynamic value, dynamic value2]);
typedef Constructor3<T extends BaseCodec> = T Function(Registry registry,
    [dynamic value, dynamic value2, dynamic value3]);
typedef Constructor4<T extends BaseCodec> = T Function(Registry registry,
    [dynamic value, dynamic value2, dynamic value3, dynamic value4]);
// typedef Constructor3<T extends BaseCodec> = T Function(Registry registry, [List<dynamic> value]);

// Type ArgsDef = Map<String, Constructor>;
