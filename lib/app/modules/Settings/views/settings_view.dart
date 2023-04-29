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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settingsTitle),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _sectionTitle(
            context,
            S.current.settingsGeneral,
          ),
          Obx(
            () => SwitchListTile.adaptive(
              title: Text(S.current.settingsKeepScreenAwake),
              value: controller.settings.keepScreenAwake,
              onChanged: (value) => controller.updateSettings(
                controller.settings.copyWith(keepScreenAwake: value),
              ),
            ),
          ),
          Obx(
            () => _sectionTitle(
              context,
              S.current.settingsDefaultLightTheme,
              onChangeSeeAll: (val) => controller.seeAll[Brightness.light] = val,
              seeAll: controller.seeAll[Brightness.light]!,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: controller.seeAll[Brightness.light]! ? AppThemes.allThemes : AppThemes.allLightThemes,
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
          Obx(
            () => _sectionTitle(
              context,
              S.current.settingsDefaultDarkTheme,
              onChangeSeeAll: (val) => controller.seeAll[Brightness.dark] = val,
              seeAll: controller.seeAll[Brightness.dark]!,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: controller.seeAll[Brightness.dark]! ? AppThemes.allThemes : AppThemes.allDarkThemes,
                selected: controller.settings.defaultDarkTheme,
                onSelected: (theme) async {
                  await controller.updateSettings(
                    controller.settings.copyWith(defaultDarkTheme: theme),
                  );
                  if (controller.user.brightness == Brightness.dark) {
                    if (maybeChar != null) {
                      charService.switchToCharacterTheme(character);
                    } else {
                      charService.switchToTheme(theme);
                    }
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

  Widget _sectionTitle(
    BuildContext context,
    String labelText, {
    void Function(bool)? onChangeSeeAll,
    bool? seeAll,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final bodySmall = textTheme.bodySmall!;
    return _pad(Row(
      children: [
        Expanded(child: Text(labelText, style: bodySmall)),
        if (seeAll != null && onChangeSeeAll != null) ...[
          Text(S.current.seeAll),
          Switch.adaptive(value: seeAll, onChanged: onChangeSeeAll),
        ],
      ],
    ));
  }

  Widget _pad(Widget child, {double horizontal = 16}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: child,
    );
  }
}
