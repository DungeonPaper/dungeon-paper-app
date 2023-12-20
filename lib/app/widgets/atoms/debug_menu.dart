import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/debug_dialog.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class DebugMenu extends StatelessWidget with CharacterProviderMixin {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuButton(
      items: [
        MenuEntry(
          label: const Text('Toggle dark mode'),
          value: 'toggleDarkMode',
          onSelect: () => _toggleTheme(context),
        ),
        MenuEntry(
          label: const Text('Clear all Char Data'),
          value: 'clearChars',
          onSelect: () => _clearChars(context),
        ),
        MenuEntry(
          label: const Text('Open create char page'),
          value: 'createChar',
          onSelect: () => _createChar(context),
        ),
        MenuEntry(
          label: const Text('View JSON'),
          value: 'viewCharJson',
          onSelect: () => _viewCharJson(context),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.bug_report),
      ),
    );
  }

  Map<String, void Function(BuildContext context)> get actionMap => {
        'toggleDarkMode': _toggleTheme,
        'createChar': _createChar,
        'clearChars': _clearChars,
        'viewCharJson': _viewCharJson,
      };

  void _toggleTheme(BuildContext context) {
    var theme = DynamicTheme.of(context)!;
    theme.setTheme(
        theme.themeId == AppThemes.dark ? AppThemes.parchment : AppThemes.dark);
  }

  void _clearChars(BuildContext context) async {
    charProvider.clear();
    final all = await StorageHandler.instance.getCollection('Characters');
    for (var c in all) {
      StorageHandler.instance.delete('Characters', c['key']);
    }
  }

  void _createChar(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.createCharacter);
  }

  void _viewCharJson(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DebugDialog(
        text: charProvider.current.toRawJson(),
      ),
    );
  }
}

