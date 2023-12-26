import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_snack_bar.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class CharacterUtils {
  // Moves
  static Character updateMoves(Character char, Iterable<Move> moves) =>
      char.copyWith(
        moves: updateByKey(char.moves, moves),
      );
  static Character addMoves(Character char, Iterable<Move> moves) =>
      char.copyWith(
        moves: addByKey(char.moves, moves),
      );
  static Character removeMoves(Character char, Iterable<Move> move) =>
      char.copyWith(
        moves: removeByKey(char.moves, move),
      );
  static Character reorderMoves(Character char, int oldIndex, int newIndex) =>
      char.copyWith(
        moves: reorder(char.moves, oldIndex, newIndex),
      );

  // Spells
  static Character updateSpells(Character char, Iterable<Spell> spells) =>
      char.copyWith(
        spells: updateByKey(char.spells, spells),
      );
  static Character addSpells(Character char, Iterable<Spell> spells) =>
      char.copyWith(
        spells: addByKey(char.spells, spells),
      );
  static Character removeSpells(Character char, Iterable<Spell> spell) =>
      char.copyWith(
        spells: removeByKey(char.spells, spell),
      );
  static Character reorderSpells(Character char, int oldIndex, int newIndex) =>
      char.copyWith(
        spells: reorder(char.spells, oldIndex, newIndex),
      );

  // Items
  static Character updateItems(Character char, Iterable<Item> items) =>
      char.copyWith(
        items: updateByKey(char.items, items),
      );
  static Character addItems(Character char, Iterable<Item> items) =>
      char.copyWith(
        items: addByKey(char.items, items),
      );
  static Character removeItems(Character char, Iterable<Item> item) =>
      char.copyWith(
        items: removeByKey(char.items, item),
      );
  static Character reorderItems(Character char, int oldIndex, int newIndex) =>
      char.copyWith(
        items: reorder(char.items, oldIndex, newIndex),
      );

  // Notes
  static Character updateNotes(Character char, Iterable<Note> notes) =>
      char.copyWith(
        notes: updateByKey(char.notes, notes),
      );
  static Character addNotes(Character char, Iterable<Note> notes) =>
      char.copyWith(
        notes: addByKey(char.notes, notes),
      );
  static Character removeNotes(Character char, Iterable<Note> note) =>
      char.copyWith(
        notes: removeByKey(char.notes, note),
      );
  static Character reorderNotes(Character char, int oldIndex, int newIndex) =>
      char.copyWith(
        notes: reorder(char.notes, oldIndex, newIndex),
      );

  // CHARACTER CLASS

  // COMBINED

  static Character updateByType<T>(Character char, Iterable<T> items) =>
      char.copyWith(
        moves: T == Move ? updateByKey(char.moves, items.cast<Move>()) : null,
        spells:
            T == Spell ? updateByKey(char.spells, items.cast<Spell>()) : null,
        items: T == Item ? updateByKey(char.items, items.cast<Item>()) : null,
        notes: T == Note ? updateByKey(char.notes, items.cast<Note>()) : null,
      );

  static Character addByType<T>(Character char, Iterable<T> items) =>
      char.copyWith(
        moves: T == Move ? addByKey(char.moves, items.cast<Move>()) : null,
        spells: T == Spell ? addByKey(char.spells, items.cast<Spell>()) : null,
        items: T == Item ? addByKey(char.items, items.cast<Item>()) : null,
        notes: T == Note ? addByKey(char.notes, items.cast<Note>()) : null,
      );

  static Character upsertByType<T>(Character char, Iterable<T> items) =>
      char.copyWith(
        moves: T == Move ? upsertByKey(char.moves, items.cast<Move>()) : null,
        spells:
            T == Spell ? upsertByKey(char.spells, items.cast<Spell>()) : null,
        items: T == Item ? upsertByKey(char.items, items.cast<Item>()) : null,
        notes: T == Note ? upsertByKey(char.notes, items.cast<Note>()) : null,
      );

  static Character removeByType<T>(Character char, Iterable<T> items) =>
      char.copyWith(
        moves: T == Move ? removeByKey(char.moves, items.cast<Move>()) : null,
        spells:
            T == Spell ? removeByKey(char.spells, items.cast<Spell>()) : null,
        items: T == Item ? removeByKey(char.items, items.cast<Item>()) : null,
        notes: T == Note ? removeByKey(char.notes, items.cast<Note>()) : null,
      );

  static Character reorderByType<T>(Character char, int oldIndex, int newIndex,
          {dynamic extraData}) =>
      char.copyWith(
        moves: T == Move ? reorder(char.moves, oldIndex, newIndex) : null,
        spells: T == Spell ? reorder(char.spells, oldIndex, newIndex) : null,
        items: T == Item ? reorder(char.items, oldIndex, newIndex) : null,
        notes: T == Note
            ? _reorderNotes(char.notes, oldIndex, newIndex, extraData as String)
            : null,
      );

  static List<Note> _reorderNotes(
      List<Note> notes, int oldIndex, int newIndex, String category) {
    final sortedInCat = reorder(
        notes.where((note) => note.localizedCategory == category).toList(),
        oldIndex,
        newIndex);
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
    return (oldIndex, newIndex) =>
        enumerate(reorder(list.toList(), oldIndex, newIndex))
            .map((e) => e.value.copyWith(
                  settings: e.value.settings.copyWith(sortOrder: e.index),
                ))
            .toList();
  }

  static addXP(BuildContext context, Character char, int xp) {
    CharacterProvider.of(context).updateCharacter(
      char.copyWith(
        stats: char.stats.copyWith(
          currentXp: char.stats.currentXp + 1,
        ),
      ),
    );
    CustomSnackBar.show(content: tr.actions.classActions.markXP.success);
  }
}

