import 'package:polkadot_dart/types/types.dart';

const MAGIC_NUMBER = 0x6174656d; // `meta`, reversed for Little Endian encoding

class MagicNumber extends u32 {
  MagicNumber(Registry registry, [dynamic value]) : super(registry, value) {
    if (!this.isEmpty) {
      final magic = registry.createType('u32', MAGIC_NUMBER);
      assert(
          this.eq(magic), "MagicNumber mismatch: expected ${magic.toHex()}, found ${this.toHex()}");
    }
  }

  static MagicNumber constructor(Registry registry, [dynamic value]) {
    return MagicNumber(registry, value);
  }

  factory MagicNumber.from(u32 origin) => MagicNumber(origin.registry, origin.originValue);
}
