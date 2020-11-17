import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/search_bar.dart';
import 'package:dungeon_paper/src/molecules/spell_card.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:flutter/material.dart';

class AddSpellList extends StatefulWidget {
  final void Function(DbSpell) onSave;

  AddSpellList({
    Key key,
    @required this.onSave,
  }) : super(key: key);

  @override
  _AddSpellListState createState() => _AddSpellListState();
}

class _AddSpellListState extends State<AddSpellList> {
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController()..addListener(_searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(_searchListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spells = <String, List<Spell>>{};
    dungeonWorld.spells.forEach((spell) {
      if (_isVisible(spell)) {
        spells[spell.level.toString()] ??= [];
        spells[spell.level.toString()].add(spell);
      }
    });

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: CategorizedList.builder(
            items: spells.keys,
            itemCount: (cat, idx) => spells[cat].length,
            titleBuilder: (ctx, cat, idx) {
              final list = spells[cat];
              return Padding(
                padding: EdgeInsets.only(top: idx == 0 ? 32 : 0),
                child: Text(isNumeric(list.first.level)
                    ? 'Level ${list.first.level}'
                    : capitalize(list.first.level)),
              );
            },
            itemBuilder: (ctx, cat, idx, catI) {
              final spell = spells[cat][idx];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: SpellCard(
                  index: -1,
                  spell: DbSpell.fromSpell(spell),
                  mode: SpellCardMode.Addable,
                  onSave: widget.onSave,
                  onDelete: null,
                ),
              );
            },
          ),
        ),
        SearchBar(controller: searchController),
      ],
    );
  }

  bool _isVisible(Spell spell) =>
      searchController.text.isEmpty ||
      spell.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase().trim());

  void _searchListener() {
    setState(() {});
  }
}
