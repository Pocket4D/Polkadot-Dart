import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/utils.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';
import 'package:polkadot_dart/utils/utils.dart';

abstract class AbstractArray<T extends BaseCodec> implements BaseCodec {
  Registry registry;
  List<T> _values;
  List<T> get value => _values;

  AbstractArray(Registry registry, List<T> values) {
    _values = List.from(values);
    this.registry = registry;
  }

  /// @description The length of the value when encoded as a Uint8Array
  int get encodedLength {
    return this._values.fold(compactToU8a(this._values.length).length, (total, raw) {
      return total + raw.encodedLength;
    });
  }

  /// @description returns a hash of the contents
  H256 get hash {
    return this.registry.hash(this.toU8a());
  }

  /// @description Checks if the value is an empty value
  bool get isEmpty {
    return this._values.length == 0 || this._values.isEmpty;
  }

  /// @description The length of the value
  int get length {
    // only included here since we ignore inherited docs
    return this._values.length;
  }

  /// @description Compares the value of the input to see if there is a match
  bool eq([dynamic other]) {
    return compareArray(this._values, other);
  }

  /// @description Converts the Object to an standard JavaScript Array
  List<T> toArray() {
    return List.from(this._values);
  }

  /// @description Returns a hex string representation of the value
  String toHex([bool isLe]) {
    return u8aToHex(this.toU8a());
  }

  /// @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
  dynamic toHuman([bool isExtended]) {
    return this._values.map((entry) => entry.toHuman(isExtended));
  }

  /// @description Converts the Object to JSON, typically used for RPC transfers
  dynamic toJSON() {
    return this._values.map((entry) => entry.toJSON()).toList();
  }

  /**
   * @description Returns the base runtime type name for this instance
   */
  // abstract toRawType(): string;

  /// @description Returns the string representation of the value
  String toString() {
    // Overwrite the default toString representation of Array.
    final data = this._values.map((entry) => entry.toString());

    return "[${data.join(', ')}]";
  }

  /// @description Encodes the value as a Uint8Array as per the SCALE specifications
  /// @param isBare true when the value has none of the type-specific prefixes(internal)
  Uint8List toU8a([dynamic isBare]) {
    final encoded = this._values.map((entry) => entry.toU8a(isBare));
    return isBare is bool && isBare == true
        ? u8aConcat([...encoded])
        : u8aConcat([compactToU8a(this.length), ...encoded]);
  }

  // Below are methods that we override. When we do a `new Vec(...).map()`,
  // we want it to return an Array. We only override the methods that return a
  // new instance.

  /// @description Concatenates two arrays
  List<T> concat(List<T> other) {
    final newList = this.toArray();
    newList.addAll(other is AbstractArray<T> ? (other as AbstractArray<T>).toArray() : other);
    return newList;
  }

  // /**
  //  * @description Filters the array with the callback
  //  */
  List<T> filter(bool Function(T value, [int index, List<T> array]) callbackfn, [dynamic thisArg]) {
    var newArr = this.toArray();
    return newArr.where((val) => callbackfn(val, newArr.indexOf(val), newArr)).toList();
  }

  // /**
  //  * @description Maps the array with the callback
  //  */
  List<U> map<U>(U Function(T value, [int index, List<T> array]) callbackfn, [dynamic thisArg]) {
    var newArr = this.toArray();
    return newArr.map((val) => callbackfn(val, newArr.indexOf(val), newArr)).toList();
  }

  // /**
  //  * @description Checks if the array includes a specific value
  //  */
  bool includes(dynamic check) {
    return this._values.contains((T value) => value.eq(check));
  }
}
