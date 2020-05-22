import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/pages/character_wizard/edit_character_view.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:reorderables/reorderables.dart';

class ManageCharactersView extends StatefulWidget {
  @override
  _ManageCharactersViewState createState() => _ManageCharactersViewState();
}

class _ManageCharactersViewState extends State<ManageCharactersView> {
  List<Character> characters;

  @override
  void initState() {
    characters = dwStore.state.characters.characters.values.toList()
      ..sort((a, b) => a.order - b.order);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Characters')),
      body: ReorderableColumn(
        header: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Tip: Hold & drag a character to change its order.'),
        ),
        padding: EdgeInsets.all(8),
        mainAxisSize: MainAxisSize.min,
        onReorder: (oldIdx, newIdx) {
          var copy = [...characters];
          var char = copy.elementAt(oldIdx);
          copy
            ..removeAt(oldIdx)
            ..insert(newIdx, char);
          for (var char in enumerate(copy)) {
            unawaited(char.value.update(json: {'order': char.index}));
          }
          setState(() {
            characters = [...copy];
          });
          dwStore.dispatch(
            SetCharacters(
              Map<String, Character>.fromEntries(
                copy.map((char) => MapEntry(char.docID, char)),
              ),
            ),
          );
        },
        children: [
          for (var char in characters)
            IntrinsicWidth(
              key: Key(char.docID),
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.only(top: 4.0),
                      width: 10,
                      height: 10,
                      child: Icon(Icons.person, size: 30),
                    ),
                    title: Text(char.displayName),
                    subtitle: Text(
                        'Level ${char.level} ${capitalize(enumName(char.alignment))} ${capitalize(char.mainClass.name)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings),
                          tooltip: 'Edit ${char.displayName}',
                          onPressed: () => onEdit(char, context),
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete_forever),
                          tooltip: 'Delete ${char.displayName}',
                          onPressed: () async {
                            if (await showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                title: Text('Delete Character?'),
                                text: Text(
                                    'THIS CAN NOT BE UNDONE!\nAre you sure this is what you want to do?'),
                                okButtonText:
                                    Text('I WANT THIS CHARACTER GONE!'),
                                cancelButtonText:
                                    Text('I regret clicking this'),
                              ),
                            )) {
                              dwStore.dispatch(RemoveCharacter(char));
                              await char.delete();
                              setState(() {
                                characters = characters..remove(char);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onEdit(Character char, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditCharacterView(character: char),
      ),
    );
  }
}
