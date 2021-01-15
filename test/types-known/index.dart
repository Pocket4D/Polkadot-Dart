import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types-known/index.dart';
import 'package:polkadot_dart/types/types.dart';

void main() {
  typesKnownTest(); // rename this test name
}

void typesKnownTest() {
  final registry = TypeRegistry();
  registry.setKnownTypes(RegisteredTypes.fromMap({
    "typesAlias": {
      "identity": {"Id": 'IdentityId'},
      "testModule": {"Proposal": 'TestProposal'},
      "treasury": {"Proposal": 'TreasuryProposals2'}
    }
  }));
  group('getModuleTypes', () {
    test('collects the pre-defined types for contracts', () {
      expect(getModuleTypes(registry, 'contracts'), {"StorageKey": 'ContractStorageKey'});
    });

    test('collects the user-defined types for testModule', () {
      expect(getModuleTypes(registry, 'testModule'), {"Proposal": 'TestProposal'});
    });

    test('overrides pre-defined with user-defined for treasury', () {
      expect(getModuleTypes(registry, 'treasury'), {"Proposal": 'TreasuryProposals2'});
    });

    test('merges pre-defined and user-defined for identity', () {
      expect(getModuleTypes(registry, 'identity'),
          {"Id": 'IdentityId', "Judgement": 'IdentityJudgement'});
    });
  });
}
