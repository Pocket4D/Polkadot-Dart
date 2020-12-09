import 'dart:ffi';
import 'dart:typed_data';

import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

bool u8aHasValue(Uint8List value) {
  return value.any((v) => v != null);
}

void checkInstance<T extends BaseCodec>(Uint8List value, dynamic created) {
  // the underlying type created.toRawType()
  final rawType = created.toRawType();

  // ignore bytes completely - this is probably a FIXME, since these are somewhat
  // breaking for at least online queries - not quite sure wtf is going wrong here
  if (rawType == 'Bytes') {
    return;
  }

  // the hex values for what we have
  final inHex = u8aToHex(value);
  final crHex = (created as T).toHex();

  // Check equality, based on some different approaches (as decoded)
  final isEqual = inHex == crHex || // raw hex values, quick path
      inHex == (created as T).toHex(true) || // wrapped options
      u8aToHex(value.reversed) == crHex; // reverse (for numbers, which are BE)

  // if the hex doesn't match and the value for both is non-empty, complain... bitterly
  if (!isEqual && (u8aHasValue(value) || u8aHasValue(created.toU8a(true)))) {
    print("$rawType:: Input doesn't match output, received ${u8aToHex(value)}, created $crHex");
  }
}

// Initializes a type with a value. This also checks for fallbacks and in the cases
// where isPedantic is specified (storage decoding), also check the format/structure
T initType<T extends BaseCodec>(Registry registry, dynamic type,
    [List<dynamic> params, bool isPedantic]) {
  if (params == null) {
    params = [];
  }

  T created;

  switch (params.length) {
    case 0:
      created = (type as Constructor<T>)(registry);
      break;
    case 1:
      created = (type as Constructor<T>)(registry, params[0]);
      break;
    case 2:
      created = (type as Constructor2<T>)(registry, params[0], params[1]);
      break;
    case 3:
      created = (type as Constructor3<T>)(registry, params[0], params[1], params[2]);
      break;
    case 4:
      created = (type as Constructor4<T>)(registry, params[0], params[1], params[2], params[3]);
      break;
    default:
      break;
  }

  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  final value = params.isEmpty ? null : params[0];

  if (isPedantic != null && isPedantic == true && isU8a(value)) {
    checkInstance(value, created);
  }

  return created;
}

// An unsafe version of the `createType` below. It's unsafe because the `type`
// argument here can be any string, which, when it cannot parse, will yield a
// runtime error.
// eslint-disable-next-line @typescript-eslint/no-unused-vars
T createTypeUnsafe<T extends BaseCodec>(Registry registry, String type,
    [List<dynamic> params, bool isPedantic]) {
  // try {

  if (params == null) {
    params = [];
  }

  final clazz = createClass<T>(registry, type);

  // Circle back to isPedantic when it handles all cases 100% - as of now,
  // it provides false warning which is more hinderance than help
  return initType(registry, clazz, params); // , isPedantic);
  // } catch (error) {
  //   throw "createType($type):: $error";
  // }
  // TODO: Debug to remove trycatch
}

T createType<T extends BaseCodec>(Registry registry, String type, List<dynamic> params) {
  return createTypeUnsafe<T>(registry, type, params);
}
