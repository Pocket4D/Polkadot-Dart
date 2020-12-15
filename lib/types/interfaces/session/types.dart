import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/interfaces/staking/types.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types.dart';

/** @name FullIdentification */
class FullIdentification<S extends Map<String, dynamic>> extends Exposure {
  FullIdentification(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory FullIdentification.from(Struct origin) => FullIdentification(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/** @name IdentificationTuple */
// <[ValidatorId, FullIdentification]>
class IdentificationTuple extends ITuple<List<BaseCodec>> {
  List<BaseCodec> list;
  IdentificationTuple(ValidatorId validatorId, FullIdentification fullIdentification) {
    list = List.from([validatorId, fullIdentification]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name Keys */
class Keys extends SessionKeys4 {
  Keys(AccountId a, AccountId b, AccountId c, AccountId d) : super(a, b, c, d);
}

/** @name MembershipProof */
class MembershipProof<S extends Map<String, dynamic>> extends Struct {
  SessionIndex get session => super.getCodec("session").cast<SessionIndex>();
  Vec<Bytes> get trieNodes => super.getCodec("trieNodes").cast<Vec<Bytes>>();
  ValidatorCount get validatorCount => super.getCodec("validatorCount").cast<ValidatorCount>();
  MembershipProof(Registry registry, S types,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(registry, types, value, jsonMap);
  factory MembershipProof.from(Struct origin) => MembershipProof(
      origin.registry, origin.originTypes, origin.originValue, origin.originJsonMap);
}

/** @name SessionIndex */
class SessionIndex extends u32 {
  SessionIndex(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory SessionIndex.from(u32 origin) {
    return SessionIndex(origin.registry, origin.value);
  }
}

/** @name SessionKeys1 */
class SessionKeys1 extends AccountId {
  SessionKeys1(Registry registry, [dynamic value]) : super(registry, value);
  factory SessionKeys1.from(AccountId origin) {
    return SessionKeys1(origin.registry, origin.value);
  }
}

// /** @name SessionKeys2 */
class SessionKeys2 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys2(AccountId a, AccountId b) {
    list = List.from([a, b]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => this.list;
}

// /** @name SessionKeys3 */
class SessionKeys3 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys3(AccountId a, AccountId b, AccountId c) {
    list = List.from([a, b, c]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys4 */
class SessionKeys4 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys4(AccountId a, AccountId b, AccountId c, AccountId d) {
    list = List.from([a, b, c, d]);
  }

  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys5 */
class SessionKeys5 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys5(AccountId a, AccountId b, AccountId c, AccountId d, AccountId e) {
    list = List.from([a, b, c, d, e]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys6 */
class SessionKeys6 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys6(AccountId a, AccountId b, AccountId c, AccountId d, AccountId e, AccountId f) {
    list = List.from([a, b, c, d, e, f]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys7 */
class SessionKeys7 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys7(
      AccountId a, AccountId b, AccountId c, AccountId d, AccountId e, AccountId f, AccountId g) {
    list = List.from([a, b, c, d, e, f, g]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys8 */
class SessionKeys8 extends ITuple<List<AccountId>> {
  List<AccountId> list;
  SessionKeys8(AccountId a, AccountId b, AccountId c, AccountId d, AccountId e, AccountId f,
      AccountId g, AccountId h) {
    list = List.from([a, b, c, d, e, f, g, h]);
  }
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

// /** @name SessionKeys9 */
class SessionKeys9 extends ITuple<List<AccountId>> {
  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

/** @name ValidatorCount */
class ValidatorCount extends u32 {
  ValidatorCount(Registry registry, [dynamic value = 0]) : super(registry, value ?? 0);
  factory ValidatorCount.from(u32 origin) {
    return ValidatorCount(origin.registry, origin.value);
  }
}

const PHANTOM_SESSION = 'session';
