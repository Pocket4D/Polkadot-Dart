import 'Option.dart' as option;
import 'BTreeMap.dart' as btreeMap;
import 'BTreeSet.dart' as btreeSet;
import 'Compact.dart' as compact;
import 'Date.dart' as date;
import 'Enum.dart' as enumTest;
import 'HashMap.dart' as hashmapTest;
import 'Int.dart' as codecIntTest;
import 'Linkage.dart' as linkageTest;
import 'Map.dart' as mapTest;
import 'Raw.dart' as rawTest;
import 'Set.dart' as setTest;
import 'Struct.dart' as structTest;
import 'Tuple.dart' as tupleTest;
import 'U8aFixed.dart' as u8aFiexedTest;
import 'Uint.dart' as uintTest;
import 'Vec.dart' as vecTest;
import 'VecFixed.dart' as vecFixedTest;
import 'utils.dart' as utilsTest;
import 'Result.dart' as resultTest;

void main() {
  option.main();
  btreeMap.main();
  btreeSet.main();
  compact.main();
  date.main();
  enumTest.main();
  hashmapTest.main();
  codecIntTest.main();
  linkageTest.main();
  mapTest.main();
  rawTest.main();
  resultTest.main();
  setTest.main();
  structTest.main();
  tupleTest.main();
  u8aFiexedTest.main();
  uintTest.main();
  vecTest.main();
  vecFixedTest.main();
  utilsTest.main();
}
