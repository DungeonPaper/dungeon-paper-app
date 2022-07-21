import 'dart:async';
import 'dart:math';

import 'package:dungeon_paper/app/data/models/meta.dart';

extension IterableUtils<T> on Iterable<T> {
  T sample() => _sample(this);

  Future<Iterable<T>> mapAsync(FutureOr<T> Function(T item) toElement) async {
    final out = <T>[];
    for (final item in this) {
      out.add(await toElement(item));
    }
    return out;
  }

  Iterable<T> joinObjects(T separator) {
    return [
      for (final i in enumerate(this)) ...[
        i.value,
        if (i.value != last) separator,
      ],
    ];
  }

  /// Gives a default iterable of [T]s if the original is empty.
  Iterable<T> withDefaultValue(Iterable<T> defaultValue) {
    return isEmpty ? defaultValue : this;
  }

  Map<Key, List<T>> groupBy<Key>(Key Function(T item) keyFn) {
    final out = <Key, List<T>>{};
    for (final item in this) {
      final key = keyFn(item);
      out[key] ??= <T>[];
      out[key]!.add(item);
    }
    return out;
  }

  List<T> uniqueBy<Key>(Key Function(T item) keyFn) {
    final out = <T>[];
    final keys = <Key>[];
    for (final item in this) {
      final key = keyFn(item);
      if (!keys.contains(key)) {
        keys.add(key);
        out.add(item);
      }
    }
    return out;
  }
}

T sample<T>(Iterable<T> list) {
  final rnd = Random().nextInt(list.length);
  return list.elementAt(rnd);
}

const _sample = sample;

class Enumerated<T> {
  final T value;
  final int index;
  final bool isFirst;
  final bool isLast;

  Enumerated._({
    required this.index,
    required this.value,
    required int sourceLength,
  })  : isFirst = index == 0,
        isLast = index == sourceLength - 1;

  static List<Enumerated<T>> listFrom<T>(Iterable<T> list) {
    var i = 0;
    final out = <Enumerated<T>>[];
    for (final item in list) {
      out.add(
        Enumerated._(
          index: i,
          value: item,
          sourceLength: list.length,
        ),
      );
      i++;
    }
    return out;
  }
}

List<Enumerated<T>> enumerate<T>(Iterable<T> list) => Enumerated.listFrom(list);

List<T> reorder<T>(List<T> list, int oldIndex, int newIndex, {bool useReorderableOffset = true}) {
  if (useReorderableOffset && newIndex > oldIndex) {
    newIndex = newIndex - 1;
  }
  final removed = list.removeAt(oldIndex);
  list.insert(newIndex, removed);
  return list;
}

List<T> sortByPredefined<T>(
  List<T> list, {
  bool prependRest = false,
  required List<T> order,
}) {
  final out = <T>[];
  for (final item in order) {
    out.add(item);
  }
  if (order.length > list.length) {
    final rest = list.where((item) => !out.contains(item));
    if (prependRest) {
      out.insertAll(0, rest);
    } else {
      out.addAll(rest);
    }
  }
  return out;
}

List<T> updateByKey<T>(List<T> original, Iterable<T> itemsToUpdate,
    {dynamic Function(T item)? key}) {
  final keyGetter = key ?? Meta.keyFor;
  final keys = itemsToUpdate.map(keyGetter);
  return original
      .map((x) => keys.contains(keyGetter(x))
          ? itemsToUpdate.firstWhere((y) => keyGetter(x) == keyGetter(y))
          : x)
      .toList();
}

List<T> updateByIndex<T>(List<T> list, T item, int index) =>
    enumerate<T>(list).map((x) => x.index == index ? item : x.value).toList();

List<T> addByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? Meta.keyFor;
  final keys = items.map(keyGetter);
  return [...list.where((x) => !keys.contains(keyGetter(x))), ...items];
}

List<T> upsertByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? Meta.keyFor;
  final keys = items.map(keyGetter);
  final existingKeys = list.map(keyGetter);

  return [
    ...list
        .map((x) =>
            keys.contains(keyGetter(x)) ? items.firstWhere((y) => keyGetter(x) == keyGetter(y)) : x)
        .toList(),
    ...items.where((x) {
      return !existingKeys.contains(keyGetter(x));
    })
  ];
}

List<T> removeByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? Meta.keyFor;
  final keys = items.map(keyGetter);
  return [...list]..removeWhere((x) => keys.contains(keyGetter(x)));
}

List<T> asList<T>(dynamic item) => item == null
    ? []
    : item is Iterable
        ? item.cast<T>().toList()
        : <T>[item];
