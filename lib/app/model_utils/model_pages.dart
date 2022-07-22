import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/library_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/character_classes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/moves_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/notes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/races_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class ModelPages {
  static CharacterService get controller => Get.find();
  static LibraryService get library => Get.find();

  static void openLibraryList<T extends WithMeta>({
    Character? character,
    void Function(Iterable<T> list)? onAdd,
    Iterable<T>? preSelections,
    FiltersGroup? initialTab,
    Type? type,
  }) {
    final map = <Type, Function()>{
      Move: () => openMovesList(
            character: character,
            onAdd: onAdd as void Function(Iterable<Move>)?,
            preSelections: preSelections as Iterable<Move>?,
            initialTab: initialTab,
          ),
      Spell: () => openSpellsList(
            character: character,
            onAdd: onAdd as void Function(Iterable<Spell>)?,
            preSelections: preSelections as Iterable<Spell>?,
            initialTab: initialTab,
          ),
      Item: () => openItemsList(
            character: character,
            onAdd: onAdd as void Function(Iterable<Item>)?,
            preSelections: preSelections as Iterable<Item>?,
            initialTab: initialTab,
          ),
      CharacterClass: () => openCharacterClassesList(
            character: character,
            onAdd: onAdd != null ? (x) => onAdd.call(asList<T>(x)) : null,
            preSelection: preSelections?.first as CharacterClass?,
            initialTab: initialTab,
          ),
      Race: () => openRacesList(
            character: character,
            onAdd: onAdd != null ? (x) => onAdd.call(asList<T>(x)) : null,
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

  static void openMovesList({
    Character? character,
    Iterable<Move>? preSelections,
    MoveCategory? category,
    FiltersGroup? initialTab,
    void Function(Iterable<Move> list)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.moves,
      arguments: MoveLibraryListArguments(
        initialTab: initialTab,
        character: char,
        category: category,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: char?.moves ?? [],
      ),
    );
  }

  static void openRacesList({
    Character? character,
    Race? preSelection,
    void Function(Race race)? onAdd,
    FiltersGroup? initialTab,
  }) {
    final char = character;
    Get.toNamed(
      Routes.races,
      arguments: RaceLibraryListArguments(
        initialTab: initialTab,
        character: char,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: asList(preSelection ?? char?.race),
      ),
    );
  }

  static void openMovePage({
    required Move? move,
    required void Function(Move move) onSave,
    required AbilityScores abilityScores,
  }) =>
      Get.toNamed(
        Routes.editMove,
        arguments: MoveFormArguments(
          entity: move,
          abilityScores: abilityScores,
          onSave: onSave,
          type: move == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openRacePage({
    required Race? race,
    required void Function(Race race) onSave,
    required AbilityScores abilityScores,
  }) =>
      Get.toNamed(
        Routes.editRace,
        arguments: RaceFormArguments(
          entity: race,
          abilityScores: abilityScores,
          onSave: onSave,
          type: race == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openSpellsList({
    Character? character,
    Iterable<Spell>? list,
    void Function(Iterable<Spell> list)? onAdd,
    FiltersGroup? initialTab,
    Iterable<Spell>? preSelections,
  }) {
    final char = character;
    Get.toNamed(
      Routes.spells,
      arguments: SpellLibraryListArguments(
        initialTab: initialTab,
        character: char,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.spells ?? [],
      ),
    );
  }

  static void openSpellPage({
    required Spell? spell,
    required void Function(Spell spell) onSave,
    required AbilityScores abilityScores,
    required List<dw.EntityReference> classKeys,
  }) =>
      Get.toNamed(
        Routes.editSpell,
        arguments: SpellFormArguments(
          entity: spell,
          abilityScores: abilityScores,
          onSave: onSave,
          type: spell == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openItemsList({
    Character? character,
    Iterable<Item>? list,
    void Function(Iterable<Item> list)? onAdd,
    FiltersGroup? initialTab,
    Iterable<Item>? preSelections,
  }) {
    final char = character;
    Get.toNamed(
      Routes.items,
      arguments: ItemLibraryListArguments(
        initialTab: initialTab,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.items ?? [],
      ),
    );
  }

  static void openItemPage({
    required Item? item,
    required void Function(Item item) onSave,
  }) =>
      Get.toNamed(
        Routes.editItem,
        arguments: ItemFormArguments(
          entity: item,
          onSave: onSave,
          type: item == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openNotesList({
    Character? character,
    Iterable<Note>? list,
    void Function(Iterable<Note> list)? onAdd,
    FiltersGroup? initialTab,
    Iterable<Note>? preSelections,
  }) {
    final char = character;
    Get.toNamed(
      Routes.notes,
      arguments: NoteLibraryListArguments(
        initialTab: initialTab,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: preSelections ?? char?.notes ?? [],
      ),
    );
  }

  static void openNotePage({
    required Note? note,
    required void Function(Note note) onSave,
  }) =>
      Get.toNamed(
        Routes.editNote,
        arguments: NoteFormArguments(
          entity: note,
          onSave: onSave,
          type: note == null ? FormContext.create : FormContext.edit,
        ),
      );

  static void openCharacterClassesList({
    Character? character,
    CharacterClass? preSelection,
    void Function(CharacterClass cls)? onAdd,
    FiltersGroup? initialTab,
  }) {
    final char = character;
    Get.toNamed(
      Routes.classes,
      arguments: CharacterClassLibraryListArguments(
        initialTab: initialTab,
        onAdd: onAdd ??
            (char != null
                ? (cls) => controller.updateCharacter(char.copyWith(characterClass: cls))
                : null),
        preSelections: asList(preSelection ?? char?.characterClass),
      ),
    );
  }

  static void openCharacterClassPage({
    required CharacterClass? characterClass,
    required void Function(CharacterClass item) onSave,
  }) =>
      Get.toNamed(
        Routes.editClass,
        arguments: CharacterClassFormArguments(
          entity: characterClass,
          onSave: onSave,
          type: characterClass == null ? FormContext.create : FormContext.edit,
        ),
      );
}
