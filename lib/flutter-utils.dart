import 'package:flutter/services.dart';

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
