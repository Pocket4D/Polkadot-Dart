import 'bn.dart';
import 'compact.dart';
import 'format.dart';
import 'hex.dart';
import 'is.dart';
import '../types/scale_types/metadata.dart';
import 'string.dart';
import 'time.dart';
import 'u8a.dart';

void main() {
  //---- utils
  bnTest();
  compactTest();
  // extensionTest();
  formatTest();
  hexTest();
  isTest();
  // loggerTest();
  metaDataTest();
  // numberTest();
  // siTest();
  stringTest();
  timeTest();
  u8aTest();
  // utilsTest();
}
