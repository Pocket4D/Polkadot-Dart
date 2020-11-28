import 'package:polkadot_dart/direct/irpc_function.dart';
import 'package:polkadot_dart/direct/isection.dart';

class RpcInterfaceSection extends ISection<IRpcFunction> {
  //Map<String, RpcInterfaceMethod> methods = new HashMap<>();

  //@Override
  //public IFunction function(String function) {
  //    return methods.get(function);
  //}
}

abstract class IRpc {
  //abstract class RpcInterfaceMethod implements IRpcFunction<Promise> {
  //    String subscription;
  //
  //    @Override
  //    public abstract Promise invoke(Object... params);
  //
  //    abstract Promise unsubscribe(int id);
  //}

  //T : () -> {}
  //T : codec
  //abstract class RpcInterfaceMethodNew<T extends IFunction.RpcResult> implements IFunction {
  //    //String subscription;
  //
  //    abstract Promise<T> invoke(Object... params);
  //
  //    //abstract Promise<> unsubscribe(int id);
  //}

  RpcInterfaceSection author();

  RpcInterfaceSection chain();

  RpcInterfaceSection state();

  RpcInterfaceSection system();
}
