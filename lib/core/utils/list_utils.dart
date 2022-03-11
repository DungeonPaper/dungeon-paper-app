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

List<T> updateByKey<T>(List<T> list, T item, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  return list.map((x) => keyGetter(x) == keyGetter(item) ? item : x).toList();
}

List<T> removeByKey<T>(List<T> list, T item, {dynamic Function(T item)? key}) {
  final keyGetter = key ?? keyFor;
  return list..removeWhere((x) => keyGetter(x) == keyGetter(item));
}
