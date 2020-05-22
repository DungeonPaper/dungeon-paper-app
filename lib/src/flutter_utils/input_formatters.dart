import 'package:flutter/foundation.dart';
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
          (formatType == FormatType.Integer && newValue.text.contains('.'))) {
        throw FormatException();
      }
      if (newNum < min || newNum > max) {
        return oldValue;
      }
      return newValue;
    } on FormatException {
      if (newValue.text == '' ||
          (newValue.text.endsWith('.') && newValue.text.isNotEmpty) &&
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

class NumberFormatter extends TextInputFormatter {
  final String patternDec = "\-?(([0-9]+\.[0-9]*)|[0-9]*)";
  final String patternInt = "\-?[0-9]*";
  final FormatType formatType;

  NumberFormatter([this.formatType = FormatType.Integer]);
  NumberFormatter.int() : formatType = FormatType.Integer;
  NumberFormatter.dec() : formatType = FormatType.Decimal;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return WhitelistingTextInputFormatter(RegExp(pattern))
        .formatEditUpdate(oldValue, newValue);
  }

  Pattern get pattern =>
      formatType == FormatType.Integer ? patternInt : patternDec;
}

class SingleChildRow extends StatelessWidget {
  final Widget child;

  const SingleChildRow({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [Expanded(child: child)]);
  }
}
