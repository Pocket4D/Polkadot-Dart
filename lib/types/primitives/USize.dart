import 'package:polkadot_dart/types/primitives/U32.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// ignore: camel_case_types
class usize extends u32 {
  usize.empty() : super.empty();
  usize(Registry registry, [dynamic value]) : super(registry, value) {
    throw 'The `usize` type should not be used. Since it is platform-specific, it creates incompatibilities between native (generally u64) and WASM (always u32) code. Use one of the `u32` or `u64` types explicitly.';
  }
  static usize constructor(Registry registry, [dynamic value]) => usize(registry, value);
}
