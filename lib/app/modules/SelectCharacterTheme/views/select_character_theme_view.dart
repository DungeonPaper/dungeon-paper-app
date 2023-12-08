import 'package:dungeon_paper/app/modules/Settings/views/theme_selector.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/select_character_theme_controller.dart';

class SelectCharacterThemeView extends GetView<SelectCharacterThemeController> {
  const SelectCharacterThemeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.character.theme.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => _sectionTitle(
              context,
              tr.character.theme.defaultLight,
              onReset: () {
                controller.lightTheme.value = null;
                controller.save();
              },
              resetEnabled: controller.lightTheme.value != null,
              onChangeSeeAll: (val) =>
                  controller.seeAll[Brightness.light] = val,
              seeAll: controller.seeAll[Brightness.light]!,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: controller.seeAll[Brightness.light]!
                    ? AppThemes.allThemes
                    : AppThemes.allLightThemes,
                selected: controller.lightTheme.value,
                onSelected: (theme) async {
                  controller.lightTheme.value = theme;
                  controller.save();
                },
              ),
            ),
            horizontal: 8,
          ),
          Obx(
            () => _sectionTitle(
              context,
              tr.character.theme.defaultDark,
              onReset: () {
                controller.darkTheme.value = null;
                controller.save();
              },
              resetEnabled: controller.darkTheme.value != null,
              onChangeSeeAll: (val) => controller.seeAll[Brightness.dark] = val,
              seeAll: controller.seeAll[Brightness.dark]!,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: controller.seeAll[Brightness.dark]!
                    ? AppThemes.allThemes
                    : AppThemes.allDarkThemes,
                selected: controller.darkTheme.value,
                onSelected: (theme) async {
                  controller.darkTheme.value = theme;
                  controller.save();
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
    required void Function() onReset,
    required void Function(bool) onChangeSeeAll,
    required bool seeAll,
    required bool resetEnabled,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final bodySmall = textTheme.bodySmall!;
    return _pad(Row(
      children: [
        Expanded(child: Text(labelText, style: bodySmall)),
        Text(tr.generic.seeAll),
        Switch.adaptive(value: seeAll, onChanged: onChangeSeeAll),
        ElevatedButton(
          onPressed: resetEnabled ? onReset : null,
          child: Text(tr.generic.useDefault),
        ),
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
