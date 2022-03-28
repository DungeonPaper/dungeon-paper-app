import 'dart:math';

import 'package:dungeon_paper/app/model_utils/model_key.dart';

extension IterableUtils<T> on Iterable<T> {
  T sample() => _sample(this);
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

List<T> reorder<T>(List<T> list, int oldIndex, int newIndex) {
  if (newIndex > oldIndex) {
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
  final keys = items.map(keyGetter).toList();
  return list
      .map((x) =>
          keys.contains(keyGetter(x)) ? items.firstWhere((y) => keyGetter(x) == keyGetter(y)) : x)
      .toList();
}

List<T> addByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  final keys = items.map(keyGetter).toList();
  return [...list.where((x) => !keys.contains(keyGetter(x))), ...items];
}

List<T> removeByKey<T>(List<T> list, Iterable<T> items, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  final keys = items.map(keyGetter).toList();
  return [...list]..removeWhere((x) => keys.contains(keyGetter(x)));
}

List<T> asList<T>(dynamic item) => item == null
    ? []
    : item is List
        ? item.cast<T>()
        : <T>[item];
