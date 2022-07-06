import 'package:dungeon_paper/app/modules/Settings/views/theme_selector.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/select_character_theme_controller.dart';

class SelectCharacterThemeView extends GetView<SelectCharacterThemeController> {
  const SelectCharacterThemeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO intl
        title: const Text('Character Theme'),
        centerTitle: true,
      ),
      floatingActionButton: AdvancedFloatingActionButton.extended(
        onPressed: controller.save,
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
      body: ListView(
        children: [
          Obx(
            () => _sectionTitle(
              context,
              S.current.settingsDefaultLightTheme,
              onReset: () => controller.lightTheme.value = null,
              resetEnabled: controller.lightTheme.value != null,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: AppThemes.allLightThemes,
                selected: controller.lightTheme.value,
                onSelected: (theme) async {
                  controller.lightTheme.value = theme;
                },
              ),
            ),
            horizontal: 8,
          ),
          Obx(
            () => _sectionTitle(
              context,
              S.current.settingsDefaultDarkTheme,
              onReset: () => controller.darkTheme.value = null,
              resetEnabled: controller.darkTheme.value != null,
            ),
          ),
          _pad(
            Obx(
              () => ThemeSelector(
                themes: AppThemes.allDarkThemes,
                selected: controller.darkTheme.value,
                onSelected: (theme) async {
                  controller.darkTheme.value = theme;
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
    required bool resetEnabled,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final caption = textTheme.caption!;
    return _pad(Row(
      children: [
        Expanded(child: Text(labelText, style: caption)),
        ElevatedButton(onPressed: resetEnabled ? onReset : null, child: Text('Use Default')),
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
