import 'package:optional/optional.dart';
import 'package:p4d_rust_binding/utils/utils.dart';
import 'package:p4d_rust_binding/types/codec/codec.dart';
import 'package:p4d_rust_binding/types/scale_types/metadata.dart' as Meta;

final ListReader<Meta.Module> modulesReader = ListReader(ModulesReader());
final ListReader<String> stringsReader = ListReader(ScaleCodecReader.stringReader);
final IterableReader<Meta.Hasher> hashEnumReader = IterableReader(Meta.Hasher.values);

class MetaDataReader implements ScaleReader<Meta.MetaDataJson> {
  @override
  Meta.MetaDataJson read(ScaleCodecReader rdr) {
    Meta.MetaDataJson result = Meta.MetaDataJson();
    result.magicNumber = ScaleCodecReader.int32Reader.read(rdr);
    result.metadata = Meta.Metadata(versionKey: "V${rdr.readUByte()}");
    if (result.metadata.versionNumber != 12) {
      throw "Unsupported metadata version: ${result.metadata.versionNumber}";
    }
    result.metadata.version = Meta.Version();

    result.metadata.version.modules = modulesReader.read(rdr);
    final modules = result.metadata.version.modules;
    for (Meta.Module m in modules) {
      List<Meta.Call> calls = m.calls;
      if (calls != null) {
        for (int j = 0; j < calls.length; j++) {
          calls[j].index = ((m.index << 8) + j);
        }
      }
    }
    return result;
  }
}

class ModulesReader implements ScaleReader<Meta.Module> {
  static final StorageReader storageReader = StorageReader();
  static final ListReader<Meta.Call> callsReader = ListReader(CallReader());
  static final ListReader<Meta.Event> eventsReader = ListReader(EventReader());
  static final ListReader<Meta.Constant> constantsReader = ListReader(ConstantReader());
  static final ListReader<Meta.Error> errorsReader = ListReader(ErrorReader());

  Meta.Module read(ScaleCodecReader rdr) {
    Meta.Module result = Meta.Module();
    result.name = rdr.readString();
    rdr.readOptional(storageReader).ifPresent((val) {
      result.storage = val as Meta.Storage;
    });
    rdr.readOptional(callsReader).ifPresent((val) {
      result.calls = val as List<Meta.Call>;
    });
    rdr.readOptional(eventsReader).ifPresent((val) {
      result.events = val as List<Meta.Event>;
    });
    result.constants = constantsReader.read(rdr);
    result.errors = errorsReader.read(rdr);
    result.index = rdr.readUByte();
    return result;
  }
}

class StorageReader implements ScaleReader<Meta.Storage> {
  static final ListReader<Meta.Entry> entryListReader = ListReader(StorageEntryReader());

  Meta.Storage read(ScaleCodecReader rdr) {
    Meta.Storage result = Meta.Storage();
    result.prefix = rdr.readString();
    result.entry = entryListReader.read(rdr);
    return result;
  }
}

class StorageEntryReader implements ScaleReader<Meta.Entry> {
  static final IterableReader<Meta.Modifier> modifierEnumReader =
      IterableReader(Meta.Modifier.values);
  static final TypeReader typeReader = TypeReader();

  // @Override
  Meta.Entry read(ScaleCodecReader rdr) {
    Meta.Entry result = Meta.Entry();
    result.name = rdr.readString();
    result.modifier = modifierEnumReader.read(rdr);
    result.type = rdr.read(typeReader);
    result.fallback = (rdr.readByteArray()).toHex();
    result.documentation = stringsReader.read(rdr);
    return result;
  }
}

class TypeReader implements ScaleReader<Meta.Typeof> {
  static final UnionReader<Meta.Typeof> typeUnionReader =
      UnionReader([TypePlainReader(), TypeMapReader(), TypeDoubleMapReader()]);

  Meta.Typeof read(ScaleCodecReader rdr) {
    return typeUnionReader.read(rdr).getValue();
  }
}

class TypePlainReader implements ScaleReader<Meta.TypePlain> {
  Meta.TypePlain read(ScaleCodecReader rdr) {
    return Meta.TypePlain(rdr.readString());
  }
}

class TypeMapReader implements ScaleReader<Meta.TypeMapDefinition> {
  Meta.TypeMapDefinition read(ScaleCodecReader rdr) {
    Meta.MapDefinition definition = Meta.MapDefinition();
    definition.hasher = hashEnumReader.read(rdr);
    definition.key = rdr.readString();
    definition.value = rdr.readString();
    definition.linked = rdr.readBoolean();
    return Meta.TypeMapDefinition(definition);
  }
}

class TypeDoubleMapReader implements ScaleReader<Meta.TypeDoubleMap> {
  Meta.TypeDoubleMap read(ScaleCodecReader rdr) {
    Meta.DoubleMap definition = Meta.DoubleMap();
    definition.hasher = hashEnumReader.read(rdr);
    definition.key1 = rdr.readString();
    definition.key2 = rdr.readString();
    definition.value = rdr.readString();
    definition.key2Hasher = hashEnumReader.read(rdr);
    return Meta.TypeDoubleMap(definition);
  }
}

class CallReader implements ScaleReader<Meta.Call> {
  static final ListReader<Meta.Arg> argsReader = ListReader(ArgReader());

  Meta.Call read(ScaleCodecReader rdr) {
    Meta.Call result = Meta.Call();
    result.name = rdr.readString();
    result.args = argsReader.read(rdr);
    result.documentation = stringsReader.read(rdr);
    return result;
  }
}

class ArgReader implements ScaleReader<Meta.Arg> {
  Meta.Arg read(ScaleCodecReader rdr) {
    Meta.Arg result = Meta.Arg();
    result.name = rdr.readString();
    result.type = rdr.readString();
    return result;
  }
}

class EventReader implements ScaleReader<Meta.Event> {
  Meta.Event read(ScaleCodecReader rdr) {
    Meta.Event result = Meta.Event();
    result.name = rdr.readString();
    result.args = stringsReader.read(rdr);
    result.documentation = stringsReader.read(rdr);
    return result;
  }
}

class ConstantReader implements ScaleReader<Meta.Constant> {
  Meta.Constant read(ScaleCodecReader rdr) {
    Meta.Constant result = Meta.Constant();
    result.name = rdr.readString();
    result.type = rdr.readString();
    result.value = rdr.readByteArray().toHex();
    result.documentation = stringsReader.read(rdr);
    return result;
  }
}

class ErrorReader implements ScaleReader<Meta.Error> {
  Meta.Error read(ScaleCodecReader rdr) {
    Meta.Error result = Meta.Error();
    result.name = rdr.readString();
    result.documentation = stringsReader.read(rdr);
    return result;
  }
}
