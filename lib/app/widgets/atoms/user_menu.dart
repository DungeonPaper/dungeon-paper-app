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
import 'character_avatar.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

  CharacterService get controller => Get.find<CharacterService>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.person),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: SizedBox(
            width: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Expanded(child: Text('User')),
                    SizedBox(width: 16),
                    CircleAvatar(backgroundColor: Colors.grey),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (final char in controller.all.values.take(5))
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => controller.setCurrent(char.key),
                          child: SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                CharacterAvatar.circle(character: char, size: 48),
                                Text(
                                  char.displayName,
                                  overflow: TextOverflow.ellipsis,
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => null,
                        child: SizedBox(
                          width: 60,
                          child: Column(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.more_horiz),
                                radius: 24,
                                backgroundColor: Theme.of(context).colorScheme.background,
                              ),
                              Text(
                                'More',
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 0.8,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          value: 'user',
          enabled: false,
        ),
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
        'viewCharJson': viewCharJson,
        'search': search,
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
    final all = await StorageHandler.instance.getCollection('Characters');
    for (var c in all) {
      debugPrint("Deleting ${c['key']}");
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

    debugPrint(resp.moves?.toString());
    debugPrint(resp.spells?.toString());
  }
}
