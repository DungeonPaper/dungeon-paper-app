import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/molecules/spell_card.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:flutter/material.dart';

class AddSpellList extends StatelessWidget {
  final void Function(DbSpell) onSave;

  AddSpellList({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spells = <String, List<Spell>>{};
    dungeonWorld.spells.forEach((spell) {
      spells[spell.level.toString()] ??= [];
      spells[spell.level.toString()].add(spell);
    });

    return CategorizedList.builder(
      items: spells.keys,
      itemCount: (cat, idx) => spells[cat].length,
      titleBuilder: (ctx, cat, idx) {
        var list = spells[cat];
        return Text(isNumeric(list.first.level)
            ? 'Level ${list.first.level}'
            : capitalize(list.first.level));
      },
      itemBuilder: (ctx, cat, idx, catI) {
        var spell = spells[cat][idx];
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: SpellCard(
            index: -1,
            spell: DbSpell.fromSpell(spell),
            mode: SpellCardMode.Addable,
            onSave: onSave,
            onDelete: null,
          ),
        );
      },
    );
  }
}
