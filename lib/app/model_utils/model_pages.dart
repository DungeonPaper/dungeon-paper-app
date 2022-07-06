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
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:get/get.dart';

class ModelPages {
  static CharacterService get controller => Get.find();
  static LibraryService get library => Get.find();
  static Character? get _char => controller.maybeCurrent;

  static void Function() openLibraryList<T extends WithMeta>({
    // Character? character,
    // void Function(Iterable<T> list)? onAdd,
    Type? type,
  }) {
    final map = <Type, Function()>{
      Move: () => openMovesList(),
      Spell: () => openSpellsList(),
      Item: () => openItemsList(),
      CharacterClass: () => openCharacterClassesList(),
      // Race: () => openRacesList(),
    };

    final t = type ?? T;

    if (map[t] == null) {
      throw TypeError();
    }

    return map[t]!.call();
  }

  static void Function() openMovesList({
    Character? character,
    Iterable<Move>? list,
    void Function(Iterable<Move> list)? onAdd,
  }) {
    final char = character;
    return () => Get.toNamed(
          Routes.moves,
          arguments: MoveLibraryListArguments(
            character: char,
            onAdd: onAdd, // ?? library.upsertToCharacter,
            preSelections: char?.moves ?? [],
          ),
        );
  }

  static void Function() openMovePage({
    required Move? move,
    required void Function(Move move) onSave,
    required AbilityScores abilityScores,
    required List<String> classKeys,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Move>(
              onSave: onSave,
              type: move == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Move>(
              item: move,
              extraData: {
                'abilityScores': abilityScores,
                'classKeys': classKeys,
              },
            ),
          );

  static void Function() openRacePage({
    required Race? race,
    required void Function(Race race) onSave,
    required AbilityScores abilityScores,
    required List<String> classKeys,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Race>(
              onSave: onSave,
              type: race == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Race>(
              item: race,
              extraData: {
                'abilityScores': abilityScores,
                'classKeys': classKeys,
              },
            ),
          );

  static void Function() openSpellsList({
    Character? character,
    Iterable<Spell>? list,
    void Function(Iterable<Spell> list)? onAdd,
  }) {
    final char = character;
    return () => Get.toNamed(
          Routes.spells,
          arguments: SpellLibraryListArguments(
            character: char,
            onAdd: onAdd, // ?? library.upsertToCharacter,
            preSelections: char?.spells ?? [],
          ),
        );
  }

  static void Function() openSpellPage({
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
            binding: RepositoryItemFormBinding<Spell>(
              item: spell,
              extraData: {
                'abilityScores': abilityScores,
                'classKeys': classKeys,
              },
            ),
          );

  static void Function() openItemsList({
    Character? character,
    Iterable<Item>? list,
    void Function(Iterable<Item> list)? onAdd,
  }) {
    final char = character;
    return () => Get.toNamed(
          Routes.items,
          arguments: ItemLibraryListArguments(
            onAdd: onAdd, // ?? library.upsertToCharacter,
            preSelections: char?.items ?? [],
          ),
        );
  }

  static void Function() openItemPage({
    required Item? item,
    required void Function(Item item) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Item>(
              onSave: onSave,
              type: item == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Item>(
              item: item,
              extraData: const {},
            ),
          );

  static void Function() openNotesList({
    Character? character,
    Iterable<Note>? list,
    void Function(Iterable<Note> list)? onAdd,
  }) {
    final char = character;
    return () => Get.toNamed(
          Routes.notes,
          arguments: NoteLibraryListArguments(
            onAdd: onAdd, // ?? library.upsertToCharacter,
            preSelections: char?.notes ?? [],
          ),
        );
  }

  static void Function() openNotePage({
    required Note? note,
    required void Function(Note note) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<Note>(
              onSave: onSave,
              type: note == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<Note>(
              item: note,
              extraData: const {},
            ),
          );

  static void Function() openCharacterClassesList({
    Character? character,
    Iterable<CharacterClass>? list,
    void Function(CharacterClass cls)? onAdd,
  }) {
    final char = character;
    return () => Get.toNamed(
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

  static void Function() openCharacterClassPage({
    required CharacterClass? characterClass,
    required void Function(CharacterClass item) onSave,
  }) =>
      () => Get.to(
            () => LibraryEntityForm<CharacterClass>(
              onSave: onSave,
              type: characterClass == null ? ItemFormType.create : ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding<CharacterClass>(
              item: characterClass,
              extraData: const {},
            ),
          );
}
