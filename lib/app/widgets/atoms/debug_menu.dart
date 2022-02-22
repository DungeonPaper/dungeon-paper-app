import 'package:dungeon_paper/core/services/character_service.dart';
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
      ],
      onSelected: (value) {
        switch (value) {
          case 'toggleDarkMode':
            toggleTheme();
            return;
          case 'updateChar':
            updateChar();
            return;
          default:
            throw Exception('Unsupported');
        }
      },
    );
  }

  void toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  void updateChar() {
    final CharacterService controller = Get.find();
    controller.debugUpdateCharData();
  }
}
