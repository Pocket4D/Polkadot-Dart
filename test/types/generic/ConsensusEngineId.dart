import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/generic/ConsensusEngineId.dart';

void main() {
  consensusEngineIdTest(); // rename this test name
}

void consensusEngineIdTest() {
  group('ConsensusEngineId', () {
    test('creates a valid id for aura', () {
      expect(GenericConsensusEngineId.stringToId('FRNK'), CID_GRPA);
      expect(GenericConsensusEngineId.stringToId('aura'), CID_AURA);
    });

    test('reverses an id to string for babe', () {
      expect(GenericConsensusEngineId.idToString(CID_BABE), 'BABE');
    });
  });
}
