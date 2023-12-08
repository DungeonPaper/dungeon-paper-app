import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/debug_dialog.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/themes.dart';

class DebugMenu extends StatelessWidget {
  const DebugMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuButton(
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.bug_report),
      ),
      items: [
        MenuEntry(
          label: const Text('Toggle dark mode'),
          value: 'toggleDarkMode',
          onSelect: _toggleTheme,
        ),
        MenuEntry(
          label: const Text('Clear all Char Data'),
          value: 'clearChars',
          onSelect: _clearChars,
        ),
        MenuEntry(
          label: const Text('Open create char page'),
          value: 'createChar',
          onSelect: _createChar,
        ),
        MenuEntry(
          label: const Text('View JSON'),
          value: 'viewCharJson',
          onSelect: _viewCharJson,
        ),
      ],
    );
  }

  Map<String, void Function()> get actionMap => {
        'toggleDarkMode': _toggleTheme,
        'createChar': _createChar,
        'clearChars': _clearChars,
        'viewCharJson': _viewCharJson,
      };

  void _toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(
        theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  void _clearChars() async {
    final CharacterService controller = Get.find();
    controller.clear();
    final all = await StorageHandler.instance.getCollection('Characters');
    for (var c in all) {
      StorageHandler.instance.delete('Characters', c['key']);
    }
  }

  void _createChar() {
    Get.toNamed(Routes.createCharacter);
  }

  void _viewCharJson() {
    final CharacterService controller = Get.find();

    Get.dialog(DebugDialog(text: controller.current.toRawJson()));
  }
}
