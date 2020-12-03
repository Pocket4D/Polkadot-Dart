import 'package:polkadot_dart/types/create/sanitize.dart';
import 'package:polkadot_dart/types/primitives/Text.dart';
import 'package:polkadot_dart/types/types/registry.dart';

class CodecType extends CodecText {
  CodecType(Registry registry, [dynamic value = '']) : super(registry, value) {
    this.setOverride(sanitize(this.value.toString()));
  }

  static CodecType constructor(Registry registry, [dynamic value]) => CodecType(registry, value);

  /// @description Returns the base runtime type name for this instance
  String toRawType() {
    return 'Type';
  }
}
