import 'package:build/build.dart';
import 'build_interfaces.dart';
import 'package:source_gen/source_gen.dart';

Builder metadataLibraryBuilder(BuilderOptions options) =>
    LibraryBuilder(InterfacesLibraryGenerator(), generatedExtension: '.info.dart');
