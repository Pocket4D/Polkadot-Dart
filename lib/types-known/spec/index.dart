import 'package:polkadot_dart/types-known/spec/centrifuge-chain.dart' as centrifuge;
import 'package:polkadot_dart/types-known/spec/kusama.dart' as kusama;
import 'package:polkadot_dart/types-known/spec/node.dart' as node;
import 'package:polkadot_dart/types-known/spec/node-template.dart' as nodeTemplate;
import 'package:polkadot_dart/types-known/spec/polkadot.dart' as polkadot;
import 'package:polkadot_dart/types-known/spec/rococo.dart' as rococo;
import 'package:polkadot_dart/types-known/spec/westend.dart' as westend;

const typesSpec = {
  'centrifuge-chain': centrifuge.versioned,
  "kusama": kusama.versioned,
  "node": node.versioned,
  'node-template': nodeTemplate.versioned,
  "polkadot": polkadot.versioned,
  "rococo": rococo.versioned,
  "westend": westend.versioned
};
