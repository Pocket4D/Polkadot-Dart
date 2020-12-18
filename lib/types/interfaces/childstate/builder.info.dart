// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// PrefixedStorageKey
class PrefixedStorageKey extends StorageKey {
  PrefixedStorageKey(Registry registry,
      [dynamic value, StorageKeyExtra override])
      : super(registry, value, override);

  factory PrefixedStorageKey.from(StorageKey origin) => PrefixedStorageKey(
      origin.registry, origin.originValue, origin.originOverride);
}
