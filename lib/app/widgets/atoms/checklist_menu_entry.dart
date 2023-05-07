import 'package:flutter/material.dart';

import 'menu_button.dart';

class ChecklistMenuEntry<T> extends MenuEntry<T> {
  ChecklistMenuEntry({
    super.key,
    required super.value,
    required this.checked,
    required this.onChanged,
    required super.label,
    super.disabled,
  }) : super(
          icon: SizedBox(
            width: 30,
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
            ),
          ),
          onSelect: () => onChanged(!checked),
        );

  final bool checked;
  final void Function(bool?) onChanged;
}
