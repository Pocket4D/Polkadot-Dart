import 'package:polkadot_dart/metadata/MagicNumber.dart';
import 'package:polkadot_dart/metadata/util/getUniqTypes.dart';
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

class MetadataVersioned extends Struct {
  Map<int, MetaMapped> _converted = new Map<int, MetaMapped>();

  MetadataVersioned(Registry registry, [dynamic value])
      : super(registry, {"magicNumber": MagicNumber.constructor, "metadata": 'MetadataAll'}, value);

  bool _assertVersion(int version) {
    assert(this.version <= version, "Cannot convert metadata from v${this.version} to v$version");
    return this.version == version;
  }

  Struct _getVersion<T extends MetaMapped, F extends MetaMapped>(
      MetaVersions version, T Function(Registry registry, F input) fromPrev) {
    final intVersion = MetaVersionsExt.version(version);

    if (this._assertVersion(MetaVersionsExt.version(version))) {
      return this._metadata.askey("V$intVersion") as Struct;
    }

    if (!this._converted.containsKey(intVersion)) {
      switch (intVersion) {
        case 10:
          this._converted[intVersion] = fromPrev(this.registry, this.asV9 as F);
          break;
        case 11:
          this._converted[intVersion] = fromPrev(this.registry, this.asV10 as F);
          break;
        case 12:
          this._converted[intVersion] = fromPrev(this.registry, this.asV11 as F);
          break;
        case 13:
          this._converted[intVersion] = fromPrev(this.registry, this.asV12 as F);
          break;
      }
      // this._converted[intVersion]=fromPrev(this.registry, this[asPrev] as F);
    }

    return this._converted[intVersion] as Struct;
  }

  /**
   * @description Returns the wrapped metadata as a limited calls-only(latest) version
   */
  MetadataVersioned get asCallsOnly {
    return new MetadataVersioned(this.registry, {
      "magicNumber": this.magicNumber,
      "metadata": this
          .registry
          .createType('MetadataAll', [toCallsOnly(this.registry, this.asLatest), this.version])
    });
  }

  /**
   * @description Returns the wrapped metadata as a V1 object
   */
  MetadataV9 get asV9 {
    this._assertVersion(9);

    return MetadataV9.from(this._metadata.asV9);
  }

  /**
   * @description Returns the wrapped values as a V10 object
   */
  MetadataV10 get asV10 {
    return MetadataV10.from(this._getVersion(MetaVersions.V10, toV10));
  }

  /**
   * @description Returns the wrapped values as a V10 object
   */
  MetadataV11 get asV11 {
    return MetadataV11.from(this._getVersion(MetaVersions.V11, toV11));
  }

  /**
   * @description Returns the wrapped values as a V10 object
   */
  MetadataV12 get asV12 {
    return MetadataV12.from(this._getVersion(MetaVersions.V12, toV12));
  }

  /**
   * @description Returns the wrapped values as a latest version object
   */
  MetadataLatest get asLatest {
    // This is non-existent & latest - applied here to do the module-specific type conversions
    return MetadataLatest.from(this._getVersion(MetaVersions.V13, toLatest));
  }

  /**
   * @description
   */
  MagicNumber get magicNumber {
    return this.getCodec('magicNumber').cast<MagicNumber>();
  }

  /**
   * @description the metadata wrapped
   */
  MetadataAll get _metadata {
    return MetadataAll.from(this.getCodec('metadata'));
  }

  /**
   * @description the metadata version this structure represents
   */
  int get version {
    return this._metadata.index;
  }

  List<String> getUniqTypes(bool throwError) {
    // this.asLatest.modules.toJSON() as List<Map<String, dynamic>>;
    return utilsGetUniqTypes.getUniqTypes(this.registry, this.asLatest, throwError);
  }
}
