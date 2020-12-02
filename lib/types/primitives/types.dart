import 'dart:typed_data';

import 'package:polkadot_dart/types/interfaces/metadata/types.dart';

abstract class StorageEntry {
  Uint8List call([dynamic arg]);
  dynamic iterKey([dynamic arg]);
  Uint8List keyPrefix([dynamic arg]);
  StorageEntryMetadataLatest meta;
  String method;
  String prefix;
  String section;
  dynamic toJSON();
}
