import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/debug_dialog.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
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
        const PopupMenuItem(child: Text('View JSON'), value: 'viewCharJson'),
        const PopupMenuItem(child: Text('Search'), value: 'search'),
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
        'createChar': createChar,
        'clearChars': clearChars,
        'viewCharJson': viewCharJson,
        'search': search,
      };

  void toggleTheme() {
    var theme = DynamicTheme.of(Get.context!)!;
    theme.setTheme(theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  void clearChars() async {
    final CharacterService controller = Get.find();
    controller.clear();
    final all = await StorageHandler.instance.getCollection('Characters');
    for (var c in all) {
      StorageHandler.instance.delete('Characters', c['key']);
    }
  }

  void createChar() {
    Get.toNamed(Routes.createCharacterPage);
  }

  void viewCharJson() {
    final CharacterService controller = Get.find();

    Get.dialog(DebugDialog(text: controller.current!.toRawJson()));
  }

  void search() async {
    final resp = await api.requests
        .search(SearchRequest(types: {SearchType.moves, SearchType.spells}, query: 'magic'));
  }
}
