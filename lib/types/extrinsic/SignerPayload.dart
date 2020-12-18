import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/utils/utils.dart';

abstract class RuntimeVersion extends Struct {
  u32 get speVersion => super.getCodec("speVersion").cast<u32>();
  u32 get transactionVersion => super.getCodec("transactionVersion").cast<u32>();
  RuntimeVersion(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "specName": "Text",
              "implName": "Text",
              "authoringVersion": "u32",
              "specVersion": "u32",
              "implVersion": "u32",
              "apis": "Vec<RuntimeVersionApi>",
              "transactionVersion": "u32"
            },
            value,
            jsonMap);
}

abstract class SignerPayloadType extends BaseCodec {
  Address address;
  Hash blockHash;
  BlockNumber blockNumber;
  ExtrinsicEra era;
  Hash genesisHash;
  Call method;
  Compact<Index> nonce;
  RuntimeVersion runtimeVersion;
  Vec<CodecText> signedExtensions;
  Compact<Balance> tip;
  u8 version;
}

class GenericPayloadJson implements SignerPayloadJSON {
  @override
  String address;

  @override
  String blockHash;

  @override
  String blockNumber;

  @override
  String era;

  @override
  String genesisHash;

  @override
  String method;

  @override
  String nonce;

  @override
  List<String> signedExtensions;

  @override
  String specVersion;

  @override
  String tip;

  @override
  String transactionVersion;

  @override
  int version;
  GenericPayloadJson(
      {this.address,
      this.blockHash,
      this.blockNumber,
      this.era,
      this.genesisHash,
      this.method,
      this.nonce,
      this.signedExtensions,
      this.specVersion,
      this.tip,
      this.transactionVersion,
      this.version});
}

class GenericPayloadRaw implements SignerPayloadRaw {
  @override
  String address;

  @override
  String data;

  @override
  String type;

  GenericPayloadRaw({this.address, this.data, this.type});
}

class GenericSignerPayload extends Struct implements ISignerPayload {
  GenericSignerPayload(Registry registry, [dynamic value, Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "address": 'Address',
              "blockHash": 'Hash',
              "blockNumber": 'BlockNumber',
              "era": 'ExtrinsicEra',
              "genesisHash": 'Hash',
              "method": 'Call',
              "nonce": 'Compact<Index>',
              "runtimeVersion": 'RuntimeVersion',
              "signedExtensions": 'Vec<Text>',
              "tip": 'Compact<Balance>',
              "version": 'u8'
            },
            value,
            jsonMap);

  static GenericSignerPayload constructor(Registry registry,
          [dynamic value, Map<dynamic, String> jsonMap]) =>
      GenericSignerPayload(registry, value, jsonMap);

  /// @description Creates an representation of the structure as an ISignerPayload JSON
  SignerPayloadJSON toPayload() {
    // const { address, blockHash, blockNumber, era, genesisHash, method, nonce, runtimeVersion: { specVersion, transactionVersion }, signedExtensions, tip, version } = this;
    var runtimeVersion = super.getCodec("runtimeVersion").cast<RuntimeVersion>();

    return GenericPayloadJson(
        address: super.getCodec("address").cast<Address>().toString(),
        blockHash: super.getCodec("blockHash").cast<Hash>().toHex(),
        blockNumber: super.getCodec("blockNumber").cast<BlockNumber>().toHex(),
        era: super.getCodec("era").cast<ExtrinsicEra>().toHex(),
        genesisHash: super.getCodec("genesisHash").cast<Hash>().toHex(),
        method: super.getCodec("method").cast<Call>().toHex(),
        nonce: super.getCodec("nonce").cast<Compact<Index>>().toHex(),
        signedExtensions: (super.getCodec("signedExtensions").cast<Vec<CodecText>>())
            .map((e, [index, list]) => e.toString())
            .toList(),
        specVersion: runtimeVersion.speVersion.toHex(),
        tip: super.getCodec("tip").cast<Compact<Balance>>().toHex(),
        transactionVersion: runtimeVersion.transactionVersion.toHex(),
        version: super.getCodec("version").cast<u8>().toNumber());
  }

  /// @description Creates a representation of the payload in raw Exrinsic form
  SignerPayloadRaw toRaw() {
    final payload = this.toPayload();
    // NOTE Explicitly pass the bare flag so the method is encoded un-prefixed(non-decodable, for signing only)
    final data = u8aToHex(this.registry.createType('ExtrinsicPayload', [
      payload,
      {"version": payload.version}
    ]).toU8a({"method": true}));

    return GenericPayloadRaw(address: payload.address, data: data, type: 'payload');
  }
}
