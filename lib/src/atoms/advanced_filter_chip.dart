import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvancedFilterChip<T> extends StatelessWidget {
  final T value;
  final bool selected;
  final Widget label;
  final void Function(T) onChanged;
  final Widget Function(BuildContext) buildDialog;

  const AdvancedFilterChip({
    Key key,
    @required this.label,
    this.selected,
    this.onChanged,
    this.buildDialog,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected
        ? Get.theme.colorScheme.onSecondary
        : Get.theme.colorScheme.onSurface;

    return IconTheme.merge(
      data: IconThemeData(color: foregroundColor),
      child: RawChip(
        avatar: null,
        label: DefaultTextStyle.merge(
          style: TextStyle(color: foregroundColor),
          child: label,
        ),
        onDeleted: () => _onChanged(null),
        onPressed: _onPressed,
        selected: selected,
        selectedColor: Get.theme.colorScheme.secondary,
      ),
    );
  }

  void _onPressed() {
    _onChanged(selected ? null : value);
  }

  void _onChanged(T value) {
    onChanged?.call(value);
  }
}
