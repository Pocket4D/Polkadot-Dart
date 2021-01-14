import 'dart:async';

import 'package:polkadot_dart/metadata/MagicNumber.dart';
// import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
import 'package:polkadot_dart/metadata/util/toCallsOnly.dart';
import 'package:polkadot_dart/metadata/v10/toV11.dart';
import 'package:polkadot_dart/metadata/v11/toV12.dart';
import 'package:polkadot_dart/metadata/v12/toLatest.dart';
import 'package:polkadot_dart/metadata/v9/toV10.dart';
import 'package:polkadot_dart/metadata/util/getUniqTypes.dart' as utilsGetUniqTypes;
import 'package:polkadot_dart/types/interfaces/metadata/types.dart';
import 'package:polkadot_dart/types/types.dart';

enum MetaVersions { V9, V10, V11, V12, V13 }
enum AsMetaVersion { asV9, asV10, asV11, asV12, asV13 }

extension MetaVersionsExt on MetaVersions {
  String get name => this.toString().replaceFirst("MetaVersions.", "");
  static MetaVersions fromString(String value) {
    return MetaVersions.values.firstWhere(
        (element) => element.name == value.replaceFirst("MetaVersions.", ""),
        orElse: () => throw "$value is not in MetaVersions.");
  }

  static MetaVersions fromVersion(int value) {
    return MetaVersions.values.firstWhere((element) => element.name == "V$value",
        orElse: () => throw "$value is not in MetaVersions.");
  }

  static Iterable<String> get names => MetaVersions.values.map((e) => e.name);
  static Map<String, MetaVersions> get stringMaps =>
      Map<String, MetaVersions>.fromEntries(MetaVersions.values.map((e) => MapEntry(e.name, e)));
  static Map<MetaVersions, String> get enumMaps =>
      Map<MetaVersions, String>.fromEntries(MetaVersions.values.map((e) => MapEntry(e, e.name)));
  static int version(MetaVersions item) {
    return int.parse(MetaVersionsExt.fromString(item.name).name.replaceAll("V", ""));
  }
}

extension AsMetaVersionExt on AsMetaVersion {
  String get name => this.toString().replaceFirst("AsMetaVersion.", "");
  static AsMetaVersion fromString(String value) {
    return AsMetaVersion.values.firstWhere(
        (element) => element.name == value.replaceFirst("AsMetaVersion.", ""),
        orElse: () => throw "$value is not in AsMetaVersion.");
  }

  static AsMetaVersion fromVersion(int value) {
    return AsMetaVersion.values.firstWhere((element) => element.name == "asV$value",
        orElse: () => throw "$value is not in AsMetaVersion.");
  }

  static Iterable<String> get names => AsMetaVersion.values.map((e) => e.name);
  static Map<String, AsMetaVersion> get stringMaps =>
      Map<String, AsMetaVersion>.fromEntries(AsMetaVersion.values.map((e) => MapEntry(e.name, e)));
  static Map<AsMetaVersion, String> get enumMaps =>
      Map<AsMetaVersion, String>.fromEntries(AsMetaVersion.values.map((e) => MapEntry(e, e.name)));
  static version(AsMetaVersion item) {
    return int.parse(AsMetaVersionExt.fromString(item.name).name.replaceAll("asV", ""));
  }
}

class MetadataVersioned extends Struct implements Castable {
  Map<int, MetaMapped> _converted = new Map<int, MetaMapped>();
  MetadataAll _metadataAll;

  MetadataVersioned(Registry registry, [dynamic thisValue])
      : super(registry, {"magicNumber": MagicNumber.constructor, "metadata": 'MetadataAll'},
            thisValue);
  MetadataVersioned.empty() : super.empty();
  static Future<MetadataVersioned> asyncMetadataVersioned(Registry registry,
      [dynamic thisValue]) async {
    final struct = await Struct.asyncStruct(
        registry, {"magicNumber": MagicNumber.constructor, "metadata": 'MetadataAll'}, thisValue);
    return MetadataVersioned.empty()
      ..setValue(struct.value)
      ..setJsonMap(struct.constructorJsonMap ?? Map<dynamic, String>())
      ..setTypes(struct.constructorTypes)
      ..originJsonMap = struct.originJsonMap
      ..originTypes = struct.originTypes
      ..originValue = struct.originValue
      ..registry = struct.registry;
  }

