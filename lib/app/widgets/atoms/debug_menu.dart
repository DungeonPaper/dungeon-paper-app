import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/themes.dart';

class DebugMenu extends StatelessWidget {
  const DebugMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.bug_report),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(child: Text('Toggle dark mode'), value: 'toggleDarkMode'),
        const PopupMenuItem(child: Text('Randomize Char Data'), value: 'updateChar'),
        const PopupMenuItem(child: Text('Clear all Char Data'), value: 'clearChars'),
        const PopupMenuItem(child: Text('Open create char page'), value: 'createChar'),
      ],
      onSelected: (value) {
        if (actionMap[value] == null) {
          throw Exception('Unsupported');
        }
        actionMap[value]!.call();
      },
    );
  }

  Map<String, void Function()> get actionMap => {
        'toggleDarkMode': toggleTheme,
        'updateChar': updateChar,
        'createChar': createChar,
        'clearChars': clearChars,
      };

  void toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  void updateChar() {
    final CharacterService controller = Get.find();
    controller.debugUpdateCharData();
  }

  void clearChars() async {
    final CharacterService controller = Get.find();
    controller.clear();
    final all = await StorageHandler.instance.getAllItems('characters');
    for (var c in all) {
      debugPrint("Deleting ${c['key']}");
      StorageHandler.instance.delete('characters', c['key']);
    }
  }

  void createChar() {
    Get.toNamed(Routes.createCharacterPage);
  }
}
