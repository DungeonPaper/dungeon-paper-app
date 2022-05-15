import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';

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
  static Character reorderMoves(Character char, int oldIndex, int newIndex) => char.copyWith(
        moves: reorder(char.moves, oldIndex, newIndex),
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
  static Character reorderSpells(Character char, int oldIndex, int newIndex) => char.copyWith(
        spells: reorder(char.spells, oldIndex, newIndex),
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
  static Character reorderItems(Character char, int oldIndex, int newIndex) => char.copyWith(
        items: reorder(char.items, oldIndex, newIndex),
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
  static Character reorderNotes(Character char, int oldIndex, int newIndex) => char.copyWith(
        notes: reorder(char.notes, oldIndex, newIndex),
      );

  // CHARACTER CLASS

  // COMBINED

  static Character updateByType<T>(Character char, Iterable<T> items) => char.copyWith(
        moves: T == Move ? updateByKey(listByType<Move>(char).toList(), items.cast<Move>()) : null,
        spells:
            T == Spell ? updateByKey(listByType<Spell>(char).toList(), items.cast<Spell>()) : null,
        items: T == Item ? updateByKey(listByType<Item>(char).toList(), items.cast<Item>()) : null,
        notes: T == Note ? updateByKey(listByType<Note>(char).toList(), items.cast<Note>()) : null,
      );

  static Character addByType<T>(Character char, Iterable<T> items) => char.copyWith(
        moves: T == Move ? addByKey(listByType<Move>(char).toList(), items.cast<Move>()) : null,
        spells: T == Spell ? addByKey(listByType<Spell>(char).toList(), items.cast<Spell>()) : null,
        items: T == Item ? addByKey(listByType<Item>(char).toList(), items.cast<Item>()) : null,
        notes: T == Note ? addByKey(listByType<Note>(char).toList(), items.cast<Note>()) : null,
      );

  static Character removeByType<T>(Character char, Iterable<T> items) => char.copyWith(
        moves: T == Move ? removeByKey(listByType<Move>(char).toList(), items.cast<Move>()) : null,
        spells:
            T == Spell ? removeByKey(listByType<Spell>(char).toList(), items.cast<Spell>()) : null,
        items: T == Item ? removeByKey(listByType<Item>(char).toList(), items.cast<Item>()) : null,
        notes: T == Note ? removeByKey(listByType<Note>(char).toList(), items.cast<Note>()) : null,
      );

  static Character reorderByType<T>(Character char, int oldIndex, int newIndex,
          {dynamic extraData}) =>
      char.copyWith(
        moves: T == Move ? reorder(listByType<Move>(char).toList(), oldIndex, newIndex) : null,
        spells: T == Spell ? reorder(listByType<Spell>(char).toList(), oldIndex, newIndex) : null,
        items: T == Item ? reorder(listByType<Item>(char).toList(), oldIndex, newIndex) : null,
        notes: T == Note
            ? _reorderNotes(
                listByType<Note>(char).toList(), oldIndex, newIndex, extraData as String)
            : null,
      );

  static List<Note> _reorderNotes(List<Note> notes, int oldIndex, int newIndex, String category) {
    final sortedInCat = reorder(
        notes.where((note) => note.localizedCategory == category).toList(), oldIndex, newIndex);
    final otherCats = notes.where((note) => note.localizedCategory != category);

    return [...sortedInCat, ...otherCats];
  }

  static Iterable<T> listByType<T>(Character char) => {
        Move: char.moves,
        Spell: char.spells,
        Item: char.items,
        Note: char.notes,
      }[T]!
          .cast<T>();

  static List<Character> Function(int oldIndex, int newIndex) reorderCharacters(
    Iterable<Character> list,
  ) {
    return (oldIndex, newIndex) => enumerate(reorder(list.toList(), oldIndex, newIndex))
        .map(
          (e) => e.value.copyWith(
            settings: e.value.settings.copyWith(sortOrder: e.index),
          ),
        )
        .toList();
  }
}
