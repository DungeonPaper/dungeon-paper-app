import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
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

    return Row(
      children: [
        Expanded(
          child: Text(
            isChangeNeutral
                ? S.current.expDialogChangeNeutral
                : isChangePositive
                    ? S.current.expDialogChangeAdd(changeAmount)
                    : S.current.expDialogChangeRemove(changeAmount),
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
            width: 60,
            height: 100,
            child: WheelSpinner(
              value: updatedValue.toDouble(),
              min: minValue?.toDouble() ?? -double.infinity,
              max: maxValue?.toDouble() ?? double.infinity,
              // childBuilder: (_) => Text(_.toString()),
              borderRadius: borderRadius,
              minMaxLabelBuilder: (_) => '',
              onSlideUpdate: (val) => onChange((N == int ? val.toInt() : val.toDouble()) as N),
              dividerColor: theme.brightness == Brightness.light ? null : Colors.grey[800],
              boxDecoration: (theme.brightness == Brightness.light
                      ? BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.2, 0.8, 1.0],
                            colors: [
                              Colors.grey[350]!,
                              Colors.grey[50]!,
                              Colors.grey[50]!,
                              Colors.grey[350]!
                            ],
                          ),
                        )
                      : BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.2, 0.8, 1.0],
                            colors: [
                              Colors.black,
                              Colors.grey[900]!,
                              Colors.grey[900]!,
                              Colors.black
                            ],
                          ),
                        ))
                  .copyWith(borderRadius: borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
