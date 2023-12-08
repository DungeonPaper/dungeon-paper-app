import 'package:dungeon_paper/core/utils/filter_sort.dart';

List<String> splitIntoWords(String string, {bool? lowerCase, bool? upperCase}) {
  assert(lowerCase == null || upperCase == null,
      "Can't apply both uppercase and lowercase");
  final pattern = RegExp(r'[^a-zA-Z0-9]|(?=[A-Z])');
  final words = string.split(pattern).where((s) => s.isNotEmpty).toList();
  if (lowerCase == true) return words.map((e) => e.toLowerCase()).toList();
  if (upperCase == true) return words.map((e) => e.toUpperCase()).toList();
  return words;
}

String wordToCapital(String string) =>
    string.substring(0, 1).toUpperCase() + string.substring(1).toLowerCase();

String toCamelCase(String string) {
  final words = splitIntoWords(string);
  if (words.isEmpty) {
    return '';
  }
  return [words.first.toLowerCase(), ...words.sublist(1).map(wordToCapital)]
      .join('');
}

String toPascalCase(String string) =>
    splitIntoWords(string).map(wordToCapital).join('');

String toTitleCase(String string) =>
    splitIntoWords(string).map(wordToCapital).join(' ');

String toSnakeCase(String string) =>
    splitIntoWords(string).map((s) => s.toLowerCase()).join('_');

String toKebabCase(String string) =>
    splitIntoWords(string).map((s) => s.toLowerCase()).join('-');

// int Function(T? date1, T? date2) dateComparator<T>({
//   SortOrder order = SortOrder.asc,
//   String? Function(T? object)? parse,
// }) {
//   int orderMultiplier = order == SortOrder.asc ? 1 : -1;
//   String _parse(T? x) => parse != null ? parse(x) ?? '' : x as String;

//   return (_a, _b) {
//     final String a = _parse(_a).toLowerCase().trim();
//     final String b = _parse(_b).toLowerCase().trim();

//     return a.compareTo(b) * orderMultiplier;
//   };
// }

final stringSorter = createSorter<String, String>(
  (val) => (val ?? '').toLowerCase().trim(),
);

String cleanStr(String str) => str.toLowerCase();

bool Function(String) stringFilter(String search) =>
    (str) => cleanStr(str).contains(cleanStr(search));
