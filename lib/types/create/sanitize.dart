const ALLOWED_BOXES = [
  'BTreeMap',
  'BTreeSet',
  'Compact',
  'DoNotConstruct',
  'HashMap',
  'Int',
  'Linkage',
  'Result',
  'Option',
  'UInt',
  'Vec'
];
const BOX_PRECEDING = [
  '<',
  '(',
  '[',
  '"',
  ',',
  ' '
]; // start of vec, tuple, fixed array, part of struct def or in tuple

class SanitizeOptions {
  bool allowNamespaces;
  SanitizeOptions({this.allowNamespaces});
}

typedef Mapper = String Function(String value, [SanitizeOptions options]);

int findClosing(String value, int start) {
  int depth = 0;

  for (var index = start; index < value.length; index++) {
    if (value[index] == '>') {
      if (depth != 0) {
        return index;
      }

      depth--;
    } else if (value[index] == '<') {
      depth++;
    }
  }

  throw "Unable to find closing matching <> on '$value' (start $start)";
}

Mapper alias(List<String> src, String dest, [bool withChecks = true]) {
  return (String value, [SanitizeOptions options]) {
    return src.fold<String>(value, (value, srcString) {
      var boxMap = BOX_PRECEDING.map((box) => "\\$box$srcString").join('|');

      var regText = RegExp('(^$srcString|$boxMap)');

      var replaceVal = (Match srcString2) {
        var m = srcString2[0];
        return withChecks && BOX_PRECEDING.contains(m[0]) ? "${m[0]}$dest" : dest;
      };

      return value.replaceAllMapped(regText, replaceVal);
    });
  };
}

Mapper cleanupCompact() {
  return (String value, [SanitizeOptions options]) {
    for (var index = 0; index < value.length; index++) {
      if (value[index] != '<') {
        continue;
      }
      var end = findClosing(value, index + 1) - 14;
      if (value.substring(end, end + 14) == ' as HasCompact') {
        value = "Compact<${value.substring(index + 1, end)}>";
      }
    }
    return value;
  };
}

Mapper flattenSingleTuple() {
  return (String value, [SanitizeOptions options]) {
    return value.replaceAllMapped(RegExp(r"\(([^,]+)\)"), (match) => "${match[1]}");
  };
}

Mapper removeColons() {
  return (String value, [SanitizeOptions options]) {
    var index = 0;

    while (index != -1) {
      index = value.indexOf('::');

      if (index == 0) {
        value = value.substring(2);
      } else if (index != -1) {
        if (options != null && options.allowNamespaces) {
          return value;
        }

        var start = index;

        while (start != -1 && !BOX_PRECEDING.contains(value[start])) {
          start--;
        }

        value = "${value.substring(0, start + 1)}${value.substring(index + 2)}";
      }
    }

    return value;
  };
}

Mapper removeGenerics() {
  return (String value, [SanitizeOptions options]) {
    for (var index = 0; index < value.length; index++) {
      if (value[index] == '<') {
        // check against the allowed wrappers, be it Vec<..>, Option<...> ...
        var box = ALLOWED_BOXES.where((box) {
          var start = index - box.length;

          return (start >= 0 && value.substring(start, start + box.length) == box) &&
              (
                  // make sure it is stand-alone, i.e. don't catch ElectionResult<...> as Result<...>
                  start == 0 || BOX_PRECEDING.contains(value[start - 1]));
        });

        // we have not found anything, unwrap generic innards
        if (box != null) {
          var end = findClosing(value, index + 1);

          value = "${value.substring(0, index)}${value.substring(end + 1)}";
        }
      }
    }

    return value;
  };
}

Mapper removePairOf() {
  return (String value, [SanitizeOptions options]) {
    for (var index = 0; index < value.length; index++) {
      if (value.substring(index, index + 7) == 'PairOf<') {
        var start = index + 7;
        var end = findClosing(value, start);
        var type = value.substring(start, end);

        value = "${value.substring(0, index)}($type,$type)${value.substring(end + 1)}";
      }
    }

    return value;
  };
}

Mapper removeTraits() {
  return (String value, [SanitizeOptions options]) {
    return value
        // remove all whitespaces
        .replaceAll(RegExp(r"\s"), '')
        // anything `T::<type>` to end up as `<type>`
        .replaceAll(RegExp(r"(T|Self)::"), '')
        // replace `<T as Trait>::` (whitespaces were removed above)
        .replaceAll(RegExp(r"<(T|Self)asTrait>::"), '')
        // replace `<T as something::Trait>::` (whitespaces were removed above)
        .replaceAll(RegExp(r"<Tas[a-z]+::Trait>::"), '')
        // replace <Lookup as StaticLookup>
        .replaceAll(RegExp(r"<LookupasStaticLookup>"), 'Lookup')
        // replace `<...>::Type`
        .replaceAll(RegExp(r"::Type"), '');
  };
}

Mapper removeWrap(String checker) {
  var check = "$checker<";

  return (String value, [SanitizeOptions options]) {
    var index = 0;

    while (index != -1) {
      index = value.indexOf(check);

      if (index != -1) {
        final start = index + check.length;
        final end = findClosing(value, start);

        value =
            "${value.substring(0, index)}${value.substring(start, end)}${value.substring(end + 1)}";
      }
    }

    return value;
  };
}

List<Mapper> mappings = [
  // alias <T::InherentOfflineReport as InherentOfflineReport>::Inherent -> InherentOfflineReport
  alias(['<T::InherentOfflineReport as InherentOfflineReport>::Inherent'], 'InherentOfflineReport',
      false),
  // <T::Balance as HasCompact>
  cleanupCompact(),
  // Remove all the trait prefixes
  removeTraits(),
  // remove PairOf<T> -> (T, T)
  removePairOf(),
  // remove boxing, `Box<Proposal>` -> `Proposal`
  removeWrap('Box'),
  // remove generics, `MisbehaviorReport<Hash, BlockNumber>` -> `MisbehaviorReport`
  removeGenerics(),
  // alias String -> Text (compat with jsonrpc methods)
  alias(['String'], 'Text'),
  // alias Vec<u8> -> Bytes
  alias(['Vec<u8>', '&\\[u8\\]'], 'Bytes'),
  // alias RawAddress -> Address
  alias(['RawAddress'], 'Address'),
  // lookups, mapped to Address/AccountId as appropriate in runtime
  alias(['Lookup::Source'], 'LookupSource'),
  alias(['Lookup::Target'], 'LookupTarget'),
  // HACK duplication between contracts & primitives, however contracts prefixed with exec
  alias(['exec::StorageKey'], 'ContractStorageKey'),
  // flattens tuples with one value, `(AccountId)` -> `AccountId`
  flattenSingleTuple(),
  // converts ::Type to Type, <T as Trait<I>>::Proposal -> Proposal
  removeColons()
];

String sanitize(String value, [SanitizeOptions options]) {
  return mappings.fold(value.toString(), (result, fn) {
    return fn(result, options);
  }).trim();
}
