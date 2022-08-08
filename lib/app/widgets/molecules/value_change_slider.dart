import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:wheel_spinner/wheel_spinner.dart';

enum ValueChange { positive, neutral, negative }

class ValueChangeSlider<N extends num> extends StatelessWidget {
  const ValueChangeSlider({
    super.key,
    required this.value,
    required this.updatedValue,
    required this.onChange,
    this.maxValue,
    this.minValue,
    required this.positiveText,
    required this.neutralText,
    required this.negativeText,
  });

  final N value;
  final N updatedValue;
  final void Function(N value) onChange;
  final N? maxValue;
  final N? minValue;
  final String Function(N) positiveText;
  final String Function(N) neutralText;
  final String Function(N) negativeText;

  ValueChange get change => value == updatedValue
      ? ValueChange.neutral
      : value > updatedValue
          ? ValueChange.negative
          : ValueChange.positive;

  N get changeAmount => (updatedValue - value).abs() as N;

  bool get isChangePositive => change == ValueChange.positive;
  bool get isChangeNegative => change == ValueChange.negative;
  bool get isChangeNeutral => change == ValueChange.neutral;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    const width = 70.0;

    return Row(
      children: [
        Expanded(
          child: Text(
            isChangeNeutral
                ? neutralText(changeAmount)
                : isChangePositive
                    ? positiveText(changeAmount)
                    : negativeText(changeAmount),
            style: textTheme.headline5!.copyWith(
              color: isChangeNeutral
                  ? null
                  : isChangePositive
                      ? DwColors.success
                      : theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(borderRadius: borderRadius),
            clipBehavior: Clip.antiAlias,
            width: width,
            height: 100,
            child: WheelSpinner(
              value: updatedValue.toDouble(),
              min: minValue?.toDouble() ?? -double.infinity,
              max: maxValue?.toDouble() ?? double.infinity,
              theme: (theme.brightness == Brightness.light
                      ? WheelSpinnerThemeData.light()
                      : WheelSpinnerThemeData.dark())
                  .copyWith(
                borderRadius: borderRadius,
              ),
              // childBuilder: (_) => Text(_.toString()),
              minMaxLabelBuilder: (_) => '',
              onSlideUpdate: (val) => onChange((N == int ? val.toInt() : val.toDouble()) as N),
            ),
          ),
        ),
      ],
    );
  }
}
