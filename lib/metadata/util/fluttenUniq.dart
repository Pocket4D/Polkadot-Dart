List<String> flattenUniq(List<dynamic> list) {
  final flat = list.fold([], (result, entry) {
    return result.concat(entry is List ? flattenUniq(entry) : entry);
  });

  return [...new Set.from(flat)].where((value) => value).toList()..sort();
}
