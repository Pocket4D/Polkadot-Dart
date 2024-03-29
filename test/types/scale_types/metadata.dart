import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/scale_types/metadata.dart';

import '../../metajson.dart';

void main() {}

void metaDataTest() {
  test('MetaDataJson.fromMap', () {
    try {
      var jsonData = MetaDataJson.fromMap(metaJson);
      var systemModule =
          jsonData.metadata.version.modules.firstWhere((element) => element.name == 'System');
      expect(systemModule.storage.prefix, "System");
      if (systemModule.storage.prefix == "System") {
        systemModule.storage.entry.forEach((e) {
          expect(e.name is String, true);
        });
      }
      // print("\n");
    } catch (e) {
      throw e;
    }
  });
}
