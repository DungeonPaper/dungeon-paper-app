import 'dart:async';
import 'dart:math';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/backup_view/backup_view.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_character_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
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
  StreamSubscription<DWStore> subscription;
  User user;
  bool sortMode;

  @override
  void initState() {
    subscription = dwStore.onChange.listen(_loadCharsFromState);
    characters = dwStore.state.characters.all.values.toList()
      ..sort((a, b) => a.order - b.order);
    user = dwStore.state.user.current;
    sortMode = false;
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void _loadCharsFromState(DWStore state) {
    setState(() {
      characters = state.characters.all.values.toList()
        ..sort((a, b) => a.order - b.order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation(
      title: Text('Manage Characters'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
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
              children: [
                Expanded(
                  child: RaisedButton.icon(
                    icon: Icon(Icons.sort),
                    onPressed: () => setState(() => sortMode = !sortMode),
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                    label: Text(!sortMode ? 'Sort' : 'Done'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton.icon(
                    icon: Icon(Icons.settings_backup_restore),
                    onPressed: !sortMode ? _openBackupView : null,
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                    label: Text('Backup'),
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
      char.value.order = char.index;
      unawaited(char.value.update());
    }
    setState(() {
      characters = [...copy];
    });
    dwStore.dispatch(
      SetCharacters.fromIterable(copy),
    );
  }

  void _edit(Character char) {
    Get.to(
      EditCharacterView(
        character: char,
        mode: DialogMode.Edit,
      ),
    );
  }

  void _select(Character char) {
    dwStore.dispatch(SetCurrentChar(char));
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
        dwStore.dispatch(RemoveCharacter(char));
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
        mode: DialogMode.Create,
      ),
    );
  }

  void _openBackupView() {
    Get.to(BackupView());
  }
}
