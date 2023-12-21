import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';

// TODO use createSorter
int Function(T? date1, T? date2) createSortByDate<T>({
  SortOrder order = SortOrder.asc,
  DateTime? Function(T? object)? parse,
}) {
  int orderMultiplier = order == SortOrder.asc ? 1 : -1;
  DateTime? parse0(T? x) => parse != null ? parse(x) : x as DateTime;

  return (a, b) {
    final DateTime? parsedA = parse0(a);
    final DateTime? parsedB = parse0(b);

    if (parsedA == null && parsedB == null) {
      return 0;
    }

    if (parsedA == null) {
      return -1 * orderMultiplier;
    }

    if (parsedB == null) {
      return 1 * orderMultiplier;
    }

    return parsedA.compareTo(parsedB) * orderMultiplier;
  };
}

DateTime parseDate<T>(T date) {
  return date is String ? DateTime.parse(date) : (date as Timestamp).toDate();
}
