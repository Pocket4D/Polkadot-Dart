import 'package:polkadot_dart/types/extrinsic/signedExtensions/polkadot.dart';
import 'package:polkadot_dart/types/extrinsic/signedExtensions/substrate.dart';

final allExtensions = {...substrateExtensions, ...polkadotExtensions};

const defaultExtensions = [
  'CheckVersion',
  'CheckGenesis',
  'CheckEra',
  'CheckNonce',
  'CheckWeight',
  'ChargeTransactionPayment',
  'CheckBlockGasLimit'
];

List<String> findUnknownExtensions(List<String> extensions) {
  final names = (allExtensions).keys.toList();

  return extensions.where((key) => !names.contains(key)).toList();
}

Map<String, dynamic> expandExtensionTypes(List<String> extensions, String type) {
  final result = extensions
      .map((key) => allExtensions[key])
      .where((info) => info != null)
      .toList()
      .fold<Map<String, dynamic>>({}, (result, info) => {...result, ...info[type]});
  return result;
}
