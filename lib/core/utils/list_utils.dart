import 'dart:math';

extension<T> on List<T> {
  // ignore: unused_element
  T sample() {
    final rnd = Random().nextInt(length);
    return elementAt(rnd);
  }
}

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
