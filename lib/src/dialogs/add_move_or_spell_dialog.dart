import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/moves.dart';
import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/scaffolds/add_move_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/add_spell_scaffold.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
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
                  color: Color(0xFF9B1D20),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: PlatformSvg.asset(
                      'swords.svg',
                      width: 30,
                      height: 30,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  label: Text(
                    'Add Move',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
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
                            logger.d('add_move_or_spell.dart onCreateMove');
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
                  color: Color(0xFF2274A5),
                  // icon: Icon(
                  //   Icons.book,
                  //   color: Theme.of(context).colorScheme.onSecondary,
                  //   size: 30,
                  // ),
                  icon: Icon(
                    Icons.menu_book_rounded,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 30,
                  ),
                  // icon: Padding(
                  //   padding: const EdgeInsets.only(top: 8),
                  //   child: PlatformSvg.asset(
                  //     'book-stack.svg',
                  //     width: 30,
                  //     height: 30,
                  //     color: Theme.of(context).colorScheme.onSecondary,
                  //   ),
                  // ),
                  label: Text(
                    'Add Spell',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
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
