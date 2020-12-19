import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/interfaces/runtime/types.dart';
import 'package:polkadot_dart/types/types.dart';

class GenericBlock extends Struct {
  GenericBlock(Registry registry, [dynamic value])
      : super(
            registry,
            {
              "header": 'Header',
              // eslint-disable-next-line sort-keys
              "extrinsics": 'Vec<Extrinsic>'
            },
            value);
  static GenericBlock constructor(Registry registry, [dynamic value]) =>
      GenericBlock(registry, value);

  /**
   * @description Encodes a content [[Hash]] for the block
   */
  H256 get contentHash {
    return this.registry.hash(this.toU8a());
  }

  /**
   * @description The [[Extrinsic]] contained in the block
   */
  Vec<GenericExtrinsic> get extrinsics {
    return this.getCodec('extrinsics').cast<Vec<GenericExtrinsic>>();
  }

  /**
   * @description Block/header [[Hash]]
   */
  H256 get hash {
    //return this.header.hash;
    return throw UnimplementedError();
  }

  /**
   * @description The [[Header]] of the block
   */
  // Header get header {
  //   return this.getCodec('header').cast<Header>();
  // }
}
