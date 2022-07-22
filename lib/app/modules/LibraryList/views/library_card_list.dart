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
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryCardList<T extends WithMeta, F extends EntityFilters<T>>
    extends GetView<LibraryListController<T, F>> {
  LibraryCardList({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required List<Widget> children,
    required this.totalItemCount,
    this.extraData = const {},
    this.onSave,
  })  : itemBuilder = ((BuildContext context, int index) => children[index]),
        itemCount = children.length,
        super(key: key);

  const LibraryCardList.builder({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required this.totalItemCount,
    required this.itemBuilder,
    required this.itemCount,
    this.extraData = const {},
    this.onSave,
  }) : super(key: key);

  final bool useFilters;
  final Widget Function(
      FiltersGroup, F filters, void Function(FiltersGroup group, F filters) update)? filtersBuilder;
  final F filters;
  final FiltersGroup group;
  final void Function(T item)? onSave;
  final Map<String, dynamic> extraData;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int totalItemCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(8).copyWith(top: 0, bottom: controller.selectable ? 80 : 4),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: index < _leadingCount
                    ? _leading(context).elementAt(index)
                    : itemBuilder(context, index - _leadingCount),
              ),
              itemCount: itemCount + _leadingCount,
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

  /// **Make sure to keep in sync with _leading**
  int get _leadingCount => sum([
        1,
        if (itemCount == 0) 5,
        if (onSave != null) ...[
          1,
          if (itemCount > 0) 1,
        ],
      ]);

  /// **Make sure to keep in sync with _leadingCount**
  List<Widget> _leading(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return [
      const SizedBox(height: 40),
      if (itemCount == 0) ...[
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
        if (itemCount > 0) const Divider(height: 32),
      ],
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