  bool _assertVersion(int version) {
    assert(this.version <= version, "Cannot convert metadata from v${this.version} to v$version");
    return this.version == version;
  }

  T _getVersion<T extends MetaMapped, F extends MetaMapped>(
      MetaVersions version, T Function(Registry registry, F input, int versionNumber) fromPrev) {
    final intVersion = MetaVersionsExt.version(version);

    if (this._assertVersion(MetaVersionsExt.version(version))) {
      switch (intVersion) {
        case 9:
          final result =
              this._converted.containsKey(9) ? this._converted[9] : this._metadata.asV9 as T;
          this.updateMeta(result);
          return result;
        case 10:
          final result =
              this._converted.containsKey(10) ? this._converted[10] : this._metadata.asV10 as T;
          this.updateMeta(result);
          return result;
        case 11:
          final result =
              this._converted.containsKey(11) ? this._converted[11] : this._metadata.asV11 as T;
          this.updateMeta(result);
          return result;
        case 12:
          final result =
              this._converted.containsKey(12) ? this._converted[12] : this._metadata.asV12 as T;
          this.updateMeta(result);
          return result;
        case 13:
          final result = this._converted.containsKey(13) ? this._converted[13] : this.asLatest as T;
          this.updateMeta(result);
          return result;
        default:
          break;
      }
    }

    if (!this._converted.containsKey(intVersion)) {
      switch (intVersion) {
        case 10:
          this._converted[intVersion] = fromPrev(this.registry, this.asV9 as F, this.version);
          break;
        case 11:
          this._converted[intVersion] = fromPrev(this.registry, this.asV10 as F, this.version);
          break;
        case 12:
          this._converted[intVersion] = fromPrev(this.registry, this.asV11 as F, this.version);
          break;
        case 13:
          this._converted[intVersion] = fromPrev(this.registry, this.asV12 as F, this.version);
          break;
      }
      // this._converted[intVersion]=fromPrev(this.registry, this[asPrev] as F);
    }
    // TODO: should make some update function to do that
    // (this.value["metadata"] as Enum).setRaw(this._converted[intVersion]);
    this.updateMeta(this._converted[intVersion]);
    return this._converted[intVersion] as T;
  }

  /// @description Returns the wrapped metadata as a limited calls-only(latest) version
  MetadataVersioned get asCallsOnly {
    return new MetadataVersioned(this.registry, {
      "magicNumber": this.magicNumber,
      "metadata": this
          .registry
          .createType('MetadataAll', [toCallsOnly(this.registry, this.asLatest), this.version])
    });
  }

  /// @description Returns the wrapped metadata as a V1 object
  MetadataV9 get asV9 {
    this._assertVersion(9);

    return this._metadata.asV9;
  }

  /// @description Returns the wrapped values as a V10 object
  MetadataV10 get asV10 {
    return this._getVersion<MetadataV10, MetadataV9>(MetaVersions.V10, toV10);
  }

  /// @description Returns the wrapped values as a V10 object
  MetadataV11 get asV11 {
    return this._getVersion<MetadataV11, MetadataV10>(MetaVersions.V11, toV11);
  }

  /// @description Returns the wrapped values as a V10 object
  MetadataV12 get asV12 {
    return this._getVersion<MetadataV12, MetadataV11>(MetaVersions.V12, toV12);
  }

  /// @description Returns the wrapped values as a latest version object
  MetadataLatest get asLatest {
    return this._getVersion<MetadataLatest, MetadataV12>(MetaVersions.V13, toLatest);
  }

  /// @description
  MagicNumber get magicNumber {
    return MagicNumber.from(this.getCodec('magicNumber'));
  }

  /// @description the metadata wrapped
  MetadataAll get _metadata {
    if (this._metadataAll != null) {
      return this._metadataAll;
    }
    return _metadataAll = MetadataAll.from(this.getCodec('metadata'));
  }

  /// @description the metadata version this structure represents
  int get version {
    return this._metadata.index;
  }

  List<String> getUniqTypes(bool throwError) {
    // this.asLatest.modules.toJSON() as List<Map<String, dynamic>>;
    return utilsGetUniqTypes.getUniqTypes(this.registry, this.asLatest, throwError);
  }

  void updateMeta(MetaMapped data) {
    this.value["metadata"] = enumWith((this.value["metadata"] as Enum).def)(
        this.registry, data, (this.value["metadata"] as Enum).index);
  }
}
