import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/moves.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/scaffolds/add_move_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/add_spell_scaffold.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddMoveOrSpell extends StatelessWidget {
  final PlayerClass defaultClass;
  final Character character;

  const AddMoveOrSpell({
    Key key,
    this.defaultClass,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // title: Text('Add Move/Spell'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          // .copyWith(bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 60,
                child: RaisedButton.icon(
                  color: Colors.orange,
                  icon: PlatformSvg.asset(
                    'swords.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: Text(
                    'Add Move',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => AddMoveScreen(
                          move: Move(
                            key: Uuid().v4(),
                            name: '',
                            description: '',
                            classes: [],
                            explanation: '',
                          ),
                          mode: DialogMode.Create,
                          onSave: (move) {
                            print('add_move_or_spell.dart onCreateMove');
                            createMove(character, move);
                            Navigator.pop(ctx);
                          },
                          defaultClass: defaultClass,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(height: 20),
              Container(
                height: 60,
                child: RaisedButton.icon(
                  color: Colors.lightBlue,
                  icon: Icon(Icons.book),
                  label: Text(
                    'Add Spell',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => AddSpellScaffold(
                          spell: DbSpell(
                            key: Uuid().v4(),
                            name: '',
                            description: '',
                            tags: [],
                            level: '1-5',
                          ),
                          mode: DialogMode.Create,
                          onSave: (spell) {
                            createSpell(character, spell);
                            Navigator.pop(ctx);
                          },
                          index: -1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}