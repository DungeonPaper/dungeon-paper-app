import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/library_provider.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/character_classes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/moves_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/notes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/races_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/modules/StandardMoves/controllers/standard_moves_list_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class ModelPages with LibraryProviderMixin, CharacterProviderMixin {
  static void openLibraryList<T extends WithMeta>(
    BuildContext context, {
    Character? character,
    void Function(Iterable<T> list)? onSelected,
    Iterable<T>? preSelections,
    FiltersGroup? initialTab,
    AbilityScores? abilityScores,
    MoveCategory? moveCategory,
    List<dw.EntityReference>? classKeys,
    Type? type,
  }) {
    final map = <Type, Function()>{
      Move: () => openMovesList(
            context,
            character: character,
            onSelected: onSelected as void Function(Iterable<Move>)?,
            preSelections: preSelections as Iterable<Move>?,
            abilityScores: abilityScores,
            category: moveCategory,
            classKeys: classKeys,
            initialTab: initialTab,
          ),
      Spell: () => openSpellsList(
            context,
            character: character,
            onSelected: onSelected as void Function(Iterable<Spell>)?,
            preSelections: preSelections as Iterable<Spell>?,
            abilityScores: abilityScores,
            classKeys: classKeys,
            initialTab: initialTab,
          ),
      Item: () => openItemsList(
            context,
            character: character,
            onSelected: onSelected as void Function(Iterable<Item>)?,
            preSelections: preSelections as Iterable<Item>?,
            initialTab: initialTab,
          ),
      CharacterClass: () => openCharacterClassesList(
            context,
            character: character,
            onSelected: onSelected != null
                ? (x) => onSelected.call(asList<T>(x))
                : null,
            preSelection: preSelections?.first as CharacterClass?,
            initialTab: initialTab,
          ),
      Race: () => openRacesList(
            context,
            character: character,
            onSelected: onSelected != null
                ? (x) => onSelected.call(asList<T>(x))
                : null,
            preSelection: preSelections?.first as Race?,
            initialTab: initialTab,
          ),
    };

    final t = type ?? T;

    if (map[t] == null) {
      throw TypeError();
    }

    map[t]!.call();
  }

  static void openMovesList(
    BuildContext context, {
    Character? character,
    Iterable<Move>? preSelections,
    MoveCategory? category,
    FiltersGroup? initialTab,
    void Function(Iterable<Move> list)? onSelected,
    AbilityScores? abilityScores,
    List<dw.EntityReference>? classKeys,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.moves,
      arguments: MoveLibraryListArguments(
        initialTab: initialTab,
        character: char,
        category: category,
        onSelected: onSelected, // ?? library.upsertToCharacter,
        preSelections: char?.moves ?? [],
        abilityScores: abilityScores,
        classKeys: classKeys,
      ),
    );
  }

  static void openStandardMovesList(
    BuildContext context, {
    required Character character,
    required MoveCategory category,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.standardMoves,
      arguments: StandardMovesArgs(
        category: category,
        character: char,
      ),
    );
  }

  static void openRacesList(
    BuildContext context, {
    Character? character,
    Race? preSelection,
    void Function(Race race)? onSelected,
    FiltersGroup? initialTab,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.races,
      arguments: RaceLibraryListArguments(
        initialTab: initialTab,
        character: char,
        onSelected: onSelected, // ?? library.upsertToCharacter,
        preSelections: asList(preSelection ?? char?.race),
      ),
    );
  }

  static void openMovePage(
    BuildContext context, {
    required Move? move,
    required void Function(Move move) onSave,
    required AbilityScores abilityScores,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editMove,
        arguments: MoveFormArguments(
          entity: move,
          abilityScores: abilityScores,
          onSave: onSave,
          formContext: move == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openRacePage(
    BuildContext context, {
    required Race? race,
    required void Function(Race race) onSave,
    required AbilityScores abilityScores,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editRace,
        arguments: RaceFormArguments(
          entity: race,
          abilityScores: abilityScores,
          onSave: onSave,
          formContext: race == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openSpellsList(
    BuildContext context, {
    Character? character,
    Iterable<Spell>? list,
    void Function(Iterable<Spell> list)? onSelected,
    FiltersGroup? initialTab,
    Iterable<Spell>? preSelections,
    AbilityScores? abilityScores,
    List<dw.EntityReference>? classKeys,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.spells,
      arguments: SpellLibraryListArguments(
        initialTab: initialTab,
        character: char,
        onSelected: onSelected, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.spells ?? [],
        abilityScores: abilityScores,
        classKeys: classKeys,
      ),
    );
  }

  static void openSpellPage(
    BuildContext context, {
    required Spell? spell,
    required void Function(Spell spell) onSave,
    required AbilityScores abilityScores,
    required List<dw.EntityReference> classKeys,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editSpell,
        arguments: SpellFormArguments(
          entity: spell,
          abilityScores: abilityScores,
          onSave: onSave,
          formContext: spell == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openItemsList(
    BuildContext context, {
    Character? character,
    Iterable<Item>? list,
    void Function(Iterable<Item> list)? onSelected,
    FiltersGroup? initialTab,
    Iterable<Item>? preSelections,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.items,
      arguments: ItemLibraryListArguments(
        initialTab: initialTab,
        onSelected: onSelected, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.items ?? [],
      ),
    );
  }

  static void openItemPage(
    BuildContext context, {
    required Item? item,
    required void Function(Item item) onSave,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editItem,
        arguments: ItemFormArgumentsNew(
          entity: item,
          onSave: onSave,
          formContext: item == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openNotesList(
    BuildContext context, {
    Character? character,
    Iterable<Note>? list,
    void Function(Iterable<Note> list)? onSelected,
    FiltersGroup? initialTab,
    Iterable<Note>? preSelections,
  }) {
    final char = character;
    Navigator.of(context).pushNamed(
      Routes.notes,
      arguments: NoteLibraryListArguments(
        initialTab: initialTab,
        onSelected: onSelected, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.notes ?? [],
      ),
    );
  }

  static void openNotePage(
    BuildContext context, {
    required Note? note,
    required void Function(Note note) onSave,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editNote,
        arguments: NoteFormArguments(
          entity: note,
          onSave: onSave,
          formContext: note == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openCharacterClassesList(
    BuildContext context, {
    Character? character,
    CharacterClass? preSelection,
    void Function(CharacterClass cls)? onSelected,
    FiltersGroup? initialTab,
  }) {
    final char = character;
    final charProvider = CharacterProvider.of(appGlobalKey.currentContext!);

    Navigator.of(context).pushNamed(
      Routes.classes,
      arguments: CharacterClassLibraryListArguments(
        initialTab: initialTab,
        onSelected: onSelected ??
            (char != null
                ? (cls) => charProvider
                    .updateCharacter(char.copyWith(characterClass: cls))
                : null),
        preSelections: asList(preSelection ?? char?.characterClass),
      ),
    );
  }

  static void openCharacterClassPage(
    BuildContext context, {
    required CharacterClass? characterClass,
    required void Function(CharacterClass item) onSave,
  }) =>
      Navigator.of(context).pushNamed(
        Routes.editClass,
        arguments: CharacterClassFormArguments(
          entity: characterClass,
          onSave: onSave,
          formContext:
              characterClass == null ? FormContext.create : FormContext.edit,
        ),
      );
}