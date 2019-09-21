import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum FormatType { Integer, Decimal }

class BetweenValuesTextFormatter extends TextInputFormatter {
  final num min;
  final num max;
  final bool allowNull;
  final FormatType formatType;

  BetweenValuesTextFormatter(
    this.min,
    this.max, {
    this.allowNull = true,
    this.formatType = FormatType.Integer,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      num newNum = double.tryParse(newValue.text);
      if (newNum == null ||
          (formatType == FormatType.Integer && newValue.text.contains('.')))
        throw FormatException();
      if (newNum < min || newNum > max) {
        return oldValue;
      }
      return newValue;
    } on FormatException {
      if (newValue.text == '' ||
          (newValue.text.endsWith('.') && newValue.text.length > 0) &&
              (min < 0 && newValue.text.trim() == '-') &&
              this.allowNull) {
        return newValue;
      }
    } on Error catch (e) {
      print(e);
    }
    return oldValue;
  }
}

typedef CallbackFunc<T, R> = R Function(T obj);
typedef VoidCallbackFunc<T> = void Function(T obj);
typedef EmptyCallbackFunc<R> = R Function();
typedef VoidEmptyCallbackFunc = void Function();
