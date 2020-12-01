import 'Iterable_reader.dart';
import 'bool_optional_reader.dart';
import 'bool_reader.dart';
import 'compact_bigInt_reader.dart';
import 'era_reader.dart';
import 'int32_reader.dart';
import 'list_reader.dart';
import 'string_reader.dart';
import 'uint128_reader.dart';
import 'uint16_reader.dart';
import 'uint32_reader.dart';
import 'union_reader.dart';

void main() {
  boolOptionalReaderTest();
  boolReaderTest();
  compactBigIntReaderTest();
  eraReaderTest();
  int32ReaderTest();
  iterableReaderTest();
  listReaderTest();
  stringReaderTest();
  uint16ReaderTest();
  uint32ReaderTest();
  uint128ReaderTest();
  unionReaderTest();
}
