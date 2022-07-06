import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import 'theme_selector.dart';

class SettingsView extends GetView<SettingsController> with CharacterServiceMixin {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final caption = textTheme.caption!;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settingsTitle),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _sectionTitle(context, S.current.settingsGeneral),
          Obx(
            () => SwitchListTile.adaptive(
              title: Text(S.current.settingsKeepScreenAwake),
              value: controller.settings.keepScreenAwake,
              onChanged: (value) => controller.updateSettings(
                controller.settings.copyWith(keepScreenAwake: value),
              ),
            ),
          ),
          _sectionTitle(context, S.current.settingsDefaultLightTheme),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: AppThemes.allLightThemes,
                selected: controller.settings.defaultLightTheme,
                onSelected: (theme) async {
                  await controller.updateSettings(
                    controller.settings.copyWith(defaultLightTheme: theme),
                  );
                  if (controller.user.brightness == Brightness.light) {
                    charService.switchToCharacterTheme(character);
                  }
                },
              ),
            ),
            horizontal: 8,
          ),
          _sectionTitle(context, S.current.settingsDefaultDarkTheme),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: AppThemes.allDarkThemes,
                selected: controller.settings.defaultDarkTheme,
                onSelected: (theme) async {
                  await controller.updateSettings(
                    controller.settings.copyWith(defaultDarkTheme: theme),
                  );
                  if (controller.user.brightness == Brightness.dark) {
                    charService.switchToCharacterTheme(character);
                  }
                },
              ),
            ),
            horizontal: 8,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String labelText) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final caption = textTheme.caption!;
    return _pad(Text(labelText, style: caption));
  }

  Widget _pad(Widget child, {double horizontal = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: child,
    );
  }
}
