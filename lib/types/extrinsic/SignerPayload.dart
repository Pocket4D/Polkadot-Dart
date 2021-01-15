import 'package:polkadot_dart/types/interfaces/extrinsics/types.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;
import 'package:polkadot_dart/types/types/extrinsic.dart';
import 'package:polkadot_dart/utils/utils.dart';

class RuntimeVersion extends Struct {
  u32 get specVersion => this.getCodec("specVersion")?.cast<u32>();
  u32 get transactionVersion => this.getCodec("transactionVersion")?.cast<u32>();
  RuntimeVersion.empty() : super.empty();
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
  factory RuntimeVersion.from(Struct origin) =>
      RuntimeVersion(origin.registry, origin.originValue, origin.originJsonMap);
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
  Map<String, dynamic> toMap() => {
        "address": this.address,
        "blockHash": this.blockHash,
        "blockNumber": this.blockNumber,
        "era": this.era,
        "genesisHash": this.genesisHash,
        "method": this.method,
        "nonce": this.nonce,
        "signedExtensions": this.signedExtensions,
        "specVersion": this.specVersion,
        "tip": this.tip,
        "transactionVersion": this.transactionVersion,
        "version": this.version
      };
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

  static GenericSignerPayload constructor(Registry registry, [dynamic value, dynamic jsonMap]) =>
      GenericSignerPayload(registry, value, jsonMap as Map<dynamic, String>);

  /// @description Creates an representation of the structure as an ISignerPayload JSON
  SignerPayloadJSON toPayload() {
    // print(super.getCodec("runtimeVersion").runtimeType);

    // const { address, blockHash, blockNumber, era, genesisHash, method, nonce, runtimeVersion: { specVersion, transactionVersion }, signedExtensions, tip, version } = this;
    var runtimeVersion = RuntimeVersion.from(this.getCodec("runtimeVersion"));

    var data = (this.getCodec("signedExtensions") as Vec);
    var newList = data.value.map((element) {
      return CodecText(data.registry, element.toString());
    }).toList();
    final signedExtensions = Vec.fromList(newList, data.registry, 'Text')
        .map((e, [index, list]) => e.toString())
        .toList();

    return GenericPayloadJson(
        address: Address.from(this.getCodec("address")).toString(),
        blockHash: Hash.from(this.getCodec("blockHash")).toHex(),
        blockNumber: BlockNumber.from(this.getCodec("blockNumber")).toHex(),
        era: (this.getCodec("era")).toHex(),
        genesisHash: Hash.from(this.getCodec("genesisHash")).toHex(),
        method: Call.from(this.getCodec("method")).toHex(),
        nonce:
            (Compact.from(Index.from((this.getCodec("nonce") as Compact).value), registry, 'Index'))
                .toHex(),
        signedExtensions: signedExtensions,
        specVersion: runtimeVersion.specVersion.toHex(),
        tip: (Compact.from(
                Balance.from((this.getCodec("tip") as Compact).value), registry, 'Balance'))
            .toHex(),
        transactionVersion: runtimeVersion.transactionVersion.toHex(),
        version: this.getCodec("version").cast<u8>().toNumber());
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
