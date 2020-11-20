import 'common.dart';
import 'ed25519.dart';
import 'sr25519.dart';

void main() {
  // --- crypto
  commonTest();
  ed25519Test();
  sr25519Test();
  // crypto.secp256k1Test();
  // crypto.utilTest();
}
