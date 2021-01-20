import 'dart:async';
import 'dart:math';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_character_view.dart';
import 'package:dungeon_paper/src/controllers/characters_controller.dart';
import 'package:dungeon_paper/src/controllers/user_controller.dart';
import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';

class ManageCharactersView extends StatefulWidget {
  @override
  _ManageCharactersViewState createState() => _ManageCharactersViewState();
}

class _ManageCharactersViewState extends State<ManageCharactersView> {
  List<Character> characters;
  User user;
  bool sortMode;
  GetStream _loadCharsSub;

  @override
  void initState() {
    _loadCharsSub = GetStream(onListen: _loadCharsFromState);
    characterController.all..addListener(_loadCharsSub);
    characters = characterController.all.values.toList()
      ..sort((a, b) => a.order - b.order);
    user = userController.current;
    sortMode = false;
    super.initState();
  }

  @override
  void dispose() {
    _loadCharsSub.close();
    super.dispose();
  }

  void _loadCharsFromState() {
    setState(() {
      characters = characterController.all.values.toList()
        ..sort((a, b) => a.order - b.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Get.theme;
    return MainScaffold(
      title: Text('Manage Characters'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        onPressed: _openCreatePage,
      ),
      automaticallyImplyLeading: true,
      body: Padding(
        padding:
            const EdgeInsets.all(8).copyWith(bottom: BOTTOM_SPACER.height + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text('Tip: Hold & drag a character to change its order.'),
            // ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: mq.size.width < 500 ? mq.size.width / 2 : 200,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.sort),
                    onPressed: _toggleSort,
                    color: theme.colorScheme.secondary,
                    textColor: theme.colorScheme.onSecondary,
                    label: Text(!sortMode ? 'Sort' : 'Done'),
                  ),
                ),
              ],
            ),
            for (var char in enumerate(characters))
              CardListItem(
                key: Key(char.value.documentID),
                width: MediaQuery.of(context).size.width - 22,
                title: Text(char.value.displayName),
                leading: Icon(Icons.person, size: 40),
                onTap: () => _select(char.value),
                subtitle: Text('Level ${char.value.level} '
                    '${capitalize(enumName(char.value.alignment))} '
                    '${capitalize(char.value.mainClass.name)}'),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: !sortMode
                        ? [
                            IconButton(
                              icon: Icon(Icons.edit),
                              tooltip: 'Edit ${char.value.displayName}',
                              onPressed: () => _edit(char.value),
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete_forever),
                              tooltip: 'Delete ${char.value.displayName}',
                              onPressed: characters.length > 1
                                  ? _delete(char.value)
                                  : null,
                              visualDensity: VisualDensity.compact,
                            ),
                          ]
                        : [
                            IconButton(
                              icon: Icon(Icons.arrow_upward),
                              tooltip: 'Move Up',
                              onPressed: char.index > 0
                                  ? () => _moveUp(char.index)
                                  : null,
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              tooltip: 'Move Down',
                              onPressed: char.index < characters.length - 1
                                  ? () => _moveDown(char.index)
                                  : null,
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _toggleSort() {
    unawaited(
      analytics.logEvent(
        name: sortMode ? Events.CharactersSortEnd : Events.CharactersSortStart,
        parameters: {
          'characters_count': characters.length,
        },
      ),
    );
    setState(() => sortMode = !sortMode);
  }

  void _moveUp(num oldIdx) {
    var copy = [...characters];
    var char = copy.elementAt(oldIdx);
    copy
      ..removeAt(oldIdx)
      ..insert(max(oldIdx - 1, 0), char);
    _updateChars(copy);
  }

  void _moveDown(num oldIdx) {
    var copy = [...characters];
    var char = copy.elementAt(oldIdx);
    copy
      ..removeAt(oldIdx)
      ..insert(min(oldIdx + 1, copy.length), char);
    _updateChars(copy);
  }

  void _updateChars(List<Character> copy) {
    for (var char in enumerate(copy)) {
      char = Enumeration(char.index, char.value.copyWith(order: char.index));
      unawaited(char.value.update(keys: ['order']));
    }
    setState(() {
      characters = [...copy];
    });
    characterController.setAll(copy);
  }

  void _edit(Character char) {
    Get.to(
      EditCharacterView(
        character: char,
        mode: DialogMode.edit,
      ),
    );
  }

  void _select(Character char) {
    characterController.setCurrent(char);
    Get.back();
  }

  Future<void> Function() _delete(Character char) {
    return () async {
      logger.d('Delete Character');
      final result = await showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: Text('Delete Character?'),
          text: Text(
              'THIS CAN NOT BE UNDONE!\nAre you sure this is what you want to do?'),
          okButtonText: Text('I WANT THIS CHARACTER GONE!'),
          cancelButtonText: Text('I regret clicking this'),
        ),
      );
      if (result == true) {
        unawaited(analytics.logEvent(name: Events.DeleteCharacter));
        characterController.remove(char);
        await char.delete();
        if (mounted) {
          setState(() {
            characters = characters..remove(char);
          });
        }
      }
    };
  }

  void _openCreatePage() {
    Get.to(
      EditCharacterView(
        character: null,
        mode: DialogMode.create,
      ),
    );
  }
}
