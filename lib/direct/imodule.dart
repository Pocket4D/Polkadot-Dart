import 'package:p4d_rust_binding/direct/isection.dart';

abstract class IModule<S extends ISection> {
  S section(String section);

  Set<String> sectionNames();

  void addSection(String sectionName, S section) {}
}
