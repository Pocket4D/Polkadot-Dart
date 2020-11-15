import 'package:p4d_rust_binding/direct/imodule.dart';
import 'package:p4d_rust_binding/rpc/core_irpc.dart';

abstract class IRpcModule extends IModule<RpcInterfaceSection> {
  RpcInterfaceSection author();

  RpcInterfaceSection chain();

  RpcInterfaceSection state();

  RpcInterfaceSection system();

  @override
  Set<String> sectionNames() {
    return Set.from(["author", "chain", "state", "system"]);
  }

  @override
  RpcInterfaceSection section(String section) {
    switch (section) {
      case "author":
        return author();
      case "chain":
        return chain();
      case "state":
        return state();
      case "system":
        return system();
      default: //TODO 2019-05-09 15:19
        throw UnsupportedError("Unsupport RpcInterfaceSection: $section");
    }
  }
}
