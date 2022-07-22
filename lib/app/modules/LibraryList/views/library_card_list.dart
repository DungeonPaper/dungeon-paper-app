import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryCardList<T extends WithMeta, F extends EntityFilters<T>>
    extends GetView<LibraryListController<T, F>> {
  const LibraryCardList({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required this.children,
    required this.totalItemCount,
    this.extraData = const {},
    this.onSave,
  }) : super(key: key);

  final bool useFilters;
  final Widget Function(
      FiltersGroup, F filters, void Function(FiltersGroup group, F filters) update)? filtersBuilder;
  final F filters;
  final FiltersGroup group;
  final Iterable<Widget> children;
  final void Function(T item)? onSave;
  final Map<String, dynamic> extraData;
  final int totalItemCount;

  @override
  Widget build(BuildContext context) {
    final listViewChildren = _children(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ListView.builder(
              padding: const EdgeInsets.all(8).copyWith(top: 0, bottom: 80),
              itemBuilder: (context, index) => listViewChildren.elementAt(index),
              itemCount: listViewChildren.length,
            ),
          ),
        ),
        if (useFilters)
          Padding(
            padding: const EdgeInsets.all(8),
            child: filtersBuilder!(group, filters, controller.setFilters),
          ),
      ],
    );
  }

  List<Widget> _children(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return [
      const SizedBox(height: 40),
      if (children.isEmpty) ...[
        const SizedBox(height: 32),
        Text(
          S.current.libraryListNoItemsFoundTitle(S.current.entityPlural(T)),
          style: textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Center(
          child: SizedBox(
            width: 300,
            child: Text(
              filters.isEmpty
                  ? S.current.libraryListNoItemsFoundSubtitleNoFilters(S.current.entityPlural(T))
                  : S.current.libraryListNoItemsFoundSubtitleFilters(S.current.entityPlural(T)),
              style: textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
      if (onSave != null) ...[
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: () => Get.toNamed(
              Routes.editByType<T>(),
              arguments: createPageArgsByType(extraData),
            ),
            label: Text(S.current.createGeneric(S.current.entity(T))),
            icon: const Icon(Icons.add),
          ),
        ),
        if (children.isNotEmpty) const Divider(height: 32),
      ],
      ...children.map(
        (child) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: child,
        ),
      ),
    ];
  }

  createPageArgsByType(Map<String, dynamic> extraData) {
    switch (T) {
      case Move:
        return MoveFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Move move),
          type: FormContext.create,
        );
      case Spell:
        return SpellFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Spell spell),
          type: FormContext.create,
        );
      case Item:
        return ItemFormArguments(
          entity: null,
          onSave: onSave! as void Function(Item item),
          type: FormContext.create,
        );
      case Note:
        return NoteFormArguments(
          entity: null,
          onSave: onSave! as void Function(Note note),
          type: FormContext.create,
        );
      case CharacterClass:
        return CharacterClassFormArguments(
          entity: null,
          onSave: onSave! as void Function(CharacterClass characterClass),
          type: FormContext.create,
        );
      case Race:
        return RaceFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Race race),
          type: FormContext.create,
        );
    }
    throw TypeError();
  }
}
