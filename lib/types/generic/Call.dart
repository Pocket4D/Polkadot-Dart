import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/utils/utils.dart';

class DecodeMethodInput {
  dynamic args;
  // eslint-disable-next-line no-use-before-define
  // GenericCallIndex | Uint8Array;
  dynamic callIndex;
  DecodeMethodInput({this.args, this.callIndex});
}

class DecodedMethod extends DecodeMethodInput {
  Map<String, Constructor> argsDef;
  FunctionMetadataLatest meta;
  DecodedMethod({args, callIndex, this.argsDef, this.meta})
      : super(args: args, callIndex: callIndex);
  Map<String, dynamic> toMap() => {
        "args": this.args,
        "callIndex": this.callIndex is GenericCallIndex
            ? (this.callIndex as GenericCallIndex).value
            : this.callIndex,
        "argsDef": this.argsDef,
        "meta": this.meta
      };
}

Map<String, Constructor> getArgsDef(Registry registry, FunctionMetadataLatest meta) {
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  return GenericCall.filterOrigin(meta).fold({}, (result, argsDef) {
    final type = getTypeClass(registry, getTypeDef(argsDef.type.toString()));
    result[argsDef.name.toString()] = type;
    return result;
  });
}

DecodedMethod decodeCallViaObject(Registry registry, DecodedMethod value,
    [FunctionMetadataLatest _meta]) {
  // we only pass args/methodsIndex out
  final args = value.args;
  final callIndex = value.callIndex;
  // Get the correct lookupIndex
  // eslint-disable-next-line @typescript-eslint/no-use-before-define
  final lookupIndex =
      callIndex is GenericCallIndex ? callIndex.toU8a() : Uint8List.fromList(callIndex);

  // Find metadata with callIndex
  final meta = _meta ?? registry.findMetaCall(lookupIndex).meta;
  return DecodedMethod(
      args: args, argsDef: getArgsDef(registry, meta), callIndex: callIndex, meta: meta);
}

/** @internal */
DecodedMethod decodeCallViaU8a(Registry registry, Uint8List value, [FunctionMetadataLatest _meta]) {
  // We need 2 bytes for the callIndex
  final callIndex = Uint8List(2);
  callIndex.setAll(0, value.length < 2 ? value.sublist(0, value.length) : value.sublist(0, 2));

  // Find metadata with callIndex
  final meta = _meta ?? registry.findMetaCall(callIndex).meta;

  return DecodedMethod(
      args: value.length < 2 ? [] : value.sublist(2),
      argsDef: getArgsDef(registry, meta),
      callIndex: callIndex,
      meta: meta);
}

DecodedMethod decodeCall(Registry registry, [dynamic value, FunctionMetadataLatest _meta]) {
  if (value == null) {
    value = Uint8List.fromList([]);
  }
  if (value is GenericCall) {
    value = value.value;
  }

  if (isHex(value) || isU8a(value)) {
    return decodeCallViaU8a(registry, u8aToU8a(value), _meta);
  } else if (isObject(value) && value["callIndex"] != null && value["args"] != null) {
    final method = DecodedMethod(args: value["args"], callIndex: value["callIndex"]);
    return decodeCallViaObject(registry, method, _meta);
  }

  throw "Call: Cannot decode value '$value' of type ${value.runtimeType}";
}

class GenericCallIndex extends U8aFixed {
  GenericCallIndex(Registry registry, [dynamic value]) : super(registry, value, 16);
  static GenericCallIndex constructor(Registry registry, [dynamic value]) =>
      GenericCallIndex(registry, value);
  factory GenericCallIndex.from(U8aFixed origin) => GenericCallIndex(origin.registry, origin.value);
}

class GenericCall extends Struct implements IMethod {
  FunctionMetadataLatest _meta;

