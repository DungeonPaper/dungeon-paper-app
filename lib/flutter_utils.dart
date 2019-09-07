import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BetweenValuesTextFormatter<T extends num> extends TextInputFormatter {
  final T min;
  final T max;
  final bool allowNull;

  BetweenValuesTextFormatter(this.min, this.max, {this.allowNull = true});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      T newNum;
      newNum = T is int
          ? int.parse(newValue.text) as T
          : double.tryParse(newValue.text) as T;
      String newNumString = newNum.toString();
      if (newNum < min || newNum > max) {
        return oldValue;
      }
      return TextEditingValue(
        selection: newNumString != newValue.text
            ? TextSelection(
                baseOffset: newNumString.length,
                extentOffset: newNumString.length,
              )
            : newValue.selection,
        composing: newValue.composing,
        text: newNumString,
      );
    } on FormatException {
      if (newValue.text == '' && this.allowNull) {
        return newValue;
      }
      return oldValue;
    }
  }
}

typedef CallbackFunc<T, R> = R Function(T obj);
typedef VoidCallbackFunc<T> = void Function(T obj);
typedef EmptyCallbackFunc<R> = R Function();
typedef VoidEmptyCallbackFunc = void Function();
