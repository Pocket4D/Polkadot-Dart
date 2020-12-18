import 'package:polkadot_dart/types/extrinsic/index.dart';
import 'package:polkadot_dart/types/extrinsic/types.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicPayload.dart';
import 'package:polkadot_dart/types/extrinsic/v4/ExtrinsicSignature.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class ExtrinsicEra extends GenericExtrinsicEra {
  ExtrinsicEra(Registry registry) : super(registry);
}

class EcdsaSignature extends U8aFixed {
  EcdsaSignature(Registry registry,
      [dynamic value, int bitLength = 520, String typeName = "EcdsaSignature"])
      : super(registry, value, bitLength ?? 520, typeName ?? "EcdsaSignature");

  factory EcdsaSignature.from(U8aFixed origin) =>
      EcdsaSignature(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class Ed25519Signature extends H512 {
  Ed25519Signature(Registry registry,
      [dynamic value, int bitLength = 512, String typeName = "Ed25519Signature"])
      : super(registry, value, bitLength ?? 512, typeName ?? "Ed25519Signature");

  factory Ed25519Signature.from(U8aFixed origin) =>
      Ed25519Signature(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class Sr25519Signature extends U8aFixed {
  Sr25519Signature(Registry registry,
      [dynamic value, int bitLength = 512, String typeName = "Sr25519Signature"])
      : super(registry, value, bitLength ?? 512, typeName ?? "Sr25519Signature");

  factory Sr25519Signature.from(U8aFixed origin) =>
      Sr25519Signature(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

class MultiSignature extends Enum {
  bool get isEd25519 => super.isKey("Ed25519");
  Ed25519Signature get asEd25519 => super.askey("Ed25519").cast<Ed25519Signature>();
  bool get isSr25519 => super.isKey("Sr25519");
  Sr25519Signature get asSr25519 => super.askey("Sr25519").cast<Sr25519Signature>();
  bool get isEcdsa => super.isKey("Ecdsa");
  EcdsaSignature get asEcdsa => super.askey("Ecdsa").cast<EcdsaSignature>();

  MultiSignature(Registry registry, [dynamic value, int index])
      : super(
            registry,
            {
              "Ed25519": "Ed25519Signature",
              "Sr25519": "Sr25519Signature",
              "Ecdsa": "EcdsaSignature"
            },
            value,
            index);

  factory MultiSignature.from(Enum origin) =>
      MultiSignature(origin.registry, origin.originValue, origin.originIndex);
}

class ExtrinsicSignature extends MultiSignature {
  ExtrinsicSignature(Registry registry, [dynamic value, int index]) : super(registry, value, index);
  factory ExtrinsicSignature.from(Enum origin) =>
      ExtrinsicSignature(origin.registry, origin.originValue, origin.originIndex);
}

class Signature extends H512 {
  Signature(Registry registry, [dynamic value, int bitLength = 512, String typeName = "Signature"])
      : super(registry, value, bitLength ?? 512, typeName ?? "Signature");

  factory Signature.from(U8aFixed origin) =>
      Signature(origin.registry, origin.value, origin.bitLength, origin.typeName);
}

// class SignerPayload extends GenericSignerPayload {}

class ExtrinsicPayloadV4 extends GenericExtrinsicPayloadV4 {
  ExtrinsicPayloadV4(Registry registry, [dynamic value]) : super(registry, value);
  factory ExtrinsicPayloadV4.from(GenericExtrinsicPayloadV4 origin) =>
      ExtrinsicPayloadV4(origin.registry, origin.originValue);
}

/** @name ExtrinsicSignatureV4 */
class ExtrinsicSignatureV4 extends GenericExtrinsicSignatureV4 {
  ExtrinsicSignatureV4(Registry registry, [dynamic value, ExtrinsicSignatureOptions options])
      : super(registry, value, options);
  factory ExtrinsicSignatureV4.from(GenericExtrinsicSignatureV4 origin) =>
      ExtrinsicSignatureV4(origin.registry, origin.value, origin.originOptions);
}