  GenericCall(Registry registry, [dynamic callValue, FunctionMetadataLatest meta])
      : super(
            registry,
            {
              "callIndex": GenericCallIndex.constructor,
              // // eslint-disable-next-line sort-keys
              "args": Struct.withParams(decodeCall(registry, callValue, meta).argsDef)
            },
            decodeCall(registry, callValue, meta).toMap()) {
    final decoded = decodeCall(registry, callValue, meta);

    try {
      Struct(
          registry,
          {
            "callIndex": GenericCallIndex.constructor,
            // eslint-disable-next-line sort-keys
            "args": Struct.withParams(decoded.argsDef)
          },
          decoded.toMap());
    } catch (error) {
      var method = 'unknown.unknown';

      try {
        final c = registry.findMetaCall(decoded.callIndex);

        method = "${c.section}.${c.method}";
      } catch (error) {
        // ignore
      }
      throw "Call: failed decoding $method:: $error}";
    }

    this._meta = decoded.meta;
  }

  static GenericCall constructor(Registry registry, [dynamic value, dynamic meta]) =>
      GenericCall(registry, value, meta as FunctionMetadataLatest);

  // If the extrinsic function has an argument of type "Origin", we ignore it
  static List<FunctionArgumentMetadataLatest> filterOrigin([FunctionMetadataLatest meta]) {
    // FIXME should be "arg.type !== Origin", but doesn't work...
    return meta != null
        ? meta.args
            .filter((latest, [i, list]) => latest.type.toString() != 'Origin')
            .map((element) {
            return FunctionArgumentMetadataLatest.from(element);
          }).toList()
        : [];
  }

  /**
   * @description The arguments for the function call
   */
  List<BaseCodec> get args {
    // FIXME This should return a Struct instead of an Array
    return [...(this.getCodec('args').cast<Struct>()).value.values];
  }

  /**
   * @description The argument definitions
   */
  Map<String, Constructor> get argsDef {
    return getArgsDef(this.registry, this.meta);
  }

  /**
   * @description The encoded "[sectionIndex, methodIndex]" identifier
   */
  Uint8List get callIndex {
    return (this.getCodec('callIndex').cast<GenericCallIndex>()).toU8a();
  }

  /**
   * @description The encoded data
   */
  Uint8List get data {
    return (this.getCodec('args').cast<Struct>()).toU8a();
  }

  /**
   * @description "true" if the "Origin" type is on the method(extrinsic method)
   */
  bool get hasOrigin {
    final firstArg = this.meta.args.value.isNotEmpty ? this.meta.args.value[0] : null;

    return firstArg != null && firstArg.type.toString() == 'Origin';
  }

  /**
   * @description The [[FunctionMetadata]]
   */
  FunctionMetadataLatest get meta {
    return this._meta;
  }

  /**
   * @description Returns the name of the method
   */
  String get methodName {
    return this.registry.findMetaCall(this.callIndex).method;
  }

  /**
   * @description Returns the name of the method
   */
  String get method {
    return this.methodName;
  }

  /**
   * @description Returns the module containing the method
   */
  String get sectionName {
    return this.registry.findMetaCall(this.callIndex).section;
  }

  /**
   * @description Returns the module containing the method
   */
  String get section {
    return this.sectionName;
  }

  /**
   * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
   */
  Map<String, dynamic> toHuman([bool isExpanded]) {
    // let call: CallFunction | undefined;
    var call;
    try {
      call = this.registry.findMetaCall(this.callIndex);
    } catch (error) {
      // swallow
    }

    return {
      "args": this.args.map((arg) => arg.toHuman(isExpanded)),
      // args: this.args.map((arg, index) => call
      //   ? { [call.meta.args[index].name.toString()]: arg.toHuman(isExpanded) }
      //   : arg.toHuman(isExpanded)
      // ),
      // callIndex: u8aToHex(this.callIndex),
      "method": call?.method,
      "section": call?.section,
      ...(isExpanded != null && isExpanded == true && call != null
          ? {"documentation": call.meta.documentation.map((d) => d.toString())}
          : {})
    };
  }

  /**
   * @description Returns the base runtime type name for this instance
   */
  String toRawType() {
    return 'Call';
  }
}
