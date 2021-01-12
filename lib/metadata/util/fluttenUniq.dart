List<String> flattenUniq(List<dynamic> list) {
  final flat = list.fold<List<String>>(List<String>.from([]), (flatResult, entry) {
    var toAdd;
    if (entry is List<List>) {
      toAdd = flattenUniq(entry);
    } else if (entry is List<String>) {
      toAdd = entry;
    } else if (entry is List<Object>) {
      var expanded = entry.expand<String>((element) {
        if (element is String) {
          return [element];
        } else if (element is List<Object>) {
          return element.expand<String>((e) => [e]).toList();
        } else {
          return element;
        }
      }).toList();
      toAdd = expanded;
    } else {
      toAdd = List<String>.from([entry]);
    }
    flatResult.addAll(toAdd);
    return flatResult;
  });

  final nonNullFlat = flat.where((value) => value != null && value.isNotEmpty);
  final resultSet = Set<String>();
  resultSet.addAll(nonNullFlat);

  final result = resultSet.toList()
    ..where((value) => value != null && value.isNotEmpty)
    ..sort();

  return result;
}
