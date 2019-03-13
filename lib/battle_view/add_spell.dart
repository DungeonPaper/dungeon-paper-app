import 'package:dungeon_paper/battle_view/spell_card.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:flutter/material.dart';

class AddSpell extends StatelessWidget {
  AddSpell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List<Spell>> spells = {};
    dungeonWorld.spells.forEach((key, spell) {
      spells[spell.level.toString()] ??= [];
      spells[spell.level.toString()].add(spell);
    });
    Iterable<Widget> spellsByLevel = spells.values.map((list) {
      Widget title = Text(isNumeric(list.first.level) ? "Level ${list.first.level}" : capitalize(list.first.level),
          style: TextStyle(color: Theme.of(context).textTheme.subtitle.color));
      return Container(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title] +
              list
                  .map(
                    (spell) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: SpellCard(
                            index: -1,
                            spell: spell,
                            mode: SpellCardMode.Addable,
                          ),
                        ),
                  )
                  .toList(),
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.all(16),
      children: spellsByLevel.toList(),
    );
  }
}
