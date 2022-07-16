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
import 'package:dungeon_paper/app/modules/LibraryList/bindings/library_form_binding.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/character_classes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/moves_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/notes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:get/get.dart';

class ModelPages {
  static CharacterService get controller => Get.find();
  static LibraryService get library => Get.find();

  static void openLibraryList<T extends WithMeta>({
    // Character? character,
    // void Function(Iterable<T> list)? onAdd,
    Type? type,
  }) {
    final map = <Type, Function()>{
      Move: openMovesList,
      Spell: openSpellsList,
      Item: openItemsList,
      CharacterClass: openCharacterClassesList,
      // Race: () => openRacesList(),
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
    void Function(Iterable<Move> list)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.moves,
      arguments: MoveLibraryListArguments(
        character: char,
        category: category,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: char?.moves ?? [],
      ),
    );
  }

  static void openMovePage({
    required Move? move,
    required void Function(Move move) onSave,
    required AbilityScores abilityScores,
  }) =>
      Get.to(
        () => LibraryEntityForm<Move>(
          onSave: onSave,
          type: move == null ? ItemFormType.create : ItemFormType.edit,
        ),
        binding: RepositoryItemFormBinding<Move>(),
        arguments: MoveFormArguments(move: move, abilityScores: abilityScores),
      );

  static void openRacePage({
    required Race? race,
    required void Function(Race race) onSave,
    required AbilityScores abilityScores,
  }) =>
      Get.to(
        () => LibraryEntityForm<Race>(
          onSave: onSave,
          type: race == null ? ItemFormType.create : ItemFormType.edit,
        ),
        binding: RepositoryItemFormBinding<Race>(),
        arguments: RaceFormArguments(
          race: race,
          abilityScores: abilityScores,
        ),
      );

  static void openSpellsList({
    Character? character,
    Iterable<Spell>? list,
    void Function(Iterable<Spell> list)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.spells,
      arguments: SpellLibraryListArguments(
        character: char,
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: char?.spells ?? [],
      ),
    );
  }

  static void openSpellPage({
    required Spell? spell,
    required void Function(Spell spell) onSave,
    required AbilityScores abilityScores,
    required List<String> classKeys,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Spell>(
              onSave: onSave,
              type: spell == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Spell>(),
            arguments: SpellFormArguments(spell: spell, abilityScores: abilityScores),
          );

  static void openItemsList({
    Character? character,
    Iterable<Item>? list,
    void Function(Iterable<Item> list)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.items,
      arguments: ItemLibraryListArguments(
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: char?.items ?? [],
      ),
    );
  }

  static void openItemPage({
    required Item? item,
    required void Function(Item item) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Item>(
              onSave: onSave,
              type: item == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Item>(),
            arguments: ItemFormArguments(item: item),
          );

  static void openNotesList({
    Character? character,
    Iterable<Note>? list,
    void Function(Iterable<Note> list)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.notes,
      arguments: NoteLibraryListArguments(
        onAdd: onAdd, // ?? library.upsertToCharacter,
        preSelections: char?.notes ?? [],
      ),
    );
  }

  static void openNotePage({
    required Note? note,
    required void Function(Note note) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Note>(
              onSave: onSave,
              type: note == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Note>(),
            arguments: NoteFormArguments(note: note),
          );

  static void openCharacterClassesList({
    Character? character,
    Iterable<CharacterClass>? list,
    void Function(CharacterClass cls)? onAdd,
  }) {
    final char = character;
    Get.toNamed(
      Routes.characterClass,
      arguments: CharacterClassLibraryListArguments(
        onAdd: (list) => onAdd != null
            ? onAdd(list.elementAt(0))
            : char != null
                ? controller.updateCharacter(
                    char.copyWith(characterClass: list.elementAt(0)),
                  )
                : null,
        preSelections: char != null ? [char.characterClass] : [],
      ),
    );
  }

  static void openCharacterClassPage({
    required CharacterClass? characterClass,
    required void Function(CharacterClass item) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<CharacterClass>(
              onSave: onSave,
              type: characterClass == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<CharacterClass>(),
            arguments: CharacterClassFormArguments(characterClass: characterClass),
          );
}
