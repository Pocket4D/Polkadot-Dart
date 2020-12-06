import 'package:polkadot_dart/types/types/codec.dart';

abstract class CompactEncodable extends BaseCodec {
  int get bitLength;
  BigInt toBn();
  int toInt();
  int toNumber();
}
