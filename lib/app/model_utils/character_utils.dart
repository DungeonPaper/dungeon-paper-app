import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/repository_item_form_binding.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:get/get.dart';

class CharacterUtils {
  // Moves
  static Character updateMoves(Character char, Iterable<Move> moves) => char.copyWith(
        moves: updateByKey(char.moves, moves),
      );
  static Character addMoves(Character char, Iterable<Move> moves) => char.copyWith(
        moves: addByKey(char.moves, moves),
      );
  static Character removeMoves(Character char, Iterable<Move> move) => char.copyWith(
        moves: removeByKey(char.moves, move),
      );

  static void Function() openMovePage({
    required Move? move,
    required void Function(Move move) onSave,
    required RollStats rollStats,
    required List<String> classKeys,
  }) =>
      () => Get.to(
            () => RepositoryItemForm<Move>(
              onSave: onSave,
              type: ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding(
              item: move,
              extraData: {
                'rollStats': rollStats,
                'classKeys': classKeys,
              },
            ),
          );

  // Spells
  static Character updateSpells(Character char, Iterable<Spell> spells) => char.copyWith(
        spells: updateByKey(char.spells, spells),
      );
  static Character addSpells(Character char, Iterable<Spell> spells) => char.copyWith(
        spells: addByKey(char.spells, spells),
      );
  static Character removeSpells(Character char, Iterable<Spell> spell) => char.copyWith(
        spells: removeByKey(char.spells, spell),
      );

  static void Function() openSpellPage({
    required Spell? spell,
    required void Function(Spell spell) onSave,
    required RollStats rollStats,
    required List<String> classKeys,
  }) =>
      () => Get.to(
            () => RepositoryItemForm<Spell>(
              onSave: onSave,
              type: ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding(
              item: spell,
              extraData: {
                'rollStats': rollStats,
                'classKeys': classKeys,
              },
            ),
          );

  // Items
  static Character updateItems(Character char, Iterable<Item> items) => char.copyWith(
        items: updateByKey(char.items, items),
      );
  static Character addItems(Character char, Iterable<Item> items) => char.copyWith(
        items: addByKey(char.items, items),
      );
  static Character removeItems(Character char, Iterable<Item> item) => char.copyWith(
        items: removeByKey(char.items, item),
      );

  static void Function() openItemPage({
    required Item? item,
    required void Function(Item item) onSave,
  }) =>
      () => Get.to(
            () => RepositoryItemForm<Item>(
              onSave: onSave,
              type: ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding(
              item: item,
              extraData: const {},
            ),
          );

  // Notes
  static Character updateNotes(Character char, Iterable<Note> notes) => char.copyWith(
        notes: updateByKey(char.notes, notes),
      );
  static Character addNotes(Character char, Iterable<Note> notes) => char.copyWith(
        notes: addByKey(char.notes, notes),
      );
  static Character removeNotes(Character char, Iterable<Note> note) => char.copyWith(
        notes: removeByKey(char.notes, note),
      );

  static void Function() openNotePage({
    required Note? note,
    required void Function(Note note) onSave,
  }) =>
      () => Get.to(
            () => RepositoryItemForm<Note>(
              onSave: onSave,
              type: ItemFormType.edit,
            ),
            binding: RepositoryItemFormBinding(
              item: note,
              extraData: const {},
            ),
          );
}
