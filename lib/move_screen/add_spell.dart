import 'package:dungeon_paper/battle_view/spell_card.dart';
import 'package:dungeon_paper/components/categorized_list.dart';
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

    return CategorizedList.builder(
      categories: spells.keys,
      itemCount: (cat, idx) => spells[cat].length,
      titleBuilder: (ctx, cat, idx) {
        var list = spells[cat];
        return Text(isNumeric(list.first.level)
            ? "Level ${list.first.level}"
            : capitalize(list.first.level));
      },
      itemBuilder: (ctx, cat, idx) {
        var spell = spells[cat][idx];
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: SpellCard(
            index: -1,
            spell: spell,
            mode: SpellCardMode.Addable,
          ),
        );
      },
    );
  }
}
