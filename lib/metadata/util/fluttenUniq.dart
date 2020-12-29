List<String> flattenUniq(List<dynamic> list) {
  final flat = list.fold<List<String>>(List<String>.from([]), (result, entry) {
    var toAdd;
    if (entry is List<List>) {
      toAdd = flattenUniq(entry);
    } else if (entry is List<String>) {
      toAdd = entry;
    } else if (entry is List<Object>) {
      toAdd = entry.map((e) => e.toString()).toList();
    } else {
      toAdd = List<String>.from([entry]);
    }
    result.addAll(toAdd);
    return result;
  });

  final result =
      List<String>.from([...new Set.from(flat)].where((value) => value != null).toList()..sort());
  return result;
}
