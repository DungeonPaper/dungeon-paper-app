import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../data/services/user_provider.dart';

class ThemeBrightnessSwitch extends StatelessWidget
    with CharacterProviderMixin, UserProviderMixin {
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
      icon: icon(user),
      title: title(user),
      onChanged: () => onChanged?.call(
        _toggleTheme(context, user, maybeChar),
      ),
    );
  }

  static Brightness brightnessOf(User user) => user.brightness;

  static IconData icon(User user) => brightnessOf(user) == Brightness.light
      ? Icons.light_mode
      : Icons.light_mode_outlined;

  static String title(User user) => brightnessOf(user) == Brightness.light
      ? tr.settings.switchToDark
      : tr.settings.switchToLight;

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

  static Brightness _toggleTheme(
      BuildContext context, User user, Character? character) {
    final currentIsDark = user.brightness == Brightness.dark;
    final brightness = currentIsDark ? Brightness.light : Brightness.dark;
    _updateThemeOnUser(context, user, character);
    return brightness;
  }

  static void _updateThemeOnUser(
    BuildContext context,
    User user,
    Character? character,
  ) async {
    final currentIsDark = user.brightness == Brightness.dark;
    final brightness = currentIsDark ? Brightness.light : Brightness.dark;
    final userProvider = UserProvider.of(context);
    final charProvider = CharacterProvider.of(context);

    await userProvider.updateUser(
      user.copyWith(
        settings: user.settings.copyWith(brightnessOverride: brightness),
      ),
    );

    if (character != null) {
      charProvider.switchToCharacterTheme(character);
    }
  }
}

