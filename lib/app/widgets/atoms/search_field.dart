import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.controller,
    this.hintText,
    this.trailing = const [],
    this.suffix,
  }) : super(key: key);

  final String? hintText;
  final Widget? suffix;
  final List<Widget> trailing;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final colorScheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              // label: Text(''),
              // filled: false,
              // border: InputBorder.none,
              // floatingLabelBehavior: FloatingLabelBehavior.never,
              // contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: hintText ?? S.current.searchPlaceholder,
              // suffix: suffix != null ? SizedBox(child: suffix, height: 20) : null,
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        if (trailing.isNotEmpty) const SizedBox(width: 8),
        ...trailing,
      ],
    );
  }
}
