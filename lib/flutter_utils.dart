import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BetweenValuesTextFormatter extends TextInputFormatter {
  final num min;
  final num max;

  BetweenValuesTextFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    num newNum = int.parse(newValue.text);
    if (newNum < min || newNum > max) {
      return oldValue;
    }

    return newValue;
  }
}

typedef CallbackFunc<T, R> = R Function(T obj);
typedef VoidCallbackFunc<T> = void Function(T obj);
typedef EmptyCallback<R> = R Function();
typedef VoidEmptyCallback = void Function();
