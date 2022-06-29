import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.controller,
    this.hintText,
    this.trailing = const [],
    this.suffix,
    this.elevation,
    this.enabled,
    this.autofocus,
  }) : super(key: key);

  final String? hintText;
  final Widget? suffix;
  final double? elevation;
  final List<Widget> trailing;
  final TextEditingController controller;
  final bool? enabled;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: elevation ?? 5,
      color: Color.alphaBlend(_getFillColor(theme), theme.scaffoldBackgroundColor),
      shape: const StadiumBorder(),
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                autofocus: autofocus ?? false,
                enabled: enabled,
                decoration: InputDecoration(
                  filled: false,
                  hintText: hintText ?? S.current.searchPlaceholder,
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            if (trailing.isNotEmpty) const SizedBox(width: 8),
            ...trailing,
          ],
        ),
      ),
    );
  }

  Color _getFillColor(ThemeData themeData) {
    // dark theme: 10% white (enabled), 5% white (disabled)
    // light theme: 4% black (enabled), 2% black (disabled)
    const Color darkEnabled = Color(0x1AFFFFFF);
    const Color darkDisabled = Color(0x0DFFFFFF);
    const Color lightEnabled = Color(0x0A000000);
    const Color lightDisabled = Color(0x05000000);

    switch (themeData.brightness) {
      case Brightness.dark:
        return (enabled ?? true) ? darkEnabled : darkDisabled;
      case Brightness.light:
        return (enabled ?? true) ? lightEnabled : lightDisabled;
    }
  }
}
