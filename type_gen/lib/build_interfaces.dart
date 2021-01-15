import 'dart:convert';

import 'package:build/build.dart';

import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:polkadot_dart/types/types.dart' hide ConstantReader;
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:type_gen/formatter.dart';

import 'annotations.dart';
import 'utils.dart';
import 'v12.dart' as rpcMetadata;

final registry = TypeRegistry();

class InterfacesLibraryGenerator extends GeneratorForAnnotation<InterfaceAnnotation> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    var result = _concatStrings(_extractTypesDefsList(annotation));
    // import 'package:polkadot_dart/types/types.dart';
    // import 'package:polkadot_dart/types/interfaces/types.dart';
    return '''
part of 'builder.dart';

$result
    ''';
  }
}

List<ClassCreation> _extractTypesDefsList(ConstantReader annotation) {
  final meta = Metadata(registry, rpcMetadata.v12);
  registry.setMetadata(meta);
  var typesMap = annotation
      .peek("defs")
      .mapValue
      .entries
      .singleWhere((element) => element.key.toStringValue() == "types")
      ?.value
      ?.toMapValue();

  List<ClassCreation> resultClasses = List<ClassCreation>.empty(growable: true);
  if (typesMap != null) {
    typesMap.forEach((key, value) {
      final classKey = key.toStringValue();
      print("\n classKey :$classKey");
      var type = registry.createType(classKey);
      print("\n type :${type.runtimeType}");

      var classExtends;

      var rawClassExtends;

      var _getterMapRaw = Map<String, dynamic>();

      var _getterMapPreset;

      if (value.type.isDartCoreMap) {
        final mapValue = value.toMapValue();

        if (mapValue.isEmpty) {
          classExtends = getClassExtends(registry, "Struct");
        } else {
          mapValue.forEach((key, val) {
            if (key.toStringValue() != "_enum" && key.toStringValue() != "_set") {
              _getterMapRaw[key.toStringValue()] = val.toStringValue();
              _getterMapPreset = jsonEncode(Map<String, dynamic>.from(_getterMapRaw));
              classExtends = getClassExtends(registry, "Struct");
            } else if (key.toStringValue() == "_enum") {
              if (val.type.isDartCoreMap) {
                val.toMapValue().forEach((_key, _val) {
                  _getterMapRaw[_key.toStringValue()] = _val.toStringValue();
                });
                _getterMapPreset = jsonEncode(Map<String, dynamic>.from(_getterMapRaw));
              } else if (val.type.isDartCoreList) {
                val.toListValue().forEach((element) {
                  _getterMapRaw[element.toStringValue()] = "Null";
                });
                _getterMapPreset =
                    jsonEncode(List.from(val.toListValue().map((e) => e.toStringValue()).toList()));
              }
              classExtends = getClassExtends(registry, "Enum");
            } else if (key.toStringValue() == "_set") {
              if (val.type.isDartCoreMap) {
                val.toMapValue().forEach((_key, _val) {
                  _getterMapRaw[_key.toStringValue()] = "Null";
                });
                _getterMapPreset = jsonEncode(Map<String, dynamic>.from(_getterMapRaw));
              } else if (val.type.isDartCoreList) {
                val.toListValue().forEach((element) {
                  _getterMapRaw[element.toStringValue()] = "Null";
                });
                _getterMapPreset =
                    jsonEncode(List.from(val.toListValue().map((e) => e.toStringValue()).toList()));
              }
              classExtends = getClassExtends(registry, "CodecSet");
            }
          });
        }
      } else if (value.type.isDartCoreString) {
        rawClassExtends = value.toStringValue();
        classExtends = getClassExtends(registry, getClassByType(registry, rawClassExtends));
      }
      // print("classExtends $classExtends");

      var getterMap =
          classExtends == "Struct" || classExtends == "Enum" || classExtends == "CodecSet"
              ? _getterMapRaw
              : {};

      var getters = getterMap is Map ? Map<String, dynamic>.from(getterMap) : null;
      var created = ClassCreation(
          classKey: getKeyClassExtendTypes(registry, classKey, classExtends),
          classExtends: classExtends,
          classConstructor: getKeyClassConstructor(
              registry,
              classKey,
              getClassExtends(registry, type.runtimeType.toString()),
              _getterMapPreset,
              classExtends,
              rawClassExtends),
          classFactory: getKeyClassFactory(registry, classKey,
              getClassExtends(registry, type.runtimeType.toString()), classExtends),
          getters: getKeyClassGetters(registry, classKey, classExtends, getters));
      resultClasses.add(created);
    });
  }
  return resultClasses;
}

String _concatStrings(List<ClassCreation> artifacts) {
  return artifacts.map((e) => '''
  \n
  /// ${e.classKey}
      class ${e.classKey} extends ${e.classExtends}{
          ${e.getters}
          ${e.classConstructor}
          ${e.classFactory}
      }''').toList().join("\n");
}

class ClassCreation {
  String classKey;
  String classExtends;
  String classConstructor;
  String classFactory;
  String getters;
  ClassCreation(
      {this.classKey, this.classExtends, this.classConstructor, this.classFactory, this.getters});
}
