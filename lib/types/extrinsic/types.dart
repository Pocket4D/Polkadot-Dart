import 'dart:typed_data';

abstract class ExtrinsicOptions {
  bool isSigned;
  int version;
}

abstract class ExtrinsicPayloadOptions {
  int version;
}

abstract class ExtrinsicSignatureOptions {
  bool isSigned;
}

abstract class ExtrinsicExtraValue {
  Uint8List era;
  dynamic nonce;
  dynamic tip;
}
