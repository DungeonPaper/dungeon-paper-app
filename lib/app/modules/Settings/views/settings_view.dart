import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/user_provider.dart';
import '../controllers/settings_controller.dart';
import 'theme_selector.dart';

class SettingsView extends StatelessWidget
    with CharacterProviderMixin, UserProviderMixin {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.settings.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _sectionTitle(
            context,
            tr.settings.categories.general,
          ),
          if (PlatformHelper.isMobile)
            Consumer<SettingsController>(
              builder: (context, controller, _) => SwitchListTile.adaptive(
                title: Text(tr.settings.keepAwake),
                value: controller.settings.keepScreenAwake,
                onChanged: (value) => controller.updateSettings(
                  controller.settings.copyWith(keepScreenAwake: value),
                ),
              ),
            ),
          Consumer<SettingsController>(
            builder: (context, controller, _) => _sectionTitle(
              context,
              tr.settings.defaultTheme.light,
              onChangeSeeAll: (val) =>
                  controller.setSeeAll(Brightness.light, val),
              seeAll: controller.seeAll[Brightness.light]!,
            ),
          ),
          _pad(
            Consumer<SettingsController>(
              builder: (context, controller, _) => ThemeSelector(
                themes: controller.seeAll[Brightness.light]!
                    ? AppThemes.allThemes
                    : AppThemes.allLightThemes,
                selected: controller.settings.defaultLightTheme,
                onSelected: (theme) => controller.setLightTheme(theme),
              ),
            ),
            horizontal: 8,
          ),
          Consumer<SettingsController>(
            builder: (context, controller, _) => _sectionTitle(
              context,
              tr.settings.defaultTheme.dark,
              onChangeSeeAll: (val) =>
                  controller.setSeeAll(Brightness.dark, val),
              seeAll: controller.seeAll[Brightness.dark]!,
            ),
          ),
          _pad(
            Consumer<SettingsController>(
              builder: (context, controller, _) => ThemeSelector(
                themes: controller.seeAll[Brightness.dark]!
                    ? AppThemes.allThemes
                    : AppThemes.allDarkThemes,
                selected: controller.settings.defaultDarkTheme,
                onSelected: (theme) => controller.setDarkTheme(theme),
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
          Text(tr.generic.seeAll),
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

