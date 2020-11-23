import 'dart:convert';
import 'dart:typed_data';

class KeyringOptions {
  int ss58Format;
  String type;
  KeyringOptions({this.ss58Format, this.type});
}

// export type KeyringPair$Meta = Record<string, unknown>;

// export type KeyringPair$JsonVersion = '0' | '1' | '2' | '3';

// export type KeyringPair$JsonEncodingTypes = 'none' | 'scrypt' | 'xsalsa20-poly1305';

class KeyringPair$JsonEncoding {
  List<String> content;
  dynamic type; // String or List<String>
  String version;
  KeyringPair$JsonEncoding({this.content, this.type, this.version});
  factory KeyringPair$JsonEncoding.fromMap(Map<String, dynamic> map) => KeyringPair$JsonEncoding(
      content: map['content'] as List<String>,
      type: map["type"] as dynamic,
      version: map["version"] as String);
  toMap() => {
        "content": this.content,
        "type": this.type,
        "version": this.version,
      };
  toJson() => jsonEncode(toMap());
}

class KeyringPair$Json {
  String address;
  String encoded;
  KeyringPair$JsonEncoding encoding;
  Map<String, dynamic> meta;
  KeyringPair$Json({this.address, this.encoded, this.encoding, this.meta});
  factory KeyringPair$Json.fromMap(Map<String, dynamic> map) => KeyringPair$Json(
      address: map["address"] as String,
      encoded: map["encoded"] as String,
      encoding: KeyringPair$JsonEncoding.fromMap(Map<String, dynamic>.from(map["encoding"])),
      meta: Map<String, dynamic>.from(map["meta"]));
  toMap() => {
        "address": address,
        "encoded": encoded,
        "encoding": encoding.toMap(),
        "meta": meta,
      };
  toJson() => jsonEncode(toMap());
}

class SignOptions {
  bool withType;
}

typedef KDecodePkcs8 = Future Function(String passphrase, [Uint8List encoded]);
typedef KDerive = KeyringPair Function(String suri, [Map<String, dynamic> meta]);
typedef KEncodePkcs8 = Future<Uint8List> Function([String passphrase]);
typedef KLock = void Function();
typedef KSetMeta = void Function(Map<String, dynamic> meta);
typedef KSign = Uint8List Function(Uint8List message, [SignOptions options]);
typedef KToJson = Future<KeyringPair$Json> Function([String passphrase]);
typedef KVerify = bool Function(Uint8List message, Uint8List signature);

abstract class KeyringPair {
  String get address;
  Uint8List get addressRaw;
  Map<String, dynamic> get meta;
  bool get isLocked;
  Uint8List get publicKey;
  String get type;

  KDecodePkcs8 decodePkcs8;
  KDerive derive;
  KEncodePkcs8 encodePkcs8;
  KLock lock;
  KSetMeta setMeta;
  KSign sign;
  KToJson toJson;
  KVerify verify;
}

abstract class KeyringPairs {
  KeyringPair add(KeyringPair pair);
  List<KeyringPair> all();
  KeyringPair get(dynamic address);
  void remove(dynamic address);
}

abstract class KeyringInstance {
  List<KeyringPair> get pairs;
  List<Uint8List> get publicKeys;
  String get type;

  Uint8List decodeAddress(dynamic encoded, [bool ignoreChecksum, int ss58Format]);
  String encodeAddress(dynamic key, [int ss58Format]);
  void setSS58Format(int ss58Format);

  KeyringPair addPair(KeyringPair pair);
  KeyringPair addFromAddress(dynamic address,
      [Map<String, dynamic> meta,
      Uint8List encoded,
      String type,
      bool ignoreChecksum,
      List<String> encType]);
  KeyringPair addFromJson(KeyringPair$Json pair, [bool ignoreChecksum]);
  KeyringPair addFromMnemonic(String mnemonic, [Map<String, dynamic> meta, String type]);
  KeyringPair addFromSeed(Uint8List seed, [Map<String, dynamic> meta, String type]);
  KeyringPair addFromUri(String suri, [Map<String, dynamic> meta, String type]);
  KeyringPair createFromJson(KeyringPair$Json json, [bool ignoreChecksum]);
  KeyringPair createFromUri(String suri, [Map<String, dynamic> meta, String type]);
  KeyringPair getPair(dynamic address);
  List<KeyringPair> getPairs();
  List<Uint8List> getPublicKeys();
  void removePair(dynamic address);
  Future<KeyringPair$Json> toJson(dynamic address, [String passphrase]);
}
