import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';

abstract class StorageEntry {
  Uint8List call([dynamic arg]);
  dynamic Function([dynamic arg]) iterKey;
  Uint8List Function([dynamic arg]) keyPrefix;
  StorageEntryMetadataLatest meta;
  String method;
  String prefix;
  String section;
  Map<String, dynamic> Function() toJSON;
}
