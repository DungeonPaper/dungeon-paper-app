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
    required this.selections,
  }) : super(key: key);

  final void Function(Iterable<Spell> spells) onAdd;
  final Iterable<Spell> selections;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Spell, SpellFilters>(
      storageKey: 'Spells',
      title: Text(S.current.addGeneric(S.current.entityPlural(Spell))),
      filterFn: (spell, filters) => filters.filter(spell),
      filtersBuilder: (group, filters, onChange) => SpellFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (
        ctx,
        spell, {
        required selected,
        required selectable,
        required onToggle,
        required label,
        required icon,
      }) =>
          SpellCard(
        spell: spell,
        showDice: false,
        showStar: false,
        actions: [
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          )
        ],
      ),
      onAdd: onAdd,
      selections: selections,
    );
  }
}
