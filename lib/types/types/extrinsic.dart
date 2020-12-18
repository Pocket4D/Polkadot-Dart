import 'package:polkadot_dart/types/interfaces/system/types.dart';
import 'package:polkadot_dart/types/interfaces/types.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

abstract class ISubmittableResult {
  DispatchError get dispatchError;
  DispatchInfo get dispatchInfo;
  // List<EventRecord> get events;
  // ExtrinsicStatus get status;
  bool get isCompleted;
  bool get isError;
  bool get isFinalized;
  bool get isInBlock;
  bool get isWarning;

  // List<EventRecord> filterRecords(String section, String method);
  // EventRecord findRecord(String section, String method);
  dynamic toHuman([bool isExtended]);
}

abstract class SignerPayloadJSON {
  /**
   * @description The ss-58 encoded address
   */
  String address;

  /**
   * @description The checkpoint hash of the block, in hex
   */
  String blockHash;

  /**
   * @description The checkpoint block number, in hex
   */
  String blockNumber;

  /**
   * @description The era for this transaction, in hex
   */
  String era;

  /**
   * @description The genesis hash of the chain, in hex
   */
  String genesisHash;

  /**
   * @description The encoded method (with arguments) in hex
   */
  String method;

  /**
   * @description The nonce for this transaction, in hex
   */
  String nonce;

  /**
   * @description The current spec version for the runtime
   */
  String specVersion;

  /**
   * @description The tip for this transaction, in hex
   */
  String tip;

  /**
   * @description The current transaction version for the runtime
   */
  String transactionVersion;

  /**
   * @description The applicable signed extensions for this runtime
   */
  String signedExtensions;

  /**
   * @description The version of the extrinsic we are dealing with
   */
  int version;
}

abstract class SignerPayloadRawBase {
  /**
   * @description The hex-encoded data for this request
   */
  String data;

  /**
   * @description The type of the contained data
   */
  String type;
}

abstract class SignerPayloadRaw extends SignerPayloadRawBase {
  /**
   * @description The ss-58 encoded address
   */
  String address;

  /**
   * @description The type of the contained data
   */
  String type;
}

abstract class ISignerPayload {
  SignerPayloadJSON toPayload();
  SignerPayloadRaw toRaw();
}

abstract class SignerResult {
  /**
   * @description The id for this request
   */
  int id;

  /**
   * @description The resulting signature in hex
   */
  String signature;
}

abstract class Signer {
  /**
   * @description signs an extrinsic payload from a serialized form
   */
  Future<SignerResult> signPayload(SignerPayloadJSON payload);

  /**
   * @description signs a raw payload, only the bytes data as supplied
   */
  Future<SignerResult> signRaw(SignerPayloadRaw raw);

  /**
   * @description Receives an update for the extrinsic signed by a `signer.sign`
   */
  // H256 | ISubmittableResult
  void update(int id, dynamic status);
}

abstract class IExtrinsicEra extends BaseCodec {
  BaseCodec asImmortalEra;
  BaseCodec asMortalEra;
}

abstract class SignatureOptions {
  dynamic blockHash; //Uint8Array | string;
  IExtrinsicEra era;
  dynamic genesisHash; // Uint8Array | string;
  dynamic nonce; // AnyNumber;
  IRuntimeVersion runtimeVersion;
  List<String> signedExtensions;
  Signer signer;
  dynamic tip; //  AnyNumber;
}

abstract class ExtrinsicSignatureBase {
  bool get isSigned;
  IExtrinsicEra get era;
  ICompact<Index> get nonce;
  dynamic get signature; //: EcdsaSignature | Ed25519Signature | Sr25519Signature;
  // Address get signer;
  ICompact<Balance> get tip;
}

abstract class ExtrinsicPayloadValue {
  dynamic blockHash; // AnyU8a;
  dynamic era; // AnyU8a | IExtrinsicEra;
  dynamic genesisHash; // AnyU8a;
  dynamic method; // AnyU8a | IMethod;
  dynamic nonce; //: AnyNumber;
  dynamic specVersion; //: AnyNumber;
  dynamic tip; //: AnyNumber;
  dynamic transactionVersion; //: AnyNumber;
}

abstract class IExtrinsicSignature extends ExtrinsicSignatureBase implements BaseCodec {
  IExtrinsicSignature addSignature(dynamic signer, dynamic signature, dynamic payload);
  IExtrinsicSignature sign(Call method, IKeyringPair account, SignatureOptions options);
  IExtrinsicSignature signFake(Call method, dynamic address, SignatureOptions options);
}

abstract class IExtrinsicSignable<T> {
  T addSignature(dynamic signer, dynamic signature, dynamic payload);
  T sign(IKeyringPair account, SignatureOptions options);
  T signFake(dynamic address, SignatureOptions options);
}

abstract class IExtrinsicImpl extends IExtrinsicSignable<IExtrinsicImpl> implements BaseCodec {
  Call get method;
  IExtrinsicSignature get signature;
  int get version;
}

abstract class IExtrinsic extends IExtrinsicSignable<IExtrinsic>
    implements ExtrinsicSignatureBase, IMethod {
  int get length;
  Call get method;
  int get type;
  int get version;
}
