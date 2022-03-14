import 'enums.dart';

int Function(T1? date1, T1? date2) Function({
  SortOrder order,
  T2? Function(T1? object)? parse,
}) createSorter<T1 extends Comparable, T2 extends Comparable>(
    [T2 Function(T2? object)? postParse]) {
  T2 _postParse(T2? x) => postParse != null ? postParse(x) : x as T2;

  return ({order = SortOrder.asc, parse}) {
    int orderMultiplier = order == SortOrder.asc ? 1 : -1;
    T2? _parse(T1? x) => parse != null ? parse(x) : x as T2?;

    return (_a, _b) {
      final T2 a = _postParse(_parse(_a));
      final T2 b = _postParse(_parse(_b));

      return a.compareTo(b) * orderMultiplier;
    };
  };
}

bool Function(T item) createFilter<T, F>({
  F Function(T item)? parse,
  required bool Function(F item) compare,
}) {
  F Function(T item) _parse = parse ?? (x) => x as F;

  return (item) {
    final parsed = _parse(item);
    return compare(parsed);
  };
}

bool Function(T item) createCompoundFilter<T>({
  required Iterable<bool Function(T item)> filters,
  BoolLogic? logic,
}) {
  return (item) {
    if (logic == BoolLogic.or) {
      return filters.any((f) => f(item));
    }
    return filters.every((f) => f(item));
  };
}
