// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// StorageKind
class StorageKind extends Enum {
  bool get isUnused => super.isKey("Unused");

  bool get isPersistent => super.isKey("Persistent");

  bool get isLocal => super.isKey("Local");

  StorageKind(Registry registry, [dynamic value, int index])
      : super(registry, ["__UNUSED", "PERSISTENT", "LOCAL"], value, index);

  factory StorageKind.from(Enum origin) =>
      StorageKind(origin.registry, origin.originValue, origin.originIndex);
}
