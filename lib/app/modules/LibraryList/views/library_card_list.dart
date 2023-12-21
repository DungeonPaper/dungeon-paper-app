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
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryCardList<T extends WithMeta, F extends EntityFilters<T>>
    extends StatelessWidget {
  LibraryCardList({
    super.key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required List<Widget> children,
    required this.totalItemCount,
    this.extraData = const {},
    this.onSave,
  })  : itemBuilder = ((BuildContext context, int index) => children[index]),
        itemCount = children.length;

  const LibraryCardList.builder({
    super.key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required this.totalItemCount,
    required this.itemBuilder,
    required this.itemCount,
    this.extraData = const {},
    this.onSave,
  });

  final bool useFilters;
  final Widget Function(
    FiltersGroup,
    F filters,
    void Function(FiltersGroup group, F filters) update,
  )? filtersBuilder;
  final F filters;
  final FiltersGroup group;
  final void Function(T item)? onSave;
  final Map<String, dynamic> extraData;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int totalItemCount;

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryListController<T, F>>(
      builder: (context, controller, _) => Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ItemBuilder.listViewBuilder(
                padding: const EdgeInsets.all(8).copyWith(
                  top: 0,
                  bottom: controller.selectable ? 80 : 4,
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: itemBuilder(context, index),
                ),
                itemCount: itemCount,
                leadingCount: _leadingCount(context),
                leadingBuilder: _leadingBuilder,
              ),
            ),
          ),
          if (useFilters)
            Padding(
              padding: const EdgeInsets.all(8),
              child: filtersBuilder!(group, filters, controller.setFilters),
            ),
        ],
      ),
    );
  }

  Widget _leadingBuilder(BuildContext context, int index) {
    return _leading(context).elementAt(index).call();
  }

  /// **Make sure to keep in sync with _leading**
  /// TODO use [ItemBuilder]
  int _leadingCount(BuildContext context) => _leading(context).length;

  /// **Make sure to keep in sync with _leadingCount**
  /// TODO use [ItemBuilder]
  List<Widget Function()> _leading(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return [
      () => const SizedBox(height: 40),
      if (itemCount == 0) ...[
        () => const SizedBox(height: 32),
        () => Text(
              tr.myLibrary.emptyState.title(tr.entityPlural(tn(T))),
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
        () => const SizedBox(height: 8),
        () => Center(
              child: SizedBox(
                width: 300,
                child: Text(
                  filters.isEmpty
                      ? tr.myLibrary.emptyState.subtitle
                          .noFilters(tr.entityPlural(tn(T)))
                      : tr.myLibrary.emptyState.subtitle
                          .filters(tr.entityPlural(tn(T))),
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        () => const SizedBox(height: 32),
      ],
      if (onSave != null) ...[
        () => SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ButtonThemes.primaryElevated(context),
                onPressed: () => Navigator.of(context).pushNamed(
                  Routes.editByType<T>(),
                  arguments: createPageArgsByType(extraData),
                ),
                label: Text(tr.generic.createEntity(tr.entity(tn(T)))),
                icon: const Icon(Icons.add),
              ),
            ),
        if (itemCount > 0) () => const Divider(height: 32),
      ],
    ];
  }

  createPageArgsByType(Map<String, dynamic> extraData) {
    switch (T) {
      case == Move:
        return MoveFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Move move),
          formContext: FormContext.create,
        );
      case == Spell:
        return SpellFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Spell spell),
          formContext: FormContext.create,
        );
      case == Item:
        return ItemFormArgumentsNew(
          entity: null,
          onSave: onSave! as void Function(Item item),
          formContext: FormContext.create,
        );
      case == Note:
        return NoteFormArguments(
          entity: null,
          onSave: onSave! as void Function(Note note),
          formContext: FormContext.create,
        );
      case == CharacterClass:
        return CharacterClassFormArguments(
          entity: null,
          onSave: onSave! as void Function(CharacterClass characterClass),
          formContext: FormContext.create,
        );
      case == Race:
        return RaceFormArguments(
          entity: null,
          abilityScores: extraData['abilityScores'],
          onSave: onSave! as void Function(Race race),
          formContext: FormContext.create,
        );
    }
    throw TypeError();
  }
}
