import 'dart:math';

import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/dialogs/export_characters_dialog.dart';
import 'package:dungeon_paper/src/pages/edit_character/edit_character_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

class ManageCharactersView extends StatefulWidget {
  @override
  _ManageCharactersViewState createState() => _ManageCharactersViewState();
}

class _ManageCharactersViewState extends State<ManageCharactersView> {
  List<Character> characters;
  User user;

  @override
  void initState() {
    characters = dwStore.state.characters.characters.values.toList()
      ..sort((a, b) => a.order - b.order);
    user = dwStore.state.user.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation.primaryBackground(
      title: Text('Manage Characters'),
      actions: [
        if (user.isTester)
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: _openExportDialog,
            tooltip: 'Export Characters',
          ),
      ],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).canvasColor,
        // foregroundColor: Theme.of(context).canvasColor,
        onPressed: _openCreatePage,
      ),
      automaticallyImplyLeading: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Tip: Hold & drag a character to change its order.'),
          ),
          for (var char in enumerate(characters))
            Padding(
              key: Key(char.value.documentID),
              padding: const EdgeInsets.only(left: 8),
              child: CardListItem(
                width: MediaQuery.of(context).size.width - 22,
                title: Text(char.value.displayName),
                leading: Icon(Icons.person, size: 40),
                subtitle: Text('Level ${char.value.level} '
                    '${capitalize(enumName(char.value.alignment))} '
                    '${capitalize(char.value.mainClass.name)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(32),
                          1: FixedColumnWidth(32),
                        },
                        children: [
                          TableRow(children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              tooltip: 'Edit ${char.value.displayName}',
                              onPressed: () => _edit(char.value, context),
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.delete_forever),
                              tooltip: 'Delete ${char.value.displayName}',
                              onPressed: _delete(char.value),
                              visualDensity: VisualDensity.compact,
                            ),
                          ]),
                          TableRow(children: [
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
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
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
      SetCharacters(
        Map<String, Character>.fromEntries(
          copy.map((char) => MapEntry(char.documentID, char)),
        ),
      ),
    );
  }

  void _edit(Character char, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditCharacterView(
          character: char,
          mode: DialogMode.Edit,
        ),
      ),
    );
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
    Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => EditCharacterView(
          character: null,
          mode: DialogMode.Create,
        ),
      ),
    );
  }

  void _openExportDialog() {
    showDialog(
      context: context,
      builder: (context) => ExportCharactersDialog(),
    );
  }
}
