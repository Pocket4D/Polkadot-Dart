import 'package:p4d_rust_binding/direct/ifunction.dart';
import 'package:p4d_rust_binding/utils/logger.dart';

abstract class ISection<F extends IFunction> {
  Map<String, F> functions = Map<String, F>();

  F function(String function) {
    return functions[function];
  }

  bool addFunction(String name, F function) {
    bool result = true;
    if (this.functions.containsKey(name)) {
      logger.e(" dup function name $name, ${this.functions[name]}, $function");
      result = false;
    }
    this.functions[name] = function;
    return result;
  }

  Set<String> functionNames() {
    return this.functions.keys.toSet();
  }
}
