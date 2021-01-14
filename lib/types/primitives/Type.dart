import 'package:polkadot_dart/types/create/sanitize.dart';
import 'package:polkadot_dart/types/primitives/Text.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class CodecType extends CodecText {
  dynamic originValue;
  CodecType.empty() : super.empty();
  CodecType(Registry registry, [dynamic thisValue = '']) : super(registry, thisValue) {
    originValue = thisValue;
    this.setOverride(sanitize(this.value.toString()));
  }

  static CodecType transform(CodecType origin) {
    return CodecType.empty()
      ..setOverride(origin.override)
      ..setValue(origin.value)
      ..originValue = origin.originValue
      ..registry = origin.registry;
  }

  factory CodecType.from(CodecType origin) => CodecType(origin.registry, origin.originValue);

  static CodecType constructor(Registry registry, [dynamic value]) => CodecType(registry, value);

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Type';
  }
}
