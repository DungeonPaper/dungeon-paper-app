import 'dart:async';
import 'dart:math';

import 'package:dungeon_paper/app/model_utils/model_key.dart';

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
}

T sample<T>(Iterable<T> list) {
  final rnd = Random().nextInt(list.length);
  return list.elementAt(rnd);
}

const _sample = sample;

class Enumerated<T> {
  final T value;
  final int index;

  Enumerated({required this.index, required this.value});

  static List<Enumerated<T>> listFrom<T>(Iterable<T> list) {
    var i = 0;
    final out = <Enumerated<T>>[];
    for (final item in list) {
      out.add(Enumerated(index: i, value: item));
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

List<T> updateByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  final keys = items.map(keyGetter);
  return list
      .map((x) =>
          keys.contains(keyGetter(x)) ? items.firstWhere((y) => keyGetter(x) == keyGetter(y)) : x)
      .toList();
}

List<T> updateByIndex<T>(List<T> list, T item, int index) =>
    enumerate<T>(list).map((x) => x.index == index ? item : x.value).toList();

List<T> addByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  final keys = items.map(keyGetter);
  return [...list.where((x) => !keys.contains(keyGetter(x))), ...items];
}

List<T> upsertByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
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
  final keyGetter = key ?? keyFor;
  final keys = items.map(keyGetter);
  return [...list]..removeWhere((x) => keys.contains(keyGetter(x)));
}

List<T> asList<T>(dynamic item) => item == null
    ? []
    : item is List
        ? item.cast<T>()
        : <T>[item];
