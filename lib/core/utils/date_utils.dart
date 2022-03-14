import 'enums.dart';

// TODO use createSorter
int Function(T? date1, T? date2) dateComparator<T>({
  SortOrder order = SortOrder.asc,
  DateTime? Function(T? object)? parse,
}) {
  int orderMultiplier = order == SortOrder.asc ? 1 : -1;
  DateTime? _parse(T? x) => parse != null ? parse(x) : x as DateTime;

  return (_a, _b) {
    final DateTime? a = _parse(_a);
    final DateTime? b = _parse(_b);

    if (a == null && b == null) {
      return 0;
    }

    if (a == null) {
      return -1 * orderMultiplier;
    }

    if (b == null) {
      return 1 * orderMultiplier;
    }

    return a.compareTo(b) * orderMultiplier;
  };
}
