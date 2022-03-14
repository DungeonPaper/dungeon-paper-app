import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/spell_filters.dart';

class AddSpellsView extends GetView<AddRepositoryItemsController<Spell, SpellFilters>> {
  const AddSpellsView({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final void Function(Iterable<Spell> spells) onAdd;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Spell, SpellFilters>(
      title: Text(S.current.addSpells),
      filterFn: (spell, filters) => filters.filter(spell),
      filtersBuilder: (filters, update) => SpellFiltersView(
        filters: filters,
        onChange: controller.setFilters,
        searchController: controller.search,
      ),
      cardBuilder: (ctx, spell, {required onSelect, required selected}) => SpellCard(
        spell: spell,
        showDice: false,
        showStar: false,
        actions: [
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: () => onSelect(!selected),
            label: Text(!selected ? S.current.select : S.current.remove),
            icon: Icon(!selected ? Icons.add : Icons.remove),
          )
        ],
      ),
      onAdd: onAdd,
    );
  }
}
