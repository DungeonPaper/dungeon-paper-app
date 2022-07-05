import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class ThemeBrightnessSwitch extends StatelessWidget {
  const ThemeBrightnessSwitch({
    super.key,
    required this.builder,
    this.onChanged,
  });

  final Widget Function(
    BuildContext context, {
    required IconData icon,
    required String title,
    required void Function() onChanged,
  }) builder;

  final void Function(Brightness brightness)? onChanged;

  const ThemeBrightnessSwitch.listTile({
    super.key,
    this.onChanged,
    bool withCheckbox = false,
  }) : builder = _listTileBuilder;

  const ThemeBrightnessSwitch.iconButton({
    super.key,
    this.onChanged,
  }) : builder = _iconButtonBuilder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      icon: icon(context),
      title: title(context),
      onChanged: () => onChanged?.call(_toggleTheme(context)),
    );
  }

  static Brightness brightnessOf(BuildContext context) => Theme.of(context).brightness;

  static IconData icon(BuildContext context) =>
      brightnessOf(context) == Brightness.light ? Icons.light_mode : Icons.light_mode_outlined;

  static String title(BuildContext context) => brightnessOf(context) == Brightness.light
      ? S.current.themeTurnDark
      : S.current.themeTurnLight;

  static Widget _listTileBuilder(
    BuildContext context, {
    required IconData icon,
    required String title,
    required void Function() onChanged,
  }) =>
      ListTile(
        visualDensity: VisualDensity.compact,
        title: Text(title),
        leading: Icon(icon),
        onTap: onChanged,
      );

  static Widget _iconButtonBuilder(
    BuildContext context, {
    required IconData icon,
    required String title,
    required void Function() onChanged,
  }) =>
      IconButton(
        icon: Icon(icon),
        tooltip: title,
        onPressed: onChanged,
      );

  static Brightness _toggleTheme(BuildContext context) {
    final theme = DynamicTheme.of(context)!;
    final isDark = theme.themeId == AppThemes.dark;
    theme.setTheme(isDark ? AppThemes.parchment : AppThemes.dark);
    return isDark ? Brightness.light : Brightness.dark;
  }
}
